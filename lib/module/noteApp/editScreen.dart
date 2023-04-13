import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/module/noteApp/noteScreen.dart';
import 'package:note_app/shared/AppCubit.dart';
import 'package:note_app/shared/CubitState.dart';

class EditScreen extends StatelessWidget{
  Map? model;

  EditScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, states) {},

      builder: (BuildContext context,  states) {
        return Scaffold(
          backgroundColor: CupertinoColors.darkBackgroundGray,
          body:  showScreen(context, model!),
          // Padding(
          //   padding: const EdgeInsets.all(20),
          //   child: SingleChildScrollView(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         SizedBox(
          //           height: 30,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Container(
          //               height: 40,
          //               width: 40,
          //               decoration: BoxDecoration(
          //                 color: Colors.black26,
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //               child: IconButton(onPressed: (){
          //                 // setState(() {
          //                 //   Navigator.pop(context);
          //                 // });
          //               },
          //                 icon: Icon(
          //                   Icons.arrow_back_rounded,
          //                   size: 20,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //             SizedBox(width: 270,),
          //
          //             Container(
          //               height: 40,
          //               width: 40,
          //               decoration: BoxDecoration(
          //                 color: Colors.black26,
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //               child: IconButton(
          //                 onPressed: (){
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) =>NoteScreen()));
          //                 },
          //                 icon: Icon(
          //                   Icons.edit,
          //                   size: 20,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 20,),
          //         Text('${notes['title']}',
          //           style: TextStyle(
          //             fontSize: 30,
          //             color: Colors.grey,
          //           ),
          //         ),
          //         SizedBox(
          //             height: 40
          //         ),
          //         Text('',
          //           style: TextStyle(
          //             fontSize: 20,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
Widget showScreen(context,Map model)
{
  return  Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 270,),

                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: (){
                      AppCubit.get(context).EditButton(context, model);
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text('${model['title']}',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
                height: 40
            ),
            Text('${model['description']}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
  );


}