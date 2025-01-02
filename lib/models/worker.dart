class Worker {
  late bool canRestart;
  late String id;
  late String lastSeen;
  late String name;
  late String status;
  // late Map<String, dynamic>? statusChange;
  late String version;

  Worker({
    required this.id,
    required this.name,
    required this.lastSeen,
    required this.status,
    required this.version,
    required this.canRestart,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    version: json["version"],
    lastSeen: json["last_seen"],
    canRestart: json["can_restart"]
  );
}
