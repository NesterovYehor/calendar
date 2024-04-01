import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertBox extends StatefulWidget {
  MyAlertBox({Key? key, required this.onSave, required this.taskName, required this.description}) : super(key: key);

  final Function(String, String, TimeOfDay) onSave;
  final String taskName;
  final String description;

  @override
  _MyAlertBoxState createState() => _MyAlertBoxState();
}

class _MyAlertBoxState extends State<MyAlertBox> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _taskController.text = widget.taskName;
    _descriptionController.text = widget.description;
 }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff30384c),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Task Name',  
                hintStyle: TextStyle(color: Colors.grey), 
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Description (if needed)', 
                hintStyle: TextStyle(color: Colors.grey), 
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => Container(
                    height: 300,
                    color: Colors.white,  
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          _selectedTime = TimeOfDay.fromDateTime(newTime);
                        });
                      },
                      use24hFormat: true,
                      minuteInterval: 1,
                    ),
                  ),
                );
              },
              child: Text(
                'Selected Time: ${_selectedTime.format(context)}',  
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(_taskController.text, _descriptionController.text, _selectedTime);
            Navigator.pop(context);
          },
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
