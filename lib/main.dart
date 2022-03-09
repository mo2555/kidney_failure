import 'package:fire_base/Screens/add_products.dart';
import 'package:fire_base/Screens/result_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/auth.dart';
import 'Screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  SharedPreferences pre = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MyApp(
        resultScreen: pre.getBool('resultScreen') ?? false,
        resultData: pre.getString('resultData') ?? "You don't make any test yet",
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool resultScreen;
  final String resultData;

  const MyApp({this.resultScreen, this.resultData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TFDKD",
      theme: ThemeData(
        primaryColor: Colors.orange,
        canvasColor: Color.fromRGBO(255, 238, 219, 1),
      ),
      debugShowCheckedModeBanner: false,
      home: Provider.of<Auth>(context).isAuth
          ? MyHomePage(
              resultScreen: resultScreen,
              resultData: resultData,
            )
          : FutureBuilder(
              future: Provider.of<Auth>(context, listen: false).tryAutoLogin(),
              builder: (ctx, snapShot) =>
                  snapShot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.black45,
                        ))
                      : AuthScreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool resultScreen;
  final String resultData;

  const MyHomePage({this.resultScreen, this.resultData});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return widget.resultScreen ? ResultScreen(result: widget.resultData,) : AddProduct();
  }
}
