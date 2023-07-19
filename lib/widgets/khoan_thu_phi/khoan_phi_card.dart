import 'package:flutter/material.dart';
import 'package:quan_ly_dan_cu/models/khoan_phi.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_dan_cu/screens/khoan_thu_phi/chi_tiet_khoan_thu_page.dart';

class KhoanPhiCard extends StatefulWidget {
  KhoanPhi khoanPhi;
  KhoanPhiCard({Key? key,required this.khoanPhi}) : super(key: key);

  @override
  State<KhoanPhiCard> createState() => _KhoanPhiCardState();
}

class _KhoanPhiCardState extends State<KhoanPhiCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChiTietKhoanThuPage(khoanPhi: widget.khoanPhi)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width-40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.khoanPhi.ten!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
            const SizedBox(height: 5,),
            Text("${DateFormat.yMd().format(widget.khoanPhi.batdau!)} - ${DateFormat.yMd().format(widget.khoanPhi.ketthuc!)}",style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 13),),
            const SizedBox(height: 5,),
            Text("Định mức ${widget.khoanPhi.dinhmuc??"0"}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black),)
          ],
        ),
      ),
    );
  }
}
