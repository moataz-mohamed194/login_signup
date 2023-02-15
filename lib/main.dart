import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/eyesBloc/CheckerCubit.dart';
import 'injection_container.dart' as di;
import 'features/auth/presentation/ pages/LoginPage.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<LoginBloc>()),
          BlocProvider(
            create: (_) => CheckerCubit(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            home: LoginPage()));
  }
}
