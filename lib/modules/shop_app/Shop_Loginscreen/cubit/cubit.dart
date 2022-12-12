import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/Shop_Loginscreen/cubit/states.dart';
import 'package:todo_app/shared/network/endpoint/endpoint.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../models/ShopAppModel/shoploginmodel.dart';
import '../../../../shared/comapnents/constans.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=> BlocProvider.of(context) ;

  late ShopLoginModel loginModel ;
  void userLogin(
  {
    required String email ,
    required String password,
  }
      ){
        emit(ShopLoginLoadingState()) ;
        DioHelper.postData(url: LOGIN, data: {
          'email' : email ,
          'password':password,
        }).then((value) {
          loginModel=ShopLoginModel.fromJosn(value?.data);
          token=loginModel.data.token ;
          print(value.toString()) ;
          emit(ShopLoginSucessState(loginModel)) ;

        }).catchError((error)
            {
              print(error.toString()) ;
              emit(ShopLoginErrorState(error.toString()));
            }
        );

       }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeVisibilty(){

        isPassword = ! isPassword ;
        suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

        emit(ShopLoginChangeVisbility());
       }
}