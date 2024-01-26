SELECT A.name, A.investment, A.month_of_payback, A.return
FROM
    (SELECT 
        R.name,
        R.investment,
        R.month AS month_of_payback,
        R.cumulative_sum - R.investment AS return,
        row_number() OVER (PARTITION BY R.name ORDER BY R.month) AS row_num
    FROM
        (
            SELECT 
                clients.name, 
                clients.investment,
                operations.month,
                SUM(operations.profit) OVER (PARTITION BY operations.client_id ORDER BY operations.month)
                    AS cumulative_sum
            FROM 
                clients
            LEFT JOIN 
                operations 
                    ON clients.id = operations.client_id
        ) as R
    WHERE (R.cumulative_sum - R.investment) >= 0
    ) as A
WHERE A.row_num = 1;