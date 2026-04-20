{{
  config(
    materialized='table'
  )
}}


with antananarivo as (
  select * from tap_csv.antananarivo
)

SELECT row_number() OVER () AS id_date, EXTRACT(MONTH FROM to_date("Mois", 'DD/MM/YY')) AS mois, EXTRACT(YEAR FROM to_date("Mois", 'DD/MM/YY')) AS annee FROM antananarivo
