
import 'package:flutter/material.dart';
import 'package:chess_positional_coach/core/services/locale_store.dart';
import 'package:chess_positional_coach/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget{
  final LocaleStore store; const SettingsScreen({super.key, required this.store});
  @override Widget build(BuildContext context){ final t=AppLocalizations.of(context); return Scaffold(
    appBar: AppBar(title: Text(t.settings)),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      Text(t.language, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height:12),
      RadioListTile(value:'es', groupValue: store.locale?.languageCode ?? 'es', onChanged:(_)=> store.setLocale(const Locale('es')), title: Text(t.lang_es)),
      RadioListTile(value:'en', groupValue: store.locale?.languageCode ?? 'es', onChanged:(_)=> store.setLocale(const Locale('en')), title: Text(t.lang_en)),
    ])),
  ); }
}
