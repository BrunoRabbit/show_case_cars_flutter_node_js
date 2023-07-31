import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_button.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_text_field.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/divider_with_title.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';
import 'package:showcase_cars_flutter_node_js/core/utils/snack_bar_utils.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/user_model.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Crie sua conta ou inicie sessão',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Insira suas informações para prosseguir. Garantimos a segurança e privacidade dos seus dados em nosso banco de dados.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              label: 'Nome completo',
              icon: Icons.person_outline,
              controller: nameController,
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
              title: 'Registrar',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  attemptRegister(viewModel);
                }
              },
            ),
            const DividerWithTitle(),
            CustomButton(
              title: 'Entrar',
              color: AppColors.primaryColor,
              onPressed: () {
                widget.controller.jumpToPage(1);
              },
            ),
          ],
        ),
      ),
    );
  }

  void attemptRegister(HomeViewModel viewModel) async {
    try {
      await viewModel.apiProvider.createUser(
        UserModel(
          name: nameController.text,
          password: passwordController.text,
          email: emailController.text,
        ),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showSuccessSnackBar('Registrado com sucesso'),
      );
      widget.controller.jumpToPage(1);
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showErrorSnackBar(error),
      );
    }
  }
}
