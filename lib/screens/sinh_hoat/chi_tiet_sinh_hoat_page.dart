import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_dan_cu/screens/sinh_hoat/chinh_sua_sinh_hoat_page.dart';
import 'package:quan_ly_dan_cu/screens/sinh_hoat/sinh_hoat_page.dart';
import 'package:quan_ly_dan_cu/widgets/sinh_hoat/nhan_khau_card.dart';
import '../../models/sinh_hoat.dart';
import '../../models/tham_gia.dart';


class ChiTietSinhHoatPage extends StatefulWidget {
  SinhHoat sinhhoat;

  ChiTietSinhHoatPage({Key? key, required this.sinhhoat}) : super(key: key);

  @override
  State<ChiTietSinhHoatPage> createState() => _ChiTietSinhHoatPageState();
}

class _ChiTietSinhHoatPageState extends State<ChiTietSinhHoatPage> {
  late List<ThamGia> danhsachmoi;

  _buildDanhsachsinhhoat() {
    List<Widget> list = [];
    if (danhsachmoi.isEmpty) return list;
    danhsachmoi.forEach((nhankhau) {
      list.add(NhanKhauCard(thamgia: nhankhau));
      list.add(const SizedBox(
        height: 10,
      ));
    });
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    danhsachmoi = widget.sinhhoat.nguoithamgia ?? [];
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
          onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>SinhHoatPage())),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await SinhHoat.deleteByID(int.parse(widget.sinhhoat.id!));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SinhHoatPage()));
              },
              icon: const Icon(
                Icons.delete,
                size: 27,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChinhSuaSinhHoat(sinhHoat: widget.sinhhoat)));
              },
              icon: const Icon(
                Icons.settings,
                size: 27,
                color: Colors.black,
              )),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chủ đề : ${widget.sinhhoat.chude!}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Địa điểm : ${widget.sinhhoat.diadiem}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Bắt đầu : ${DateFormat.jm().format(widget.sinhhoat.batdau!)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Kết thúc : ${DateFormat.jm().format(widget.sinhhoat.ketthuc!)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Ngày : ${DateFormat.yMd().format(widget.sinhhoat.batdau!)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Danh sách người được mời :",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: _buildDanhsachsinhhoat(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
