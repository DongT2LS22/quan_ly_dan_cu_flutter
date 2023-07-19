import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_dan_cu/models/sinh_hoat.dart';
import 'package:quan_ly_dan_cu/screens/sinh_hoat/chi_tiet_sinh_hoat_page.dart';

class SinhHoatCard extends StatefulWidget {
  SinhHoat sinhHoat;
  SinhHoatCard({Key? key,required this.sinhHoat}) : super(key: key);

  @override
  State<SinhHoatCard> createState() => _SinhHoatCardState();
}

class _SinhHoatCardState extends State<SinhHoatCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChiTietSinhHoatPage(sinhhoat: widget.sinhHoat,)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width-40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.sinhHoat.chude!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
            const SizedBox(height: 5,),
            Text("${DateFormat("hh:mm a").format(widget.sinhHoat.batdau!)} - ${DateFormat("hh:mm a").format(widget.sinhHoat.ketthuc!)}",style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 13),),
            const SizedBox(height: 5,),
            Text("Địa điểm : ${widget.sinhHoat.diadiem}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black),)
          ],
        ),
      ),
    );
  }
}
