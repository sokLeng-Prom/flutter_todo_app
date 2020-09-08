import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/providers/todos_provider.dart';
import 'package:provider_demo/screens/todos_screen/todo_ui.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // when the screen first renders
    // we fetch the list of todos
    TodosProvider todosProvider =
        Provider.of<TodosProvider>(context, listen: false);
    try {
      // run the fetchTodos function
      todosProvider.fetchTodos();
    } catch (e) {
      // this block of code will run when ever there is an error
      // in the try block. In this case i'm just going to print out
      // the error
      print(e);
    }
  }

  void onAddTodoButtonPressed() async {
    // only execute when the input is not empty
    if (textFieldController.text.length > 0) {
      // initialize the provider
      TodosProvider todosProvider = Provider.of<TodosProvider>(
        context,
        listen: false,
      );
      // calls the addtodo function from the provider to add into API
      todosProvider.addTodo(textFieldController.text);
      // clear the text field
      textFieldController.clear();
    }
  }

  // these functions can't be used in other files for some reasons
  // void onDeleteButtonPressed(int id) {
  //   // TodosProvider todosProvider = Provider.of<TodosProvider>(
  //   //   context,
  //   //   listen: false,
  //   // );
  //   // todosProvider.removeTodo(id);
  //   print('doggos');
  // }

  // void onUpdateStatusButtonPressed(int id) async {
  //   TodosProvider todosProvider = Provider.of<TodosProvider>(
  //       context,
  //       listen: false,
  //     );
  //   todosProvider.updateTodo(id);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosProvider>(
      builder: (
        BuildContext context,
        TodosProvider todosProvider,
        Widget child,
      ) {
        return TodoUI(
          todos: todosProvider.todos,
          textFieldController: textFieldController,
          onAddTodoButtonPressed: onAddTodoButtonPressed,
        );
      },
    );
  }
}
