-- models/staging/stg_items.sql
-- 注文アイテムのステージングモデル

select
    id as item_id,
    order_id,
    sku as product_sku
from {{ source('jaffle_shop_raw', 'items') }}
