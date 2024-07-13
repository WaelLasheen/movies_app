import 'package:flutter/material.dart';
import 'package:movies_app/Fetchers/Favorite/data/favorite_db_helper.dart';
import 'package:movies_app/Fetchers/splash/Splash.dart';
// import 'package:movies_app/core/widget/animated_gridview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FavoriteDatabaseHelper().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovietOo',
      // theme: ThemeData.dark(),
      // home: MyCustomWidget(),    /////////////// update and use animated gridview
      home: Splash(),
    );
  }
}
