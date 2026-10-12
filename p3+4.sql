

USE shop;

-- ------------------------------------------------------------
-- ПУНКТ 3: об'єднати всі 8 таблиць через INNER JOIN.
-- ------------------------------------------------------------
SELECT *
FROM orders o
INNER JOIN order_details od ON o.id          = od.order_id
INNER JOIN customers    c   ON o.customer_id = c.id
INNER JOIN employees    e   ON o.employee_id = e.employee_id
INNER JOIN shippers     sh  ON o.shipper_id  = sh.id
INNER JOIN products     p   ON od.product_id = p.id
INNER JOIN categories   cat ON p.category_id = cat.id
INNER JOIN suppliers    su  ON p.supplier_id = su.id;


-- ------------------------------------------------------------
-- ПУНКТ 4.1: скільки рядків повертає цей JOIN (COUNT)
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_rows
FROM orders o
INNER JOIN order_details od ON o.id          = od.order_id
INNER JOIN customers    c   ON o.customer_id = c.id
INNER JOIN employees    e   ON o.employee_id = e.employee_id
INNER JOIN shippers     sh  ON o.shipper_id  = sh.id
INNER JOIN products     p   ON od.product_id = p.id
INNER JOIN categories   cat ON p.category_id = cat.id
INNER JOIN suppliers    su  ON p.supplier_id = su.id;


-- ------------------------------------------------------------
-- ПУНКТ 4.2: INNER -> LEFT / RIGHT
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_rows
FROM customers c
LEFT JOIN orders        o   ON o.customer_id = c.id
LEFT JOIN order_details od  ON o.id          = od.order_id
LEFT JOIN employees     e   ON o.employee_id = e.employee_id
LEFT JOIN shippers      sh  ON o.shipper_id  = sh.id
LEFT JOIN products      p   ON od.product_id = p.id
LEFT JOIN categories    cat ON p.category_id = cat.id
LEFT JOIN suppliers     su  ON p.supplier_id = su.id;


-- ------------------------------------------------------------
-- ПУНКТ 4.3: тільки рядки, де employee_id > 3 та <= 10
-- ------------------------------------------------------------
SELECT *
FROM orders o
INNER JOIN order_details od ON o.id          = od.order_id
INNER JOIN customers    c   ON o.customer_id = c.id
INNER JOIN employees    e   ON o.employee_id = e.employee_id
INNER JOIN shippers     sh  ON o.shipper_id  = sh.id
INNER JOIN products     p   ON od.product_id = p.id
INNER JOIN categories   cat ON p.category_id = cat.id
INNER JOIN suppliers    su  ON p.supplier_id = su.id
WHERE o.employee_id > 3 AND o.employee_id <= 10;


-- ------------------------------------------------------------
-- ПУНКТ 4.4–4.7: групування за категорією + COUNT + AVG(quantity),
-- фільтр середньої кількості > 21 (HAVING),
-- сортування за спаданням кількості рядків (ORDER BY),
-- 4 рядки з пропущеним першим (LIMIT 4 OFFSET 1).
-- ------------------------------------------------------------
SELECT
  cat.name              AS category,
  COUNT(*)              AS rows_count,
  AVG(od.quantity)      AS avg_quantity
FROM orders o
INNER JOIN order_details od ON o.id          = od.order_id
INNER JOIN customers    c   ON o.customer_id = c.id
INNER JOIN employees    e   ON o.employee_id = e.employee_id
INNER JOIN shippers     sh  ON o.shipper_id  = sh.id
INNER JOIN products     p   ON od.product_id = p.id
INNER JOIN categories   cat ON p.category_id = cat.id
INNER JOIN suppliers    su  ON p.supplier_id = su.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY rows_count DESC
LIMIT 4 OFFSET 1;