import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/components/todo_card.dart';
import 'package:provider_demo/models/todo_item.dart';

import '../../components/todo_card.dart';
import '../../providers/todos_provider.dart';

class TodoUI extends StatelessWidget {
  const TodoUI(
      {this.todos,
      this.textFieldController,
      this.onAddTodoButtonPressed,
      this.onDeleteButtonPressed,
      this.onUpdateStatusButtonPressed});

  final Function onAddTodoButtonPressed;
  final Function onDeleteButtonPressed;
  final Function onUpdateStatusButtonPressed;
  final TextEditingController textFieldController;
  final List<TodoItem> todos;

  @override
  Widget build(BuildContext context) {
    TodosProvider todosProvider = Provider.of<TodosProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                              controller: textFieldController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ))),
                        ),
                        SizedBox(width: 5.0),
                        FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: onAddTodoButtonPressed,
                          child: Text("Add Todo"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Container(
                        height: 150.0,
                        width: 100.0,
                        child: Lottie.asset('assets/lottie/lotties.json'),
                      ),
                      Container(
                          child: Column(
                        children: <Widget>[
                          Container(
                              child: Text("Hello Suling!",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))),
                          Container(
                              child: Text(
                                  "You have ${todosProvider.todos.length} taskes today"))
                        ],
                      ))
                    ],
                  )),
                ],
              ),
            ),
            ...todos.map((TodoItem e) {
              return TodoItemCard(
                todoItem: e,
                onDeleteButtonPressed: onDeleteButtonPressed,
                onUpdateStatusButtonPressed: onUpdateStatusButtonPressed,
              );
            }),
          ],
        )),
      ),
    );
  }
}
