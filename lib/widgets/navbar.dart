import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:weather_app/utils/constants.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late ColorScheme colors;
  @override
  Widget build(BuildContext context) {
    colors = Theme.of(context).colorScheme;
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => mobileNavBar(),
      desktop: (BuildContext context) => desktopNavBar(),
    );
  }

  Widget mobileNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Demo app for HireLATAM',
              style: TextStyle(color: colors.primary, fontSize: h! / 45),
            ),
          ),
          navLogo()
        ],
      ),
    );
  }

  Widget desktopNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navLogo(),
          Container(
            height: 45,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Demo app for HireLATAM',
              style: TextStyle(
                  color: colors.primary,
                  fontSize: h! / 40,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget navLogo() {
    return Container(
      width: w! / 10,
      decoration:
          const BoxDecoration(image: DecorationImage(image: AssetImage(logo))),
    );
  }
}
