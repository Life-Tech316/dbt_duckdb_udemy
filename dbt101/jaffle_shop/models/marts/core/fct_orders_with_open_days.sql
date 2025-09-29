-- 複数のカラムに基づく一意性テスト
{{ dbt_utils.test_unique_combination_of_columns(
    model=ref('stg_orders'),
    combination_of_columns=['customer_id', 'ordered_at']
) }}

-- 日付の差分を計算（店舗開店からの経過日数）
select
    o.order_id,
    o.store_id,
    datediff(o.ordered_at, s.opened_at) as days_since_open
from {{ ref('stg_orders') }} o
join {{ ref('stg_stores') }} s on o.store_id = s.store_id
