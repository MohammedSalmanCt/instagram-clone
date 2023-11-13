import 'package:flutter/material.dart';

class Storyavtr extends StatefulWidget {
  const Storyavtr({super.key});

  @override
  State<Storyavtr> createState() => _StoryavtrState();
}

class _StoryavtrState extends State<Storyavtr> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.red,
      radius:38,
    );
  }
}