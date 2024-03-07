import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {Key? key,
      this.height,
      this.width,
      this.url = '',
      this.ringSize = 2,
      this.ringColor = Colors.transparent,
      this.fit = BoxFit.cover})
      : super(key: key);
  final double? height;
  final double? width;
  final String url;
  final BoxFit? fit;
  final Color ringColor;
  final double ringSize;

//TODO: add Cache Network Image library to display url images optimally

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ringColor, width: ringSize)),
      height: height ?? 52,
      width: width ?? 52,
      child: ClipOval(
          child: AppNetworkImage(
        url: url,
        fit: fit!,
      )),
    );
  }
}

class UserAvatarFromName extends StatelessWidget {
  const UserAvatarFromName({
    Key? key,
    this.height,
    this.width,
    this.color = kPrimaryColor,
    required this.name,
  }) : super(key: key);
  final double? height;
  final double? width;
  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        height: height ?? 70,
        width: width ?? 70,
        child: Center(
          child: Text(
            name.trim().characters.first,
            style: AppStyles.getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kWhite,
            ),
          ),
        ),
      ),
    );
  }
}

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    this.url = '',
    this.fit = BoxFit.contain,
  }) : super(key: key);

  final String? url;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: url == null
            ? Image.asset(
                'assets/images/doctor_illustration.png',
                fit: fit,
              )
            : CachedNetworkImage(
                imageUrl: url!,
                fit: fit,
                errorWidget: (context, _, __) {
                  return Image.asset(
                    'assets/images/doctor_illustration.png',
                    fit: fit,
                  );
                },
              ));
  }
}
