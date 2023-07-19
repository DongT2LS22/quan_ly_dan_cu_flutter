import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_dan_cu/models/khoan_phi.dart';
import 'package:quan_ly_dan_cu/screens/khoan_thu_phi/khoan_thu_phi_page.dart';
import 'package:quan_ly_dan_cu/widgets/input_field.dart';

class TaoKhoanPhiPage extends StatefulWidget {
  TaoKhoanPhiPage({Key? key}) : super(key: key);

  @override
  State<TaoKhoanPhiPage> createState() => _TaoKhoanPhiPageState();
}

class _TaoKhoanPhiPageState extends State<TaoKhoanPhiPage> {
  final TextEditingController _tenController = TextEditingController();

  late DateTime _selectedDateForStartDate;

  late DateTime _selectedDateForEndDate;

  final TextEditingController _dinhmucController = TextEditingController();
  late bool batbuoc;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _selectedDateForStartDate = DateTime.utc(2023, 1, 1);
    _selectedDateForEndDate = DateTime.utc(2023, 1, 1);
    batbuoc = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return Colors.blue;
    }

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
                title: "Tên khoản phí",
                hint: "Trung thu",
                controller: _tenController,
              ),
              InputField(
                title: "Ngày bắt đầu",
                hint: DateFormat.yMd()
                    .format(_selectedDateForStartDate)
                    .toString(),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUserForStart();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              InputField(
                title: "Ngày kết thúc",
                hint:
                    DateFormat.yMd().format(_selectedDateForEndDate).toString(),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUserForEnd();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              InputField(title: "Định mức", hint: "10000đ",controller: _dinhmucController,),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: batbuoc,
                            onChanged: (value) {
                              setState(() {
                                batbuoc = value!;
                              });
                            }),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Text(
                        "Bắt buộc",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),

                    ],
                  ),
                  TextButton(
                      onPressed: () async {
                        await KhoanPhi.create(KhoanPhi(ten: _tenController.text,batdau: _selectedDateForStartDate,ketthuc: _selectedDateForEndDate,batbuoc: batbuoc?1:0,dinhmuc: int.parse(_dinhmucController.text)));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const KhoanThuPhiPage()));
                        },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                        child: const Text("Tạo",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDateFromUserForStart() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: _selectedDateForStartDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (pickerDate != null) {
      setState(() {
        _selectedDateForStartDate = pickerDate;
      });
    }
  }

  _getDateFromUserForEnd() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: _selectedDateForEndDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (pickerDate != null) {
      setState(() {
        _selectedDateForEndDate = pickerDate;
      });
    }
  }
}
