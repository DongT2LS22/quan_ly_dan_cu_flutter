import 'package:flutter/material.dart';
import 'package:quan_ly_dan_cu/models/khoan_phi.dart';
import 'package:quan_ly_dan_cu/models/nhan_khau.dart';
import 'package:quan_ly_dan_cu/models/sinh_hoat.dart';
import 'package:quan_ly_dan_cu/screens/admin_home_page.dart';

void main() async {
  // String url = "http://localhost:8081/api/v1/khoan-phi/all";
  // Response response = await get(Uri.http("10.0.2.2:8081","/api/v1/khoan-phi/all"));
  // print(response.statusCode);
  runApp(const MyApp());
  // SinhHoat.addThamGia(17, 31);]
  // KhoanPhi.update(KhoanPhi(id: "25",ten: "Trung thu 2023",batdau: DateTime(2023,1,1,1,1,1),ketthuc: DateTime(2023,2,2,2,2,2),batbuoc: 0,dinhmuc: 0));
  // SinhHoat.update(SinhHoat(id: "20",chude: "Hello",batdau: DateTime(2023,1,1,19,30,0),ketthuc:DateTime(2023,1,1,19,30,0),diadiem: "Nha van hoa" ));
  // DongGop.update(DongGop(id: "2",hokhau: HoKhau(id: 1),sotien: 100000,ngaydong: DateTime(2023,1,1),dadong: 1));
  // DongGop.deleteById("1");
  // SinhHoat.create(SinhHoat(chude: "Sinh hoat tong ket nam",batdau: DateTime(2023,1,1,1,0,0),ketthuc:DateTime(2023,1,1,2,0,0),diadiem: "Nha van hoa"));
  // KhoanPhi.create(KhoanPhi(ten: "Khoan phi vo van nao do",batdau: DateTime(2023,1,1),ketthuc: DateTime(2023,1,2),dinhmuc: 0,batbuoc: 0));
  // String url = 'https://jsonplaceholder.typicode.com/posts';
  // Response response = await get(Uri.https("jsonplaceholder.typicode.com","/posts"));
  // print(response.body);
  // DongGop.create(DongGop(id: "1",hokhau: HoKhau(id: 1),sotien: 100000,ngaydong: DateTime(2023,1,1),dadong: 1), 27);
  // DongGop dongGop = await DongGop.getById(20);
  // print(dongGop.hokhau!.diachi);
  // SinhHoat.getAll(Client());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AdminHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

