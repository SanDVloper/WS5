import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseFormScreen extends StatefulWidget {
  final Course? course;

  const CourseFormScreen({super.key, this.course});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  static const _statuses = ['planned', 'active', 'done'];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _titleController;
  late final TextEditingController _creditsController;
  late String _status;

  bool get _isEditing => widget.course != null;

  @override
  void initState() {
    super.initState();
    final course = widget.course;
    _codeController = TextEditingController(text: course?.code ?? '');
    _titleController = TextEditingController(text: course?.title ?? '');
    _creditsController =
        TextEditingController(text: course?.credits.toString() ?? '');
    _status = _statuses.contains(course?.status) ? course!.status : 'planned';
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<CourseProvider>();
    if (provider.isSaving) return;

    final id = widget.course?.id;
    if (_isEditing && id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course tidak memiliki id')),
      );
      return;
    }

    final course = Course(
      id: id,
      code: _codeController.text.trim(),
      title: _titleController.text.trim(),
      credits: int.parse(_creditsController.text.trim()),
      status: _status,
    );

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final error = _isEditing
        ? await provider.updateCourse(id!, course)
        : await provider.createCourse(course);

    if (!mounted) return;
    if (error != null) {
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          _isEditing
              ? 'Course berhasil diperbarui'
              : 'Course berhasil ditambahkan',
        ),
      ),
    );
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isSaving = context.watch<CourseProvider>().isSaving;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Course' : 'Tambah Course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _codeController,
                readOnly: _isEditing,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Kode Course',
                  border: const OutlineInputBorder(),
                  helperText: _isEditing
                      ? 'Kode tidak dapat diubah karena dipakai sebagai kunci favorites'
                      : null,
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Kode wajib diisi'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Course',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Judul wajib diisi'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _creditsController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'SKS',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final credits = int.tryParse(value?.trim() ?? '');
                  if (credits == null || credits <= 0) {
                    return 'SKS harus berupa angka lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: _statuses
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(_statusLabel(status)),
                        ))
                    .toList(),
                onChanged: isSaving
                    ? null
                    : (value) {
                        if (value != null) setState(() => _status = value);
                      },
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: isSaving ? null : _save,
                icon: isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(_isEditing ? Icons.save : Icons.add),
                label: Text(isSaving ? 'Menyimpan...' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'done':
        return 'Selesai';
      case 'active':
        return 'Aktif';
      default:
        return 'Rencana';
    }
  }
}
