{{
  config(
    materialized='table'
  )
}}

with provinces as (
  select "Mois","GAZ(T)","EA","JET","NAPHTA","PL","GO","FO", 'antananarivo' as province from tap_csv.antananarivo
  union all
  select "Mois","GAZ(T)","EA","JET","NAPHTA","PL","GO","FO", 'antsiranana' from tap_csv.antsiranana
  union all
  select "Mois","GAZ(T)","EA","JET","NAPHTA","PL","GO","FO", 'toamasina' from tap_csv.toamasina
  union all
  select "Mois","GAZ(T)","EA","JET","NAPHTA","PL","GO","FO", 'majunga' from tap_csv.majunga
  union all
  select "Mois","GAZ(T)","EA","JET","NAPHTA","PL","GO","FO", 'toliara' from tap_csv.toliara
  union all
  select "Mois","GAZ(T)","EA","JET","NAPHTA","PL","GO","FO", 'fianarantsoa' from tap_csv.fianarantsoa
),

unpivoted as (
  select
    "Mois",
    province,
    'GAZ(T)' as carburant,
    "GAZ(T)" as quantite
  from provinces

  union all
  select "Mois", province, 'EA', "EA" from provinces
  union all
  select "Mois", province, 'JET', "JET" from provinces
  union all
  select "Mois", province, 'NAPHTA', "NAPHTA" from provinces
  union all
  select "Mois", province, 'PL', "PL" from provinces
  union all
  select "Mois", province, 'GO', "GO" from provinces
  union all
  select "Mois", province, 'FO', "FO" from provinces
),
dates_parsed as (
  select
    *,
    extract(month from to_date("Mois", 'DD/MM/YY')) as month,
    extract(year from to_date("Mois", 'DD/MM/YY')) as year
  from unpivoted
),
final as (
  select
    row_number() over () as id_consomation,
    d.id_date,
    p.id_province,
    c.id_carburant,
    dp.quantite
  from dates_parsed dp
  join analytics.date d
    on d.month = dp.month
   and d.year = dp.year
  join analytics.province p
    on p.nom = dp.province
  join analytics.carburant c
    on c.carburant_type = dp.carburant
)

select * from final
