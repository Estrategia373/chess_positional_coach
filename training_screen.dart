
import 'package:flutter/material.dart';
import '../core/services/elo_store.dart';
import '../core/scoring/scorer.dart';
import '../l10n/app_localizations.dart';

class TrainingScreen extends StatefulWidget{ final Map position; const TrainingScreen({super.key, required this.position}); @override State<TrainingScreen> createState()=> _TrainingScreenState(); }
class _TrainingScreenState extends State<TrainingScreen>{ final _c1=TextEditingController(); final _c2=TextEditingController(); int? _score; int _delta=0;
  List<_Cell> _parseFen(String fen){ final rows=fen.split(' ')[0].split('/'); const w={'K':'♔','Q':'♕','R':'♖','B':'♗','N':'♘','P':'♙'}; const b={'k':'♚','q':'♛','r':'♜','b':'♝','n':'♞','p':'♟'}; final bd=<_Cell>[]; for(final row in rows){ for(int i=0;i<row.length;i++){ final ch=row[i]; final d=int.tryParse(ch); if(d!=null){ for(int j=0;j<d;j++) bd.add(_Cell('',false)); } else { bd.add(_Cell(w.containsKey(ch)?w[ch]!:b[ch]!, w.containsKey(ch))); } } } return bd; }
  @override void dispose(){ _c1.dispose(); _c2.dispose(); super.dispose(); }
  @override Widget build(BuildContext context){ final t=AppLocalizations.of(context); final p=widget.position; final bd=_parseFen(p['fen']); final prompts=(p['prompts'] as List).cast<String>(); final expected=(p['expected_concepts'] as List).cast<String>(); final coach=(p['style_prompts'] as List).cast<String>();
    return Scaffold(appBar: AppBar(title: Text('${p['id']}')), body: SingleChildScrollView(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      AspectRatio(aspectRatio:1, child: GridView.builder(physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:8), itemCount:64, itemBuilder:(ctx,i){ final r=i~/8,c=i%8; final dark=(r+c)%2==1; final cell=i<bd.length?bd[i]:_Cell('',false); return Container(color: dark?const Color(0xFF769656):const Color(0xFFEEEED2), child: Center(child: Text(cell.char, style: TextStyle(fontSize:24, color: cell.isWhite?Colors.white:Colors.black87)))); })),
      const SizedBox(height:8), Text(t.phase_label(p['phase'])), const SizedBox(height:4), Text(t.style_label((p['style_hint'] as List).join(', '))),
      const SizedBox(height:8), if(coach.isNotEmpty) Card(color: const Color(0xFFeef3ff), child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[ Text(t.coach_tips, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height:6), for(final s in coach.take(3)) Text('• '+s) ]))),
      const SizedBox(height:10), Text(prompts.isNotEmpty?prompts[0]:t.q1_default), const SizedBox(height:6), TextField(controller:_c1, maxLines:3, decoration: const InputDecoration(border: OutlineInputBorder())),
      const SizedBox(height:12), Text(prompts.length>1?prompts[1]:t.q2_default), const SizedBox(height:6), TextField(controller:_c2, maxLines:3, decoration: const InputDecoration(border: OutlineInputBorder())),
      const SizedBox(height:12), if(_score!=null) ...[ Text('Score: $_score  •  ΔELO: ${_delta>=0?'+':''}$_delta'), const SizedBox(height:8) ],
      Row(children:[ FilledButton(onPressed: () async { final text=(_c1.text+' '+_c2.text).toLowerCase(); final s=Scorer.scoreAnswer(text, expected); final d=Scorer.eloDelta(s, expectedDifficulty:(p['difficulty'] as num).toInt()); final newElo=await EloStore.update(d); setState((){_score=s; _delta=d;}); if(context.mounted){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Score '+s.toString()+' • ELO '+newElo.toString()+' (Δ'+(_delta>=0?'+':'')+_delta.toString()+')'))); } }, child: Text(t.evaluate)), const SizedBox(width:12), TextButton(onPressed:(){ setState((){ _c1.clear(); _c2.clear(); _score=null; _delta=0;}); }, child: Text(t.reset)) ])
    ])) ); }
}
class _Cell{ final String char; final bool isWhite; _Cell(this.char,this.isWhite); }
