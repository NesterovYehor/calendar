import 'package:calendar/components/task_tile.dart';
import 'package:calendar/screens/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override 
  void initState() {
    final vm = Provider.of<HomeViewModel>(context, listen: false); 
    vm.db.fetchTasksForDate(vm.today);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
        appBar: AppBar(
          title:  Text(vm.isTodaySelected()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => vm.addNewTask(context),
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: vm.today,
                rowHeight: 40,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, vm.today),
                onDaySelected: (selectedDay, focusedDay) =>
                    vm.onDaySelected(selectedDay, focusedDay),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, events) => vm.dayBuilder(context, date, events),
                  todayBuilder: (context, date, events) => vm.dayBuilder(context, date, events),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.56,
                decoration: const BoxDecoration(
                  color: Color(0xff30384c),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: EdgeInsets.only(left: 10, top: 40),
                      child: Text(
                         vm.isTodaySelected(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: vm.db.todayTasksList.length,
                        itemBuilder: (context, index) {
                          
                          if (vm.db.todayTasksList.isEmpty) {
                            return const Center(
                              child: Text(
                                "NO TASK FOR TODAY",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          } else {
                            return  TaskTile(
                              taskName: vm.db.todayTasksList[index][0], 
                              taskCompleted: vm.db.todayTasksList[index][2], 
                              onChanged: (value) => vm.onChanged(value!, index), 
                              deleteTapped: (p0) => vm.deleteTask(index, context), 
                              taskDescription: vm.db.todayTasksList[index][1],
                              taskTime: vm.db.todayTasksList[index][3],
                              settingsTapped: (p0) => vm.openSettings(context, index),
                              );
                            }
                          },
                        ),
                      ),
                    ], 
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
