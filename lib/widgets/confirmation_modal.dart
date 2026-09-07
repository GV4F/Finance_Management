import 'dart:ui';
import 'package:flutter/material.dart';

/// Modal de confirmación minimalista centrado en pantalla,
/// adaptado a la estética neon/dark de la aplicación.
class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final IconData? icon;
  final bool isDestructive;
  final Color? customAccentColor;

  const ConfirmationModal({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'CONFIRM',
    this.cancelText = 'CANCEL',
    this.icon,
    this.isDestructive = false,
    this.customAccentColor,
  });

  /// Método de utilidad estático para mostrar el diálogo de confirmación fácilmente.
  /// Retorna `true` si el usuario confirma, `false` o `null` si cancela o descarta.
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'CONFIRM',
    String cancelText = 'CANCEL',
    IconData? icon,
    bool isDestructive = false,
    Color? customAccentColor,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (BuildContext dialogContext) {
        return ConfirmationModal(
          title: title,
          message: message,
          confirmText: confirmText,
          cancelText: cancelText,
          icon: icon,
          isDestructive: isDestructive,
          customAccentColor: customAccentColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final Color accentColor = customAccentColor ??
        (isDestructive ? colors.tertiary : colors.primary);

    final IconData displayIcon = icon ??
        (isDestructive
            ? Icons.warning_amber_rounded
            : Icons.help_outline_rounded);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 380.0),
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: colors.onPrimary.withValues(alpha: 0.88),
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.15),
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icono central con halo de acento
                Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.2),
                        blurRadius: 12.0,
                      ),
                    ],
                  ),
                  child: Icon(
                    displayIcon,
                    color: accentColor,
                    size: 28.0,
                  ),
                ),
                const SizedBox(height: 20.0),

                // Título
                Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'BrunoAce',
                    color: accentColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12.0),

                // Mensaje descriptivo
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.8),
                    fontSize: 14.0,
                    height: 1.45,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 28.0),

                // Botones de acción
                Row(
                  children: [
                    // Botón Cancelar
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(false),
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: colors.onSurface.withValues(alpha: 0.3),
                                width: 1.2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                cancelText,
                                style: TextStyle(
                                  fontFamily: 'BrunoAce',
                                  color: colors.onSurface.withValues(alpha: 0.7),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14.0),

                    // Botón Confirmar
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: accentColor,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withValues(alpha: 0.25),
                                  blurRadius: 8.0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                confirmText,
                                style: TextStyle(
                                  fontFamily: 'BrunoAce',
                                  color: accentColor,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
