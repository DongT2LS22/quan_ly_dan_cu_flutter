import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quan_ly_dan_cu/models/khoan_phi.dart';
import 'package:quan_ly_dan_cu/screens/admin_home_page.dart';
import 'package:quan_ly_dan_cu/screens/khoan_thu_phi/tao_khoan_phi_page.dart';
import 'package:quan_ly_dan_cu/screens/khoan_thu_phi/thong_ke_khoan_thu_page.dart';
import 'package:quan_ly_dan_cu/widgets/khoan_thu_phi/khoan_phi_card.dart';


class KhoanThuPhiPage extends StatefulWidget {
  const KhoanThuPhiPage({Key? key}) : super(key: key);

  @override
  State<KhoanThuPhiPage> createState() => _KhoanThuPhiPageState();
}

class _KhoanThuPhiPageState extends State<KhoanThuPhiPage> {
  late Future<List<KhoanPhi>> listKhoanPhi;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listKhoanPhi = KhoanPhi.getAll(Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomePage()));
          },
        ),
        title: const Text(
          "Khoản thu phí",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaoKhoanPhiPage()));
              },
              icon: const Icon(
                Icons.add,
                size: 25,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ThongKeKhoanThuPage()));
              },
              icon: const Icon(
                Icons.bar_chart,
                size: 20,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FutureBuilder<List<KhoanPhi>>(
            future: listKhoanPhi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!.map((e) => (
                      Column(
                        children: [
                          KhoanPhiCard(khoanPhi: e),
                          const SizedBox(height: 10,)
                        ],
                      )
                  )).toList(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
