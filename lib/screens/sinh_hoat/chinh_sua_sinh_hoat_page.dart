import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_dan_cu/screens/sinh_hoat/sinh_hoat_page.dart';
import '../../models/sinh_hoat.dart';
import '../../widgets/input_field.dart';


class ChinhSuaSinhHoat extends StatefulWidget {
  SinhHoat sinhHoat;
  ChinhSuaSinhHoat({Key? key,required this.sinhHoat}) : super(key: key);

  @override
  State<ChinhSuaSinhHoat> createState() => _ChinhSuaSinhHoatState();
}

class _ChinhSuaSinhHoatState extends State<ChinhSuaSinhHoat> {
  TextEditingController _chudeController = TextEditingController();
  TextEditingController _diadiemController = TextEditingController();
  late DateTime _ngayController;

  String _batdau = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _ketthuc = "09:30 PM";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ngayController = widget.sinhHoat.batdau!;
    _batdau = DateFormat("hh:mm a").format(widget.sinhHoat.batdau!).toString();
    _ketthuc = DateFormat("hh:mm a").format(widget.sinhHoat.ketthuc!).toString();
    _chudeController.text = widget.sinhHoat.chude!;
    _diadiemController.text = widget.sinhHoat.diadiem!;
  }

  int getHour(String time){
    List<String> times = time.split(" ");
    List<String> hours = times.first.split(":");
    if(times[1] == "PM"){
      return int.parse(hours.first) + 12;
    }else{
      return int.parse(hours.first);
    }
  }

  int getMinute(String time){
    List<String> times = time.split(" ");
    List<String> hours = times.first.split(":");
    return int.parse(hours[1]);
  }

  DateTime concatwithDatetime(String time,DateTime date){
    return DateTime(date.year,date.month,date.day,getHour(time),getMinute(time));
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
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                title: "Chủ đề",
                hint: "Trung thu",
                controller: _chudeController,
              ),
              InputField(
                title: "Ngày",
                hint: DateFormat.yMd().format(_ngayController).toString(),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                        title: "Start time",
                        hint: _batdau,
                        widget: IconButton(
                          icon: const Icon(Icons.access_time_rounded),
                          onPressed: () {
                            _getTimeStartFromUser(isStartTime: true);
                          },
                        ),
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: InputField(
                        title: "End time",
                        hint: _ketthuc,
                        widget: IconButton(
                          icon: const Icon(Icons.access_time_rounded),
                          onPressed: () {
                            _getTimeEndFromUser(isStartTime: false);
                          },
                        ),
                      )),
                ],
              ),
              InputField(
                title: "Địa điểm",
                hint: "Nhà văn hóa",
                controller: _diadiemController,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero)),
                    onPressed: () async {
                      print(widget.sinhHoat.id);
                      await SinhHoat.update(SinhHoat(id: widget.sinhHoat.id,chude: _chudeController.text,batdau: concatwithDatetime(_batdau, _ngayController),ketthuc: concatwithDatetime(_ketthuc, _ngayController),diadiem: _diadiemController.text));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SinhHoatPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: const Text(
                        "Chỉnh sửa",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (pickerDate != null) {
      setState(() {
        _ngayController = pickerDate;
      });
    }
  }

  _getTimeStartFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _batdau = formatedTime;
      });
    } else {
      setState(() {
        _ketthuc = formatedTime;
      });
    }
  }

  _getTimeEndFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _batdau = formatedTime;
      });
    } else {
      setState(() {
        _ketthuc = formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(
            hour: int.parse(_batdau.split(":")[0]),
            minute: int.parse(_batdau.split(":")[1].split(" ")[0])));
  }
}
