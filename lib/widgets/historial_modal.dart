import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistorialModal extends StatefulWidget {
  final String transactionId;
  final String title;
  final String date;
  final double amount;
  final String description;
  final bool isIncome; // : true para ingresos (+), false para gastos (-)
  final VoidCallback onRevertSuccess;

  const HistorialModal({
    super.key,
    required this.transactionId,
    required this.title,
    required this.date,
    required this.amount,
    required this.description,
    required this.isIncome,
    required this.onRevertSuccess,
  });

  @override
  State<HistorialModal> createState() => _HistorialModalState();
}

class _HistorialModalState extends State<HistorialModal> {
  bool _isLoading = false;

  final formatCurrency = NumberFormat.currency(locale: 'en_US', symbol: 'Q. ');
  final formatDate = DateFormat('MMMM dd, yyyy - hh:mm a');

  Future<void> _revertTransaction() async {
    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) throw Exception('Usuario no autenticado');

      // 1. Lógica matemática para revertir usando tu RPC 'update_balance'
      // Si fue ingreso (isIncome = true), para revertirlo debemos RESTAR (operation: false)
      // Si fue gasto (isIncome = false), para revertirlo debemos SUMAR (operation: true)
      final bool operation = !widget.isIncome; 

      await supabase.rpc('update_balance', params: {
        'p_user_id': userId,
        'increase': widget.amount,
        'operation': operation,
      });

      await supabase
          .from('transaction')
          .delete()
          .eq('id', widget.transactionId);

      if (!mounted) return;
      
      Navigator.pop(context);
      widget.onRevertSuccess();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction reverted successfully', style: TextStyle(fontFamily: 'Bruce Ace')),
          backgroundColor: Color(0xFF00E5FF),
        ),
      );

    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error', style: const TextStyle(fontFamily: 'Bruce Ace')),
          backgroundColor: const Color(0xFFFF1744),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final Color accentColor = widget.isIncome ? colors.primary : colors.tertiary;
    final String sign = widget.isIncome ? '+' : '-';

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), 
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: colors.onPrimary.withValues(alpha: 0.75),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pill / Drag Handle
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: colors.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // : Header: Título y Monto
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Bruce Ace',
                      color: colors.onSurface,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '$sign ${formatCurrency.format(widget.amount)}',
                  style: TextStyle(
                    fontFamily: 'Bruce Ace',
                    color: accentColor,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        color: accentColor.withValues(alpha: 0.6),
                        blurRadius: 8,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Fecha
            Text(
              formatDate.format(DateTime.parse(widget.date)),
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),

            // Caja de Descripción
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.onSurface.withValues(alpha: 0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontFamily: 'Bruce Ace',
                      color: colors.onSurface.withValues(alpha: 0.4),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description.isNotEmpty ? widget.description : 'No description provided.',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // : Botón de Revertir (Acción Crítica)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _revertTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFFFF1744), width: 1.5),
                  ),
                ).copyWith(
                  elevation: WidgetStateProperty.all(0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: colors.tertiary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Color(0xFFFF1744),
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'REVERT TRANSACTION',
                            style: TextStyle(
                              fontFamily: 'Bruce Ace',
                              color: Color(0xFFFF1744),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // : Espacio extra para el SafeArea de dispositivos modernos
          ],
        ),
      ),
    );
  }
}