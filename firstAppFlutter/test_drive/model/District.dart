class District{
  String? id;
  String? name;
  String? level;
  String? provinceId;

  static District fromMap(dynamic input){
    District district = District();
    district.id = input['id'];
    district.name = input['name'];
    district.level = input['level'];
    district.provinceId = input['provinceId'];
    return district;
  }
}
