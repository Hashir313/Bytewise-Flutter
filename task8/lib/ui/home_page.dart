// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task8/data/database.dart';
import 'package:task8/model/dialog_box.dart';
import 'package:task8/model/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('MyBox');
  ToDoDataBase dataBase = ToDoDataBase();

  @override
  void initState() {
    // TODO: implement initState

    //agar app first time chalay gi to default data load hoga
    if (_myBox.get("ToDoList") == null) {
      dataBase.createInitialData();
    } else {
      // agar user na first time app nai chalai hogi to uska pehlay wala data load hoga
      dataBase.loadData();
    }
    super.initState();
  }

  bool? floatingButton = false;
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      dataBase.toDoList[index][1] = !dataBase.toDoList[index][1];
    });
    dataBase.updateData();
  }

  void addNewTask() {
    setState(() {
      dataBase.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    dataBase.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            textController: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: addNewTask,
          );
        });
  }

  void deleteFunction(int index) {
    setState(() {
      dataBase.toDoList.removeAt(index);
    });
    dataBase.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.yellow.shade200,
        appBar: AppBar(
          title: Text(
            'To Do',
            style: GoogleFonts.figtree(
              fontWeight: FontWeight.w500,
              fontSize: 22.0,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              createNewTask();
            });
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: dataBase.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: dataBase.toDoList[index][0],
                taskStatus: dataBase.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteTask: (BuildContext) => deleteFunction(index),
              );
            }));
  }
}
