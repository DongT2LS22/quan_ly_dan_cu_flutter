class HoKhau {
  int? id;
  String? diachi;
  String? chuHo;
  HoKhau({this.id, this.diachi});

  HoKhau.fromJson(Map<String,dynamic> json){
    id = json['id'];
    diachi = json['diaChi'];
    chuHo = json['chuHo']['hoTen'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diaChi'] = diachi;
    return data;
  }
}