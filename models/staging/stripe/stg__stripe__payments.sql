SELECT 
    id AS payment_id, -- not a customer id
    orderid AS order_id,
    paymentmethod AS payment_method,
    status,
    created  AS order_date,
    amount / 100 as amount
FROM raw.stripe.payment