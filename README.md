# Meltano Station

A Meltano project with a built-in dashboard and GUI using Metabase.

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Meltano (installed via `uv tool install meltano`)

### Running the Project

To start the pipeline, database, and the dashboard, run:

```bash
docker compose up -d
```

### Accessing the GUI/Dashboard

The Metabase GUI is available at:
- **URL:** [http://localhost:3000](http://localhost:3000)

### Configuration for Metabase

When you first open Metabase, follow the setup wizard. To connect to your data:
1. **Database Type:** PostgreSQL
2. **Host:** `postgres`
3. **Port:** `5432`
4. **Database Name:** `meltano_station`
5. **Username:** `meltano`
6. **Password:** (Check your `.env` file, default is `password`)
7. **Schema:** `analytics` (where your dbt models are located)

### Processing Data via GUI
While the ELT pipeline runs automatically on startup, you can interact with and "process" the data through the Metabase GUI:

1. **Visualize Results:** Once the pipeline finishes, your transformed data is available in the `analytics` schema. You can build dashboards to analyze the fuel consumption across provinces.
2. **Ad-hoc Queries:** Use the **Native Query** editor in Metabase to run custom SQL on your transformed models (e.g., `SELECT * FROM analytics.consommation`).
3. **Manual Re-run:** If you need to re-trigger the ELT process manually, you can restart the `pipeline` container:
   ```bash
   docker compose restart pipeline
   ```
## Project Structure

- `meltano.yml`: Project configuration and plugin definitions.
- `compose.yml`: Docker services (Postgres, Metabase, Pipeline).
- `data/`: Source CSV files.
- `transform/`: dbt models for data transformation.
