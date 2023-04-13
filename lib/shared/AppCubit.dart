

import 'dart:ffi';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/module/noteApp/editScreen.dart';
import 'package:note_app/shared/CubitState.dart';
import 'package:sqflite/sqflite.dart';

import '../layout/homeLayout.dart';
import '../module/noteApp/noteScreen.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  Database? database;
  List<Map> notes = [];
  Map x= {};
  List<Map> search =[];
  Color? c;


  void CreateDatabase() {
    openDatabase(
        'noteApp.db',
        version: 1,

        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT, description TEXT, color TEXT)'
          ).then((value) {
            print('table inserted successfully');
          }).catchError((onError) {
            print('error when creating table${onError.toString()}');
          });
        },
        onOpen: (database) {
          GetDatabase(database);
          print('database opened');
        }
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  InsertIntoDataBase({
    required String title,
    required String description,
    required String color,
  }) async {
    await database?.transaction((txn) async
    {
      txn.rawInsert(
          'INSERT INTO note(title, description, color) VALUES("$title", "$description", "$color")')
          .then((value) {
        print('$value inserted Successfully.');
        emit(AppInsertIntoDatabaseState());
        GetDatabase(database);
      }).catchError((onError) {
        print('error when inserting new record ${onError.toString()}');
      });
    });
  }

  void GetDatabase(database){
     database.rawQuery(
        'SELECT * FROM note').then((value) {
      notes = value;
      emit(AppGetDatabaseState());
      print(notes);
    });
  }
  void UpdateDatabase(
      {
        required int id,
        String? title,
        String? description,
        String? color,
      }
      )
  async{
    await database?.rawUpdate('UPDATE note SET title = ?, description = ?, color = ? WHERE id = ?', [
      '$title', '$description', '$color', '$id']).then((value) {
      GetDatabase(database);
      emit(AppUpdateDatabaseState());

        print("from Update database");
      });
  }

  Future<void> DeleteDataBase(
      {
        required int id,
      })
  async {
    await database?.rawDelete('DELETE FROM note WHERE id = ?',[id]).then((value) {
      GetDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void Add(context) {

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => NoteScreen(model: x)
      ));
      emit(AppAddState());
  }
  void SaveNotes(context){
    InsertIntoDataBase(
        title: titleController.text,
        description: descriptionController.text,
        color: color1.toString().substring(35,45),
    );
    print(AppCubit().notes);
    Navigator.pop(context);
    Navigator.pop(context);
    titleController.text = descriptionController.text = '';
    emit(AppSaveNoteState());
  }
  void EditButton(context, Map note){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>NoteScreen(model: note,)));
    emit(AppEditButtonState());
  }
  void UpdateNotes(context,Map<dynamic,dynamic>model){
    UpdateDatabase(
        title: titleController.text,
        description: descriptionController.text,
        color: color1.toString().substring(35,45),
        id: model['id']
    );
    Navigator.pop(context);
    Navigator.pop(context);
    print("fromupdate");
  }
  void SearchDatabase(
      String title,
      )
  {
    search=[];
    database?.rawQuery('SELECT * FROM note where title LIKE ?',['$title%']).then((value) {
      search = value;
      emit(AppSearchDatabaseState());
    });
  }
  ChangeCircleAvatarColor()
  {
   var a = c;
  }
}