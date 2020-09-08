import 'package:flutter/material.dart';
import 'package:provider_demo/models/todo_item.dart';
import 'package:provider_demo/services/todos_services.dart';

class TodosProvider extends ChangeNotifier {
  List<TodoItem> _todos = [];
  List<TodoItem> get todos => this._todos;

  set todos(List<TodoItem> _newTodos) {
    this._todos = _newTodos;
  }

  void fetchTodos() async {
    // initialize the TodoServices class
    TodoServices todoServices = TodoServices();
    // run the fetchTodos function in TodoServices class to get all todos from backend
    List<TodoItem> __todos = await todoServices.fetchTodos();
    // update the _todos variable
    this._todos = __todos;
    // notify the ui to change
    notifyListeners();
  }

  void addTodo(String text) async {   
    // initialize the TodoServices class
    TodoServices todoServices = TodoServices();
    // run the addTodo function in TodoServices class to post the todo into the api
    int id = await todoServices.addTodo(text);
    // create a new todoitem
    TodoItem todoItem = TodoItem(content: text, id: id, isDone: false);
    // add todoitem to the list
    _todos.add(todoItem);

    print(todoItem.id);

    notifyListeners();
  }

  void removeTodo(int id) {
    // initialize the TodoServices class
    TodoServices todoServices = TodoServices();
    // run the updateStatus function in TodoServices class to update the todo status into the api
    todoServices.removeTodo(id);
    this._todos = this._todos.where((TodoItem element) {
      return element.id != id;
    }).toList();
    print(_todos);
    notifyListeners();
  }

  void updateTodo(int id, bool newValue) {
    // initialize the TodoServices class
    TodoServices todoServices = TodoServices();
    // run the updateStatus function in TodoServices class to update the todo status into the api
    todoServices.updateStatus(id, newValue);
    notifyListeners();
  }

}
