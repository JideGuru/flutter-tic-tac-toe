import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app.dart';
import 'package:tic_tac_toe/choose_side/view/choose_side_page.dart';

import '../../shared/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: kToolbarHeight + 90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Hero(
                      tag: 'xw1',
                      child: XWidget(shouldAnimate: false, strokeWidth: 40),
                    ),
                    Hero(
                      tag: '0w1',
                      child: OWidget(shouldAnimate: false, strokeWidth: 40),
                    ),
                  ],
                ),

                const SizedBox(height: 80),
                Text(
                  'Tic-Tac-Toe'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseSidePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                        color: yellow, borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: red,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
