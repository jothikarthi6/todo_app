import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../../theme/app_theme.dart';

class AddEditTaskSheet extends ConsumerStatefulWidget {
  final TaskModel? task;
  const AddEditTaskSheet({super.key, this.task});

  @override
  ConsumerState<AddEditTaskSheet> createState() => _AddEditTaskSheetState();
}

class _AddEditTaskSheetState extends ConsumerState<AddEditTaskSheet> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.task?.title ?? '');
    _descCtrl = TextEditingController(text: widget.task?.description ?? '');
  }

  Future<void> _save() async {
    if (_titleCtrl.text.trim().isEmpty) return;
    setState(() => _loading = true);
    final svc = ref.read(taskServiceProvider);
    if (widget.task == null) {
      await svc.addTask(_titleCtrl.text.trim(), _descCtrl.text.trim());
    } else {
      widget.task!.title = _titleCtrl.text.trim();
      widget.task!.description = _descCtrl.text.trim();
      await svc.updateTask(widget.task!);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24, right: 24, top: 24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(widget.task == null ? 'Add Task' : 'Edit Task',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        TextField(controller: _titleCtrl,
          decoration: InputDecoration(
            hintText: 'Task title', labelText: 'Title',
            filled: true, fillColor: const Color(0xFFF5F6FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none))),
        const SizedBox(height: 12),
        TextField(controller: _descCtrl, maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Description (optional)', labelText: 'Description',
            filled: true, fillColor: const Color(0xFFF5F6FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none))),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))),
            onPressed: _loading ? null : _save,
            child: _loading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(widget.task == null ? 'Add Task' : 'Save Changes',
                  style: const TextStyle(color: Colors.white,
                    fontSize: 16, fontWeight: FontWeight.bold)),
          )),
        const SizedBox(height: 24),
      ]),
    );
  }
}