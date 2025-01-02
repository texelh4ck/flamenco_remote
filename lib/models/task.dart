class Task {
  String id;
  int indexInJob;
  String name;
  int priority;
  String status;
  String taskType;
  String updated;

  Task(
      {required this.id,
      required this.indexInJob,
      required this.name,
      required this.priority,
      required this.status,
      required this.taskType,
      required this.updated});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        indexInJob: json['index_in_job'],
        name: json['name'],
        priority: json['priority'],
        status: json['status'],
        taskType: json['task_type'],
        updated: json['updated'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['index_in_job'] = indexInJob;
    data['name'] = name;
    data['priority'] = priority;
    data['status'] = status;
    data['task_type'] = taskType;
    data['updated'] = updated;
    return data;
  }
}
