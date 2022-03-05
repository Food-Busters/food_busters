// Flutter imports:
import "package:flutter/material.dart";

Container profilePic(String img, double size, {Widget? child}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: NetworkImage(img),
      ),
    ),
    child: child,
  );
}
