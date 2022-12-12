import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomecubit.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomestate.dart';
import 'package:todo_app/models/categoriesModel/categoriesmodel.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

class ShopCategory extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,ShopHomeStates>(
        listener: (context,states){},
        builder: (context,states){
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder:(context,index)=>buildCatItem(HomeCubit.get(context).categoriesModel!.data!.data[index]) ,
              separatorBuilder:(context,index)=>myDivider(),
              itemCount: HomeCubit.get(context).categoriesModel!.data!.data.length) ;
        },
        ) ;
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(
            '${model.image}'),
            width: 80,
            height: 80,
            fit: BoxFit.cover,

        ),
        SizedBox(width: 20,) ,
        Text(
          '${model.name}' ,
          style: TextStyle(
            fontSize: 20 ,
            fontWeight: FontWeight.bold ,
          )
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios
        ),
      ],
    ),
  ) ;
}
