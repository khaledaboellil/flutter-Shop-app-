import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomecubit.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomestate.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

import '../../../models/favouritegetmodel/favouritegetmodel.dart';
import '../../../shared/comapnents/constans.dart';

class ShopFavourite extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! LoadingGetFavSuccessState,
            builder:(context) =>ListView.separated(
                itemBuilder: (context, index) =>
                    BuildFavListInRow(HomeCubit
                        .get(context)
                        .favModel!
                        .data!
                        .data[index].product, context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: HomeCubit
                    .get(context)
                    .favModel!
                    .data!
                    .data
                    .length),
            fallback: (context) => Center(child: CircularProgressIndicator()),);
      },
    );
  }

  Widget BuildFavListInRow(Product? model, context) =>
      Expanded(
        child: Column(
          children: [
            Row(
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
                            '${model.price!.round()}',

                            style: TextStyle(
                              color: defaultcolor,
                              fontSize: 12,
                            ),

                          ),
                          SizedBox(width: 5,),
                          if(model.discount != 0)
                            Text(

                              '${model.oldPrice!.round()}',

                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),

                            ),
                          Spacer(),
                          CircleAvatar(
                            backgroundColor: istrue(HomeCubit
                                .get(context)
                                .fav[model.id]) ? defaultcolor : Colors.grey,
                            child: IconButton(onPressed: () {
                              HomeCubit.get(context).changeButtonColor(model.id);


                            },
                              icon: Icon(Icons.favorite_border),
                              color: Colors.white,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}