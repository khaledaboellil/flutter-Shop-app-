import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomecubit.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomestate.dart';
import 'package:todo_app/modules/shop_app/Shop_Loginscreen/Shop_loginScreen.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/network/locale/cache_helper.dart';

class ShopSettings extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController() ;
  var userNameController = TextEditingController() ;
  var phoneController = TextEditingController() ;
  var passwordController =TextEditingController() ;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit,ShopHomeStates>(
      listener: (context, state) {
        if(state is UpdateSuccessState)
        {
          if(state.updateModel!.status!)
          {
            CacheHelper.saveData(key: 'token', value: state.updateModel!.data!.token);
            toastShow(msg: 'Account has been updated', state: toastStatus.SUCESS);
            navigatePushAndDelete(context, Shop_Login_Screen());
          }
          else{
            toastShow(msg: '${state.updateModel!.message}', state: toastStatus.ERROR);
          }
        }
      },
      builder: (context,state){
        var model = HomeCubit.get(context).profileModel ;
        emailController.text=model!.data!.email! ;
        userNameController.text=model.data!.name!;
        phoneController.text=model.data!.phone!;

        print('this is model ');
        print(model);
        return  ConditionalBuilder(
            condition: model != null,
            builder: (context)=>Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      defaultTextForm(
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your username';
                            }
                          },
                          controller: userNameController,
                          type: TextInputType.name,
                          label: 'UserName',
                          prefix: Icons.drive_file_rename_outline) ,
                      SizedBox(height: 10,) ,
                      defaultTextForm(
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your emailaddress';
                            }
                          },
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email) ,
                      SizedBox(height: 10,),
                      defaultTextForm(
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your phonenumber';
                            }
                          },
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'PhoneNumber',
                          prefix: Icons.phone_android) ,
                      SizedBox(height: 10,),
                      defaultTextForm(validate: (String? value){
                        if(value!.isEmpty)
                        {
                          return 'password is too short';
                        }

                      },
                        visblepass: (){

                        HomeCubit.get(context).changeVisibilty() ;} ,
                        isPassword: HomeCubit.get(context).isPassword,
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'password',
                        prefix: Icons.lock_outline,
                        suffix: HomeCubit.get(context).suffix ,

                      ) ,
                      SizedBox(height : 120,),
                      ConditionalBuilder(condition: state is! LoadingUpdateState,
                          builder: (context)=>defaultButton(function: (){
                            if(formkey.currentState!.validate())
                            {
                              print('ana hnahnahna ybm elhall');
                              HomeCubit.get(context).updateUser(
                                email: emailController.text,
                                password: passwordController.text,
                                phone:phoneController.text,
                                name: userNameController.text ,

                              ) ;

                            }
                          }, text: 'Update',width: 250), fallback: (context)=>Center(child:CircularProgressIndicator())),

                      SizedBox(height: 15,) ,
                      defaultButton(function: (){
                        signOut(context);
                      }, text: 'Logout',width: 250 )
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator())) ;
      },
    );
  }


  void signOut(context){
    CacheHelper.removeData(key: 'token') ;
    navigatePushAndDelete(context, Shop_Login_Screen()) ;
  }
}