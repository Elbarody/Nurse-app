import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key:key);

  @override
  _SplashViewBodyState createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> with SingleTickerProviderStateMixin{
  AnimationController? animationController;
  Animation? fadingAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600) );
    fadingAnimation =
        Tween<double>(begin: .2 , end: 1).animate(animationController!)..addListener(()
        {
          setState(() {

          });
        });
    animationController?.forward();
  }
    @override
    Widget build(BuildContext context) {
      return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: fadingAnimation?.value,
               child:
               const Text(
                'Your Personal Nurse is Here !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Poppins',
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    height: 1
                ),
              ),
      ),


            ],
          ));
    }
  }



