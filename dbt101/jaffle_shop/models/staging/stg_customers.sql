-- models/staging/stg_customers.sql
-- 顧客データのステージングモデル

select
  id   as customer_id,
  name as customer_name
from {{ source('jaffle_shop_raw', 'customers') }}
