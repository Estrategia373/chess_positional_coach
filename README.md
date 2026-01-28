
# Chess Positional Coach — FULL v6 (ES/EN)

Proyecto listo para GitHub + Codemagic con:
- i18n ES/EN (stub), tablero tipo Lichess (FEN), 2 preguntas, pistas, scoring, ΔELO
- Dataset sintético de 2.000 posiciones (500/1000/500)
- pubspec.yaml con intl ^0.20.2
- codemagic.yaml sin instance_type, crea /android y ejecuta un sanity check que parchea cualquier uso residual de '.fromSeed(' → 'ColorScheme.fromSeed('

## Pasos
1. Sube el CONTENIDO de este ZIP a un repo de GitHub.
2. En Codemagic, conecta el repo, crea el grupo `keystore_credentials` y sube tu .jks.
3. Lanza el workflow "Android Release AAB (auto-add android, sanity checked)".
4. Descarga el .aab en Artifacts.
