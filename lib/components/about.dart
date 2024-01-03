// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_new, unused_import, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
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

  /*void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: new InputDecoration.collapsed(
            hintText: 'Add your details',
            border: OutlineInputBorder(),
          ),
          style: TextStyle(height: 1.5),
          scrollPadding: EdgeInsets.all(12.0),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                firestoreService.addEducation(textController.text);
              } else {
                firestoreService.updateEducation(docID, textController.text);
              }

              textController.clear();

              Navigator.pop(context);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }*/
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
      //height: 1100.0,
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
              /*Image.asset(
                "assets/Dewmin.png",
                height: 156.0,
              ),*/
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
                  "I am a final year undergraduate student in software engineering department of NSBM Green University. I have comprehensive experience in software engineering field. I am computer literate and have very good practical knowledge of the subject. I am confident, I can do Front - end Develop, Back - End Develop, UI Desings, Software Testing and Debugging in filed software engineering. It is my hope to further improve my skills here.",
                  textAlign: TextAlign.center,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  Chip(
                    label: Text(
                      "Full Stack Developer",
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),

                  /*Chip(
                    label: Text(
                      "Full Stack Developer",
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Chip(
                    label: Text(
                      "App developer",
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),*/
                ],
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
