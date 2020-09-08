import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_item.dart';
import '../providers/todos_provider.dart';

class TodoAnimation extends StatefulWidget {
  const TodoAnimation({
    this.id,
  });

  final int id;
  @override
  _TodoAnimationState createState() => _TodoAnimationState();
}

class _TodoAnimationState extends State<TodoAnimation>
    with SingleTickerProviderStateMixin {
  TodoItem todoItem;
  AnimationController _animationcontroller;
  Animation<double> _animation;

  void initState() {
    super.initState();

    _animationcontroller =
        AnimationController(duration: Duration(seconds: 15), vsync: this)
          ..repeat();

    _animation = CurvedAnimation(
        parent: _animationcontroller, curve: Curves.bounceInOut);
  }

  void dispose() {
    _animationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: IconButton(
        color: Colors.red,
        alignment: Alignment.bottomRight,
        onPressed: () {
          TodosProvider todosProvider =
              Provider.of<TodosProvider>(context, listen: false);
          todosProvider.removeTodo(widget.id);
          // setState(() {});
        },
        icon: Icon(Icons.delete),
      ),
      // duration: Duration(seconds: 1))
    );
  }
}
