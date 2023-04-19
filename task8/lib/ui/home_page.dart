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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

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

    //icon animation
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
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
            onCancel: () {
              setState(() {
                Navigator.of(context).pop();
                _animationController.reverse();
                isPlaying = false ;
              });
            } ,
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

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.yellow.shade200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              _handleOnPressed();
              createNewTask();
            });
          },
          child: AnimatedIcon(
            icon: AnimatedIcons.add_event,
            progress: _animationController,
          ),
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
