import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModalUpcomingPayment extends StatefulWidget {
  final Future<void> Function() getAllPayments;

  const ModalUpcomingPayment({
    super.key,
    required this.getAllPayments,
  });

  @override
  State<ModalUpcomingPayment> createState() => _ModalUpcomingPaymentState();
}

class _ModalUpcomingPaymentState extends State<ModalUpcomingPayment> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final frequencies = const {
    'Weekly': '1 week',
    'Monthly': '1 month',
    'Yearly': '1 year',
  };

  DateTime? selectedPaymentDate;
  String? selectedFrequency;
  bool isSaving = false;

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> selectPaymentDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedPaymentDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null && mounted) {
      setState(() => selectedPaymentDate = date);
    }
  }

  Future<void> registerUpcomingPayment() async {
    final title = titleController.text.trim();
    final amount = double.tryParse(
      amountController.text.trim().replaceAll(',', '.'),
    );
    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        selectedPaymentDate == null ||
        selectedFrequency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields with valid information.')),
      );
      return;
    }

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to add a payment.')),
      );
      return;
    }

    setState(() => isSaving = true);
    try {
      await Supabase.instance.client.from('upcoming_pays').insert({
        'title': title,
        'amount': amount,
        'payment_date': selectedPaymentDate!.toIso8601String().split('T').first,
        'frequency': selectedFrequency,
        'id_user': user.id,
      });
      await widget.getAllPayments();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upcoming payment registered successfully!')),
        );
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final dateLabel = selectedPaymentDate == null
        ? 'Select payment date'
        : '${selectedPaymentDate!.day.toString().padLeft(2, '0')}/'
            '${selectedPaymentDate!.month.toString().padLeft(2, '0')}/'
            '${selectedPaymentDate!.year}';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Upcoming Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              _buildInput('Title', Icons.tag, titleController),
              const SizedBox(height: 20),
              _buildInput('Amount', Icons.attach_money, amountController, isNumber: true),
              const SizedBox(height: 20),
              InkWell(
                onTap: selectPaymentDate,
                borderRadius: BorderRadius.circular(12),
                child: InputDecorator(
                  decoration: _inputDecoration('Payment date', Icons.calendar_month),
                  child: Text(
                    dateLabel,
                    style: TextStyle(
                      color: selectedPaymentDate == null ? Colors.grey.shade400 : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: selectedFrequency,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E1E1E),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: _inputDecoration('Payment frequency', Icons.repeat),
                items: frequencies.entries
                    .map((frequency) => DropdownMenuItem(
                          value: frequency.value,
                          child: Text(frequency.key),
                        ))
                    .toList(),
                onChanged: (frequency) => setState(() => selectedFrequency = frequency),
              ),
              const SizedBox(height: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: isSaving ? null : registerUpcomingPayment,
                  child: Container(
                    width: 280,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colors.primary, colors.secondary],
                        begin: Alignment.bottomCenter,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: colors.onPrimary,
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Register',
                            style: TextStyle(
                              color: colors.onPrimary,
                              fontFamily: 'BrunoAce',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: _inputDecoration(label, icon),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIcon: Icon(icon, color: const Color(0xFF00E6C0), size: 20),
      filled: true,
      fillColor: const Color(0xFF121212).withValues(alpha: 0.5),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF00E6C0), width: 1.5),
      ),
    );
  }
}