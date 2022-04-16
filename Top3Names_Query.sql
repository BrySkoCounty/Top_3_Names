SELECT 
    state,
    gender,
    year,
    name,
    number
FROM
    (
	--This selects all columns, and assigns row numbers to each by year, gender, and state 
	--and then orders by column number descending so that the highest values are 1, 2, and 3
    SELECT 
        state,
        gender,
        year,
        name,
        number,
        ROW_NUMBER() OVER (
            PARTITION BY year, gender, state
            ORDER BY number DESC
        ) AS row_num
    FROM
        `bigquery-public-data.usa_names.usa_1910_current`
    )
WHERE
	--Along with the initial SELECT statement (which selects all columns), the WHERE selects only those
	--rows which have a row number less than or equal to 3. In other words, the top 3 names of each gender, state, and year
    row_num <= 3
ORDER BY year ASC
