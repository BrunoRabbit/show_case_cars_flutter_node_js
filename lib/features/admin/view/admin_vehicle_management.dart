import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/core/routes/routes.gr.dart';

import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_text_field.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';
import 'package:showcase_cars_flutter_node_js/core/utils/number_dot_input_formatter.dart';
import 'package:showcase_cars_flutter_node_js/core/utils/snack_bar_utils.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/car_model.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';

@RoutePage()
class AdminVehicleManagementView extends StatefulWidget {
  const AdminVehicleManagementView({
    Key? key,
    required this.title,
    required this.sectionTitle,
    required this.isEditCar,
    this.carModel,
  }) : super(key: key);

  final String title;
  final String sectionTitle;
  final bool isEditCar;
  final CarModel? carModel;

  @override
  State<AdminVehicleManagementView> createState() =>
      _AdminVehicleManagementViewState();
}

class _AdminVehicleManagementViewState
    extends State<AdminVehicleManagementView> {
  final nameEC = TextEditingController();
  final brandEC = TextEditingController();
  final carModelEC = TextEditingController();
  final priceEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                if (widget.isEditCar) {
                  await _handleEditCar(viewModel);
                } else {
                  if (_formKey.currentState!.validate()) {
                    await _handleAddCar(viewModel);

                    viewModel.image = null;

                    if (!mounted) return;
                    context.router.replace(const HomeRoute());
                  }
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sectionTitle,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(
                  label: 'Nome',
                  hintText: 'Ex: Toyota Camry',
                  icon: Icons.add,
                  controller: nameEC,
                ),
                CustomTextField(
                  label: 'Marca',
                  hintText: 'Ex: Toyota',
                  icon: Icons.add,
                  controller: brandEC,
                ),
                CustomTextField(
                  label: 'Modelo',
                  hintText: 'Ex: Camry',
                  icon: Icons.add,
                  controller: carModelEC,
                ),
                CustomTextField(
                  label: 'Preço',
                  hintText: 'Ex: 26.558',
                  icon: Icons.add,
                  controller: priceEC,
                  inputFormatters: [NumberDotInputFormatter()],
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.pickImage();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: viewModel.image != null
                            ? AppColors.primaryColor
                            : AppColors.errorColor,
                        width: 3,
                      ),
                    ),
                    child: viewModel.image == null
                        ? const Icon(
                            Icons.add_a_photo_outlined,
                            size: 40,
                          )
                        : Image.file(
                            File(viewModel.image!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                viewModel.image == null
                    ? const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'A imagem não pode ser vazia',
                          style: TextStyle(
                            color: AppColors.errorColor,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleEditCar(HomeViewModel viewModel) async {
    if (viewModel.image == null) return;
    CarModel carModelUpdated = CarModel(
      id: widget.carModel!.getId,
      name: nameEC.text.isEmpty ? widget.carModel!.name : nameEC.text,
      brand: brandEC.text.isEmpty ? widget.carModel!.brand : brandEC.text,
      model: carModelEC.text.isEmpty ? widget.carModel!.model : carModelEC.text,
      price: priceEC.text.isEmpty
          ? widget.carModel!.price
          : double.parse(priceEC.text),
      photo: widget.carModel!.photo!,
    );
    try {
      await viewModel.apiProvider.editCar(carModelUpdated);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showSuccessSnackBar(
          'Redirecionando, por favor aguarde!',
        ),
      );
      Future.delayed(const Duration(seconds: 1), () {
        context.router.replaceAll([const HomeRoute()]);
      });

    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showErrorSnackBar(error),
      );
    }
  }

  Future<void> _handleAddCar(HomeViewModel viewModel) async {
    try {
      await viewModel.apiProvider.addCar(
        CarModel(
          name: nameEC.text,
          brand: brandEC.text,
          model: carModelEC.text,
          price: double.parse(priceEC.text),
          photo: viewModel.image!.path,
        ),
      );
      await viewModel.loadCars();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showSuccessSnackBar(
          'Redirecionando, por favor aguarde!',
        ),
      );
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtils.showErrorSnackBar(error),
      );
    }
  }
}
