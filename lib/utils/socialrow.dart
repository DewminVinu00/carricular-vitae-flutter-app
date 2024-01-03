// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curricular_vitae/utils/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialRow extends StatefulWidget {
  const SocialRow({Key? key}) : super(key: key);

  @override
  State<SocialRow> createState() => _SocialRowState();
}

class _SocialRowState extends State<SocialRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedIconButton(iconData: FontAwesomeIcons.facebook, onTap: () {}),
        const SizedBox(
          width: 8.0,
        ),
        AnimatedIconButton(iconData: FontAwesomeIcons.instagram, onTap: () {}),
        const SizedBox(
          width: 8.0,
        ),
        AnimatedIconButton(iconData: FontAwesomeIcons.twitter, onTap: () {}),
      ],
    );
  }
}
