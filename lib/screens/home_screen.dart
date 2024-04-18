import 'package:flutter/material.dart';
import 'package:mo_jannah/utils/constants/sizes.dart';
import 'package:mo_jannah/widgets/bottom_select_sheet.dart';
import 'package:mo_jannah/widgets/map_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // this is the map widget
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  height: constraints.maxHeight * (1 - SHEET_HEIGHT) +
                      MAP_PADDING, // 32 is the bottom padding
                  child: MapWidget(),
                );
              },
            ),
            // this is the bottom sheet widget
            const BottomSelectSheet(),
          ],
        ),
      ),
    );
  }
}
