// 🐦 Flutter imports:
import "package:flutter/material.dart";

Container profilePic(String img, double size, {Widget? child}) {
  if (img.startsWith("assets/")) return profileAssets(img, size, child: child);
  return profileNetwork(img, size, child: child);
}

Container profileNetwork(String img, double size, {Widget? child}) {
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

Container profileAssets(String img, double size, {Widget? child}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(img),
      ),
    ),
    child: child,
  );
}
