import 'package:flutter/widgets.dart';

class AdaptiveSizes {
  static double getAdaptiveWidth(BuildContext context, double baseWidth) {
    return MediaQuery.of(context).size.width / 375.0 * baseWidth;
  }

  static double getAdaptiveHeight(BuildContext context, double baseHeight) {
    return MediaQuery.of(context).size.height / 812.0 * baseHeight;
  }
}
