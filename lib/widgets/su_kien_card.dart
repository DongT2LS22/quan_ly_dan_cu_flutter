import 'package:flutter/material.dart';

class SuKienCard extends StatefulWidget {
  const SuKienCard({Key? key}) : super(key: key);

  @override
  State<SuKienCard> createState() => _SuKienCardState();
}

class _SuKienCardState extends State<SuKienCard> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue
      ),
      width: MediaQuery.of(context).size.width - 40,
    );
  }
}
