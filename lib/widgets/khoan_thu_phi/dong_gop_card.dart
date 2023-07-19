import 'package:flutter/material.dart';
import 'package:quan_ly_dan_cu/screens/khoan_thu_phi/cap_nhat_dong_gop_page.dart';

import '../../models/dong_gop.dart';
class DongGopCard extends StatefulWidget {
  DongGop dongGop;
  DongGopCard({Key? key,required this.dongGop}) : super(key: key);

  @override
  State<DongGopCard> createState() => _DongGopCardState();
}

class _DongGopCardState extends State<DongGopCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CapNhatDongGopPage(dongGop: widget.dongGop,))).then((value){
        setState(() {

        });
      });},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20)
        ),
        width: MediaQuery.of(context).size.width-40,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width-40)*2/3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.dongGop.hokhau==null?"":widget.dongGop.hokhau!.diachi}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),),
                  const SizedBox(height: 5,),
                  Text("${widget.dongGop.hokhau==null?"" : widget.dongGop.hokhau!.id}",style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black),),
                  const SizedBox(height: 5,),
                  Text("Đã đóng : ${widget.dongGop.sotien??0}đ",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black),)
                ],
              ),
            ),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: widget.dongGop.dadong == 1 ? const Icon(Icons.check,size: 20,color: Colors.black,) : Container(),
            )
          ],
        ),
      ),
    );
  }
}
