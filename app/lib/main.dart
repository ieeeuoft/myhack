import 'package:app/page_viewer.dart';
import 'package:app/app/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/global_service.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotifications();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    GlobalUserService().updateUser(user);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PageViewer(),
      routes: AppRoutes.routes,
      navigatorKey: navigatorKey,
    );
  }
}

// class MainScaffold extends StatefulWidget {
//   @override
//   _MainScaffoldState createState() => _MainScaffoldState();
// }

// class _MainScaffoldState extends State<MainScaffold> {
//   AppTab _selectedTab = AppTab.Home;

//   void _onTabTapped(int index) {
//     setState(() {
//       _selectedTab = AppTab.values[index];
//     });
//   }

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future signInWithEmail(String email, String password) async {
//     UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);
//     return result.user;
//   }
//
//   Future signUpWithEmail(String email, String password) async {
//     UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     return result.user;
//   }
//
//   Future signInWithGoogle() async {
//     GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
//     if (googleSignInAccount != null) {
//       GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//       AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//       UserCredential result = await _auth.signInWithCredential(credential);
//       return result.user;
//     }
//   }
// }
//

//

//
//
// class SignInPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign In')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             UserCredential userCredential = await AuthService().signInWithGoogle();
//             if (userCredential.user != null) {
//               Navigator.pushReplacementNamed(context, '/profile');
//             }
//           },
//           child: Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }
// }
//
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       theme: ThemeData(
// //         primarySwatch: Colors.indigo,
// //         brightness: Brightness.dark,
// //       ),
// //       home: const SignInScreen(),
// //     );
// //   }
// // }
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   int _currentIndex = 0;
//   final List<Widget> _children = [
//     // ProfilePage(), // You need to import or define ProfilePage
//     // TeamPage(),    // You need to import or define TeamPage
//     // BlogPage(),    // You need to import or define BlogPage
//     // SignInPage(),
//     // Add more pages here
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hackathon App'),
//       ),
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.group),
//             label: 'Team',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'Blog',
//           ),
//           // Add more tabs here
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
//
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         theme: ThemeData(
// //           primarySwatch: Colors.blue,
// //           textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
// //           textTheme: TextTheme(
// //             subtitle1: TextStyle(color: Colors.black), //<-- SEE HERE
// //           ),
// //           inputDecorationTheme: InputDecorationTheme(
// //             hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
// //             contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// //             border: OutlineInputBorder(borderSide: BorderSide.none),
// //           ),
// //         ),
// //         home: const LoginScreen());
// //   }
// // }
//
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //      return MaterialApp(
// //       title: 'Bottom Navigation Bar',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: Colors.transparent,
// //           elevation: 0, // Remove the shadow
// //         ),
// //       ),
// //       home: SignInPage(), // MyHomePage(title: 'myhack',),
// //     );
// //   }
// // }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text('Home'),
//     Text('Search'),
//     Text('Profile'),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bottom Navigation Bar'),
//         // backgroundColor: Colors.transparent,
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         // backgroundColor: Colors.transparent,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: Colors.black),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search, color: Colors.black),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, color: Colors.black),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
