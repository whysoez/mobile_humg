class Ward{
  String? id;
  String? name;
  String? level;
  String? districtId;
  String? provinceId;

  static Ward fromMap(dynamic input){
    Ward ward = Ward();
    ward.id = input['id'];
    ward.name = input['name'];
    ward.level = input['level'];
    ward.districtId = input['districtId'];
    ward.provinceId = input['provinceId'];
    return ward;
  }
}