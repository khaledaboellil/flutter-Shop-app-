import '../../../../models/register model/registermodel.dart';

abstract class RegisterStates{}


class RegisterInitialState extends RegisterStates {}

class RegisterChangePass extends RegisterStates{}
class RegisterLoadingState extends RegisterStates {}


class RegisterSuccessState extends RegisterStates {
  RegisterModel? model;

  RegisterSuccessState(this.model);
}
class RegisterErrorState extends RegisterStates {

}