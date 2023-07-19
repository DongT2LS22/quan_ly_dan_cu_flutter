import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'ho_khau.dart';

class DongGop {
  String? id;
  HoKhau? hokhau;
  int? sotien;
  DateTime? ngaydong;
  int? dadong;

  DongGop({this.id, this.hokhau, this.sotien = 0, this.ngaydong,
      this.dadong = 0});

  DongGop.fromJson(Map<String,dynamic> json){
    id = json['id'].toString();
    hokhau = HoKhau.fromJson(json['hoKhau']??"");
    sotien = json['soTien']??0;
    ngaydong = DateTime.parse(json['ngayDong']??DateTime(2023,1,1).toString());
    dadong = json['daDong']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idHoKhau'] = hokhau!.id;
    data['soTien'] = sotien;
    data['ngayDong'] =DateFormat("yyyy-MM-dd").format(ngaydong!);
    data['daDong'] = dadong;
    return data;
  }

  static List<DongGop> parseDongGop(String body){
    final parsed = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsed.map<DongGop>((json)=>DongGop.fromJson(json)).toList();
  }

  // static Future<List<KhoanPhi>> getAll(Client client) async {
  //   final response = await client.get(Uri.parse("http://10.0.2.2:8081/api/v1/khoan-phi/all"));
  //   return compute(parseKhoanPhi,response.body);
  // }
  static Future<DongGop> getById(int id) async {
    Response response = await get(Uri.parse("http://10.0.2.2:8081/api/v1/dong-gop?id=${id}"));
    DongGop dongGop = DongGop.fromJson(jsonDecode(response.body));
    return dongGop;
  }

  static void create(DongGop dongGop,int id)async{
    final Map<String,dynamic> createDonggop = dongGop.toJson();
    createDonggop['idKhoanPhi'] = id;
    await post(
      Uri.parse('http://10.0.2.2:8081/api/v1/dong-gop'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        createDonggop
      ),
    );
  }

  static void update(DongGop dongGop)async{
    await put(
      Uri.parse('http://10.0.2.2:8081/api/v1/dong-gop?id=${int.parse(dongGop.id!)}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          dongGop.toJson()
      ),
    );
  }

  static void deleteById(String id) async {
    await delete(
      Uri.parse("http://10.0.2.2:8081/api/v1/dong-gop?id=${int.parse(id)}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}