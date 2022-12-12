import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/Shop_Loginscreen/Shop_loginScreen.dart';
import 'package:todo_app/modules/shop_app/shop_registerscreen/cubit/RegisterStates.dart';
import 'package:todo_app/modules/shop_app/shop_registerscreen/cubit/Registercubit.dart';
import 'package:todo_app/shared/comapnents/constans.dart';

import '../../../layout/shopapp/shopapp.dart';
import '../../../shared/comapnents/companents.dart';
import '../../../shared/network/locale/cache_helper.dart';
import '../Shop_Loginscreen/cubit/cubit.dart';

class Shop_Register_screen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;
  var phoneController=TextEditingController();
  var nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),

      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState)
          {
            if(state.model!.status!)
            {
              CacheHelper.saveData(key: 'token', value: state.model!.data!.token);
              toastShow(msg: 'Account has been created', state: toastStatus.SUCESS);
              navigatePushAndDelete(context, Shop_Login_Screen());
            }
            else{
              toastShow(msg: '${state.model!.message}', state: toastStatus.ERROR);
            }
          }

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register',style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),),
                        Text('Register to browse our hot offers',style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        )),
                        SizedBox(height: 30,),
                        defaultTextForm(
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your username';
                              }
                            },
                            controller: nameController,
                            type: TextInputType.name, label: 'UserName', prefix: Icons.drive_file_rename_outline) ,
                        SizedBox(height: 15),
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

                          RegisterCubit.get(context).changeVisibilty() ;} ,
                          isPassword: RegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'password',
                          prefix: Icons.lock_outline,
                          suffix: RegisterCubit.get(context).suffix ,

                        ) ,
                        SizedBox(height:15) ,
                        defaultTextForm(
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your PhoneNumber';
                              }
                            },
                            controller: phoneController,
                            type: TextInputType.phone, label: 'Phonenumber', prefix: Icons.email) ,
                        SizedBox(height: 15),
                        ConditionalBuilder(condition: state is! RegisterLoadingState,
                            builder: (context)=>defaultButton(function: (){
                              if(formkey.currentState!.validate())
                              {
                                RegisterCubit.get(context).registerUser(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone:phoneController.text,
                                    name: nameController.text ,

                                ) ;
                              }
                            }, text: 'Register'), fallback: (context)=>Center(child:CircularProgressIndicator())) ,


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
