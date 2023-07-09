#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mlrgo --t2c filter '$featurecode=="ADM3"' then put '$citta=$name;$citta=sub($citta,"Reggio di Cal.+","Reggio Calabria");$citta=sub($citta,".+Boze.+","Bolzano")'  "$folder"/2023-07-09_geonames_IT.txt >"$folder"/2023-07-09_geonames_IT_ADM3.csv

csvmatch "$folder"/ondate-calore_comuni.csv "$folder"/2023-07-09_geonames_IT_ADM3.csv --fields1 citta --fields2 citta -i -a --join left-outer --output 1.citta 2.name 2.geonameid 2.latitude 2.longitude 2.admin3code >"$folder"/../data/citta-anagrafica.csv
