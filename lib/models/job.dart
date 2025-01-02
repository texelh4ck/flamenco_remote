class Job {
  late Map<String, dynamic> metadata;
  late String id;
  late String name;
  late String status;
  late int priority;
  late Map<String, dynamic> settings;
  late Map<String, dynamic> storage;
  late String submitterPlatform;
  late String type;
  late String activity;
  late String created;
  late String updated;

  Job({
    required this.metadata,
    required this.name,
    required this.id,
    required this.status,
    required this.priority,
    required this.settings,
    required this.storage,
    required this.submitterPlatform,
    required this.type,
    required this.activity,
    required this.created,
    required this.updated,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        metadata: json["metadata"],
        name: json["name"],
        id: json["id"],
        status: json["status"],
        priority: json["priority"],
        settings: json["settings"],
        storage: json["storage"],
        submitterPlatform: json["submitter_platform"],
        type: json["type"],
        activity: json["activity"],
        created: json["created"],
        updated: json["updated"],
      );
}
