import 'dart:convert';

import 'package:http/http.dart';
import 'package:quan_ly_dan_cu/models/nhan_khau.dart';

class ThamGia {
  int? id;
  NhanKhau? nhanKhau;
  int? thamgia;

  ThamGia({this.id,this.nhanKhau, this.thamgia});

  ThamGia.fromJson(Map<String,dynamic> json){
    id = json['id'];
    nhanKhau = NhanKhau.fromJson(json['nhanKhau']);
    thamgia = json['coMat'];
  }


  static update(ThamGia thamGia) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coMat'] = thamGia.thamgia;
    await put(
      Uri.parse('http://10.0.2.2:8081/api/v1/tham-gia?id=${thamGia.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        data
      ),
    );
  }
}