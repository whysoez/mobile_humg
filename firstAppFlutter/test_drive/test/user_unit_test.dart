import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import '../model/AddressInfo.dart';
import '../model/Province.dart';
import '../model/District.dart';
import '../model/UserInfo.dart';
import '../model/Ward.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp());
  String data = await rootBundle.loadString('assets/don_vi_hanh_chinh.json');
  Map<String, dynamic> jsonData = jsonDecode(data);
  List provinceData = jsonData['province'];
  List districtData = jsonData['district'];
  List wardData = jsonData['ward'];
  List<Province> provinceList = [];
  List<District> districtList = [];
  List<Ward> wardList = [];
  List<AddressInfo> addressInfoList = [];

  group('Unit Test all method fromMap in all class', () {
    test("Test User", () {
      provinceList = provinceData.map((e) => Province.fromMap(e)).toList();
      expect(provinceList.isNotEmpty, true);
    });

    test('Province', () {
      districtList = districtData.map((e) => District.fromMap(e)).toList();
      expect(districtList.isNotEmpty, true);
    });

    test('Ward', () {
      wardList = wardData.map((e) => Ward.fromMap(e)).toList();
      expect(wardList.isNotEmpty, true);
    });

    test('AddressInfo Test', () {
      addressInfoList =
          AddressInfo.fromMap(provinceList, districtList, wardList);
      expect(addressInfoList.isNotEmpty, true);
    });

    test('UserInfo Test', () {
      var userList = UserInfo.fromMap(addressInfoList);
      expect(userList.isNotEmpty, true);
    });
  });
}
