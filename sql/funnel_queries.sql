-- Queries



-- Event distribution
SELECT event_type, COUNT(*) 
FROM events 
GROUP BY event_type;




-- Funnel Conversion

SELECT
COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS views,
COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS carts,
COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases,

COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) * 1.0 /
COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS cart_conversion,

COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 1.0 /
COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS purchase_conversion

FROM events;





-- Revenue by Price Range

SELECT
CASE
    WHEN price < 50 THEN '0-50'
    WHEN price < 100 THEN '50-100'
    WHEN price < 200 THEN '100-200'
    WHEN price < 500 THEN '200-500'
    WHEN price < 1000 THEN '500-1000'
    ELSE '1000+'
END AS price_range,

SUM(price) AS revenue

FROM events

WHERE event_type = 'purchase'

GROUP BY price_range

ORDER BY revenue DESC;





-- Purchases by Hour

SELECT
hour,
COUNT(*) AS purchases
FROM events
WHERE event_type = 'purchase'
GROUP BY hour
ORDER BY hour;
