import 'package:flutter/material.dart';
import 'package:showcase_cars_flutter_node_js/core/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';

void application() async {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _appRouter = Routes();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
