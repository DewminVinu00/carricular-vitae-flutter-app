// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';

import 'package:curricular_vitae/components/about.dart';
import 'package:curricular_vitae/components/education.dart';
import 'package:curricular_vitae/components/footer.dart';
import 'package:curricular_vitae/components/skills.dart';
import 'package:curricular_vitae/main.dart';
import 'package:curricular_vitae/pages/home_page.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List<Widget> navItems = [];

  bool isMobile = false;

  final skillKey = GlobalKey();
  final skillKeyE = GlobalKey();

  @override
  void initState() {
    navItems = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              Scrollable.ensureVisible(skillKeyE.currentContext!);
            },
            child: Text("Education")),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              Scrollable.ensureVisible(skillKey.currentContext!);
            },
            child: Text("Skills")),
      ),
      SizedBox(
        height: 20.0,
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text("Go to Home Screen"),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 5.0,
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Skills()),
                  );
                },
                child: Text("Go to Skill page"),
              ),
            ),
          ],
        ),
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dewmin Vinuraka CV"),
        actions: isMobile ? null : navItems,
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                children: navItems,
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20.0,
                runAlignment: WrapAlignment.center,
                children: [
                  About(),
                  Education(
                    key: skillKeyE,
                  ),
                ],
              ),
              Divider(
                color: Colors.blue.shade200,
                endIndent: 50.0,
                indent: 50.0,
              ),
              Skills(
                key: skillKey,
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
