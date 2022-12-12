import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/todo_app/arcived_tasks/archived_tasks.dart';
import '../../modules/todo_app/done_tasks/done_tasks.dart';
import 'new_tasks.dart';


class TodoCubit extends Cubit<TodoStates>{
  TodoCubit() : super(TodoInitialStates());
  static TodoCubit get(context)=> BlocProvider.of(context) ;
  late Database database ;
  int currentindex=0 ;
  bool isbottomsheetshow = false ;
  List tasks =[];
  List<Widget>screens=[
      newtasks(),
      donetasks(),
      archivedtasks()
                       ];
  List<String>title=[
      "New Tasks",
      "Done Tasks",
      "Archived Tasks"
                     ];

  void changeIndex(int index)
  {
    currentindex=index ;
    emit(TodoChangeBottomNav()) ;
  }
  void createdatabase() {
    openDatabase("tasks.db", version: 1,
        onCreate: (database, version) {
          print("Data base created ");
          database
              .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((value) {
            print("table created ");
          }).catchError((error) {
            print('${error.toString}');
          });
        }, onOpen: (database) {
          getfromdatabase(database);
          print("data base open");
        }).then((value) {
          database=value ;
          emit(TodoCreatedata());
    });
  }

  Future insrettodatabase(
      @required title,
      @required time,
      @required date,
      ) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("${title}","${date}","${time}","NEW")')
          .then((value) {
        print("data insert sucessfully");

        emit(TodoInsertdata());
      }).catchError((error) {
        print("${error.toString()}");
      });
    });
  }
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isbottomsheetshow = isShow;
    fabIcon = icon;

    emit(TodoChangeBottomSheetState());
  }
  Future<List<Map>> getfromdatabase(database) async {

    emit(TodoGetdata()) ;
    return await database.rawQuery('SELECT * FROM tasks');
  }
}