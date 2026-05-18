with cte_read_product as(
    select id, name, code, category, price, currency, color, created_at, updated_at
    from {{ source('file_system', 'product_raw') }}
),

cte_cast_product as(
    select id, name, code, category, cast(price as float) as price, currency, color, 
    cast(created_at as timestamp) as created_at, cast(updated_at as timestamp) as updated_at
    from cte_read_product
),

cte_clean_product as(
    select id, replace(name, '_', '') as name, code, category, price, currency, lower(color) as color, created_at,
    updated_at from cte_cast_product
)

select * from cte_clean_product