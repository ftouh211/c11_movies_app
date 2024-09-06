import 'package:c11_movie_app/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class splashScreen extends StatefulWidget {
  static const String routeName = "splash";
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    Future.delayed(
        Duration(seconds: 3), () {
      Navigator.pushReplacement(context ,
          MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Expanded(
                child: Center(
                    child: Image.asset(
                      "assets/images/movies.png",
                      height: 208,
                      width: 199,
                    ))),
            Image.asset("assets/images/91148991_2820896908005806_2254769371253571584_n.png",
              height: 128,
              width: 128,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "supervised by Ahmed && Ftouh",
              style: TextStyle(color: Color(0xffFFBB3B),fontSize: 14,),
            )
          ],
        ),
      ),
    );
  }
}