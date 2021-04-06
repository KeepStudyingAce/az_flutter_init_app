import 'package:date_format/date_format.dart';

enum TimeFormat {
  normal,
  yyyyMM_CN,
  yyyyMMdd_EN,
  yyyyMMdd_CN,
}

extension TimeFormatExtension on TimeFormat {
  List<String> get value => [
        [yyyy, '-', mm, '-', dd, '  ', HH, ':', nn, ':', ss],
        [yyyy, '年', mm, '月'],
        [yyyy, '-', mm, '-', dd],
        [yyyy, '年', mm, '月', dd, '日']
      ][this.index];
}

class TimeUtil {
  ///utc时间转换且 格式化
  static String getTimeFormat(String utcDateTimeString,
      {TimeFormat timeFormat = TimeFormat.normal}) {
    if (utcDateTimeString == null) {
      return "";
    }

    DateTime parse = getDateTime(utcDateTimeString);

    return getDateTimeFormat(parse, timeFormat: timeFormat);
  }

  ///utc时间转换成dataTime
  static DateTime getDateTime(String utcDateTimeString) {
    if (utcDateTimeString == null) {
      return null;
    }
    DateTime parse = DateTime.parse(utcDateTimeString);

    return parse.add(parse.timeZoneOffset);
  }

  static String getDateTimeFormat(DateTime dateTime,
      {TimeFormat timeFormat = TimeFormat.normal}) {
    if (dateTime == null) {
      return "";
    }

    return formatDate(dateTime, timeFormat.value);
  }
}
