class Products {
  int? id;
  String? name;
  String? value;
  int? idCompany;
  String? quantity;
  int? idCategory;
  String? description;
  String? image;
  String? star;

  Products(
      {this.id,
      this.name,
      this.value,
      this.idCompany,
      this.quantity,
      this.idCategory,
      this.description,
      this.image,
      this.star});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    idCompany = json['id_company'];
    quantity = json['quantity'];
    idCategory = json['id_category'];
    description = json['description'];
    image = json['image'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['id_company'] = this.idCompany;
    data['quantity'] = this.quantity;
    data['id_category'] = this.idCategory;
    data['description'] = this.description;
    data['image'] = this.image;
    data['star'] = this.star;
    return data;
  }
}
