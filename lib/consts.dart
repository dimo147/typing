import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:path_provider/path_provider.dart';

const borderColor = Color(0xFF3FC416);
const backgroundStartColor = Colors.black87;
const backgroundEndColor = Colors.black;
const sidebarColor = Colors.black87;

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF3FC416),
    mouseOver: const Color(0xFF3FC416),
    mouseDown: const Color(0xFF000000),
    iconMouseOver: const Color(0xFF000000),
    iconMouseDown: const Color(0xFF3FC416));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF3FC416),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationSupportDirectory();
  return directory.path;
}

Future<File> get localFile async {
  final path = await _localPath;
  return File('$path/tests.txt');
}
