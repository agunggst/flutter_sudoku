import 'package:flutter/material.dart';
import 'package:flutter_sudoku/widgets/push_button.dart';

class NumPad extends StatefulWidget {
  const NumPad({super.key});

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  List<int> numList = [1,2,3,4,5,6,7,8,9];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: numList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        childAspectRatio: 1
      ), 
      itemBuilder: (BuildContext context, int index) {
        return PushButton(
          text: numList[index].toString(), 
          paddingH: 8,
          paddingV: 4,
          fontSize: 16,
          fontFamily: "Cartoon",
          onPressed: () {}
        );
      }    
    );
  }
}