import 'package:flutter/material.dart';
import 'package:quan_ly_dan_cu/screens/admin_home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  TextEditingController? _username;

  TextEditingController? _password;
  bool _showPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(top: 150,bottom: 20,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Đăng nhập",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.black),),
            const SizedBox(height: 30,),
            const Text("Tài khoản",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
            const SizedBox(height: 10,),
            TextField(
              controller: _username,
            ),
            const SizedBox(height: 30,),
            const Text("Mật khẩu",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
            const SizedBox(height: 10,),
            TextField(
              controller: _password,
              obscureText: _showPass,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_showPass==true? Icons.visibility_off : Icons.visibility,size: 20,),
                  onPressed: (){
                    setState(() {
                      _showPass = !_showPass;
                    });
                  },
                )
              ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomePage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Đăng nhập",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
