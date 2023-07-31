import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_app_bar.dart';
import 'package:showcase_cars_flutter_node_js/features/auth/view/widgets/login_widget.dart';
import 'package:showcase_cars_flutter_node_js/features/auth/view/widgets/register_widget.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';
import 'package:showcase_cars_flutter_node_js/features/settings/view/settings_view.dart';

@RoutePage()
class AuthRootView extends StatefulWidget {
  const AuthRootView({super.key});

  @override
  State<AuthRootView> createState() => _AuthRootViewState();
}

class _AuthRootViewState extends State<AuthRootView> {
  final PageController pageController = PageController();
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().verifyTokenJwt();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<HomeViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 27,
          top: 30,
          right: 27,
        ),
        child: viewModel.user == null
            ? PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  RegisterWidget(
                    controller: pageController,
                  ),
                  LoginWidget(
                    controller: pageController,
                  ),
                ],
              )
            : const SettingsView(),
      ),
    );
  }
}
