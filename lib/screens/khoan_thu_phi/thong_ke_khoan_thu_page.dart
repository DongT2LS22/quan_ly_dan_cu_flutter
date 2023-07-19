import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../widgets/input_field.dart';

class KhoanThuDTO {
  String? tenKhoanPhi;
  int? daDong;
  String? chuHo;

  KhoanThuDTO.fromJson(Map<String, dynamic> json) {
    tenKhoanPhi = json['tenKhoanPhi'];
    daDong = json['soTien'];
    chuHo = json['hoKhau']['chuHo']['hoTen'];
  }

  static List<KhoanThuDTO> parsedKhoanThuDTO(String body) {
    final parsed = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<KhoanThuDTO>((json) => KhoanThuDTO.fromJson(json))
        .toList();
  }

  static Future<List<KhoanThuDTO>> search(Client client, int option,
      String input, DateTime from, DateTime to) async {
    String choose = option == 0 ? "by-khoan-phi" : "by-chu-ho";
    String startDate = DateFormat("yyyy-MM-dd").format(from).toString();
    String endDate = DateFormat("yyyy-MM-dd").format(to).toString();
    final response = await client.get(Uri.parse(
        "http://10.0.2.2:8081/api/v1/dong-gop/$choose?name=$input&from=$startDate&to=$endDate"));
    return compute(parsedKhoanThuDTO, response.body);
  }
}

class ThongKeKhoanThuPage extends StatefulWidget {
  const ThongKeKhoanThuPage({Key? key}) : super(key: key);

  @override
  State<ThongKeKhoanThuPage> createState() => _ThongKeKhoanThuPageState();
}

class _ThongKeKhoanThuPageState extends State<ThongKeKhoanThuPage> {
  late DateTime _selectedDateForStartDate;
  late DateTime _selectedDateForEndDate;
  final TextEditingController _inputController = TextEditingController();
  String? _stringValue;
  late Future<List<KhoanThuDTO>> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDateForStartDate = DateTime.utc(2023, 1, 1);
    _selectedDateForEndDate = DateTime.utc(2023, 12, 31);
    _stringValue = "Khoản thu";
    _inputController.text = "";
    list = KhoanThuDTO.search(
        Client(), 0, "", DateTime(2020, 1, 1), DateTime(2030, 1, 1));

  }

  _buildTableSearch() {
    setState(() {
      list = KhoanThuDTO.search(Client(), _stringValue == "Khoản thu"? 0 : 1, _inputController.text, _selectedDateForStartDate, _selectedDateForEndDate);
    });
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
                          value: "Khoản thu",
                          groupValue: _stringValue,
                          onChanged: (value) {
                            setState(() {
                              _stringValue = value;
                            });
                          }),
                      const Text(
                        "Khoản thu",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black),
                      )
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
                      const Text(
                        "Hộ gia đình",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
              InputField(
                  title:
                      _stringValue == "Khoản thu" ? "Khoản thu" : "Hộ gia đình",
                  hint: "",
              controller: _inputController,),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: InputField(
                    title: "Ngày kết thúc",
                    hint: DateFormat.yMd()
                        .format(_selectedDateForEndDate)
                        .toString(),
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
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0))),
                  onPressed: () async {
                    await _buildTableSearch();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                    child: const Text(
                      "Thống kê",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Table(
                children:  [
                  TableRow(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Colors.grey))),

                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: const Text(
                          "Khoan phi",
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
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: const Text(
                          "Da dong",
                          style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]
                  )
                ],
              ),
              FutureBuilder<List<KhoanThuDTO>>(
                future: list,
                builder: (context, snapshot) {
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
                                    e.tenKhoanPhi!,
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
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Text(
                                    e.daDong.toString(),
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
