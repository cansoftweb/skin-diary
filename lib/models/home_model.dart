// 메인 주간 달력 아이템
class CalendarWeeks {
  String? date;
  String? day;

  CalendarWeeks({this.date, this.day});

  CalendarWeeks.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['day'] = this.day;
    return data;
  }
}
