import 'package:flutter/material.dart';
import 'package:quan_ly_dan_cu/screens/khoan_thu_phi/khoan_thu_phi_page.dart';
import 'package:quan_ly_dan_cu/screens/login_page.dart';
import 'package:quan_ly_dan_cu/screens/sinh_hoat/sinh_hoat_page.dart';



class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 150,right: 20,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Menu",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(height: 50,),
            TextButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>KhoanThuPhiPage()));},
                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue
                  ),
                  child: const Center(child: Text("Khoản thu phí",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),)),
                )),
            const SizedBox(height: 20,),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SinhHoatPage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue
                  ),
                  child: const Center(child: Text("Sinh hoạt",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),)),
                )),
            const SizedBox(height: 20,),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue
                  ),
                  child: const Center(child: Text("Đăng xuất",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),)),
                )),
          ],
        ),
      ),
    );
  }
}
