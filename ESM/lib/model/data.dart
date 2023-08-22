import 'package:flutter/material.dart';

class ListItem {
  final String title;

  ListItem(this.title);
}

class ExpansionTileData {
  final String title;
  final Widget expandedForm;

  ExpansionTileData(this.title, this.expandedForm);
}

class CheckBoxTileListItem {
  final String title;
  late final bool checked;

  CheckBoxTileListItem(this.title, this.checked);
}
