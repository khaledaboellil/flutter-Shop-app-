import 'package:todo_app/models/GetUserModel/GetUserModel.dart';

import '../../../models/SearchModel/SearchModel.dart';
import '../../../models/UpdateModel/UpdateModel.dart';
import '../../../models/postFav/postFavModel.dart';

class ShopHomeStates {}

class HomeInitialState extends ShopHomeStates{}

class changeBottonNav extends ShopHomeStates{}


class ShopHomeDataLoadingState extends ShopHomeStates{}

class ShopHomeDataSuccessState extends ShopHomeStates{}


class ShopHomeDataErrorState extends ShopHomeStates{}
class ShopCategoriesSuccessState extends ShopHomeStates{}


class ShopCategoriesErrorState extends ShopHomeStates{}
class LoadingGetFavSuccessState extends ShopHomeStates{}

class GetFavSuccessState extends ShopHomeStates{

}



class GetFavErrorState extends ShopHomeStates{}

class ChangeFavState extends ShopHomeStates{}

class ChangeFavSucessState extends ShopHomeStates{
 final FavPostModel model ;
 ChangeFavSucessState(this.model) ;
}

class ChangeFavErrorState extends ShopHomeStates{}

class LoadingGetProState extends ShopHomeStates{}

class GetProSuccessState extends ShopHomeStates{
 GetProfileModel? model ;
 GetProSuccessState(this.model);
}



class GetProErrorState extends ShopHomeStates{}

class LoadingUpdateState extends ShopHomeStates{}

class UpdateSuccessState extends ShopHomeStates{
 UpdateModel? updateModel ;
 UpdateSuccessState(this.updateModel) ;
}

class UpdateErrorState extends ShopHomeStates{}

class UpdateChangePass extends ShopHomeStates{}


class LoadingSearchState extends ShopHomeStates{}

class SearchSuccessState extends ShopHomeStates{
 SearchModel? searchModel ;
 SearchSuccessState(this.searchModel) ;
}

class SearchErrorState extends ShopHomeStates{}