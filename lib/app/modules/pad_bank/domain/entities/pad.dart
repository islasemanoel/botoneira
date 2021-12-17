import 'package:nine_grid_view/nine_grid_view.dart';

import 'pad_bank.dart';

class Pad extends DragBean {
  int? id;
  String name = "";
  String path = "";
  late int index;
  late PadBank padBank;

  Pad({this.id, required this.name, required this.path, required this.index, required this.padBank});

}
