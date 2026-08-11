import 'package:flutter/material.dart';
import './options_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OptionsSection extends StatefulWidget {
  const OptionsSection({super.key});

  @override
  State<OptionsSection> createState() => _OptionsSectionState();
}

class _OptionsSectionState extends State<OptionsSection> {
  Future<void> cleanHistorialTransaction() async{
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser?.id;
      await supabase.from('transaction').delete().eq('id_user', user!);

      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Clean successfully', style: TextStyle(fontFamily: 'Bruce Ace')),
            backgroundColor: Color(0xFF00E5FF),
          )
        );
      }
    } catch(e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Clean failed', style: TextStyle(fontFamily: 'Bruce Ace')),
            backgroundColor: Color(0xFFFF1744),
          )
        );
      }
    }

  }

  Future<void> changeViewProfile() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser?.id;

      final data = await supabase.from('users').select('view').eq('id', user!).single();
      final bool view = data['view'] ?? true;

      await supabase.from('users').update({'view': !view}).eq('id', user);

      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Update successfully', style: TextStyle(fontFamily: 'Bruce Ace')),
            backgroundColor: Color(0xFF00E5FF),
          )
        );
      }

    } catch(e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Change view failed', style: TextStyle(fontFamily: 'Bruce Ace')),
            backgroundColor: Color(0xFFFF1744),
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(), 
        itemCount: 2, 
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return OptionsCard(
              title: 'Clean Historial',
              icon: Icons.cleaning_services_outlined,
              onTap: () {
                cleanHistorialTransaction();
              },
            );
          } else {
            return OptionsCard(
              title: 'Change default visibility',
              icon: Icons.remove_red_eye_outlined,
              onTap: () {
                changeViewProfile();
              },
            );
          }
        },
      )
    );
  }
}
