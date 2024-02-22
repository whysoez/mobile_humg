import './AddressInfo.dart';

class UserInfo{
  String? name;
  String? email;
  String? phoneNumber;
  DateTime? birthDate;
  AddressInfo? address;

  static List<UserInfo> fromMap(List<AddressInfo> addressInfo){
    List<UserInfo> userInfoList = [];
    for(int i = 0; i < addressInfo.length; i++){
      UserInfo userInfo = UserInfo();
      userInfo.name = addressInfo[i].province?.name;
      userInfo.email = 'email$addressInfo[$i].province?.id';
      userInfo.phoneNumber = '0$addressInfo[$i].province?.id';
      userInfo.birthDate = DateTime.now();
      userInfo.address = addressInfo[i];
      userInfoList.add(userInfo);
    }
    return userInfoList;
  }
}