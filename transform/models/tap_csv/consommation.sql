{{
  config(
    materialized='table'
  )
}}

with provinces as (
  select "Mois","GAZ(T)","EA","JET","SC","NAPHTA","PL","GO","FO", 'antananarivo' as province from tap_csv.antananarivo
  union all
  select "Mois","GAZ(T)","EA","JET","SC","NAPHTA","PL","GO","FO", 'antsiranana' from tap_csv.antsiranana
  union all
  select "Mois","GAZ(T)","EA","JET","SC","NAPHTA","PL","GO","FO", 'toamasina' from tap_csv.toamasina
  union all
  select "Mois","GAZ(T)","EA","JET","SC","NAPHTA","PL","GO","FO", 'majunga' from tap_csv.majunga
  union all
  select "Mois","GAZ(T)","EA","JET","SC","NAPHTA","PL","GO","FO", 'toliara' from tap_csv.toliara
  union all
  select "Mois","GAZ(T)","EA","JET","SC","NAPHTA","PL","GO","FO", 'fianarantsoa' from tap_csv.fianarantsoa
),

unpivoted as (
  select
    "Mois",
    province,
    'GAZ(T)' as carburant,
    CAST("GAZ(T)" AS NUMERIC) as quantite
  from provinces

  union all
  select "Mois", province, 'EA', CAST("EA" AS NUMERIC) from provinces
  union all
  select "Mois", province, 'JET', CAST("JET" AS NUMERIC) from provinces
  union all
  select "Mois", province, 'SC', CAST("SC" AS NUMERIC) from provinces
  union all
  select "Mois", province, 'NAPHTA', CAST("NAPHTA" AS NUMERIC) from provinces
  union all
  select "Mois", province, 'PL', CAST("PL" AS NUMERIC) from provinces
  union all
  select "Mois", province, 'GO', CAST("GO" AS NUMERIC) from provinces
  union all
  select "Mois", province, 'FO', CAST("FO" AS NUMERIC) from provinces
),
dates_parsed as (
  select
    *,
    trim(to_char(to_date("Mois", 'DD/MM/YY'), 'Month')) as mois,
    extract(year from to_date("Mois", 'DD/MM/YY')) as annee
  from unpivoted
),
final as (
  select distinct
    row_number() over () as id_consommation,
    d.id_date,
    p.id_province,
    c.id_carburant,
    dp.quantite
  from dates_parsed dp
  join {{ ref('date') }} d
    on d.mois = dp.mois
   and d.annee = dp.annee
  join {{ ref('province') }} p
    on p.nom = dp.province
  join {{ ref('carburant') }} c
    on c.carburant_type = dp.carburant
  order by id_consommation, id_province, id_date, id_carburant
)

select * from final
