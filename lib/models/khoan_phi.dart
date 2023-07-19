import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dong_gop.dart';
import 'package:http/http.dart';

class KhoanPhi {
  String? id;
  String? ten;
  DateTime? batdau;
  DateTime? ketthuc;
  int? dinhmuc;
  int? batbuoc;
  List<DongGop>? donggops;

  KhoanPhi({this.id, this.ten, this.batdau, this.ketthuc, this.dinhmuc = 0,this.donggops,this.batbuoc = 0});

  KhoanPhi.fromJson(Map<String,dynamic> json){
    id = json['id'].toString();
    ten = json['ten'];
    print(ten);
    batdau = DateTime.parse(json['batDau']);
    ketthuc = DateTime.parse(json['ketThuc']);
    dinhmuc = json['dinhMuc'];
    batbuoc = json['batBuoc'];
    var danhsachdonggop = json['dongGopsById'] as List;
    if(danhsachdonggop.isEmpty){
      print("Khong co gi");
    }else{
      List<DongGop> listDonggop = [];
      for(var i=0;i<danhsachdonggop.length;i++){
        listDonggop.add(DongGop.fromJson(danhsachdonggop[i]));
      }
      donggops = listDonggop;
    }
    // donggops = DongGop.parseDongGop(danhsachdonggop.toString());
    // if(donggops!.isEmpty)print(null);
    // else{
    //   print(donggops!.first.id);
    // }
    // print(danhsachdonggop.toString());
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ten'] = ten;
    data['batDau'] = DateFormat('yyyy-MM-dd').format(batdau!);
    data['ketThuc'] = DateFormat('yyyy-MM-dd').format(ketthuc!);
    data['dinhMuc'] = dinhmuc;
    data['batBuoc'] = batbuoc;
    // data['dongGopsById'] = donggops!.map((e) => e.toJson()).toList();
    return data;
  }

  static List<KhoanPhi> parseKhoanPhi(String body){
    final parsed = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsed.map<KhoanPhi>((json)=>KhoanPhi.fromJson(json)).toList();
  }

  static Future<List<KhoanPhi>> getAll(Client client) async {
    final response = await client.get(Uri.parse("http://10.0.2.2:8081/api/v1/khoan-phi/all"));
    return compute(parseKhoanPhi,response.body);
  }

  static create(KhoanPhi khoanPhi) async {
    Map<String,dynamic> khoanphi = khoanPhi.toJson();
    await post(
      Uri.parse('http://10.0.2.2:8081/api/v1/khoan-phi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        khoanphi
      ),
    );
  }

  static deleteByID(int id) async {
    await delete(
      Uri.parse('http://10.0.2.2:8081/api/v1/khoan-phi?id=$id'),
    );
  }

  static update(KhoanPhi khoanPhi) async {
    await put(
      Uri.parse('http://10.0.2.2:8081/api/v1/khoan-phi?id=${khoanPhi.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(khoanPhi.toJson()),
    );
  }
}