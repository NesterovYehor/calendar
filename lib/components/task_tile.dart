import 'package:calendar/components/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTapped,
    required this.taskDescription,
    required this.taskTime,
    required this.settingsTapped,

  });

  final String taskName;
  final String taskTime;
  final String taskDescription;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showPopover(
        context: context,
        bodyBuilder: (context) {
          return MenuItems(
            onSettings: () => settingsTapped!(context),
            deleteTapped: () => deleteTapped!(context),
          );
        },
        width: 250,
        height: 120,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 1.4,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    shape: const CircleBorder(),
                    activeColor: const Color.fromARGB(255, 99, 230, 103),
                    checkColor: Colors.black,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    taskDescription,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(taskTime, style: TextStyle(color: Colors.white, fontSize: 17),)
            ],
          ),
        ),
      ),
    );
  }
}