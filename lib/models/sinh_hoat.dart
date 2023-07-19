import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:quan_ly_dan_cu/models/tham_gia.dart';

class SinhHoat {
  String? id;
  String? chude;
  DateTime? batdau;
  DateTime? ketthuc;
  String? diadiem;
  List<ThamGia>? nguoithamgia;

  SinhHoat(
      {this.id,
      this.chude,
      this.batdau,
      this.ketthuc,
      this.diadiem,
      this.nguoithamgia});

  SinhHoat.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    chude = json['chuDe'];
    batdau = DateTime.parse(json['batDau']);
    ketthuc = DateTime.parse(json['ketThuc']);
    diadiem = json['diaDiem'];
    var listNguoithamgia = json['thamGiasById'] as List;

    if (listNguoithamgia.isEmpty) {
      print(id! + "Khong co gi");
    } else {
      List<ThamGia> nhungnguoithamgia = [];
      for (var i = 0; i < listNguoithamgia.length; i++) {
        nhungnguoithamgia
            .add(ThamGia.fromJson(listNguoithamgia[i]));
      }
      nguoithamgia = nhungnguoithamgia;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chuDe'] = chude;
    data['batDau'] = batdau!.toIso8601String();
    data['ketThuc'] = ketthuc!.toIso8601String();
    data['diaDiem'] = diadiem;
    return data;
  }

  static List<SinhHoat> parsedSinhHoat(String body) {
    final parsed = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsed.map<SinhHoat>((json) => SinhHoat.fromJson(json)).toList();
  }

  static Future<List<SinhHoat>> getAll(Client client) async {
    final response = await client
        .get(Uri.parse("http://10.0.2.2:8081/api/v1/sinh-hoat/all"));
    return compute(parsedSinhHoat, response.body);
  }

  static create(SinhHoat sinhHoat) async {
    await post(
      Uri.parse('http://10.0.2.2:8081/api/v1/sinh-hoat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sinhHoat.toJson()),
    );
  }

  static update(SinhHoat sinhHoat) async {
    await put(
      Uri.parse('http://10.0.2.2:8081/api/v1/sinh-hoat?id=${sinhHoat.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sinhHoat.toJson()),
    );
  }

  static deleteByID(int id) async {
    await delete(
      Uri.parse('http://10.0.2.2:8081/api/v1/sinh-hoat?id=$id'),
    );
  }

  static addThamGia(int idSinhHoat, int idNhanKhau) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sinhHoat'] = idSinhHoat;
    data['nhanKhau'] = idNhanKhau;
    await post(
      Uri.parse('http://10.0.2.2:8081/api/v1/tham-gia'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        data
      ),
    );
  }
}
