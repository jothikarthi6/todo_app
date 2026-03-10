import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import 'auth_provider.dart';

final taskServiceProvider = Provider((_) => TaskService());

final tasksStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  final auth = ref.watch(authStateProvider);
  final user = auth.value;
  if (user == null) {
    return Stream.value([]);
  }
  return ref.read(taskServiceProvider).watchTasks();
});

// Filter: 'all', 'active', 'completed'
final filterProvider = StateProvider<String>((_) => 'all');

final filteredTasksProvider = Provider<List<TaskModel>>((ref) {
  final tasks = ref.watch(tasksStreamProvider).value ?? [];
  final filter = ref.watch(filterProvider);
  return switch (filter) {
    'active' => tasks.where((t) => !t.isCompleted).toList(),
    'completed' => tasks.where((t) => t.isCompleted).toList(),
    _ => tasks,
  };
});
