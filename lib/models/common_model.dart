class PercentModel {
  double? percent;
  String? title;
  int? color;

  PercentModel({this.percent, this.title, this.color});

  PercentModel.fromJson(Map<String, dynamic> json) {
    percent = json['percent'];
    title = json['title'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percent'] = this.percent;
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }
}
