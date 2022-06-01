


import 'package:intl/intl.dart';

class DateUtility{
  DateTime dateTime;

  DateUtility({
    required this.dateTime,
  });



  String render(){
    return ' ${DateFormat('MMM dd, hh:mm a').format(dateTime)}';
  }

  String renderTime(){
    return DateFormat('HH:mm').format(dateTime);
  }

  String renderCardDate(){
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }

  String renderToJsonDate(){
    // 2022-01-04 11:30:00
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  String timeAgo(){
    // 2022-01-04 11:30:00
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  monthAbbreviation() {
    return DateFormat('MMM').format(dateTime);
  }




}