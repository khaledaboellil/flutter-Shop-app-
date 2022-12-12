import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/newsapp/cubit/states.dart';

import 'package:todo_app/shared/comapnents/companents.dart';

import '../../modules/news_app/search/search.dart';
import 'cubit/cubit.dart';
import 'cubit/modecubit.dart';

class NewsApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context)..getBusiness() ;
          return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [IconButton(onPressed: ()=>navigateTo(context, Search()), icon: Icon(Icons.search)) ,
                        IconButton(onPressed: (){ModeCubit.get(context).changelightmode();}, icon: Icon(Icons.brightness_6)),
              ],
            ),
            body: cubit.screens[cubit.current_index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.current_index,
              items:cubit.Navitems ,
              onTap:(index)=> cubit.changeBottomNavBar(index),
            ),
          );
        });
  }
}
