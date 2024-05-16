
import 'package:flutter/material.dart';

showSnackBar(context, msg, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(msg, style: const TextStyle(color: Colors.white)),
    backgroundColor: color,
    duration: const Duration(seconds: 2),
  ));
}
