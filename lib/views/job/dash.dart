import 'package:flamenco_remote/models/job.dart';
import 'package:flamenco_remote/providers/flamenco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashView extends StatefulWidget {
  final Job job;
  const DashView({super.key, required this.job});

  @override
  State<DashView> createState() => _DashViewState(job: job);
}

class _DashViewState extends State<DashView> {
  var server = Flamenco();
  String lastRendered = "";
  final Job job;

  ThemeData? theme;

  _DashViewState({required this.job}) {
    _refreshLastRendered();
  }

  Future _refresh() async {
    _refreshLastRendered();
  }

  Future _refreshLastRendered() async {
    String img = await server.getJobLastRender(widget.job.id);
    setState(() {
      lastRendered = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _lastRender(),
            Text(
              job.status.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                color: job.status == "active"
                    ? Colors.greenAccent
                    : Colors.redAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Settings",
              style: TextStyle(color: Colors.grey.shade500),
            ),
            _jobDetails(),
          ],
        ),
      ),
    );
  }

  Widget _lastRender() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: lastRendered == ""
                    ? Container(
                        color: Colors.black38,
                        alignment: AlignmentDirectional.center,
                        child: SvgPicture.asset(
                          "assets/brand.svg",
                          width: 70,
                        ),
                      )
                    : Image.network(lastRendered)),
            Row(
              children: [
                const Spacer(flex: 1),
                IconButton(
                    onPressed: () {
                      _refreshLastRendered();
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            )
          ],
        ),
      ),
    );
  }

  _jobDetails() {
    final date = DateTime.parse(job.created);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ID: ${job.id}"),
          Text(
              "Created: ${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}"),
          Text("Blendfile: ${job.settings['blendfile']}"),
          Text("Scene: ${job.settings['scene']}"),
          Text("FPS: ${job.settings['fps']}"),
          Text("Frames: ${job.settings['frames']}"),
          Text("Chunk: ${job.settings['chunk_size']}"),
          Text("Extension: ${job.settings['format']}"),
        ],
      ),
    );
  }
}
