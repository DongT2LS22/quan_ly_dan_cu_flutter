import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_dan_cu/screens/khoan_thu_phi/chinh_sua_khoan_phi_page.dart';
import 'package:quan_ly_dan_cu/screens/khoan_thu_phi/khoan_thu_phi_page.dart';
import 'package:quan_ly_dan_cu/widgets/khoan_thu_phi/dong_gop_card.dart';
import '../../models/dong_gop.dart';
import '../../models/khoan_phi.dart';

class ChiTietKhoanThuPage extends StatefulWidget {
  KhoanPhi khoanPhi;
  ChiTietKhoanThuPage({Key? key,required this.khoanPhi}) : super(key: key);

  @override
  State<ChiTietKhoanThuPage> createState() => _ChiTietKhoanThuPageState();
}

class _ChiTietKhoanThuPageState extends State<ChiTietKhoanThuPage> {
  List<DongGop>? list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.khoanPhi.donggops;
  }
  _buildListDongGop(){
    List<Widget> listDonggop = [];
    if(list == null) return listDonggop;
    for (var element in list!) {
      listDonggop.add(DongGopCard(dongGop: element,));
      listDonggop.add(const SizedBox(height: 10,));
    }
    return listDonggop;
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
          onPressed: ()=>Navigator.pop(context),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await KhoanPhi.deleteByID(int.parse(widget.khoanPhi.id!));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const KhoanThuPhiPage()));
              },
              icon: const Icon(Icons.delete,size: 27,color: Colors.black,)
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChinhSuaKhoanPhiPage(khoanPhi: widget.khoanPhi)));
              },
              icon: const Icon(Icons.settings,size: 27,color: Colors.black,)
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tên khoản phí : ${widget.khoanPhi.ten!}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),overflow: TextOverflow.visible,),
              const SizedBox(height: 5,),
              Text("Bắt buộc : ${widget.khoanPhi.batbuoc! == 1 ?"Có" : "Không"}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),overflow: TextOverflow.visible,),
              const SizedBox(height: 5,),
              Text("Bắt đầu : ${DateFormat.yMd().format(widget.khoanPhi.batdau!)}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),),
              const SizedBox(height: 5,),
              Text("Kết thúc : ${DateFormat.yMd().format(widget.khoanPhi.ketthuc!)}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),),
              const SizedBox(height: 5,),
              Text("Định mức : ${widget.khoanPhi.dinhmuc??"0"}đ",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),),
              const SizedBox(height: 10,),
              const Text("Danh sách các hộ :",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),
              const SizedBox(height: 20,),
              Column(
                children: _buildListDongGop(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
