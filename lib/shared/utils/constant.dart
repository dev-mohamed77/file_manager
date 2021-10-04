import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constant {
  static String whatsAppPath = "/storage/emulated/0/WhatsApp/Media/.Statuses";

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List categories = [
    {
      'title': 'Downloads',
      'icon': Icons.download,
      'path': '',
      'color': Colors.purple
    },
    {'title': 'Images', 'icon': Icons.image, 'path': '', 'color': Colors.blue},
    {
      'title': 'Videos',
      'icon': FontAwesomeIcons.video,
      'path': '',
      'color': Colors.red,
    },
    {
      'title': 'Audio',
      'icon': Icons.headphones,
      'path': '',
      'color': Colors.teal
    },
    {
      'title': 'Documents & Others',
      'icon': FontAwesomeIcons.file,
      'path': '',
      'color': Colors.pink
    },
    {'title': 'Apps', 'icon': Icons.android, 'path': '', 'color': Colors.green},
    {
      'title': 'Whatsapp Statuses',
      'icon': FontAwesomeIcons.whatsapp,
      'path': '',
      'color': Colors.green
    },
  ];

  static List sortList = [
    'File name (A to Z)',
    'File name (Z to A)',
    'Date (oldest first)',
    'Date (newest first)',
    'Size (largest first)',
    'Size (Smallest first)',
  ];
}
