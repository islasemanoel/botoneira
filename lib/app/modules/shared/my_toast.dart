import 'package:fluttertoast/fluttertoast.dart';

abstract class MyToast {
  showToast({String msg, MyToastLength toastLength, MyToastGravity gravity});
}

class MyToastImpl implements MyToast {
  showToast(
      {String msg = '',
      MyToastLength toastLength = MyToastLength.LENGTH_SHORT,
      MyToastGravity gravity = MyToastGravity.CENTER}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: getLength(toastLength),
        gravity: getGravity(gravity),
        timeInSecForIosWeb: 1);
  }

  Toast getLength(MyToastLength toastLength) {
    switch (toastLength) {
      case MyToastLength.LENGTH_LONG:
        return Toast.LENGTH_LONG;
      case MyToastLength.LENGTH_SHORT:
        return Toast.LENGTH_SHORT;
      default:
        return Toast.LENGTH_SHORT;
    }
  }

   ToastGravity getGravity(MyToastGravity gravity) {
    switch (gravity) {
      case MyToastGravity.CENTER:
        return ToastGravity.CENTER;
      case MyToastGravity.BOTTOM:
        return ToastGravity.BOTTOM;
      case MyToastGravity.TOP:
        return ToastGravity.TOP;
      default:
        return ToastGravity.CENTER;
    }
  }
}

enum MyToastLength {
  /// Show Short toast for 1 sec
  LENGTH_SHORT,

  /// Show Long toast for 5 sec
  LENGTH_LONG
}

/// ToastGravity
/// Used to define the position of the Toast on the screen
enum MyToastGravity {
  TOP,
  BOTTOM,
  CENTER,
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT,
  CENTER_LEFT,
  CENTER_RIGHT,
  SNACKBAR
}
