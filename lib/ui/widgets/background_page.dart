import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/assets_path.dart';
class BackgroundPage extends StatelessWidget {
  const BackgroundPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.imagesBackground,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
