import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:note_app/layout/homeLayout.dart';
import 'package:note_app/module/noteApp/editScreen.dart';



import '../../shared/AppCubit.dart';
import '../../shared/CubitState.dart';

var formKey = GlobalKey<FormState>();
var titleController = TextEditingController();
var descriptionController = TextEditingController();
Color? color1;

class NoteScreen extends StatelessWidget {
  Map model;
  String? title;
  String? description;
  NoteScreen({required this.model});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {},
        builder: (BuildContext context, AppStates states) {
          child:
          if (states is AppEditButtonState) {
            titleController.text = model['title'];
            descriptionController.text = model['description'];
            return buildItem(context, true,model);
          }
          return buildItem(context, false,model);
        });
  }
}

Widget buildItem(context, bool edit,Map<dynamic,dynamic> model) {
  return Scaffold(
    backgroundColor: CupertinoColors.darkBackgroundGray,
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
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
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Icon(
                                    Icons.info,
                                    color: Colors.blueGrey,
                                  ),
                                  content: Text(
                                    'Are You sure to discard changes ?',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.black45,
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            AppCubit()..SaveNotes(context,);
                                          },
                                          child: Text(
                                            'Keep',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Colors.greenAccent,
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Discard',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 190,
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                      showDialog(context: context,
                          builder: (_) {
                            return AlertDialog(
                              backgroundColor: Colors. greenAccent,
                            title: Text('color picker'),
                               actions:[
                                 BlockPicker(
                                   pickerColor: Colors.red, //default color
                                   onColorChanged: (Color color){
                                     color1 = color;//on color picked
                                     print(color1);
                                     print(color1.toString().indexOf('0x'));
                                     print(color1.toString().substring(35,45));
                                     print(color1.toString().length);
                                     print('You choose color: $color1');
                                   },
                                 ),
                                 MaterialButton(
                                   onPressed: () {
                                     AppCubit.get(context).c = color1;
                                     Navigator.pop(context);
                                   },
                                   color: Colors.black,
                                   child:
                                   Text(
                                     'Got it',
                                      style: TextStyle(
                                      color: Colors.white
                                    ),
                                   ),
                                 )
                               ]
                          );

                          });
                      print(color1);

                      },
                      icon: Icon(
                        Icons.visibility_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),

                  ),

                  SizedBox(width: 20),
                  //  Save Button and AlertBox
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Icon(
                                    Icons.info,
                                    color: Colors.blueGrey,
                                  ),
                                  content: Text(
                                    'Save changes ?',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.black45,
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            if (edit == true) {
                                              AppCubit.get(context)
                                                  .UpdateNotes(context,model);
                                              Navigator.pop(context);
                                              titleController.text = descriptionController.text ='';
                                            } else {
                                              AppCubit.get(context)
                                                  .SaveNotes(context);
                                            }
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Colors.greenAccent,
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Discard',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                      },
                      icon: Icon(
                        Icons.save_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
                maxLines: 2,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type something...',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                maxLines: null,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),


            ],
          ),
        ),
      ),
    ),
  );
}


