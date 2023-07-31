import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/core/routes/routes.gr.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_button.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_text_field.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';
import 'package:showcase_cars_flutter_node_js/core/utils/snack_bar_utils.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/user_model.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';
import 'package:showcase_cars_flutter_node_js/features/settings/view/widgets/custom_expansion_title.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // ? Edit
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // ? remove
  final _confirmFormKey = GlobalKey<FormState>();
  final emailConfirmEC = TextEditingController();
  final nameEditEC = TextEditingController();
  final passwordConfirmEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Configurações',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(Icons.logout_rounded),
                      onTap: () async {
                        context.router.replace(const HomeRoute());

                        await Future.delayed(const Duration(milliseconds: 100));

                        await viewModel.logout();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: CircleAvatar(
                  radius: 45,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Portrait_Placeholder.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  viewModel.user!.name ?? nameEditEC.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              CustomExpansionTitle(
                title: 'Nome e e-mail',
                iconColor: AppColors.primaryColor,
                subTitle: 'Insira seu nome e e-mail para atualizar',
                body: CustomButton(
                  title: 'Editar',
                  color: Colors.white70,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () async {
                    _showModalEdit(
                      context,
                      _confirmFormKey,
                    );
                  },
                ),
              ),
              CustomExpansionTitle(
                title: 'Senha',
                iconColor: AppColors.primaryColor,
                subTitle: 'Editar senha',
                body: CustomTextField(
                  hintText: "",
                  controller: passwordEC,
                  isObscureText: true,
                  icon: Icons.edit_outlined,
                ),
                button: CustomButton(
                  title: 'Senha',
                  color: Colors.white70,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _attemptEditPassword(viewModel);
                    }
                  },
                ),
              ),
              CustomExpansionTitle(
                title: 'Excluir a conta',
                iconColor: Colors.red,
                subTitle:
                    'Depois de excluir sua conta, não há como voltar atrás. Por favor, tenha certeza.',
                body: CustomButton(
                  title: 'Excluir a conta',
                  color: Colors.white70,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    _showModalDelete(
                      context,
                      _confirmFormKey,
                      emailConfirmEC,
                      passwordConfirmEC,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showModalEdit(
    BuildContext context,
    GlobalKey<FormState> confirmFormKey,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        final model = Provider.of<HomeViewModel>(context);

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: 380,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Insira suas credencias para continuar',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black.withOpacity(.4),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 24.0,
                  ),
                  child: Form(
                    key: _confirmFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'Nome',
                          hintText: 'Ex: Lucas',
                          icon: Icons.person_outline,
                          controller: nameEditEC,
                        ),
                        CustomTextField(
                          label: 'E-mail',
                          icon: Icons.email_outlined,
                          controller: emailConfirmEC,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: CustomButton(
                            title: 'Confirmar edição',
                            color: AppColors.primaryColor,
                            onPressed: () {
                              if (_confirmFormKey.currentState!.validate()) {
                                _attemptEdit(model);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      emailConfirmEC.text = "";
    });
  }

  _showModalDelete(
    BuildContext context,
    GlobalKey<FormState> confirmFormKey,
    TextEditingController emailConfirm,
    TextEditingController passwordConfirm,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        final model = Provider.of<HomeViewModel>(context);

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: 380,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Insira suas credencias para continuar',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black.withOpacity(.4),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 24.0,
                  ),
                  child: Form(
                    key: _confirmFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          icon: Icons.email,
                          controller: emailConfirmEC,
                        ),
                        CustomTextField(
                          icon: Icons.key_rounded,
                          controller: passwordConfirmEC,
                          hintText: "",
                          isObscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: CustomButton(
                            title: 'Confirmar exclusão',
                            color: AppColors.primaryColor,
                            onPressed: () {
                              if (_confirmFormKey.currentState!.validate()) {
                                _attemptDelete(
                                  model,
                                  emailConfirmEC.text,
                                  passwordConfirmEC.text,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      emailConfirmEC.text = "";
      passwordConfirmEC.text = "";
    });
  }

  _attemptDelete(HomeViewModel viewModel, String email, String password) async {
    try {
      await viewModel.apiProvider.deleteUser(
        UserModel(
          email: email,
          password: password,
        ),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showSuccessSnackBar('Conta excluida com sucesso!'),
      );

      context.router.replaceAll([const HomeRoute()]);

      viewModel.user = null;
      viewModel.token = null;
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showErrorSnackBar(error),
      );
    }
  }

  _attemptEditPassword(HomeViewModel viewModel) async {
    UserModel updatedUser = UserModel(
      id: viewModel.user!.id,
      password: passwordEC.text,
    );
    try {
      await viewModel.handleEditUser(updatedUser);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showSuccessSnackBar('Editado com sucesso!'),
      );
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showErrorSnackBar(error),
      );
    }
  }

  _attemptEdit(HomeViewModel viewModel) async {
    UserModel updatedUser = UserModel(
      id: viewModel.user!.id,
      name: nameEditEC.text,
      email: emailConfirmEC.text,
    );
    try {
      await viewModel.handleEditUser(updatedUser);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showSuccessSnackBar('Editado com sucesso!'),
      );
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showErrorSnackBar(error),
      );
    }
  }
}
