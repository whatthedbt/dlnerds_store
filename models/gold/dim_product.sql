{% set tier=[
    {'name': 'low', 'min': 0, 'max': 29.99},
    {'name': 'mediaum', 'min': 30, 'max': 59.99},
    {'name': 'high', 'min': 60, 'max': 199.99}
] %}
with cte_read_product as(
    select id, name, code, category, price, currency, color, created_at, updated_at
    from {{ ref('product_cleaned') }}
),

cte_transform_product as(
    select id, name, code, category, price, currency, 
    case
    when price between {{ tier[0].min}} and {{ tier[0].max}} then '{{ tier[0].name }}'
    when price between {{ tier[1].min}} and {{ tier[1].max }} then '{{ tier[1].name }}'
    when price between {{ tier[2].min }} and {{ tier[2].max}} then '{{ tier[2].name }}'
    else null
    end as tier, 
    color, created_at, updated_at from cte_read_product
)

select * from cte_transform_product