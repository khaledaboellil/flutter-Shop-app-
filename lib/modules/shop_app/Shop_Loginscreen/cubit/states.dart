import 'package:todo_app/models/ShopAppModel/shoploginmodel.dart';

abstract class ShopLoginStates {}
class ShopLoginInitialState extends ShopLoginStates {}
class ShopLoginLoadingState extends ShopLoginStates {}
class ShopLoginSucessState extends ShopLoginStates {
  late final ShopLoginModel loginModel ;
  ShopLoginSucessState(this.loginModel) ;
}
class ShopLoginErrorState extends ShopLoginStates {
  late final String error ;
  ShopLoginErrorState(this.error) ;
}

class ShopLoginChangeVisbility extends ShopLoginStates {}
