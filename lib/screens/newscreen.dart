// import 'package:flutter/material.dart';

// import 'package:page_transition/page_transition.dart';
// import './dashboard.dart';

// class NewScreen extends StatefulWidget {
//   _NewScreenState createState() => _NewScreenState();
// }

// class _NewScreenState extends State<NewScreen> with TickerProviderStateMixin {
//   PageController _pageController;

//   AnimationController rippleController;
//   AnimationController scaleController;

//   Animation<double> rippleAnimation;
//   Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _pageController = PageController(initialPage: 0);

//     rippleController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));

//     scaleController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1))
//           ..addStatusListener(
//             (status) {
//               if (status == AnimationStatus.completed) {
//                 Navigator.push(
//                   context,
//                   PageTransition(
//                     type: PageTransitionType.fade,
//                     child: DashBoard(),
//                   ),
//                 );
//               }
//             },
//           );

//     rippleAnimation =
//         Tween<double>(begin: 80.0, end: 90.0).animate(rippleController)
//           ..addStatusListener((status) {
//             if (status == AnimationStatus.completed) {
//               rippleController.reverse();
//             } else if (status == AnimationStatus.dismissed) {
//               rippleController.forward();
//             }
//           });

//     scaleAnimation =
//         Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);

//     rippleController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         children: <Widget>[
//           makePage(image: 'assets/images/one.jpg'),
//           makePage(image: 'assets/images/two.jpg'),
//           makePage(image: 'assets/images/three.jpg'),
//         ],
//       ),
//     );
//   }

//   Widget makePage({image}) {
//     return Container(
//       decoration: BoxDecoration(
//           image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
//       child: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//           Colors.black.withOpacity(.3),
//           Colors.black.withOpacity(.3),
//         ])),
//         child: Padding(
//           padding: EdgeInsets.all(40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'Exerciese 1',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "15",
//                     style: TextStyle(
//                         color: Colors.yellow[400],
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "Minutes",
//                     style: TextStyle(color: Colors.white, fontSize: 30),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "3",
//                     style: TextStyle(
//                         color: Colors.yellow[400],
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "Exercises",
//                     style: TextStyle(color: Colors.white, fontSize: 30),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 180,
//               ),
//               Align(
//                 child: Text(
//                   "Start the morning with your health",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 30,
//                       fontWeight: FontWeight.w100),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AnimatedBuilder(
//                   animation: rippleAnimation,
//                   builder: (context, child) => Container(
//                     width: rippleAnimation.value,
//                     height: rippleAnimation.value,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.yellow.withOpacity(.4)),
//                       child: InkWell(
//                         onTap: () {
//                           scaleController.forward();
//                         },
//                         child: AnimatedBuilder(
//                           animation: scaleAnimation,
//                           builder: (context, child) => Transform.scale(
//                             scale: scaleAnimation.value,
//                             child: Container(
//                               margin: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle, color: Colors.yellow),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
