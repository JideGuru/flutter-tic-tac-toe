import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app.dart';
import 'package:tic_tac_toe/play_game/view/play_game_page.dart';
import 'package:tic_tac_toe/shared/widgets/widgets.dart';

class ChooseSidePage extends StatelessWidget {
  const ChooseSidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Choose a side'.toUpperCase(),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: yellow,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width),
          const SizedBox(height: 40),
          _LetterContainer(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayGamePage(
                    playerChar: 'x',
                    aiChar: 'o',
                  ),
                ),
              );
            },
            child: const Hero(
              tag: 'xw1',
              child: XWidget(
                width: 150,
                height: 150,
                color: red,
                shouldAnimate: false,
                strokeWidth: 50,
              ),
            ),
          ),
          const SizedBox(height: 50),
          _LetterContainer(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayGamePage(
                    playerChar: 'o',
                    aiChar: 'x',
                  ),
                ),
              );
            },
            child: const Hero(
              tag: '0w1',
              child: OWidget(
                width: 150,
                height: 150,
                color: red,
                radius: 100,
                shouldAnimate: false,
                strokeWidth: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LetterContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _LetterContainer({Key? key, required this.child, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 300,
        width: 300,
        decoration:
            BoxDecoration(color: yellow, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
          ],
        ),
      ),
    );
  }
}
