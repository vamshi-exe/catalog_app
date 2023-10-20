import 'dart:async';

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Animations'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SlideTrans()));
                  },
                  child: Text('UP TO DOWN'))
            ],
          ),
        ));
  }
}

class SlideTrans extends StatefulWidget {
  const SlideTrans({super.key});

  @override
  State<SlideTrans> createState() => _SlideTransState();
}

class _SlideTransState extends State<SlideTrans> with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    Timer(Duration(seconds: 4), () => animationController.repeat());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UP TO DOWN'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: EuforiaMethod(animationController: animationController))
        ],
      ),
    );
  }
}

class EuforiaMethod extends StatelessWidget {
  final AnimationController animationController;
  const EuforiaMethod({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -2),
          end: Offset.zero,
        ).animate(CurvedAnimation(
            parent: animationController,
            curve: Curves.fastEaseInToSlowEaseOut)),
        child: FadeTransition(
          opacity: animationController,
          child: Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
