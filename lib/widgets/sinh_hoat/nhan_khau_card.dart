import 'package:flutter/material.dart';
import 'package:quan_ly_dan_cu/models/tham_gia.dart';

class NhanKhauCard extends StatefulWidget {
  ThamGia thamgia;
  NhanKhauCard({Key? key,required this.thamgia}) : super(key: key);

  @override
  State<NhanKhauCard> createState() => _NhanKhauCardState();
}

class _NhanKhauCardState extends State<NhanKhauCard> {
  late ThamGia _thamGia;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _thamGia = widget.thamgia;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width-40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width-40)*2/3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.thamgia.nhanKhau!.hoten!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),overflow: TextOverflow.visible,),
                const SizedBox(height: 5,),
                Text("Mã định danh : ${widget.thamgia.nhanKhau!.id}",style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 13),),
                const SizedBox(height: 5,),
                Text("Địa chỉ : ${widget.thamgia.nhanKhau!.noiThuongTru}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black),)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _thamGia.thamgia = 1 - _thamGia.thamgia!;
              });
              ThamGia.update(_thamGia);
            },
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              child: widget.thamgia.thamgia == 1 ? const Icon(Icons.check,size: 20,color: Colors.black,) : Container(),
            ),
          )
        ],
      ),
    );
  }
}
