SELECT deqs.last_execution_time AS [Time], dest.TEXT AS [Query]
FROM sys.dm_exec_query_stats AS deqs
CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest
WHERE deqs.last_execution_time between '2014-10-08 18:23:00' and '2014-10-08 18:23:30'
AND dest.TEXT not like 'CREATE %'
ORDER BY deqs.last_execution_time DESC;
