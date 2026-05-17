with cte_read_product as(
    select id, name, code, category, price, currency, color, created_at, updated_at
    from {{ ref('product_cleaned') }}
),

cte_transform_product as(
    select id, name, code, category, price, currency, 
    case
    when price between 0 and 29.99 then 'Low'
    when price between 30 and 59.99 then 'Medium'
    when price between 60 and 199.99 then 'High'
    else null
    end as tier, 
    color, created_at, updated_at from cte_read_product
)

select * from cte_transform_product