import 'package:flutter/material.dart';
import 'package:universe/constants/my_colors.dart';

class JumpingDots extends StatefulWidget {
  final int numberOfDots;

  const JumpingDots({Key? key, this.numberOfDots = 4}) : super(key: key);

  @override
  JumpingDotsState createState() => JumpingDotsState();
}

class JumpingDotsState extends State<JumpingDots>
    with TickerProviderStateMixin {
  late List<AnimationController> animationControllers;
  List<Animation<double>> animations = [];
  int animationDuration = 200;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    for (var controller in animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.numberOfDots, (index) {
          return AnimatedBuilder(
            animation: animationControllers[index],
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(2.5),
                child: Transform.translate(
                  offset: Offset(0, animations[index].value),
                  child: DotWidget(
                    color: index == 0
                        ? MyColors.drawerColor
                        : index == 1
                            ? MyColors.inputBackgroundColor
                            : index == 2
                                ? MyColors.accentColor
                                : MyColors.drawerColor,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  void initAnimation() {
    animationControllers = List.generate(
      widget.numberOfDots,
      (index) {
        return AnimationController(
            vsync: this, duration: Duration(milliseconds: animationDuration));
      },
    ).toList();

    for (int i = 0; i < widget.numberOfDots; i++) {
      animations.add(
          Tween<double>(begin: 0, end: -20).animate(animationControllers[i]));
    }

    for (int i = 0; i < widget.numberOfDots; i++) {
      animationControllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationControllers[i].reverse();
          //if it is not last dot then start the animation of next dot.
          if (i != widget.numberOfDots - 1) {
            animationControllers[i + 1].forward();
          }
        }
        if (i == widget.numberOfDots - 1 &&
            status == AnimationStatus.dismissed) {
          animationControllers[0].forward();
        }
      });
    }
    animationControllers.first.forward();
  }
}

class DotWidget extends StatelessWidget {
  final Color color;

  const DotWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      height: 10,
      width: 10,
    );
  }
}
