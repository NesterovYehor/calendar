import 'package:calendar/components/my_alert_box.dart';
import 'package:calendar/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomeViewModel extends ChangeNotifier {
  DateTime today = DateTime.now();
  final db = DataService();

  void onDaySelected(DateTime day, DateTime focusedDay) {
    today = day;
    db.fetchTasksForDate(today);
    notifyListeners();
  }

  void onChanged(bool value, int index) {
    db.todayTasksList[index][2] = value;
    db.updateDatabase(today);
    notifyListeners();
  }

  void addNewTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          onSave: (taskName, description, selectedTime) {
            List newTask = [taskName, description, false ,selectedTime.format(context), today];
            db.todayTasksList.add(newTask);
            db.updateDatabase(today);
            notifyListeners();
          },
          taskName: '',
          description: '',
        );
      },
    );
  }

  String isTodaySelected() {
    if (
      today.year == DateTime.now().year && 
      today.month == DateTime.now().month && 
      today.day == DateTime.now().day){
      return "Today you have ${db.todayTasksList.length} to do";
    }
    else{
      String monthName = DateFormat('MMMM').format(DateTime(today.year, today.month, today.day));
      return  "${today.day} of ${monthName} ${today.year}y.";
    }
  }

  void deleteTask(int index, BuildContext context){
    db.deleteTask(index);
    db.updateDatabase(today);
    notifyListeners();
  }

  int getNumberOfTasksForDay(DateTime date) {
    return db.countTasksForDate(date);
  }

  Widget dayBuilder(
    context,
    date,
    events,
  ) {
    final numberOfTasks = getNumberOfTasksForDay(date);

    return Column(
      children: [
        Text(
          '${date.day}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff30384c)
          ),
        ),
        Text(
          '$numberOfTasks Tasks',
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xff30384c)
          ),
        ),
      ],
    );
  }

  void openSettings( BuildContext context, int index){
    showDialog(
      context: context,
       builder: (context) {
         return MyAlertBox(
          onSave: (taskName, description, selectedTime) {
           List newTask = [taskName, description, false ,selectedTime.format(context)];
            db.todayTasksList.add(newTask);
            db.updateDatabase(today);
            notifyListeners();
          }, 
          taskName: db.todayTasksList[index][0],
          description: db.todayTasksList[index][1],
        );
      },
    );
  }
}
