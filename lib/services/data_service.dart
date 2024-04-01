import 'package:calendar/date_time/date_time.dart';
import 'package:hive/hive.dart';

class DataService {
  List todayTasksList = [];

  final _myBox = Hive.box("Tasks_DataBase");


  fetchTasksForDate(DateTime date) {
    todayTasksList = _myBox.get(todaysDateFormatted(date)) ?? [];
  }

  void updateDatabase(date) {
    _myBox.put(todaysDateFormatted(date), todayTasksList);
  }

  void deleteTask(int index) {
    todayTasksList.removeAt(index);
  }

  int countTasksForDate(DateTime date) {
    List? tasks = _myBox.get(todaysDateFormatted(date));
    
    if (tasks != null) {
      return tasks.length;
    } else {
      return 0;
    }
  }
}
