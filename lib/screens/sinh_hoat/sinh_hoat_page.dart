import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quan_ly_dan_cu/models/sinh_hoat.dart';
import 'package:quan_ly_dan_cu/screens/admin_home_page.dart';
import 'package:quan_ly_dan_cu/screens/sinh_hoat/tao_sinh_hoat_page.dart';
import 'package:quan_ly_dan_cu/screens/sinh_hoat/thong_ke_sinh_hoat_page.dart';
import 'package:quan_ly_dan_cu/widgets/sinh_hoat/sinh_hoat_card.dart';

class SinhHoatPage extends StatefulWidget {
  SinhHoatPage({Key? key}) : super(key: key);

  @override
  State<SinhHoatPage> createState() => _SinhHoatPageState();
}

class _SinhHoatPageState extends State<SinhHoatPage> {
  late Future<List<SinhHoat>> list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = SinhHoat.getAll(Client());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,),
          onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminHomePage())),
        ),
        title: const Text("Sinh hoạt",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.black),),
        actions: [
          IconButton(
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const TaoSinhHoatPage()));},
              icon: const Icon(Icons.add,size: 25,color: Colors.black,)
          ),
          const SizedBox(width: 5,),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ThongKeSinhHoatPage()));
              },
              icon: const Icon(
                Icons.bar_chart,
                color: Colors.black,
                size: 20,
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FutureBuilder<List<SinhHoat>>(
            future: list,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!.map((e) => (
                      Column(
                        children: [
                          SinhHoatCard(sinhHoat: e),
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
