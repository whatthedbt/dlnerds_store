with cte_read_customer as (
    select id, name, gender, date_of_birth, email, country_code, city, created_at, updated_at
    from {{ ref('customer_cleaned') }}
),

cte_read_country as (
    select country_code, country_name 
    from {{ ref('country_cleaned') }}
),

cte_transform_customer as(
    -- Applying macro called split_name
    select id, {{ split_name('name', 1)}} as first_name,
   {{ split_name('name', 2 )}} as last_name,
    gender, 
    date_of_birth, email, country_code, city, created_at, updated_at
    from cte_read_customer
),

cte_join_customer_country as (
    select 
    c.id,
    c.first_name,
    c.last_name,
    c.gender,
    c.date_of_birth,
    c.email,
    c.country_code,
    ct.country_name,
    c.city,
    c.created_at,c.updated_at 
    from cte_transform_customer as c
    left join cte_read_country as ct
    on c.country_code = ct.country_code
)

select * from cte_join_customer_country