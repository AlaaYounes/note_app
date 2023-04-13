
import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/module/noteApp/SearchScreen.dart';
import 'package:note_app/module/noteApp/editScreen.dart';
import 'package:note_app/module/noteApp/noteScreen.dart';
import 'package:note_app/shared/AppCubit.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/CubitState.dart';
List colors =[
  Colors.orange,Colors.red,Colors.green,
  Colors.pink,Colors.greenAccent,Colors.indigo,
  Colors.purple, Colors.redAccent, Colors.indigoAccent,
  Colors.cyan
];


Random random = new Random();
int index = 0;
var gestureKey = GlobalKey<RawGestureDetectorState>();
var DismissibleKey = GlobalKey();
// void changeIndex() {
//   setState(() => index = random.nextInt(3));
// }
class HomeLayout extends StatelessWidget{
  Database? database;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, states){},
        builder: (context, states) {
          var tasks = AppCubit.get(context).notes;
          child:
          return Scaffold(
                        backgroundColor: CupertinoColors.darkBackgroundGray,
                        appBar: AppBar(
                          backgroundColor: CupertinoColors.darkBackgroundGray,
                          title: Text(
                            'Notes',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(

                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));

                                },
                                  icon: Icon(
                                    Icons.search,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(

                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(onPressed: (){
                                  showDialog(context: context,
                                      builder: (_)=> AlertDialog(
                                        backgroundColor: Colors.white12,
                                        content: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                            height: 10,
                                          ),
                                            Text(
                                               'Designed by: Alaa Younes' ,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Developed by: Alaa Younes & Mohamed Ezz',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )


                                  );
                                },
                                  icon: Icon(
                                    Icons.info_outline_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        body:
                        tasksBuilder(notes: tasks),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            AppCubit.get(context).Add(context);
                          },
                          child: Icon(
                            Icons.add,
                          ),
                          backgroundColor: Colors.white12,
                        ),
                      );
        }
    );
  }
  
}





Widget tasksBuilder({ required List<Map> notes})
{
  return ConditionalBuilder(
    condition: notes.length > 0,
    builder: (BuildContext context) {
      return ListView.separated(
        itemBuilder: (context, index) =>
            buildNote(model: notes[index],context: context),
        separatorBuilder: (context, index) =>
            Container(
              width: 200,
              height: 1,
              color: Colors.white12,
            ),
        itemCount: notes!.length,
      );
    },
    fallback: (context){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/Notebook-rafiki.png'),
            Text('Create your first note !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ],
        ),
      );
    },
  );
}
Widget buildNote(
    { required context,
  required Map model})
{
  return Dismissible(
        key: Key(model['id'].toString()),
        onDismissed: (direction){
          AppCubit.get(context).DeleteDataBase(id: model['id']);
        },
    child: GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=> EditScreen(model: model,),
            )
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(int.parse(model['color'])),
              borderRadius:BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
        ),
      ),
    ),
  );

}
 