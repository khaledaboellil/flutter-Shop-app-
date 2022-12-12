import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/newsapp/cubit/states.dart';

import 'package:todo_app/shared/network/locale/cache_helper.dart';


import '../../../shared/network/remote/dio_helper.dart';

class ModeCubit extends Cubit<NewsStates> {
  ModeCubit() : super(NewsInitialStates());

  static ModeCubit get(context) => BlocProvider.of(context);
  bool isDark = false ;
  void changelightmode({bool? fromShared}){
    if (fromShared!=null)
      {
        isDark=fromShared ;
        emit(NewsChangeLightMode());
      }
    else {
      isDark = !isDark;
      CacheHelper.putData("isDark", isDark).then((value) {
        emit(NewsChangeLightMode());
      });
      print(isDark);
    }

  }
}