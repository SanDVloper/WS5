class Course {
  final String code;
  final String title;
  final int credits;
  final String status;
  final String lecturer;

  const Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    required this.lecturer,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['code'] as String? ?? '-',
      title: json['title'] as String? ?? 'Tanpa judul',
      credits: (json['credits'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'planned',
      lecturer: json['lecturer'] as String? ?? '-',
    );
  }

  bool get isDone => status == 'done';
  bool get isActive => status == 'active';

  String get statusLabel {
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