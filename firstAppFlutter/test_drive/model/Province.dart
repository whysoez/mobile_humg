class Province{
  String? id;
  String? name;
  String? level;

  static Province fromMap(dynamic input){
    Province province = Province();
    province.id = input['id'];
    province.name = input['name'];
    province.level = input['level'];
    return province;
  }

}
