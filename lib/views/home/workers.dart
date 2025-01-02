import 'dart:async';

import 'package:flamenco_remote/models/worker.dart';
import 'package:flamenco_remote/providers/flamenco.dart';
import 'package:flutter/material.dart';

class WorkersView extends StatelessWidget {
  WorkersView({super.key});

  var server = Flamenco();

  var statusColors = {"awake": Colors.greenAccent, "offline": Colors.redAccent, "asleep": Colors.blueAccent};

  Future _refresh() async {
    server.getWorkers();
  }

  @override
  Widget build(BuildContext context) {
    server.getWorkers();
    return RefreshIndicator(
      onRefresh: _refresh,
      child: StreamBuilder(
        stream: server.workerStream,
        builder: (context, AsyncSnapshot<List<Worker>> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                Worker w = snapshot.data![i];
                return ListTile(
                  title: Text(w.name),
                  subtitle: Text(w.version),
                  leading: Icon(Icons.circle, size: 15, color: statusColors[w.status],)
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}

