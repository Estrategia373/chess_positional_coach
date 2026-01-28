
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:chess_positional_coach/l10n/app_localizations.dart';
import 'package:chess_positional_coach/core/services/elo_store.dart';
import 'package:chess_positional_coach/core/services/locale_store.dart';
import 'package:chess_positional_coach/ui/training_screen.dart';
import 'package:chess_positional_coach/ui/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EloStore.init();
  final store = LocaleStore();
  await store.load();
  runApp(AppRoot(store: store));
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key, required this.store});
  final LocaleStore store;

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  List<dynamic>? _positions;
  String _phase = 'todas';

  Future<void> _load() async {
    final data = await rootBundle.loadString('assets/positions/pack_2000.json');
    setState(() => _positions = json.decode(data) as List<dynamic>);
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.store,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
          locale: widget.store.locale,
          supportedLocales: const [Locale('es'), Locale('en')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Builder(
            builder: (ctx) {
              final t = AppLocalizations.of(ctx);
              return Scaffold(
                appBar: AppBar(
                  title: Text(t.appTitle),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () => Navigator.push(
                        ctx,
                        MaterialPageRoute(
                          builder: (_) => SettingsScreen(store: widget.store),
                        ),
                      ),
                    )
                  ],
                ),
                body: _positions == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                FilterChip(
                                  label: Text(t.phase_opening),
                                  selected: _phase == 'opening',
                                  onSelected: (_) => setState(() => _phase = 'opening'),
                                ),
                                const SizedBox(width: 8),
                                FilterChip(
                                  label: Text(t.phase_middlegame),
                                  selected: _phase == 'middlegame',
                                  onSelected: (_) => setState(() => _phase = 'middlegame'),
                                ),
                                const SizedBox(width: 8),
                                FilterChip(
                                  label: Text(t.phase_endgame),
                                  selected: _phase == 'endgame',
                                  onSelected: (_) => setState(() => _phase = 'endgame'),
                                ),
                                const SizedBox(width: 8),
                                FilterChip(
                                  label: Text(t.phase_all),
                                  selected: _phase == 'todas',
                                  onSelected: (_) => setState(() => _phase = 'todas'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(child: Text(t.elo_label(EloStore.elo))),
                                FilledButton(onPressed: () {}, child: Text(t.btn_train)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView(
                              children: (_phase == 'todas'
                                      ? _positions!
                                      : _positions!
                                          .where((p) => p['phase'] == _phase)
                                          .toList())
                                  .take(30)
                                  .map<Widget>((p) {
                                return Card(
                                  child: ListTile(
                                    title: Text('${p['id']} — ${p['phase']} (dif ${p['difficulty']})'),
                                    subtitle: Text('Estilo: ${(p['style_hint'] as List).join(', ')}'),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TrainingScreen(position: p),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
