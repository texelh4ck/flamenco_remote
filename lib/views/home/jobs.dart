import 'package:flamenco_remote/models/job.dart';
import 'package:flamenco_remote/providers/flamenco.dart';
import 'package:flutter/material.dart';

class JobsView extends StatelessWidget {
  JobsView({super.key});

  List<Job> jobs = [];

  final server = Flamenco();

  Future _refresh() async {
    server.getJobs();
  }

  @override
  Widget build(BuildContext context) {
    server.getJobs();
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
            stream: server.jobsStream,
            builder: (context, AsyncSnapshot<List<Job>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      _jobCard(context, snapshot.data![index]),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Widget _jobCard(BuildContext context, Job job) {
    var card = Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 10, top: 5),
          width: double.infinity,
          color: Colors.white.withOpacity(0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(job.name, style: const TextStyle(fontSize: 21)),
                  Text(job.priority.toString(),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              Text(job.type, style: const TextStyle(color: Colors.grey)),
              Text(job.status,
                  style: TextStyle(
                      color:
                          job.status == "active" ? Colors.green : Colors.red)),
              Text(job.updated, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, "/project", arguments: job);
      },
    );
  }
}
