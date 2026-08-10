import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddSavingModal extends StatefulWidget {
  const AddSavingModal({super.key});

  @override
  State<AddSavingModal> createState() => _AddSavingModalState();
}

class _AddSavingModalState extends State<AddSavingModal> {

  TextEditingController titleController = TextEditingController();  
  TextEditingController goalAmountController = TextEditingController();
  TextEditingController initialAmountController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    goalAmountController.dispose();
    initialAmountController.dispose();
    super.dispose();
  }

  Future<void> postNewSaving(String title, double goalAmount, double initialAmount) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('savings').insert({
        'title': title,
        'objetive_amount': goalAmount,
        'actual_amount': initialAmount,
      });
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New saving created successfully!')),
        );
      }
    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating new saving: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: colors.onPrimary.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: colors.primary.withValues(alpha: 0.5), 
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.2),
                blurRadius: 20.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título del Modal
              Center(
                child: Text(
                  'NEW SAVINGS',
                  style: TextStyle(
                    fontFamily: 'Bruce Ace', 
                    color: colors.primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // 1. Campo: Título
              _buildInput(
                label: 'Title (e.g., RTX 5090)',
                icon: Icons.track_changes,
                isNumber: false,
                controller: titleController,
              ),
              const SizedBox(height: 16.0),

              // 2. Campo: Objetivo Total
              _buildInput(
                label: 'Goal Amount (Q.)',
                icon: Icons.flag,
                isNumber: true,
                controller: goalAmountController,
              ),
              const SizedBox(height: 16.0),

              // 3. Campo: Cantidad Inicial
              _buildInput(
                label: 'Initial Amount (Q.)',
                icon: Icons.account_balance_wallet,
                isNumber: true,
                controller: initialAmountController,
              ),
              const SizedBox(height: 32.0),

              // Botones de Acción
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón Cancelar
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: colors.tertiary),
                        ),
                        child: Center(
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              color: colors.tertiary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Botón Crear
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        postNewSaving(
                          titleController.text,
                          double.tryParse(goalAmountController.text) ?? 0,
                          double.tryParse(initialAmountController.text) ?? 0
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: colors.primary),
                          boxShadow: [
                            BoxShadow(
                              color: colors.primary.withValues(alpha: 0.3),
                              blurRadius: 8.0,
                            )
                          ]
                        ),
                        child: Center(
                          child: Text(
                            'CREATE',
                            style: TextStyle(
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
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
    );
  }

  Widget _buildInput({required String label, required IconData icon, required bool isNumber, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.0),
        prefixIcon: Icon(icon, color: const Color(0xFF00E6C0), size: 20.0),
        filled: true,
        fillColor: const Color(0xFF121212).withValues(alpha: 0.5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF00E6C0), width: 1.5),
        ),
      ),
    );
  }
}