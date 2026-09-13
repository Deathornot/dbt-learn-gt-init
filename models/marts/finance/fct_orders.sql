with orders as (

    SELECT * FROM {{ ref('stg__jaffle_shop__orders')}}

),

payments as (

    SELECT * FROM {{ ref('stg__stripe__payments')}}

),

order_payments as (

    SELECT
        order_id,
        sum(CASE WHEN status = 'success' THEN amount END) AS amount
    FROM payments
    GROUP BY 1

),

final as (

    SELECT 
        customer_id,
        order_id,
        order_date,
        coalesce(order_payments.amount, 0) AS amount
    FROM orders
    LEFT JOIN order_payments USING (order_id)

)

SELECT * FROM final