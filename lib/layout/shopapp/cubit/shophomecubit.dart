import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomestate.dart';
import 'package:todo_app/models/GetUserModel/GetUserModel.dart';
import 'package:todo_app/models/SearchModel/SearchModel.dart';
import 'package:todo_app/models/ShopAppModel/Homemodel.dart';
import 'package:todo_app/models/UpdateModel/UpdateModel.dart';
import 'package:todo_app/models/categoriesModel/categoriesmodel.dart';
import 'package:todo_app/models/favouritegetmodel/favouritegetmodel.dart';
import 'package:todo_app/models/postFav/postFavModel.dart';
import 'package:todo_app/modules/shop_app/Shop_Loginscreen/cubit/states.dart';
import 'package:todo_app/modules/shop_app/shopcategory/shopcategory.dart';
import 'package:todo_app/modules/shop_app/shopfavourite/shopfavoruite.dart';
import 'package:todo_app/modules/shop_app/shophome/shophome.dart';
import 'package:todo_app/modules/shop_app/shopsettings/shopsettings.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../shared/comapnents/constans.dart';
import '../../../shared/network/endpoint/endpoint.dart';

class HomeCubit extends Cubit<ShopHomeStates>
{
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context)=>BlocProvider.of(context) ;

  int currentindex = 0 ;
  List<BottomNavigationBarItem>Navshopitems=[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favourite'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'category'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),

  ];
  List<Widget>pages=[
    ShopHome(),
    ShopFavourite(),
    ShopCategory(),
    ShopSettings(),
  ];

  void changeScreen(index){
    currentindex=index ;
    emit(changeBottonNav()) ;

  }
  HomeModel ?homeModel ;

  Map<int?,bool?>fav = {} ;
  void getHomeData(){

    DioHelper.getData(url: HOME,token: token).then((value) {

      homeModel=HomeModel.fromJson(value!.data) ;



      homeModel!.data!.products.forEach((elements){

          fav.addAll({
            elements.id:elements.inFavourites ,
          }) ;
       });
      print(fav) ;
      emit(ShopHomeDataSuccessState()) ;

    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataErrorState());
    }) ;
    emit(ShopHomeDataLoadingState()) ;
  }

  CategoriesModel ?categoriesModel ;
  void getCategoriesData(){
    DioHelper.getData(url: GET_CATEGORIES,token: token).then((value) {

      categoriesModel=CategoriesModel.fromJson(value!.data) ;


      emit(ShopCategoriesSuccessState()) ;

    }).catchError((error){
      print(error.toString());
      emit(ShopCategoriesErrorState());
    }) ;
    emit(ShopHomeDataLoadingState()) ;
  }

  GetFavoruitemodel ?favModel ;
  FavPostModel ? favPost ;

  void changeButtonColor(int? s){
    print('ana hna ') ;
    emit(ChangeFavState()) ;
    if(fav[s]!=null  )
      {
        if(fav[s]== true )
          {
            fav[s]=false ;
          }
        else
          {
            fav[s]=true;
          }
      }
    print('ana hna 1') ;
    DioHelper.postData(url: FAV, data: {"product_id":s},token: token ) .then((value) {
      print('ana hna 12') ;
      print(value!.data);
      favPost = FavPostModel.fromJson(value.data) ;

      print(favPost!.status);
      print('anan hnaaaa');
      if(favPost!.status==false )
        {
          if(fav[s]!=null  )
          {
            if(fav[s]== true )
            {
              fav[s]=false ;
            }
            else
            {
              fav[s]=true;
            }
          }
        }
      else{

        getFavouriteData() ;
      }
      emit(ChangeFavSucessState(favPost!)) ;
    }).catchError(
        (onError)
            {
              print(onError.toString()) ;
              emit(ChangeFavErrorState());
            }
    ) ;

  }
  void getFavouriteData(){

    print('khaled');
    emit(LoadingGetFavSuccessState()) ;

    DioHelper.getData(url: FAV,token: token).then((value) {

      favModel=GetFavoruitemodel.fromJson(value!.data) ;
      print(favModel!.data!.data.length);

      print(favModel.toString());
      emit(GetFavSuccessState()) ;

    }).catchError((error){
      print(error.toString());
      emit(GetFavErrorState());
    }) ;

  }
  GetProfileModel? profileModel ;
 void getProfileData(){
    emit(LoadingGetProState()) ;
    DioHelper.getData(url: PROFILE,token: token).then(
            (value) {
              print(value!.data) ;
              profileModel=GetProfileModel.fromJson(value.data) ;
              print(profileModel);
              emit(GetProSuccessState(profileModel)) ;
            }
            ).catchError((onError){
            print(onError.toString()) ;
            emit(GetProErrorState()) ;
    }) ;
 }
UpdateModel? updateModel ;
 void updateUser({
   required String name,
   required String phone,
   required String email,
   required String password,
}){
  emit(LoadingUpdateState());
  DioHelper.putData(url: UPDATE,token: token ,data: {
    "name":name ,
    "phone":phone,
    "password":password,
    "email":email
  }).then((value){
    updateModel=UpdateModel.fromJson(value!.data) ;
    print(updateModel!.data);
    emit(UpdateSuccessState(updateModel)) ;
  }).catchError((e){
    print(e.toString());
    emit(UpdateErrorState()) ;
  });
 }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeVisibilty(){

    isPassword = ! isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(UpdateChangePass());
  }
  SearchModel? searchModel ;
  void getSearchData(String s){
    emit(LoadingSearchState());
    DioHelper.postData(url: SEARCH, data: {"text":s}).then((value){
      searchModel = SearchModel.fromJson(value!.data) ;
      print(searchModel!.data!.data);
      print(searchModel!.data!.data.length);
      emit(SearchSuccessState(searchModel));
    }).catchError((e){
      print(e.toString());
      emit(SearchErrorState());
    });
  }
}