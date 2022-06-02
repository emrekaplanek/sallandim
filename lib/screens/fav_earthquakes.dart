import 'package:flutter/material.dart';
import 'package:sallandim/models/todo.dart';
import 'package:sallandim/services/request_service.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SizedBox()),
    );
  }
}
