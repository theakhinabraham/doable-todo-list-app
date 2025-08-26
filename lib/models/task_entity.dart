class TaskEntity {
  TaskEntity({
    this.id,
    required this.title,
    this.description,
    this.time,
    this.date,
    this.hasNotification = false,
    this.repeatRule,
    this.completed = false,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String title;
  String? description;
  String? time; // "11:30 AM"
  String? date; // "26/11/24"
  bool hasNotification;
  String? repeatRule; // e.g., "Weekly"
  bool completed;
  String? createdAt;
  String? updatedAt;

  factory TaskEntity.fromMap(Map<String, dynamic> m) => TaskEntity(
    id: m['id'] as int?,
    title: m['title'] as String,
    description: m['description'] as String?,
    time: m['time'] as String?,
    date: m['date'] as String?,
    hasNotification: (m['has_notification'] as int? ?? 0) == 1,
    repeatRule: m['repeat_rule'] as String?,
    completed: (m['completed'] as int? ?? 0) == 1,
    createdAt: m['created_at'] as String?,
    updatedAt: m['updated_at'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'time': time,
    'date': date,
    'has_notification': hasNotification ? 1 : 0,
    'repeat_rule': repeatRule,
    'completed': completed ? 1 : 0,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
