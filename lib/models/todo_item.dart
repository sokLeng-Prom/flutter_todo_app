
import 'dart:convert';

TodoItem todoFromJson(String str) => TodoItem.fromJson(json.decode(str));

String todoToJson(TodoItem todoItem) => json.encode(todoItem.toJson());

class TodoItem {
  int id;
  String content;
  bool isDone;

  TodoItem({
    int id,
    String content,
    bool isDone,
  }) {
    this.id = id;
    this.content = content;
    this.isDone = isDone;
  }

  TodoItem.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.content = json["title"];
    this.isDone = json["status"];
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "title": content,
    "status": isDone
  };
}
