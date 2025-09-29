-- models/marts/core/fact_orders.sql
-- 注文ファクトテーブル

with orders as (
    select * from {{ ref('stg_orders') }}
),

-- paymentsテーブルは今回のデータには含まれていないため、
-- ordersテーブルの金額情報を使用

order_items_agg as (
    select
        order_id,
        count(distinct product_sku) as product_count,
        count(*) as item_count
    from {{ ref('stg_items') }}
    group by order_id
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.ordered_at,
        orders.store_id,
        orders.subtotal_dollars,
        orders.tax_paid_dollars,
        orders.order_total_dollars,
        coalesce(order_items_agg.product_count, 0) as product_count,
        coalesce(order_items_agg.item_count, 0) as item_count
    from orders
    left join order_items_agg using (order_id)
)

select * from final