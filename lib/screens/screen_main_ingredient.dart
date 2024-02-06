import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 유통기한 비교 함수
String compareExpiration(String expiration) {
  String strToday = getToday();
  int result = expiration.compareTo(strToday);

  if (result > 0) {
    return '유통기한이 지나지 않았습니다.';
  } else if (result == 0) {
    return '오늘이 유통기한입니다.';
  } else {
    return '유통기한이 지났습니다.';
  }
}

// 유통기한 잔여일 계산 함수
int calculateRemainingDays(String expiration) {
  String strToday = getToday();
  DateTime today = DateTime.parse(strToday);
  DateTime expDate = DateTime.parse(expiration);

  // calculate remaining days
  Duration difference = expDate.difference(today);
  int remainingDays = difference.inDays;

  return remainingDays;
}

// 오늘 날짜 받아오는 함수
String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String strToday = formatter.format(now);
  return strToday;
}
