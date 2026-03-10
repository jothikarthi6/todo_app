import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';

class TaskService {
  final _db = FirebaseDatabase.instance;

  User? get _user => FirebaseAuth.instance.currentUser;

  Future<Box<TaskModel>> _openUserBox(String uid) async {
    final name = 'tasks_$uid';
    if (Hive.isBoxOpen(name)) return Hive.box<TaskModel>(name);
    return await Hive.openBox<TaskModel>(name);
  }

  // Fetch all tasks (syncs to Hive)
  Stream<List<TaskModel>> watchTasks() async* {
    final user = _user;
    if (user == null) {
      yield [];
      return;
    }
    final box = await _openUserBox(user.uid);
    final ref = _db.ref('users/${user.uid}/tasks');
    yield* ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];
      final map = Map<String, dynamic>.from(data as Map);
      final tasks = map.entries.map((e) =>
        TaskModel.fromJson(e.key, e.value)).toList();

      // Sync to Hive for offline access
      box.clear();
      for (var task in tasks) {
        box.put(task.id, task);
      }

      tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return tasks;
    });
  }

  // Get from Hive (offline fallback)
  Future<List<TaskModel>> getCachedTasks() async {
    final user = _user;
    if (user == null) return [];
    final box = await _openUserBox(user.uid);
    return box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> addTask(String title, String description) async {
    final user = _user;
    if (user == null) throw StateError('Not authenticated');
    final box = await _openUserBox(user.uid);
    final ref = _db.ref('users/${user.uid}/tasks').push();
    final task = TaskModel(
      id: ref.key!,
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await ref.set(task.toJson());
    box.put(task.id, task); // cache locally
  }

  Future<void> updateTask(TaskModel task) async {
    final user = _user;
    if (user == null) throw StateError('Not authenticated');
    final box = await _openUserBox(user.uid);
    await _db.ref('users/${user.uid}/tasks').child(task.id).update(task.toJson());
    box.put(task.id, task);
  }

  Future<void> toggleComplete(TaskModel task) async {
    if (_user == null) throw StateError('Not authenticated');
    task.isCompleted = !task.isCompleted;
    await updateTask(task);
  }

  Future<void> deleteTask(String taskId) async {
    final user = _user;
    if (user == null) throw StateError('Not authenticated');
    final box = await _openUserBox(user.uid);
    await _db.ref('users/${user.uid}/tasks').child(taskId).remove();
    box.delete(taskId);
  }

  Future<void> clearCache() async {
    final user = _user;
    if (user == null) return;
    final box = await _openUserBox(user.uid);
    await box.clear();
  }
}
