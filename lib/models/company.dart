class Company {
  int id;
  String name;
  bool isActive;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Company(
      {this.id,
      this.name,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

List<Map> getCompanys(List allcompanys) {
  print('${allcompanys.length}----');
  List<Map> json_allcompanys = [];
  allcompanys.forEach((allcompany) {
    Map map_company = {
      "id": allcompany.id,
      "name": allcompany.name,
      "isActive": allcompany.isActive,
      "createdAt": allcompany.createdAt,
      "updatedAt": allcompany.updatedAt,
      "deletedAt": allcompany.deletedAt
    };
    json_allcompanys.add(map_company);
  });

  return json_allcompanys;

  // return [
  //   {
  //     "id": 1,
  //     "name": "kulchon vanich",
  //     "is_active": 0,
  //     "created_at": null,
  //     "updated_at": null,
  //     "deleted_at": null
  //   }
  // ];
}
