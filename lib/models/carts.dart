class Cart {
  int? id;
  String? value;
  int? quantity;
  String? product;
  int? idProd;

  Cart({this.id, this.value, this.quantity, this.product, this.idProd});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    quantity = json['quantity'];
    product = json['product'];
    idProd = json['idProd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['quantity'] = quantity;
    data['product'] = product;
    data['idProd'] = idProd;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
