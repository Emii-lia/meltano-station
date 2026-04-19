{{
  config(
    materialized='table'
  )
}}


with provinces as (
  select tablename as nom from pg_catalog.pg_tables where schemaname='tap_csv'
)

select row_number() OVER () AS id_province, * from provinces
