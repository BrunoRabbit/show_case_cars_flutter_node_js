import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view/widgets/list_cars_cards.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';

class CarsShowcase extends StatefulWidget {
  const CarsShowcase({super.key});

  @override
  State<CarsShowcase> createState() => _CarsShowcaseState();
}

class _CarsShowcaseState extends State<CarsShowcase> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 28, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CARROS USADOS',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  viewModel.carsList.isNotEmpty
                      ? '${viewModel.carsList.length} ${viewModel.carsList.length == 1 ? 'Resultado' : 'Resultados'}'
                      : 'Sem resultados.',
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 22.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Ordenar: ',
                      ),
                      GestureDetector(
                        onTap: () {
                          _showModalFilter(context, viewModel);
                        },
                        child: Row(
                          children: [
                            Text(
                              viewModel.selectedOption,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.carsList.length,
              itemBuilder: (context, index) {
                final item = viewModel.carsList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListCarsCards(
                    item: item,
                    index: index,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _showModalFilter(BuildContext context, HomeViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 280,
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
                        'Organizar por',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
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
              Consumer<HomeViewModel>(
                builder: (context, state, _) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        value: state.selectedOption,
                        isExpanded: true,
                        items: state.filterOptions.map((filter) {
                          return DropdownMenuItem<String>(
                            value: filter,
                            child: Text(filter),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          state.selectedFilter(newValue!);
                        },
                        underline: const SizedBox(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}