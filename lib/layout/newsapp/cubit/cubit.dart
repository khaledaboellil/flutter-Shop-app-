import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/newsapp/cubit/states.dart';



import '../../../modules/news_app/bussiness/bussiness_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sport/sport_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialStates());
  static NewsCubit get(context)=> BlocProvider.of(context) ;
  int current_index=0 ;
  List <Widget>screens =[BussinessScreen(),SportScreen(),ScienceScreen()];

  List<BottomNavigationBarItem>Navitems=[
    BottomNavigationBarItem(icon:Icon(Icons.business_sharp),label: "bussiness") ,
    BottomNavigationBarItem(icon:Icon(Icons.sports),label: "sport") ,
    BottomNavigationBarItem(icon:Icon(Icons.science),label: "science") ,

  ];
  void changeBottomNavBar(index){

    current_index=index ;
    if(index==1)
      {
        getSports() ;
      }
    else if(index==2)
      {
        getScience();
      }
    emit(NewsBottomNavState());
  }
  List<dynamic> business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    if(business.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country': 'eg',
          'category': 'business',
          'apiKey': '472480d8d4b14060a31a677b7b67037e',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        business = value?.data['articles'];
        print(business[0]['title']);

        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }
    else
      {
        emit(NewsGetBusinessSuccessState());
      }
  }
  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'472480d8d4b14060a31a677b7b67037e',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value?.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'472480d8d4b14060a31a677b7b67037e',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science = value?.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetScienceSuccessState());
    }
  }
  List<dynamic> search = [];

  void getSearch(value)
  {

    emit(NewsGetSearchLoadingState());
    search=[] ;

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':'$value',

        'apiKey':'472480d8d4b14060a31a677b7b67037e',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value?.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
  }

