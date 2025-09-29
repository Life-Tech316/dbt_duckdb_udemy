{{
    config(
        materialized='table'
        )
}}

select
    store_id,
    {% for product_type in ['jaffle', 'beverage'] %}
    count(distinct case when p.category = '{{ product_type }}' then i.sku end) as {{ product_type }}_product_count
    {% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('stg_orders') }} o
join {{ ref('stg_items') }} i on o.order_id = i.order_id
join {{ ref('stg_products') }} p on i.product_sku = p.product_sku
group by store_id
