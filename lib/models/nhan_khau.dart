
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class NhanKhau {
  String? id;
  String? hoten;
  DateTime? ngaysinh;
  String ? noiThuongTru;
  NhanKhau({this.id, this.hoten, this.ngaysinh,this.noiThuongTru});

  NhanKhau.fromJson(Map<String,dynamic> json){
    id = json['id'].toString();
    hoten = json['hoTen'];
    ngaysinh = DateTime.parse(json['ngaySinh']??"2000-01-01");
    noiThuongTru = json['noiThuongTru'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hoTen'] = hoten;
    data['ngaySinh'] = ngaysinh;
    data['noiThuongTru'] = noiThuongTru;
    return data;
  }

  static List<NhanKhau> parseNhanKhau(String body){
    final parsed = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsed.map<NhanKhau>((json)=>NhanKhau.fromJson(json)).toList();
  }

  static Future<List<NhanKhau>> getAll(Client client) async {
    final response = await client.get(Uri.parse("http://10.0.2.2:8081/api/v1/tham-gia/nhan-khau"));
    print("Kha OKE");
    return compute(parseNhanKhau,response.body);
  }

}