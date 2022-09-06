import 'package:ecommerce/models/category_model.dart';

class ProductModel {
  int? id;
  String? image;
  String? createdDate;
  String? name;
  double? amount;
  String? description;
  Category? category;

  ProductModel(
      {this.id,
        this.image,
        this.createdDate,
        this.name,
        this.amount,
        this.description,
        this.category});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdDate = json['createdDate'];
    name = json['name'];
    amount = json['amount'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['createdDate'] = this.createdDate;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['description'] = this.description;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}