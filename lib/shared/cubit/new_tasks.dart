

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/comapnents/constans.dart';
import 'package:todo_app/shared/cubit/states.dart';

import 'cubit.dart';



class newtasks extends StatelessWidget {
  int  currentindex=0 ;

  @override
  Widget build(BuildContext context) {
    TodoCubit cubit = TodoCubit.get(context);
    return BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {},
        builder: (context, state)
{
      return ListView.separated(
          itemBuilder:(contex,index)=> buildtaskscreen(cubit.tasks[index]["time"],cubit.tasks[index]["title"],cubit.tasks[index]["date"]),

          separatorBuilder: (contex,index)=>Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),

          itemCount: cubit.tasks.length);

  }
    );
  }
}
