{{
  config(
    materialized='table'
  )
}}


with antananarivo as (
  select * from tap_csv.antananarivo
)

SELECT 
  row_number() OVER () AS id_date, 
  trim(TO_CHAR(to_date("Mois", 'DD/MM/YY'), 'Month')) AS mois, 
  EXTRACT(MONTH FROM to_date("Mois", 'DD/MM/YY')) AS num_mois,
  EXTRACT(YEAR FROM to_date("Mois", 'DD/MM/YY')) AS annee 
FROM antananarivo
