import 'package:hive/hive.dart';

class ToDoDataBase{

  List toDoList = [];
  //reference the box
  final _myBox = Hive.box('MyBox');

  //jb user first time app open karay ga to usay ya task show hongay
  void createInitialData(){
    toDoList = [
      ['Welcome to do list' , false],
      ['You can list your task here' , false],
      ['Swipe left every task that you want to delete' , false],
    ];
  }

  //loading data
  void loadData(){
    toDoList = _myBox.get("ToDoList");
  }

  //updating database
  void updateData(){
    _myBox.put("ToDoList", toDoList);
  }
}