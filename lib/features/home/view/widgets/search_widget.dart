import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcase_cars_flutter_node_js/features/home/view_model/home_view_model.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ? Blue Background
        Container(
          height: MediaQuery.of(context).size.height / 10.5,
          color: const Color(0xff3374DB),
          width: double.infinity,
        ),

        // ? Search Cars
        Padding(
          padding: const EdgeInsets.only(
            left: 28,
            right: 28,
            bottom: 0,
            top: 12,
          ),
          child: Container(
            height: 46,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child:  TextField(
              onChanged: (text) => context.read<HomeViewModel>().searchCars(text),
              decoration: const InputDecoration(
                hintText: 'Busque por nome...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
