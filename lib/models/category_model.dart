class Category {
  int? id;
  String? createdDate;
  String? name;

  Category({this.id, this.createdDate, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    data['name'] = this.name;
    return data;
  }
}