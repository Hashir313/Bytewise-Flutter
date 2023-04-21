import 'package:flutter/material.dart';
import 'package:task_9/animation_details.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 200.0).animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tween Animation'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Click on the pic to see its details'),
          Center(
            child: SizedBox(
              width: animation.value,
              height: animation.value,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailsScreen()));
                },
                child: Hero(
                    tag: 'details',
                    child: Image.asset('assets/animated_pic.png')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
