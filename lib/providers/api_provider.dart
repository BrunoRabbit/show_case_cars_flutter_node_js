import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcase_cars_flutter_node_js/core/services/api_requests_services.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/car_model.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/user_model.dart';

import 'package:http/http.dart' as http;

typedef ResponseHandler = dynamic Function(Map<String, dynamic> responseData);

abstract class ApiProvider {
  Future<void> createUser(UserModel userModel);
  Future<UserModel> loginUser(UserModel userModel);
  Future<void> addCar(CarModel carModel);
  Future<List<CarModel>> loadAllCars({String? text, String? orderType});
  Future<void> editCar(CarModel carModel);
  Future<void> deleteCar(CarModel carModel);
  Future<void> deleteUser(UserModel userModel);
  Future<void> editUser(UserModel userModel);
}

class ApiProviderImpl extends ApiRequestsServices implements ApiProvider {
  static const String _baseUrl = 'http://192.168.15.10:3000/';

  @override
  Future<void> createUser(UserModel userModel) async {
    try {
      http.Response response = await post(
        url: '${_baseUrl}api/user',
        body: jsonEncode(userModel.toMap()),
      );

      if (response.statusCode == 400) {
        throw json.decode(response.body)['name'];
      }
    } catch (_) {
      throw Exception("$_");
    }
  }

  @override
  Future<UserModel> loginUser(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await post(
        url: '${_baseUrl}api/user/login',
        body: jsonEncode(userModel.toMap()),
      );

      if (response.statusCode == 400) {
        throw json.decode(response.body)['name'];
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      final String? token = responseData['token'];
      await prefs.setString('token', token ?? "");

      return UserModel.fromMap(responseData['user']);
    } catch (_) {
      throw Exception('Usuário ou senha incorretos.');
    }
  }

  @override
  Future<void> addCar(CarModel carModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenLocalStorage = prefs.getString('token');

    try {
      http.Response response = await post(
        url: '${_baseUrl}api/car',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': tokenLocalStorage ?? "",
        },
        body: jsonEncode(carModel.toMap()),
      );
      if (response.statusCode == 400) {
        throw json.decode(response.body)['name'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CarModel>> loadAllCars({String? text, String? orderType}) async {
    String url = _parseUrl(text, orderType);

    try {
      http.Response response = await get(url: '$_baseUrl$url');

      if (response.statusCode == 400) {
        throw json.decode(response.body)['name'];
      }

      final responseData = List<Map<String, dynamic>>.from(
        jsonDecode(response.body),
      );

      return responseData.map((carData) => CarModel.fromMap(carData)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> editCar(CarModel carModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenLocalStorage = prefs.getString('token');
    try {
      http.Response response = await put(
        url: '${_baseUrl}api/car/${carModel.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': tokenLocalStorage ?? "",
        },
        body: jsonEncode(carModel.toMap()),
      );
      if (response.statusCode == 400) {
        throw json.decode(response.body)['name'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCar(CarModel carModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tokenLocalStorage = prefs.getString('token');

    try {
      http.Response response = await delete(
        url: '${_baseUrl}api/car/${carModel.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': tokenLocalStorage ?? "",
        },
        body: jsonEncode(carModel.toMap()),
      );
      if (response.statusCode == 400) {
        throw json.decode(response.body)['name'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteUser(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenLocalStorage = prefs.getString('token');
    try {
      http.Response response = await delete(
        url: '${_baseUrl}api/user/delete',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenLocalStorage',
        },
        body: jsonEncode({
          'email': userModel.email,
          'password': userModel.password,
        }),
      );

      if (response.statusCode == 400) {
        throw json.decode(response.body)['name'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> editUser(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenLocalStorage = prefs.getString('token');

    try {
      http.Response response = await put(
        url: '${_baseUrl}api/user/${userModel.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenLocalStorage',
        },
        body: userModel.toJson(),
      );

      if (response.statusCode == 400) {
        throw json.decode(response.body)['name'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  String _parseUrl(text, orderType) {
    const baseUrl = 'api/car';
    String url = baseUrl;

    if (text != null && text.isNotEmpty) {
      url += '?name=$text';
    }

    if (orderType != null && orderType.isNotEmpty) {
      if (url == baseUrl) {
        url += '?price=$orderType';
      } else {
        url += '&price=$orderType';
      }
    }
    return url;
  }
}
