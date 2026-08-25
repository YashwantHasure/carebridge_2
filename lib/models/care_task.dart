class CareTask {
  final String id;
  final String patientId;
  final String title;
  final String description;
  final String time;
  final bool completed;
  final String category;

  const CareTask({
    required this.id,
    required this.patientId,
    required this.title,
    required this.description,
    required this.time,
    required this.completed,
    required this.category,
  });

  CareTask copyWith({
    String? id,
    String? patientId,
    String? title,
    String? description,
    String? time,
    bool? completed,
    String? category,
  }) {
    return CareTask(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      completed: completed ?? this.completed,
      category: category ?? this.category,
    );
  }
}