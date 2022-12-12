class UpdateModel {
  bool? status;
  String? message;
  UpdateData? data;



  UpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UpdateData.fromJson(json['data']) : null;
  }

}

class UpdateData {

  String? name;
  String? email;
  String? phone;
  String? token;


  UpdateData.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }

}