
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/models/ShopAppModel/shoploginmodel.dart';
import 'package:todo_app/modules/shop_app/Shop_Loginscreen/cubit/cubit.dart';
import 'package:todo_app/modules/shop_app/Shop_Loginscreen/cubit/states.dart';
import 'package:todo_app/modules/shop_app/shop_registerscreen/shop_registerscreen.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/network/locale/cache_helper.dart';

import '../../../layout/shopapp/shopapp.dart';

class Shop_Login_Screen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSucessState)
            {
              if(state.loginModel.status)
                {
                  CacheHelper.saveData(key: 'token', value: state.loginModel.data.token);
                  navigatePushAndDelete(context, Shop_Screen());
                }
              else{

                toastShow(msg: state.loginModel.message, state: toastStatus.ERROR);
              }
            }

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),),
                        Text('Login now to browse our hot offers',style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        )),
                        SizedBox(height: 30,),
                        defaultTextForm(
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your email address';
                              }
                            },
                            controller: emailController,
                            type: TextInputType.emailAddress, label: 'Email', prefix: Icons.email) ,
                        SizedBox(height: 15),
                        defaultTextForm(validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'password is too short';
                          }

                        },
                          visblepass: (){

                          ShopLoginCubit.get(context).changeVisibilty() ;} ,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'password',
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix ,

                        ) ,
                        SizedBox(height:15) ,
                        ConditionalBuilder(condition: state is! ShopLoginLoadingState,
                            builder: (context)=>defaultButton(function: (){
                          if(formkey.currentState!.validate())
                          {
                            ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text) ;
                          }
                        }, text: 'Login'), fallback: (context)=>Center(child:CircularProgressIndicator())) ,

                        SizedBox(height:15) ,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(onPressed: (){
                              navigateTo(context, Shop_Register_screen()) ;
                            }, child: Text('Register'))
                          ],)

                      ],
                    ),
                  ),
                ),
              ),
            ),


          ) ;
        },
      ),
    );
  }



}
