import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/network/locale/cache_helper.dart';

import '../Shop_Loginscreen/Shop_loginScreen.dart';
class OnBoardingModel{
  late final String image ;
  late final String title ;
  late final String body ;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  }
      ) ;
}
class OnBoardingScreens extends StatelessWidget {
  var boardController = PageController();
  bool islast=false ;
  List<OnBoardingModel> boarding = [
    OnBoardingModel(image:'assets/images/onboard_1.jpg', title: 'On Board 1 title', body: 'On Board 1 Body'),
    OnBoardingModel(image:'assets/images/onboard_1.jpg', title: 'On Board 2 title', body: 'On Board 2 Body'),
    OnBoardingModel(image:'assets/images/onboard_1.jpg', title: 'On Board 3 title', body: 'On Board 3 Body')

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
          TextButton(onPressed: (){ submit(context);}, child: Text('Skip')),

      ],),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(

            children: [
              Expanded(
                  child:PageView.builder(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (int index){
                      if (index == boarding.length - 1) {
                        islast= true ;
                      }
                    },
                    itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),itemCount: boarding.length,controller:boardController ,)),
              SizedBox(
                height: 40.0,
              ),
              Row(children: [
                SmoothPageIndicator(controller: boardController, count: 3,) ,
                Spacer() ,
                FloatingActionButton(onPressed: (){
                  if (islast)
                    {
                      submit(context);
                    }
                  boardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn) ;
                },child: Icon(Icons.arrow_forward_ios),)
              ],)
            ] ),
      )

    );
  }
  void submit(context)
  {
    CacheHelper.saveData(key: 'onBoarding', value: true);
    navigatePushAndDelete(context, Shop_Login_Screen()) ;
  }
  Widget buildBoardingItem(OnBoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image:AssetImage('${model.image}'))) ,
      SizedBox(height: 30,),
      Text('${model.title}',style: TextStyle(fontSize: 24),),
      SizedBox(height: 15.0,),
      Text('${model.body}',style: TextStyle(fontSize: 14),),
      SizedBox(height: 30.0,),
    ],
  );
}
