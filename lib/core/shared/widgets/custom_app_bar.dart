import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/core/routes/routes.gr.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/item_general_dialog.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/drawer_model.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isMenuPressed = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: GestureDetector(
          onTap: () {
            context.router.replace(const HomeRoute());
          },
          child: Image.asset(
            'assets/images/kavak-logo.jpg',
            height: 120,
            width: 120,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 26.0),
          child: GestureDetector(
            onTap: () {
              !isMenuPressed
                  ? Platform.isAndroid || Platform.isIOS
                      ? _openModal()
                      : null
                  : context.router.pop();

              !isMenuPressed ? isMenuPressed = !isMenuPressed : null;
              setState(() {
                isMenuPressed;
              });
            },
            child: Icon(
              isMenuPressed ? Icons.close_rounded : Icons.menu,
              color: AppColors.primaryColor,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  _openModal() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.transparent,
      pageBuilder: (context, _, __) {
        final viewModel = context.watch<HomeViewModel>();

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: Container(
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      thickness: 2,
                      color: AppColors.primaryColor,
                      indent: 28,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.drawerItems.length,
                      itemBuilder: (context, index) {
                        final item = viewModel.drawerItems[index];
                        return ItemGeneralDialog(
                          item: item,
                        );
                      },
                    ),
                    viewModel.user != null && viewModel.user!.isAdmin!
                        ? ItemGeneralDialog(
                            item: DrawerModel(
                              title: 'Painel administrativo',
                              icon: const Icon(
                                Icons.admin_panel_settings_outlined,
                              ),
                              onPressed: (context) {
                                context.router.replace(
                                  AdminVehicleManagementRoute(
                                    title: "Adicionar",
                                    sectionTitle: 'Adicionar novo veiculo',
                                    isEditCar: false,
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {
        isMenuPressed = !isMenuPressed;
      });
    });
  }
}
