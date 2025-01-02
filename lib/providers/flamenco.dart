import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flamenco_remote/models/job.dart';
import 'package:flamenco_remote/models/task.dart';
import 'package:flamenco_remote/models/worker.dart';
import 'package:http/http.dart' as http;

class Flamenco {
  static String server = "";

  List<Job> _jobs = [];
  final StreamController _jobsStream = StreamController<List<Job>>.broadcast();
  get jobsStream => _jobsStream.stream;
  get jobsSink => _jobsStream.sink.add;
  get jobsDispose => _jobsStream.close;

  List<Worker> _workers = [];
  final StreamController _workerStream =
      StreamController<List<Worker>>.broadcast();
  get workerStream => _workerStream.stream;
  get workerSink => _workerStream.sink.add;
  get workerDispose => _workerStream.close;

  Future<List<Job>> getJobs() async {
    var url = Uri.http(server, "/api/v3/jobs");

    var res = await http.get(url);
    var data = json.decode(res.body);

    List<Job> jobs = [];
    for (var j in data["jobs"]) {
      Job job = Job.fromJson(j);
      jobs.add(job);
    }

    _jobs = jobs;
    jobsSink(_jobs);

    return jobs;
  }

  Future<List<Worker>> getWorkers() async {
    var url = Uri.http(server, "/api/v3/worker-mgt/workers");

    var res = await http.get(url);
    var data = json.decode(res.body);

    List<Worker> wks = [];
    for (var w in data["workers"]) {
      Worker wk = Worker.fromJson(w);
      wks.add(wk);
    }

    _workers = wks;
    workerSink(_workers);

    return wks;
  }

  Future<List<Task>> getJobTask(String job_id) async {
    var url = Uri.http(server, "/api/v3/jobs/$job_id/tasks");

    var res = await http.get(url);
    var data = json.decode(res.body);

    List<Task> tasks = [];
    for (var w in data["tasks"]) {
      Task t = Task.fromJson(w);
      tasks.add(t);
    }

    return tasks;
  }

  Future<String> getJobLastRender(String jobId) async {
    var url = Uri.http(server, "/api/v3/jobs/$jobId/last-rendered");

    var res = await http.get(url);
    var data = json.decode(res.body);

    return "http://$server${data['base']}/last-rendered-small.jpg?${Random.secure().nextDouble()}";
  }

  Future setStatusJob(String jobId, String status) async {
    var url = Uri.http(server, "/api/v3/jobs/$jobId/setstatus");

    var res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"reason": "string", "status": status}),
    );
  }
}
