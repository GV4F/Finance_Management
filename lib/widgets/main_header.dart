import 'package:flutter/material.dart';

class MainHeader extends StatefulWidget {
  const MainHeader({super.key});

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            width: screenWidth * 0.9,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [colors.tertiary, colors.primary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome Back, GVAF !',
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: colors.onPrimary,
                        size: 30,
                      ),
                      onPressed: () => {},
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colors.onPrimary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                color: colors.onSurface,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_red_eye_outlined, color: colors.tertiary, size: 25),
                              onPressed: () => {},
                            )
                          ],
                        ),
                        Text(
                          '*******',
                          style: TextStyle(
                            color: colors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}