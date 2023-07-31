import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_button.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_text_field.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/divider_with_title.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';
import 'package:showcase_cars_flutter_node_js/core/utils/snack_bar_utils.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Iniciar sessão com seu e-mail',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              label: 'Email',
              icon: Icons.email_outlined,
              hintText: 'Ex: kavak.contato.suporte@company...',
              controller: emailController,
            ),
            CustomTextField(
              label: 'Senha',
              icon: Icons.key,
              hintText: null,
              isObscureText: true,
              controller: passwordController,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
              title: 'Entrar',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await attemptLogin(viewModel);
                }
              },
            ),
            const DividerWithTitle(title: 'Não tem uma conta?'),
            CustomButton(
              title: 'Registrar',
              color: AppColors.primaryColor,
              onPressed: () {
                widget.controller.jumpToPage(0);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> attemptLogin(HomeViewModel viewModel) async {
    try {
      await viewModel.handleLogin(
        emailController.text,
        passwordController.text,
        context,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showSuccessSnackBar('Redirecionando, por favor aguarde!'),
      );
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showErrorSnackBar(error),
      );
    }
  }
}
