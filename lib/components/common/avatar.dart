import 'package:flutter/material.dart';

/// 头像
class Avatar extends StatelessWidget {

  final double width;
  final double height;
  final String src;

  Avatar({this.width, this.height, this.src});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[400], width: 4),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(this.src)),
      ),
    );
  }
}
