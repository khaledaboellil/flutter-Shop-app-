import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/comapnents/constans.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class  TodoApp extends StatelessWidget {





  var scaffoldKey = GlobalKey<ScaffoldState>() ;
  var formKey = GlobalKey<FormState>() ;

  IconData toggleicon = Icons.edit ;
  var titlecontroller= TextEditingController();
  var timecontroller= TextEditingController();
  var datecontroller= TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..createdatabase(),
      child: BlocConsumer<TodoCubit, TodoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            TodoCubit cubit = TodoCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.title[cubit.currentindex]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isbottomsheetshow) {
                    if (formKey.currentState!.validate()) {
                      cubit.insrettodatabase(
                          titlecontroller.text, timecontroller.text,
                          datecontroller.text).then((value) {
                          cubit.getfromdatabase(cubit.database).then((value) {
                          Navigator.pop(context);
                          cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                          // setState(() {
                          cubit.tasks = value ;
                          // print(tasks) ;
                          // });
                        });
                      });
                    }
                  }
                  else {
                    scaffoldKey.currentState!.showBottomSheet((context) =>

                        Container(

                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //======================= tasktitle formfield =====================//
                                defaultTextForm(controller: titlecontroller,

                                    type: TextInputType.text,
                                    validate: (String ?value) {
                                      if (value!.isEmpty) {
                                        return "title must be not empty ";
                                      }
                                      return null;
                                    },
                                    label: "Task title",
                                    prefix: Icons.title),
                                SizedBox(height: 15,),
                                //======================= time formfield ===========================//
                                defaultTextForm(controller: timecontroller,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).then((
                                          value) {
                                        timecontroller.text =
                                            value!.format(context);
                                      });
                                    },
                                    validate: (String ?value) {
                                      if (value!.isEmpty) {
                                        return "time must be not empty ";
                                      }
                                      return null;
                                    },
                                    label: "Task time",
                                    prefix: Icons.watch_later),

                                SizedBox(height: 15,),
                                //======================= Date formfield ===========================//
                                defaultTextForm(controller: datecontroller,
                                    type: TextInputType.datetime,

                                    onTap: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2022-05-20')
                                      ).then((value) {
                                        datecontroller.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validate: (String ?value) {
                                      if (value!.isEmpty) {
                                        return "Date must be not empty ";
                                      }
                                      return null;
                                    },
                                    label: "Task Date",
                                    prefix: Icons.calendar_today),
                              ],
                            ),
                          ),
                        ),
                      elevation: 20,
                    ).closed.then((value) {
                      cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);

                    });

                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);

                  }
                },
                child: Icon(cubit.fabIcon),
              ),
              body: cubit.screens[cubit.currentindex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentindex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: "Tasks",

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cloud_done),
                    label: "Done",

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: "Archived",

                  ),
                ],
              ),
            );
          }
      ),
    );
  }


}
