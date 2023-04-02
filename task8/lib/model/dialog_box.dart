// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:task8/model/custom_buttons.dart';

class DialogBox extends StatelessWidget {
  final textController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox(
      {Key? key,
      required this.textController,
      required this.onCancel,
      required this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AlertDialog(
        backgroundColor: Colors.yellow.shade200,
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: textController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2
                    )
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.yellow.shade600 , width: 2)),
                    hintText: 'Add a new task'),
              ),
              const SizedBox(
                height: 33.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(buttonText: 'Save', onPress: onSave),
                  const SizedBox(
                    width: 10.0,
                  ),
                  MyButton(buttonText: 'Cancel', onPress: onCancel),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
