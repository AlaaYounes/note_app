import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/layout/homeLayout.dart';
import 'package:note_app/shared/AppCubit.dart';

import '../../shared/CubitState.dart';

class SearchScreen extends StatelessWidget{
  var SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states){},
      builder: (context, states) {
        var cubit =AppCubit.get(context);
        return SafeArea(
  child: Scaffold(
  backgroundColor: CupertinoColors.darkBackgroundGray,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white10
              ),
              child: TextFormField(
                controller: SearchController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                onFieldSubmitted: (value){
                  cubit.SearchDatabase(value);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                  ),
                  hintText: 'Search By the keyword...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);

                    },

                  ),
                ),
              ),
            ),
            ConditionalBuilder(
              condition: cubit.search.length > 0,
              builder: (BuildContext context) {
                return Expanded(
                child: ListView.builder(

                    itemBuilder: (context, index)=>buildNote(context: context, model: cubit.search[index])
                    , itemCount: cubit.search.length)
                );
               },
              fallback: (BuildContext context) {
                return Center(
                  child: Column(
                    children: [
                      Image.asset('images/search.png'),
                      Text('File not found. Try searching again.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      )

  ),
    );
      }
  );
  }

}