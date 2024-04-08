class CalendarBtnModel {
  int? num;
  String? title;

  CalendarBtnModel({this.num, this.title});

  CalendarBtnModel.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['title'] = this.title;
    return data;
  }
}
