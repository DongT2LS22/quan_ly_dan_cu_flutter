import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/khoan_phi.dart';
import '../../widgets/input_field.dart';
import 'khoan_thu_phi_page.dart';

class ChinhSuaKhoanPhiPage extends StatefulWidget {
  KhoanPhi khoanPhi;
  ChinhSuaKhoanPhiPage({Key? key,required this.khoanPhi}) : super(key: key);

  @override
  State<ChinhSuaKhoanPhiPage> createState() => _ChinhSuaKhoanPhiPageState();
}

class _ChinhSuaKhoanPhiPageState extends State<ChinhSuaKhoanPhiPage> {
  final TextEditingController _tenController = TextEditingController();

  late DateTime _selectedDateForStartDate;

  late DateTime _selectedDateForEndDate;

  final TextEditingController _dinhmucController = TextEditingController();
  late bool batbuoc;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _selectedDateForStartDate = widget.khoanPhi.batdau!;
    _selectedDateForEndDate = widget.khoanPhi.ketthuc!;
    batbuoc = widget.khoanPhi.batbuoc! == 0 ? false : true;
    _tenController.text = widget.khoanPhi.ten!;
    _dinhmucController.text = widget.khoanPhi.dinhmuc.toString();
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
                        await KhoanPhi.update(KhoanPhi(id: widget.khoanPhi.id,ten: _tenController.text,batdau: _selectedDateForStartDate,ketthuc: _selectedDateForEndDate,batbuoc: batbuoc?1:0,dinhmuc: int.parse(_dinhmucController.text)));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const KhoanThuPhiPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                        child: const Text("Chỉnh sửa",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
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
