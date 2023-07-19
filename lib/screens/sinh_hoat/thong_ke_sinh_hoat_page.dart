import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../widgets/input_field.dart';

class SinhHoatDTO {
  String? chuDe;
  String? chuHo;

  SinhHoatDTO.fromJson(Map<String, dynamic> json) {
    chuDe = json['chuDe'];
    chuHo = json['chuHo'];
  }

  static List<SinhHoatDTO> parsedSinhHoatDTO(String body) {
    final parsed = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<SinhHoatDTO>((json) => SinhHoatDTO.fromJson(json))
        .toList();
  }

  static Future<List<SinhHoatDTO>> search(Client client, int option,
      String input, DateTime from, DateTime to) async {
    String choose = option == 0 ? "by-sinh-hoat" : "by-chu-ho";
    String startDate = DateFormat("yyyy-MM-dd").format(from).toString();
    String endDate = DateFormat("yyyy-MM-dd").format(to).toString();
    final response = await client.get(Uri.parse(
        "$URI/tham-gia/$choose?name=$input&from=$startDate&to=$endDate"));
    return compute(parsedSinhHoatDTO, response.body);
  }
}

class ThongKeSinhHoatPage extends StatefulWidget {
  ThongKeSinhHoatPage({Key? key}) : super(key: key);

  @override
  State<ThongKeSinhHoatPage> createState() => _ThongKeSinhHoatPageState();
}

class _ThongKeSinhHoatPageState extends State<ThongKeSinhHoatPage> {
  late DateTime _selectedDateForStartDate;
  late DateTime _selectedDateForEndDate;
  String? _stringValue;
  TextEditingController _inputController = TextEditingController();
  late Future<List<SinhHoatDTO>> listsinhhoat; // call api hop le

  _buildSinhhoatSearch(){
    setState(() {
      listsinhhoat = SinhHoatDTO.search(Client(), _stringValue == "Sinh hoạt" ? 0 : 1, _inputController.text, _selectedDateForStartDate, _selectedDateForEndDate);

      // listsinhhoat = SinhHoatDTO.search(Client(),0, _inputController.text, _selectedDateForStartDate, _selectedDateForStartDate);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDateForStartDate = DateTime.utc(2023, 1, 1);
    _selectedDateForEndDate = DateTime.utc(2023, 12, 31);
    _stringValue = _stringValue?? "Sinh hoạt";
    _inputController.text = "";
    listsinhhoat = SinhHoatDTO.search(Client(), 0, _inputController.text, _selectedDateForStartDate, _selectedDateForEndDate);
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                          value: "Sinh hoạt",
                          groupValue: _stringValue,
                          onChanged: (value) {
                            setState(() {
                              _stringValue = value;
                            });
                          }),
                      const Text("Sinh hoạt",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),)
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                          value: "Hộ gia đình",
                          groupValue: _stringValue,
                          onChanged: (value) {
                            setState(() {
                              _stringValue = value;
                            });
                          }),
                      const Text("Hộ gia đình",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),)
                    ],
                  ),
                ],
              ),
              InputField(title: _stringValue == "Sinh hoạt" ? "Sinh hoạt" : "Hộ gia đình", hint: "",controller: _inputController,),
              Row(
                children: [
                  Expanded(
                    child: InputField(
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
                  ),
                  const SizedBox(width: 10,),
                  Expanded(child: InputField(
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
                  )),
                ],
              ),
              const SizedBox(height: 20,),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0))
                ),
                  onPressed: () async {
                    print(_inputController.text);
                    await _buildSinhhoatSearch();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue
                    ),
                    child: const Text("Thống kê",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w600),),
                  )
              ),
              const SizedBox(height: 20,),
              Table(
                children: [
                  TableRow(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey))),

                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: const Text(
                            "Chu de",
                            style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: const Text(
                            "Ho gia dinh",
                            style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ]
                  )
                ],
              ),
              FutureBuilder<List<SinhHoatDTO>>(
                future: listsinhhoat,
                builder: (context,snapshot){
                  if (snapshot.hasData) {
                    return Table(
                      children: snapshot.data!
                          .map((e) => (TableRow(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.grey))),
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Text(
                                e.chuDe!,
                                style: const TextStyle(fontSize: 15, color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Text(
                                e.chuHo!,
                                style: const TextStyle(fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ])))
                          .toList(),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                },
              )
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
