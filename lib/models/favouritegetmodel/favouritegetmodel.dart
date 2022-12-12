class GetFavoruitemodel {
  bool? status;
  GetFavData? data;

  GetFavoruitemodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = new GetFavData.fromJson(json['data']) ;
  }

}

class GetFavData {
  int? currentPage;
  List<Data> data=[];


  GetFavData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  Product? product;



  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =Product.fromJson(json['product']) ;
  }


}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;




  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];

  }

}
