import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const defaultScrollPhysics = BouncingScrollPhysics();
const double defaultLaodingAnimationSize = 50;

extension Pricelable on int {
  String get withPriceLable => this > 0 ? '$separateByComma تومان' : 'رایگان';

  String get separateByComma {
    final numberFotmat = NumberFormat.decimalPattern();
    return numberFotmat.format(this);
  }
}
