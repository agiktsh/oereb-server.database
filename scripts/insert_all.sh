#!/bin/bash
set -Eeuo pipefail

ili2pg_executable=$(find /tmp/ili2pg -iname 'ili2pg*.jar')
# files=$(find . -type f -name "*.xtf")
files=(
"ch.Gewaesserraum-Gewaesserraum_V1_1-ch.SH.Gewaesserraum.xtf" \
"ch.Laermempfindlichkeitsstufen-Laermempfindlichkeitsstufen_V1_2-ch.2911.Laermempfindlichkeitsstufen.xtf" \
"ch.Laermempfindlichkeitsstufen-Laermempfindlichkeitsstufen_V1_2-ch.2951.Laermempfindlichkeitsstufen.xtf" \
"ch.Nutzungsplanung-Nutzungsplanung_V1_2-ch.2920.Nutzungsplanung.xtf" \
"ch.Nutzungsplanung-Nutzungsplanung_V1_2-ch.2939.Nutzungsplanung.xtf" \
"ch.Planungszonen-Planungszonen_V1_1-ch.SH.Planungszonen.xtf" \
)

echo "${files[*]}"
for file in ${files[*]}; do
  java -jar "$ili2pg_executable" \
    --import \
    --replace \
    --dbdatabase "$POSTGRES_DB" \
    --dbusr gretl \
    --dbport 54321 \
    --dbhost localhost \
    --dbpwd "$PG_GRETL_PWD" \
    --dbschema "$SCHEMA" \
    --dataset "$(basename "$file" .xtf)" \
    --disableValidation \
    --models "OeREBKRMtrsfr_V2_0" \
    --verbose \
    --modeldir http://models.interlis.ch/ \
    "$file"
done