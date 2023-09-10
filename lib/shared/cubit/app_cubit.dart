import 'package:bloc/bloc.dart';
import 'package:e_you/modules/archived_tasks/archived_tasks.dart';
import 'package:e_you/modules/done_tasks/done_tasks.dart';
import 'package:e_you/modules/new_tasks/new_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of<AppCubit>(context);

  int currentIndex = 0;

  List<Widget> screen = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];

  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase(){
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // print("DataBase Created");
        database
            .execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          // print("Table Created");
        }).catchError((error) {
          //print("Error when Creating Table ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDateFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase(
      {
        required String title,
        required String time,
        required String date}
      ) async {
     await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")'
      ).then((value) {
        // print("$value Inserted successfully");
        emit(AppInsertDatabaseState());

        getDateFromDatabase(database);

      }).catchError((error) {
        // print("error when Inserting new record ${error.toString()}");
      });
      return null;
    });
  }

  void getDateFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
      database.rawQuery('SELECT* FROM tasks').then((value) {

        value.forEach((element){
          if(element['status'] == 'new'){
            newTasks.add(element);
          }
          else if(element['status'] == 'done'){
            doneTasks.add(element);
          }else{
            archivedTasks.add(element);
          }
        });
        emit(AppGetDatabaseState());
      });
  }

  void updateData(
      {
        required String status,
        required int id
      }) async{
    database.rawUpdate(
       'UPDATE tasks SET status = ? WHERE id = ?',
        [status,id]
   ).then((value) {
     getDateFromDatabase(database);
     emit(AppUpdateDatabaseState());
    });
  }

  void deleteData(
      {
        required int id
      }) async{
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id]
    ).then((value) {
      getDateFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;

  void changeBottomShettState({
    required bool isShow,
    required IconData icon
  }){
    isBottomSheetShow = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}
