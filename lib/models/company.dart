class Company {
  int? id;
  String? fantasyName;
  String? cnpj;
  String? street;
  String? number;
  String? district;
  String? phoneNumber;
  String? segment;
  String? image;

  Company(
      {this.id,
      this.fantasyName,
      this.cnpj,
      this.street,
      this.number,
      this.district,
      this.phoneNumber,
      this.segment,
      this.image});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fantasyName = json['fantasy_name'];
    cnpj = json['cnpj'];
    street = json['street'];
    number = json['number'];
    district = json['district'];
    phoneNumber = json['phone_number'];
    segment = json['segment'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fantasy_name'] = fantasyName;
    data['cnpj'] = cnpj;
    data['street'] = street;
    data['number'] = number;
    data['district'] = district;
    data['phone_number'] = phoneNumber;
    data['segment'] = segment;
    data['image'] = image;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
