import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/features/home/presentations/view/home_screen.dart';
import 'package:task/features/search/presentation/provider/search_provider.dart';
import 'package:task/features/upload/presentation/provider/upload_provider.dart';
import 'package:task/features/home/presentations/provider/home_provider.dart';
import 'package:task/features/auth/presentation/provider/auth_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => SearchUserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const HomeScreen(),
      ),
    );
  }
}
