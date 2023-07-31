import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view/widgets/cars_showcase.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view/widgets/search_widget.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';
import 'package:showcase_cars_flutter_node_js/core/shared/widgets/custom_app_bar.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel viewModel;
  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateShowButtonState();
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.loadCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          color: AppColors.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              // ? Search Section
              SearchWidget(),

              SizedBox(
                height: 15,
              ),

              // ? Cars Showcase
              CarsShowcase()
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000),
        opacity: showbtn ? 1.0 : 0.0,
        child: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }

  void updateShowButtonState() {
    scrollController.addListener(() {
      double showoffset = 10.0;
      showbtn = false;

      if (scrollController.offset > showoffset) {
        setState(() {
          showbtn = true;
        });
      }
      setState(() {
        showbtn;
      });
    });
  }
}
