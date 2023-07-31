import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/core/routes/routes.gr.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';

import 'package:showcase_cars_flutter_node_js/features/home/models/car_model.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';

@RoutePage()
class CarSummaryView extends StatelessWidget {
  const CarSummaryView(this.item, this.index, {Key? key}) : super(key: key);

  final CarModel item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Visão geral'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.file(
              File(item.photo!),
              fit: BoxFit.cover,
            ),
          ),

          // ? Names + Icons
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name!,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      viewModel.user != null && viewModel.user!.isAdmin!
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: InkWell(
                                    onTap: () {
                                      context.router.push(
                                        AdminVehicleManagementRoute(
                                          title: 'Editar',
                                          sectionTitle:
                                              'Editar veiculo selecionado',
                                          isEditCar: true,
                                          carModel: item,
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit_outlined,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: InkWell(
                                    onTap: () async {
                                      context.router
                                          .replaceAll([const HomeRoute()]);

                                      await viewModel.apiProvider.deleteCar(
                                        CarModel(
                                          id: item.id,
                                          name: item.name,
                                          brand: item.brand,
                                          model: item.model,
                                          price: item.price,
                                          photo: item.photo,
                                        ),
                                      );
                                      await viewModel.loadCars();
                                    },
                                    child: const Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
