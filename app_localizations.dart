
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.localeName);
  final String localeName;
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  static const List<Locale> supportedLocales = [Locale('es'), Locale('en')];

  String get appTitle => localeName.startsWith('en')? 'Chess Positional Coach':'Entrenador Posicional de Ajedrez';
  String get phase_all => localeName.startsWith('en')? 'All':'Todas';
  String get phase_opening => localeName.startsWith('en')? 'Opening':'Apertura';
  String get phase_middlegame => localeName.startsWith('en')? 'Middlegame':'Medio juego';
  String get phase_endgame => localeName.startsWith('en')? 'Endgame':'Final';
  String get btn_train => localeName.startsWith('en')? 'Train':'Entrenar';
  String elo_label(int elo)=> 'ELO: '+elo.toString();
  String get coach_tips => localeName.startsWith('en')? 'Coach tips':'Pistas del entrenador';
  String phase_label(String phase)=> (localeName.startsWith('en')? 'Phase: ':'Fase: ')+phase;
  String style_label(String style)=> (localeName.startsWith('en')? 'Style: ':'Estilo: ')+style;
  String get q1_default => localeName.startsWith('en')? 'Describe your plan in 2–3 moves':'Describe tu plan en 2–3 jugadas';
  String get q2_default => localeName.startsWith('en')? "What is the opponent's plan and how do you neutralize it?":"¿Cuál es el plan del rival y cómo lo neutralizas?";
  String get evaluate => localeName.startsWith('en')? 'Evaluate & update ELO':'Evaluar y actualizar ELO';
  String get reset => 'Reset';
  String get settings => localeName.startsWith('en')? 'Settings':'Ajustes';
  String get language => localeName.startsWith('en')? 'Language':'Idioma';
  String get lang_es => localeName.startsWith('en')? 'Spanish':'Español';
  String get lang_en => localeName.startsWith('en')? 'English':'Inglés';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override bool isSupported(Locale locale)=> ['en','es'].contains(locale.languageCode);
  @override Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale.languageCode);
  @override bool shouldReload(_AppLocalizationsDelegate old)=> false;
}
