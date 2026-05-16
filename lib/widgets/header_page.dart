import 'package:flutter/material.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({
    super.key,
    required this.titlePage,
  });

  final String titlePage;

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 50.0, right: 10.0, left: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.titlePage,
                style: TextStyle(
                  color: colors.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                color: colors.onPrimary,
                onPressed: () => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}