class GetProfileModel {
  bool? status;
  DataProfile? data;



  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DataProfile.fromJson(json['data']) : null;
  }


}

class DataProfile {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? token;


  DataProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }
}