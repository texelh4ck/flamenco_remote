import 'package:flamenco_remote/models/job.dart';
import 'package:flamenco_remote/providers/flamenco.dart';
import 'package:flamenco_remote/views/job/dash.dart';
import 'package:flamenco_remote/views/job/logs.dart';
import 'package:flamenco_remote/widgets/bg_gradient.dart';
import 'package:flutter/material.dart';

class JobDetailView extends StatefulWidget {
  const JobDetailView({super.key});

  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  int tab = 0;
  late Job job;
  var server = Flamenco();
  var _pageCtrl = PageController();

  Widget _getTab() {
    switch (tab) {
      case 0:
        return DashView(job: job);
      case 1:
        return JobLogsTab(job: job);
    }
    return DashView(job: job);
  }

  @override
  Widget build(BuildContext context) {
    job = ModalRoute.of(context)!.settings.arguments as Job;
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(job.name),
        backgroundColor: Colors.deepPurple.shade700.withAlpha(70),
        centerTitle: true,
      ),
      body: BgGradient(
        child: PageView(
          onPageChanged: (i) {
            setState(() {
              tab = i;
            });
          },
          controller: _pageCtrl,
          children: [
            DashView(job: job),
            JobLogsTab(job: job),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(job.status == "active" ? Icons.pause : Icons.play_arrow),
          onPressed: _playAndPause),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.deepPurple.shade300,
        backgroundColor: Colors.deepPurple.shade700.withAlpha(70),
        currentIndex: tab,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _pageCtrl.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "logs"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.file_download), label: "files"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.settings), label: "settings"),
        ],
      ),
    );
  }

  _playAndPause() {
    setState(() {
      job.status = job.status == "active" ? "paused" : "active";
      server.setStatusJob(job.id, job.status);
    });
  }
}
