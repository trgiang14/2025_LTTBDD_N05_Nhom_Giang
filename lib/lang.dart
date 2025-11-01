import 'dart:core';

Map<String, String> _vi = {
  "app_name": "Trình phát nhạc Flow Up",
  "home": "Trang chủ",
  "player": "Trình phát",
  "about": "Giới thiệu",
  "popular_songs": "Bài hát phổ biến",
  "new": "Mới",
  "popular": "Phổ biến",
  "trending": "Xu hướng",
  "role": "Lập trình viên/Thiết kế giao diện",
  "description":
      "Xin chào! Tôi là Giang, hiện đang phát triển ứng dụng\nFlowUp — một trình phát nhạc đơn giản, hiện đại và dễ sử dụng.",
};
Map<String, String> _en = {};

String currentLanguage = "en";

String lang(String key, String defaultString) {
  if (currentLanguage == "vi") return _vi[key] ?? defaultString;
  return _en[key] ?? defaultString;
}
