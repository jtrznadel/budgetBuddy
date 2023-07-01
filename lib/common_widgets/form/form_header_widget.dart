import 'package:budget_buddy/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/sizes.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {super.key,
      required this.imageScale,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image, title, subTitle;
  final double imageScale;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * imageScale, child: SvgPicture.asset(image)),
        const SizedBox(height: kDefaultPadding),
        Text(
          title,
          style: const TextStyle(fontSize: 24, color: kPrimaryColor),
        ),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
