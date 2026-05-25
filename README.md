# Snowflake dbt S3 project 💾💻👩‍💻

- Adding bronze model to dbt_project.yml file
```yaml
models:   dlnerds_store:
  bronze:
    +enabled: true
    +materialized: table
    +schema: 01_bronze
    +tags: ['bronze']
    +docs:
      node_color: '#CD7F32'
```

- Adding a macro called generate_schema_name to avoid dbt's prefix
```sql
{% macro generate_schema_name(custom_schema_name, node) %}
{{ custom_schema_name or target.schema }} {% endmacro %}
```

- add the schema location for seed and then execute the 'dbt seed' command
```yaml
seeds:
  dlnerds_store:
    +schema: 01_bronze
```

- Adding freshness to sources.yml file 
> Source freshness in dbt tracks how up-to-date your raw source data is. It measures freshness based on a timestamp column (such as created_at or updated_at) in your source tables. When enabled, dbt queries the most recent timestamp in this column and compares it to the current time, checking how “old” the latest record is. You define acceptable limits using the warn_after and error_after thresholds.
> to check the freshness, run the 'dbt source freshness' command
```yaml
config:
  loaded_at_field: updated_at
  freshness:
   warn_after: {count: 12, period: hour}
   error_after: {count: 999, period: day}
```

- Adding silver model to the dbt_project.yml file
```yaml
models: dlnerds_store:
  silver:
    +enabled: true
    +materialized: table
    +schema: 02_silver
    +tags: ['silver']
    +docs:
      node_color: 'silver'
```

