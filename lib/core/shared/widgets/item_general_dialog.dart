import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:showcase_cars_flutter_node_js/features/home/models/drawer_model.dart';

class ItemGeneralDialog extends StatelessWidget {
  const ItemGeneralDialog({required this.item, super.key});

  final DrawerModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.pop();
        item.onPressed(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24.0,
          bottom: 10,
          top: 8,
        ),
        child: Row(
          children: [
            item.icon ?? Container(),
            const SizedBox(width: 10),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
