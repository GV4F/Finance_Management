import 'package:flutter/material.dart';

class InputSign extends StatefulWidget {

  final String hinText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;

  const InputSign({
    required this.hinText,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    super.key
  });

  @override
  State<InputSign> createState() => _InputSignState();
}

class _InputSignState extends State<InputSign> {

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final Color activeColor = const Color(0xFF624891);
    final Color inactiveColor = const Color(0x301E1E1E);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _isFocused ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        focusNode: _focusNode,
        obscureText: widget.isPassword,
        style: TextStyle(color: colors.onSurface),
        decoration: InputDecoration(
          icon: Icon(widget.icon, color: colors.primary),
          hintText: widget.hinText,
          hintStyle: TextStyle(color: colors.onSurface.withValues(alpha: 0.7)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}