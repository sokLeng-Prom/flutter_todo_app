import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider_demo/models/todo_item.dart';

class TodoServices {
  Future<List<TodoItem>> fetchTodos() async {
    // sends http "get" request to get list of todos
    print("fetching...");
    http.Response response = await http
        .get('https://fathomless-inlet-42914.herokuapp.com/api/todos');
    // the response back is a json string. So we run the below code to convert it to a Map<String, dynamic>
    Map<String, dynamic> parsed = json.decode(response.body);
    // the json structure should be something like below
    // { "data": [ {"id": int, "status": bool, "title": string} ] }
    // so we are going to loop through the data and turn each elements into a TodoItem
    List<dynamic> data = parsed["data"];
    List<TodoItem> todos = data.map((dynamic e) {
      // here e = {"id": int, "status": bool, "title": string}
      // we are going to pass it into TodoItem.fromJson in order to turn e into a TodoItem
      return TodoItem.fromJson(e);
    }).toList();
    print(todos.toString());
    // return the list of todo items
    return todos;
  }

  Future<int> addTodo(String title) async {
    // initialize the url to a string variable
    String url = "https://fathomless-inlet-42914.herokuapp.com/api/new";
    // intialize the headers to a map with key of "content-type" and value of "applicaiton/json"
    Map<String, String> headers = {"Content-Type": "application/json"};
    // initialize the map for the body which takes in the input from text field
    Map<String, String> bodyMap = {"title": title};
    // parse the bodyMap into the "todo" nest and encode it into json
    var bodyData = json.encode({
      "todo": bodyMap,
    });
    // call http.post with the params set above
    http.Response response = await http.post(url, headers: headers, body: bodyData);
    // print just to see if its working
    print('adding...');
    
    if (response.statusCode == 201) {
      print(response.body);
      print('added successfully');        

      Map<String, dynamic> parsed = json.decode(response.body);
    
      return parsed["data"]["id"];

    } 
  }

  removeTodo(int id) async {
    // initialize the url to a string variable with id
    String url = "https://fathomless-inlet-42914.herokuapp.com/api/delete/$id";
    // intialize the headers to a map with key of "content-type" and value of "applicaiton/json"
    Map<String, String> headers = {"Content-Type": "application/json",};
    // call http.delete to delete the todoitem at the id specified
    http.Response response = await http.delete(url, headers: headers);

    // print to see if its working
    print('deleting...');
    
    if (response.statusCode == 200) {
      print(response.body);
      print('deleted successfully');
    }

  }

  updateStatus(int id, bool newValue) async {
    // initialize the url to a string variable
    String url = "https://fathomless-inlet-42914.herokuapp.com/api/update";
    // intialize the headers to a map with key of "content-type" and value of "applicaiton/json"
    Map<String, String> headers = {"Content-Type": "application/json"};
    // encode the id and status into json taking the same structure as in insomnia (jes te dak te lol)
    var bodyData = json.encode({
      "id": id,
      "updated": {
        "status": newValue
      },
    });
    // call the http.patch to update the api
    http.Response response = await http.patch(url, headers: headers, body: bodyData);
    // print to see if its working
    print('updating...');
    
    if(response.statusCode == 200) {
      print(response.body);
      print('updated successfully');
    }
    
  }

}
