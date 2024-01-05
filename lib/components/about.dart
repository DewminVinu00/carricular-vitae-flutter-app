// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_new, unused_import, unused_field
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curricular_vitae/pages/professional_skill_page.dart';
import 'package:curricular_vitae/services/firestore.dart';
import 'package:curricular_vitae/utils/animated_contact.dart';
import 'package:curricular_vitae/utils/socialrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  List<Skill> skills = List.empty(growable: true);
  TextEditingController skillController = TextEditingController();

  int selectedIndex = -1;
  var isUpdating = false;

  @override
  void initState() {
    super.initState();
    fetchData();

    // Start a timer to fetch data every 5 seconds
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("skills").get();
      var tempList = <Skill>[];

      querySnapshot.docs.forEach((doc) {
        var skill = Skill(
          id: doc.id,
          skill: doc['skill'],
        );
        tempList.add(skill);
      });

      setState(() {
        skills.clear();
        skills.addAll(tempList);
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        bottom: 30.0,
      ),
      width: context.screenWidth < 900
          ? context.screenWidth * 0.9
          : context.screenWidth < 1600
              ? context.screenWidth * 0.3
              : context.screenWidth * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  "assets/Dewmin.png",
                  height: 156.0,
                  width: 156.0,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Dewmin Vinuraka",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "I am a final year undergraduate student in the software engineering department of NSBM Green University. I have comprehensive experience in the software engineering field. I am computer literate and have very good practical knowledge of the subject. I am confident I can do Front-end Development, Back-End Development, UI Designs, Software Testing, and Debugging in the field of software engineering. It is my hope to further improve my skills here.",
                  textAlign: TextAlign.center,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 8.0,
                children: skills
                    .map(
                      (skill) => Chip(
                        label: Text(
                          skill.skill,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Divider(color: Colors.blue.shade200),
              AnimatedContact(
                iconData: FontAwesomeIcons.github,
                title: "Github",
                subtitle: "SL Programmer",
                onTap: () {},
              ),
              AnimatedContact(
                iconData: FontAwesomeIcons.gitlab,
                title: "Gitlab",
                subtitle: "SL Programmer",
                onTap: () {},
              ),
              AnimatedContact(
                iconData: FontAwesomeIcons.linkedin,
                title: "Linkedin",
                subtitle: "SL Programmer",
                onTap: () {},
              ),
            ],
          ),
          Column(
            children: [
              Divider(color: Colors.blue.shade200),
              SocialRow(),
            ],
          ),
        ],
      ),
    );
  }
}
