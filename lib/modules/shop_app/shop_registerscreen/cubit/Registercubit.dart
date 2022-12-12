import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/network/endpoint/endpoint.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../models/register model/registermodel.dart';
import 'RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);
  RegisterModel? registerModel ;
  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {

      "email": email,
      "phone": phone,
      "password": password,
      "name": name,
    }).then((value) {

      registerModel=RegisterModel.fromJson(value!.data) ;
      emit(RegisterSuccessState(registerModel));
    }).catchError((e){
      print(e.toString());
      emit(RegisterErrorState());
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeVisibilty(){

    isPassword = ! isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(RegisterChangePass());
  }
}