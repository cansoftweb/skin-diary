// 숫자 단위 콤마 표시
import 'package:intl/intl.dart';

var priceFormat = (int num) {
  var addComma = NumberFormat('###,###,###,###');
  return addComma.format(num);
};

var priceFormatDouble = (double num) {
  var addComma = NumberFormat('###,###,###,###');
  return addComma.format(num);
};
