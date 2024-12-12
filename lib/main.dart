import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/providers/slot_provider.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/slot_repository_impl.dart';
import 'domain/usecases/add_slot.dart';
import 'domain/usecases/get_slots.dart';
import 'domain/usecases/delete_slot.dart';
import 'domain/usecases/register_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final slotRepository = SlotRepositoryImpl(FirebaseDatabase.instance.ref());
  final authRepository = AuthRepositoryImpl(FirebaseAuth.instance);
  final registerUseCase = RegisterUser(authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SlotProvider(
            addSlotUseCase: AddSlot(slotRepository),
            getSlotsUseCase: GetSlots(slotRepository),
            deleteSlotUseCase: DeleteSlot(slotRepository),
          ),
        ),
      ],
      child: MyApp(registerUseCase: registerUseCase),
    ),
  );
}

class MyApp extends StatelessWidget {
  final RegisterUser registerUseCase;

  MyApp({required this.registerUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      title: 'Game Slot',
      initialRoute: '/',
      routes: {
        '/': (context) => _getInitialScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(registerUseCase: registerUseCase),
      },
    );
  }

  Widget _getInitialScreen() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
