{{
  config(
    materialized='table'
  )
}}


with provinces as (
  select tablename as province from pg_catalog.pg_tables where schemaname='tap_csv'
)

select * from pronvices
