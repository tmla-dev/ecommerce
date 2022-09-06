class OrderModel {
  int? productId;
  String? productName;
  double? amount;
  int? quantity;
  double? lineTotal;

  OrderModel(
      {this.productId,
        this.productName,
        this.amount,
        this.quantity,
        this.lineTotal});

  OrderModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    amount = json['amount'];
    quantity = json['quantity'];
    lineTotal = json['lineTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['lineTotal'] = this.lineTotal;
    return data;
  }
}
