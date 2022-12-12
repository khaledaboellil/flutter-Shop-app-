import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/newsapp/cubit/cubit.dart';
import 'package:todo_app/layout/newsapp/cubit/states.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

class Search  extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list =NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: defaultTextForm(validate:(String? value){
                  if(value!.isEmpty)
                  {
                    return "Search must not be empty" ;
                  }
                  return null ;
                },
                    onChange: (value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    }
                    ,  controller: searchController, type: TextInputType.text, label: "Search", prefix:Icons.search),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true))
            ],
          ),
        );
      },

    );
  }
}
