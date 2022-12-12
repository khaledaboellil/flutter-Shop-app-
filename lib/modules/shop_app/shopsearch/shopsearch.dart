import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomecubit.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomestate.dart';

import '../../../models/SearchModel/SearchModel.dart';
import '../../../shared/comapnents/companents.dart';
import '../../../shared/comapnents/constans.dart';

class ShopSearch extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    bool isSearch=false;
    var searchController =TextEditingController() ;
    return BlocConsumer<HomeCubit,ShopHomeStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                defaultTextForm(validate:(String? value){
                  if(value!.isEmpty)
                  {
                    return "Search must not be empty" ;
                  }
                  return null ;
                },
                    onChange: (value)
                    {
                      HomeCubit.get(context).getSearchData(value) ;
                      isSearch=true ;
                    }
                    ,  controller: searchController, type: TextInputType.text, label: "Search", prefix:Icons.search),
                Expanded(child: state is! LoadingSearchState ? listBuilder(HomeCubit.get(context).searchModel!.data!.data,context,state,loading: isSearch):Center(child: CircularProgressIndicator(),))

              ],
            ),
          ),
        );
      },
    );
  }



  Widget listBuilder( list ,context,state,{ required bool loading}) => ConditionalBuilder(
    condition: list.length > 0 &&loading&&state is! LoadingSearchState,
    builder: (context) =>
        ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildSeacrhList(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,),
    fallback: (context) => state is! LoadingSearchState ? Container() : Center(child: CircularProgressIndicator()),
  );



  Widget buildSeacrhList(Data? model,context)=>Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(image: NetworkImage('${model!.image}'),
            width: 150,
            height: 150,
          ),
          if(model.discount != 0)
            Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  height: 1.3
              ),

            ),
            SizedBox(height: 70,),
            Row(
              children: [
                Text(
                  '${model.price}',

                  style: TextStyle(
                    color: defaultcolor,
                    fontSize: 12,
                  ),

                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}