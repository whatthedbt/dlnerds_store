{{
    config(
        materialized="incremental",
        incremental_strategy="delete+insert",
        unique_key="id",
    )
}}
with
    cte_read_sales as (
        select
            customer_id,
            product_id,
            sales_date,
            quantity,
            total_amount,
            currency,
            created_at,
            updated_at
        from {{ source("file_system", "sales_raw") }}
        where quantity is not null and total_amount is not null
    ),

    cte_cast_sales as (
        select
            customer_id,
            product_id,
            cast(sales_date as date) as sales_date,
            quantity,
            cast(total_amount as float) as total_amount,
            currency,
            cast(created_at as timestamp) as created_at,
            cast(updated_at as timestamp) as updated_at
        from cte_read_sales

    ),

    cte_calculate_sales as (
        select
            {{
                dbt_utils.generate_surrogate_key(
                    ["customer_id", "product_id", "sales_date"]
                )
            }} as id,
            customer_id,
            product_id,
            sales_date,
            quantity,
            total_amount,
            currency,
            created_at,
            updated_at
        from cte_cast_sales
    )

select *
from cte_calculate_sales
{% if is_incremental() %}
    where updated_at > (select max(updated_at) from {{ this }})
{% endif %}
