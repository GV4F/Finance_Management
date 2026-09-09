import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModalTransaction extends StatefulWidget {
  final String type;
  final Future<void> Function() getBalance;
  const ModalTransaction({
    super.key,
    required this.type,
    required this.getBalance
  });

  @override
  State<ModalTransaction> createState() => _ModalTransactionState();
}

class _ModalTransactionState extends State<ModalTransaction> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  List<dynamic> allSavings = [];
  String? selectedSavingId;

  @override
  void initState() {
    super.initState();
    fetchAllSavings();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> registerTransaction({
    required String title,
    required String description,
    required double amount,
  }) async {
    final supabase = Supabase.instance.client; 
    try {
      await supabase.from('transaction').insert({
        'title': title,
        'description': description,
        'amount': amount,
        'category': widget.type,
      });
      await supabase.rpc(
        'update_balance',
        params: {
          'increase': amount,
          'p_user_id': supabase.auth.currentUser!.id,
          'operation': widget.type == 'income' ? true : false,
        }
      );
      await widget.getBalance();
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction registered successfully!')),
        );
        Navigator.of(context).pop();
      }
    } catch (error) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    }
  }

  Future<void> registerSavingTransaction({
    required String title,
    required String description,
    required double amount,
    required String savingId,
  }) async {
    final supabase = Supabase.instance.client; 
    final title = allSavings.firstWhere((s) => s['id'] == savingId)['title'] as String;
    try {
      await supabase.from('transaction').insert({
        'title': title,
        'description': description,
        'amount': amount,
        'category': widget.type,
      });

      await supabase.rpc(
        'update_value',
        params: {
          'row_id': savingId,
          'increase': amount,
        }
      );
      await supabase.rpc(
        'update_balance',
        params: {
          'p_user_id': supabase.auth.currentUser!.id,
          'increase': amount,
          'operation': false,
        }
      );
      await widget.getBalance();
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction registered successfully!')),
        );
        Navigator.of(context).pop();
      }
    } catch (error) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    }
  }

  Future<void> fetchAllSavings() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    try {
      final response = await supabase.from('savings').select().eq('id_user', user!.id);
      setState(() {
        allSavings = response;
      });
    } catch (error) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF141414),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.type == 'income' ? 
              'Income' :
              widget.type == 'expense' ?
              'Expense':
              'Saving',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),

            const SizedBox(height: 20),

            if(widget.type == "saving") ...
            [
              DropdownButton<String>(
                hint: const Text('Select a saving'),
                value: selectedSavingId,
                dropdownColor: const Color(0xFF1E1E1E), 
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                isExpanded: true,
                items: allSavings.map((savings) {
                  return DropdownMenuItem<String>(
                    value: savings['id'] as String,
                    child: Text(savings['title'] as String),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSavingId = newValue;
                  });
                },
              ),
            ] else ... [
              _buildInput(label: 'Title', icon: Icons.tag, isNumber: false, controller: titleController)
            ],

            const SizedBox(height: 20),
            _buildInput(label: 'Description', icon: Icons.description, isNumber: false, controller: descriptionController),

            const SizedBox(height: 20),
            _buildInput(label: 'Amount', icon: Icons.attach_money, isNumber: true, controller: amountController),

            const SizedBox(height: 20),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  if(widget.type == "saving") {
                    if(selectedSavingId != null) {
                      registerSavingTransaction(
                        title: titleController.text,
                        description: descriptionController.text,
                        amount: double.parse(amountController.text),
                        savingId: selectedSavingId!,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a saving.')),
                      );
                    }
                  } else {
                    registerTransaction(
                      title: titleController.text,
                      description: descriptionController.text,
                      amount: double.parse(amountController.text),
                    );
                  }
                },
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colors.primary,
                        colors.secondary,
                      ],
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
                  alignment: Alignment.center,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: colors.onPrimary,
                      fontFamily: 'Bruce Ace',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final Map<String, String> frequencies = const {
    'Weekly': 'weekly',
    'Monthly': 'monthly',
    'Yearly': 'yearly',
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
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedPaymentDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && mounted) {
      setState(() {
        selectedPaymentDate = selectedDate;
      });
    }
  }

  Future<void> registerUpcomingPayment() async {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text.trim().replaceAll(',', '.'));

    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        selectedPaymentDate == null ||
        selectedFrequency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields with valid information.'),
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be signed in to add a payment.')),
        );
      }
      return;
    }

    try {
      await supabase.from('upcoming_pays').insert({
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
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final paymentDateText = selectedPaymentDate == null
        ? 'Select payment date'
        : '${selectedPaymentDate!.day.toString().padLeft(2, '0')}/'
            '${selectedPaymentDate!.month.toString().padLeft(2, '0')}/'
            '${selectedPaymentDate!.year}';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
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
        padding: const EdgeInsets.all(20),
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
              _buildInput(
                label: 'Title',
                icon: Icons.tag,
                isNumber: false,
                controller: titleController,
              ),
              const SizedBox(height: 20),
              _buildInput(
                label: 'Amount',
                icon: Icons.attach_money,
                isNumber: true,
                controller: amountController,
              ),
              const SizedBox(height: 20),
              _buildSelection(
                label: paymentDateText,
                icon: Icons.calendar_month,
                onTap: selectPaymentDate,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedFrequency,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E1E1E),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: _inputDecoration(
                  label: 'Payment frequency',
                  icon: Icons.repeat,
                ),
                items: frequencies.entries.map((frequency) {
                  return DropdownMenuItem<String>(
                    value: frequency.value,
                    child: Text(frequency.key),
                  );
                }).toList(),
                onChanged: (frequency) {
                  setState(() {
                    selectedFrequency = frequency;
                  });
                },
              ),
              const SizedBox(height: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: isSaving ? null : registerUpcomingPayment,
                  child: Container(
                    width: 280,
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
                    alignment: Alignment.center,
                    child: isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
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

  Widget _buildSelection({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: _inputDecoration(label: 'Payment date', icon: icon),
        child: Text(
          label,
          style: TextStyle(
            color: selectedPaymentDate == null ? Colors.grey.shade400 : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
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
