import "package:flutter/material.dart";

Image bgImage(String name) => Image.asset(
      name,
      fit: BoxFit.cover,
      width: double.infinity,
      alignment: Alignment.center,
    );
