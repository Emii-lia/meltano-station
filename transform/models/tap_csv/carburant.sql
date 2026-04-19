{{
  config(
    materialized='table'
  )
}}

SELECT row_number() OVER () AS id_carburant, column_name as carburant_type FROM information_schema.columns WHERE table_name = 'antananarivo' AND column_name NOT IN ('Mois', '_sdc_source_file', '_sdc_source_file_mtime', '_sdc_source_lineno', '_sdc_received_at', '_sdc_batched_at', '_sdc_deleted_at', '_sdc_sequence', '_sdc_table_version', '_sdc_sync_started_at', '_sdc_extracted_at')
