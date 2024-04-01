import 'package:flutter/material.dart';
class MenuItems extends StatelessWidget {
  const MenuItems({
    required this.onSettings,
    required this.deleteTapped,
  });

  final VoidCallback onSettings;
  final VoidCallback deleteTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onSettings();
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
            ),
            height: 50,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings),
                Text("Change", style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            deleteTapped();
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
            ),
            height: 50,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete),
                Text("Delete", style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
        ),
      ],
    );
  }
}