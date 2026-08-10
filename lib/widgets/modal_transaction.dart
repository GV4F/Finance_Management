import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModalTransaction extends StatefulWidget {
  final String type;
  const ModalTransaction({
    super.key,
    required this.type
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