import 'package:flamenco_remote/providers/flamenco.dart';
import 'package:flamenco_remote/views/home/jobs.dart';
import 'package:flamenco_remote/views/home/workers.dart';
import 'package:flamenco_remote/widgets/bg_gradient.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int tab = 0;

  Widget _getTab() {
    switch (tab) {
      case 0:
        return JobsView();
      case 1:
        return WorkersView();
    }
    return JobsView();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final pageCtrl = PageController();
    Flamenco.server = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: BgGradient(
        child: PageView(
          controller: pageCtrl,
          onPageChanged: (i) {
            setState(() {
              tab = i;
            });
          },
          children: [
            JobsView(),
            WorkersView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple.shade700.withAlpha(70),
        currentIndex: tab,
        unselectedItemColor: Colors.deepPurple.shade300,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          pageCtrl.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Jobs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.computer_rounded), label: "Workers"),
        ],
      ),
    );
  }
}
