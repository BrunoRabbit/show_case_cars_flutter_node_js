// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcase_cars_flutter_node_js/core/routes/routes.gr.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/car_model.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/drawer_model.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/user_model.dart';
import 'package:showcase_cars_flutter_node_js/providers/api_provider.dart';

class HomeViewModel with ChangeNotifier {
  ApiProvider apiProvider = ApiProviderImpl();
  XFile? image;

  // ! is User Authenticate
  String? token;

  UserModel? user;
  List<CarModel> carsList = [];
  String selectedOption = 'Relevância';
  String? orderType;
  List filterOptions = ['Relevância', 'Preço crescente', 'Preço decrescente'];

  Future<void> logout() async {
    user = null;
    token = null;
    notifyListeners();
  }

  Future<void> handleLogin(
      String email, String password, BuildContext context) async {
    user = await apiProvider.loginUser(
      UserModel(
        password: password,
        email: email,
      ),
    );

    context.router.replace(const HomeRoute());
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();
  }

  Future<void> handleEditUser(UserModel userModel) async {
    await apiProvider.editUser(userModel);

    user = userModel;
    notifyListeners();
  }

  Future<void> verifyTokenJwt() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";

    notifyListeners();
  }

  void pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  loadCars() async {
    carsList = await apiProvider.loadAllCars();
    notifyListeners();
  }

  List<DrawerModel> get drawerItems => [
        DrawerModel(
          title: 'Página inicial',
          icon: const Icon(
            Icons.home_outlined,
            color: Colors.black,
            size: 28,
          ),
          onPressed: (context) => context.router.replace(const HomeRoute()),
        ),
        DrawerModel(
          title: user == null && token == null ? "Entrar" : 'Minha conta',
          icon: const Icon(
            Icons.account_circle_outlined,
            color: Colors.black,
            size: 28,
          ),
          onPressed: (context) {
            context.router.replace(AuthRootRoute());
          },
        ),
      ];

  void selectedFilter(String old) async {
    selectedOption = old;
    orderType = null;
    if (selectedOption == filterOptions[0] ||
        selectedOption == filterOptions[1]) {
      orderType = 'ASC';
    } else if (selectedOption == filterOptions[2]) {
      orderType = 'DESC';
    }
    carsList = await apiProvider.loadAllCars(orderType: orderType);
    notifyListeners();
  }

  void searchCars(String text) async {
    carsList = await apiProvider.loadAllCars(text: text, orderType: orderType);
    notifyListeners();
  }
}
