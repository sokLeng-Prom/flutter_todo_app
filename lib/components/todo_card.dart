import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/components/todo_animation.dart';

import '../models/todo_item.dart';
import '../providers/todos_provider.dart';

class TodoItemCard extends StatefulWidget {
  const TodoItemCard(
      {Key key,
      @required this.todoItem,
      @required this.onDeleteButtonPressed,
      @required this.onUpdateStatusButtonPressed})
      : super(key: key);

  final Function onDeleteButtonPressed;
  final Function onUpdateStatusButtonPressed;
  final TodoItem todoItem;

  @override
  _TodoItemCardState createState() => _TodoItemCardState();
}

class _TodoItemCardState extends State<TodoItemCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: Checkbox(
                          value: widget.todoItem.isDone,
                          onChanged: (newValue) {
                            widget.todoItem.isDone = newValue;
                            TodosProvider todosProvider =
                                Provider.of<TodosProvider>(context,
                                    listen: false);
                            todosProvider.updateTodo(
                                widget.todoItem.id, newValue);
                          },
                        ),
                      ),
                      Text(
                        widget.todoItem.content,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20.0)),
                      TodoAnimation(
                        id: widget.todoItem.id,
                      ),
                    ]),
              ],
            )),
      ],
    );
  }
}
