import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage14Feedback extends StatefulWidget {
  const Stage14Feedback({super.key});

  @override
  State<Stage14Feedback> createState() =>
      _Stage14FeedbackState();
}

class _Stage14FeedbackState extends State<Stage14Feedback> {
  final formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(formKey.currentState!.validate())) return;
    setState(() => isLoading = true);
    // Simulasi loading singkat
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Feedback berhasil dikirim')),
    );
  }

  Future<void> _confirmReset() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Hapus semua isian form?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (result == true) {
      commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 14 - Feedback')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(studentName,
                  style:
                      TextStyle(fontWeight: FontWeight.bold)),
              Text(studentId),
              const SizedBox(height: 12),
              TextFormField(
                controller: commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Komentar (min. 5 karakter)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().length < 5) {
                    return 'Komentar minimal 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              if (isLoading)
                const Center(
                    child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Kirim'),
                ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _confirmReset,
                child: const Text('Hapus Isian'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}