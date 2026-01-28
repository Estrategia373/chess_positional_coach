
# Chess Positional Coach — FULL v7 (ES/EN)

Proyecto listo para **GitHub + Codemagic** con:
- i18n ES/EN (stub), tablero tipo Lichess (FEN), 2 preguntas, pistas, scoring, ΔELO
- Dataset sintético de **2.000** posiciones (500/1000/500)
- `pubspec.yaml` con `intl: ^0.20.2`
- `codemagic.yaml` sin `instance_type` y con paso para **crear /android** + **sanity check**
- **IMPORTANTE**: Los imports en `lib/` usan **rutas relativas** (no `package:`), así no dependen del `name:` al compilar.

## Pasos
1. Sube el **contenido** de este ZIP a tu repo de GitHub.
2. En Codemagic, conecta el repo.
3. Crea el **group** `keystore_credentials` y sube tu `.jks` (alias + contraseñas).
4. Ejecuta el workflow **Android Release AAB (auto-add android, sanity checked)**.
5. Descarga el `.aab` en **Artifacts**.
