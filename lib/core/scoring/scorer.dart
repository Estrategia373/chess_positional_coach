
class Scorer {
  static int scoreAnswer(String answer, List<String> expectedConcepts) {
    if(expectedConcepts.isEmpty) return 50;
    int hits=0; for(final c in expectedConcepts){ final toks=c.toLowerCase().split(RegExp(r'[\s,_]+')); final ok=toks.any((t)=> t.length>=4 && answer.toLowerCase().contains(t)); if(ok) hits++; }
    int score=((hits/expectedConcepts.length)*85).round();
    if(answer.length>300) score+=10; if(answer.length>600) score+=5; if(score>100) score=100; return score; }
  static int eloDelta(int score,{required int expectedDifficulty}){ const target=65; const k=18; final diff=(score-target)/100.0; int d=(k*diff).round(); if(d==0 && score>=target) d=1; return d; }
}
