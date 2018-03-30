import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.light(),
      title: 'Animation Slider',
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  Animation animation2;
  AnimationController controller2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
      vsync: this,
      duration: new Duration(
        seconds: 3,
      ),
    );
    animation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status== AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();

    controller2 = new AnimationController(
      vsync: this,
      duration: new Duration(
        seconds: 3,
      ),
    );
    animation2 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(parent: controller2, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status){
        if(status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status== AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    controller2.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor:
          new Color.fromRGBO(130, 220, (220 * animation.value).round(), 1.0),
      body: new Center(
        child: new Container(
          child: new CustomPaint(
            painter: new Artboard(
              value: animation.value,
              value2: animation2.value,
            ),
          ),
        ),
      ),
    );
  }
}

class Artboard extends CustomPainter {
  Artboard({this.value,this.value2});

  final double value;
  final double value2;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    var linePaint = new Paint()
      ..color = Colors.blueAccent[700]
      ..strokeWidth = 30.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(new Offset(0.0, -200.0), new Offset(0.0, 200.0), linePaint);

    var paint = new Paint()
    ..color = Colors.blueAccent
    ..blendMode = BlendMode.screen;


    canvas.drawRect(
        new Rect.fromCircle(
            center: new Offset(0.0, value * (-200) + 100), radius: 40.0),
        paint);

    var cirPaint = new Paint()
      ..color = Colors.greenAccent
      ..blendMode = BlendMode.multiply;
    canvas.drawCircle(new Offset(0.0, value * 100 - 100), 50.0, cirPaint);

    var triPaint = new Paint()
    ..color = Colors.redAccent
    ..blendMode = BlendMode.colorBurn;
    canvas.drawArc(
        new Rect.fromCircle(center: new Offset(0.0, 0.0), radius: 50.0),
        (math.pi * value2 - 2 * math.pi / 3),
        math.pi / 3 * 2,
        true,
        triPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
