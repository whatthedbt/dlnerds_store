{# This is Jinja Model variable example and implementation 
   This is local variable and can be referenced anywhere within the same model
#}
{% set code = ['US', 'DE'] %}
with cte_read_customer as (
    select id, name, gender, dateofbirth as date_of_birth, email, country, city, created_at, updated_at from 
    {{ source('file_system', 'customer_raw') }}
),

cte_cast_customer as(
    select id, name, gender,try_to_date(date_of_birth, 'DD.MM.YY') as date_of_birth, email,country as country_code, city, 
    created_at, updated_at from cte_read_customer
),

cte_clean_customer as(
    select id, name, gender, date_of_birth, email,
    case when country_code is not null and country_code != '' then country_code
    when city = 'Las Vegas' then '{{ code[0] }}'
    when city = 'New York' then '{{ code[0] }}'
    when city = 'Stuttgart' then 'DE'
    else null
    end as country_code, 
    city, created_at, updated_at from cte_cast_customer

)

select * from cte_clean_customer

