import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  final String? name;
  const UnknownPage(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Unknown page: $name"),
    );
  }
}
