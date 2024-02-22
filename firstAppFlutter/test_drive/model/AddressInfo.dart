import 'dart:math';

import './Province.dart';
import './District.dart';
import './Ward.dart';

class AddressInfo{
  Province? province;
  District? district;
  Ward? ward;
  String? street;

  static List<AddressInfo> fromMap(List<Province> province, List<District> district, List<Ward> ward){
    List<AddressInfo> addressInfoList = [];
    int minLength = [province.length, district.length, ward.length].reduce(min);
    int max = minLength > 5 ? 5 : minLength;
    for(int i = 0; i < max; i++){
        AddressInfo addressInfo = AddressInfo();
        addressInfo.province = province[i];
        addressInfo.district = district[i];
        addressInfo.ward = ward[i];
        addressInfo.street = 'StreetName$i';
        addressInfoList.add(addressInfo);
    }
    return addressInfoList;
  }
}