import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_dan_cu/widgets/input_field.dart';
import '../../models/dong_gop.dart';

class CapNhatDongGopPage extends StatefulWidget {
  DongGop dongGop;

  CapNhatDongGopPage({Key? key, required this.dongGop}) : super(key: key);

  @override
  State<CapNhatDongGopPage> createState() => _CapNhatDongGopPageState();
}

class _CapNhatDongGopPageState extends State<CapNhatDongGopPage> {
  final TextEditingController _tienController = TextEditingController();
  late DateTime _ngaydongController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.dongGop.sotien == 0 ? _tienController!.text = "0" : _tienController!.text = widget.dongGop.sotien.toString();
    _ngaydongController = (widget.dongGop.ngaydong ?? DateTime.utc(2023,1,1))!;
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
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID : ${widget.dongGop.hokhau!.id}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),overflow: TextOverflow.visible,),
            const SizedBox(height: 5,),
            Text("Nhà : ${widget.dongGop.hokhau!.diachi}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),overflow: TextOverflow.visible,),
            InputField(title: "Số tiền đóng : ", hint: "Nhập số tiền",controller: _tienController,),
            InputField(title: "Ngày đóng", hint: DateFormat.yMd().format(_ngaydongController).toString(),widget: IconButton(
              onPressed: () {
                _getDateFromUserForStart();
              },
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.grey,
              ),
            ),),
            const SizedBox(height: 20,),
            Center(
              child: TextButton(
                  onPressed: () {
                    widget.dongGop.ngaydong = _ngaydongController;
                    widget.dongGop.sotien = int.parse(_tienController!.text);
                    widget.dongGop.dadong = 0;
                    DongGop.update(widget.dongGop);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue
                    ),
                    child: const Text("Xác nhận chưa đóng tiền",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
                  )
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: (){
                    widget.dongGop.ngaydong = _ngaydongController;
                    widget.dongGop.dadong = 1;
                    widget.dongGop.sotien = int.parse(_tienController!.text) ;
                    DongGop.update(widget.dongGop);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue
                    ),
                    child: const Text("Xác nhận đóng tiền",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
  _getDateFromUserForStart() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: _ngaydongController,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (pickerDate != null) {
      setState(() {
        _ngaydongController = pickerDate;
      });
    }
  }
}
