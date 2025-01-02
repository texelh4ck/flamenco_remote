import 'dart:async';
import 'dart:io';

import 'package:flamenco_remote/models/job.dart';
import 'package:flamenco_remote/models/task.dart';
import 'package:flamenco_remote/providers/flamenco.dart';
import 'package:flutter/material.dart';

class JobLogsTab extends StatefulWidget {
  final Job job;
  const JobLogsTab({super.key, required this.job});

  @override
  State<JobLogsTab> createState() => _JobLogsTab_State(job: job);
}

class _JobLogsTab_State extends State<JobLogsTab> {
  final Job job;
  final server = Flamenco();
  var colorStatus = {
    "completed": Colors.greenAccent,
    "active": Colors.blueAccent,
    "queued": Colors.redAccent,
  };
  List<Task> tasks = [];
  bool loading = false;

  _JobLogsTab_State({required this.job}) {
    Timer.periodic(Duration(seconds: 1), (t) {
      if(!loading){
        _getTaskList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getTaskList();
      },
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Text(tasks[i].indexInJob.toString()),
            title: Text(tasks[i].name),
            subtitle: Text(tasks[i].status),
            trailing: Icon(
              Icons.circle,
              size: 15,
              color: colorStatus[tasks[i].status],
            ),
          );
        },
      ),
    );
  }

  _getTaskList() {
    loading = true;
    server.getJobTask(job.id).then((t) {
      for (var i = 0; i < t.length; i++) {
        if (t[0].status == "completed") {
          t.add(t[0]);
          t.removeAt(0);
        }
      }
      setState(() {
        tasks = t;
      });
      loading = false;
    });
  }
}
