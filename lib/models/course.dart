class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      credits: (json['credits'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'planned',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
    };
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