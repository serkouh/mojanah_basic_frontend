import 'package:flutter/material.dart';
import 'package:mo_jannah/utils/constants/sizes.dart';

class BottomSelectSheet extends StatelessWidget {
  const BottomSelectSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: const ValueKey(1),
      initialChildSize: SHEET_HEIGHT,
      minChildSize: SHEET_HEIGHT,
      snapSizes: const [SHEET_HEIGHT, 1],
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        );
      },
    );
  }
}
