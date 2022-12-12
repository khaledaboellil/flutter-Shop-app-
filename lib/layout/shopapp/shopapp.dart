import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomecubit.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomestate.dart';
import 'package:todo_app/modules/shop_app/Shop_Loginscreen/Shop_loginScreen.dart';
import 'package:todo_app/modules/shop_app/shopsearch/shopsearch.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/network/locale/cache_helper.dart';

class Shop_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,ShopHomeStates>(

      listener:(context,state){},
      builder:(context,state){
      HomeCubit cubit = HomeCubit.get(context) ;
      return Scaffold(
            appBar: AppBar(
              title: Text('salla'),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, ShopSearch()) ;
                }, icon: Icon(Icons.search)),
              ],
            ),
            body: cubit.pages[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
            items: cubit.Navshopitems,
            currentIndex: cubit.currentindex,
            onTap: (index)=>cubit.changeScreen(index),
            ),
          );
        });
  }



}
