import 'package:side_navigation/side_navigation.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:typing/training.dart';
import 'package:typing/settings.dart';
import 'package:typing/consts.dart';
import 'package:typing/tests.dart';
import 'package:typing/home.dart';

class Window extends StatefulWidget {
  Window({Key? key, required this.page}) : super(key: key);
  int page;

  @override
  _WindowState createState() => _WindowState();
}

class _WindowState extends State<Window> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        color: borderColor,
        width: 1,
        child: Row(
          children: [
            Navigation(
              page: widget.page,
            ),
          ],
        ),
      ),
    );
  }
}

class Navigation extends StatefulWidget {
  Navigation({Key? key, required this.page}) : super(key: key);
  int page;

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Widget> views = const [
    HomeScreen(),
    Tests(),
    TrainingScreen(),
    SettingScreen()
  ];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedIndex = widget.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundStartColor,
              backgroundEndColor,
            ],
          ),
        ),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(child: MoveWindow()),
                  const WindowButtons(),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 190),
                    child: SideNavigationBar(
                      initiallyExpanded: false,
                      theme: SideNavigationBarTheme(
                        backgroundColor: Colors.transparent,
                        itemTheme: ItemTheme(
                          selectedItemColor: borderColor,
                          unselectedItemColor: Colors.grey[600],
                        ),
                        togglerTheme: const TogglerTheme(),
                        showHeaderDivider: false,
                        showMainDivider: false,
                        showFooterDivider: false,
                      ),
                      selectedIndex: selectedIndex,
                      items: const [
                        SideNavigationBarItem(
                          icon: Icons.dashboard,
                          label: 'Dashboard',
                        ),
                        SideNavigationBarItem(
                          icon: Icons.text_fields_rounded,
                          label: 'Tests',
                        ),
                        SideNavigationBarItem(
                          icon: Icons.keyboard,
                          label: 'Training',
                        ),
                        // SideNavigationBarItem(
                        //   icon: Icons.settings,
                        //   label: 'Settings',
                        // ),
                      ],
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: views.elementAt(selectedIndex),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
