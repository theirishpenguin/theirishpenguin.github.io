---
comments: true
date: 2010-09-22 09:13:59
layout: post
slug: beginning-optimization-in-mysql
title: Beginning Optimization in MySQL
wordpress_id: 881
tags:
- Programming
- RubyIreland
- database
- mysql
---

The first place to start be to run your query using EXPLAIN in order to see what MySQL execution plan. Simply put EXPLAIN in front of your SELECT statement and check the output. Initially, you might think that its output doesn't give hard figures and as a result is pretty awkward to understand. But you'll soon see that it really helps you understand your queries and how they interact with things like indexes. The first page of [this article](http://www.databasejournal.com/features/mysql/article.php/1382791/Optimizing-MySQL-Queries-and-Indexes.htm) by Ian Gilfillan is a great explanation of explain (bit of a mouthful that!).

The other good starting point is to known how does MySQL do joins? Well, the short answer is the single-sweep multi-join method and if you didn't know that then check out [this post](http://www.fiftyfoureleven.com/weblog/web-development/programming-and-scripts/mysql-optimization-tip) by Mike Papageorge.


## Cache rich, time poor...


Of course, as you use EXPLAIN you'll try different things in your query and re-run queries to see the difference in performance. You'll want to some hard figures. Each time you run a MySQL query from the MySQL command line, or MySQL Query Browser, it will give you a query execution time. Unfortunately, the second time you run a query the execution time will be drastically shorter - because the results from the previous execution will be in MySQL's Query Cache. The only reliable way I've found to minimise the effect of the cache is to restart the MySQL server after every query (eg. /etc/init.d/mysql restart). It won't give you the exact same metric as, for example, after a reboot of your machine but it's a good line in the sand nonetheless.


## Ok, a quick checklist...


The thing is someone else has always done the hard work for you on topics like this. A great place to start is with this [checklist](http://blog.sven.co.za/2010/03/23/mysql-database-optimization/) by Sevn Welzel. Here's my favourite from that checklist, which I'm listing here more as a memo-to-self than anything else.

**Note: That MySQL 5.0 introduced a lot of changes so certain optimizations pre-5.0, such as converting OR statements to UNIONs are no longer needed.**



	
* Derived tables (subqueries in the FROM clause) can be useful for retrieving BLOBs without sorting them. (Self-join can speed up a query if 1st part finds the IDs and uses then to fetch the rest)

	
* Avoid using IN(…) when selecting on indexed fields

	
* InnoDB ALWAYS keeps the primary key as part of each index, so do not make the primary key very large

	
* This list of [Easy MySQL Performance Tweaks](http://docs.cellblue.nl/2007/03/17/easy-mysql-performance-tweaks/)

	
* Sven also lists a bundle of tips by Alexander Skakunov at [AjaxLine](http://www.ajaxline.com/32-tips-to-speed-up-your-mysql-queries) the most useful one for me being the way the MySQL Query Optimizer can use the leftmost index prefix - this mean you can define index on several columns so that left part of that index can be used a separate one so that you need less indices (though remember that your index will be bigger overall and hence not a fast to search as a smaller index)




## Handpicking Indexes


A big part of optimizing in MySQL is experimenting with different indexes on your database but you don't want to have to keep adding and removing them - as this can take a long time on big tables. Consider using IGNORE INDEX(some_index) if you'd like to see how your query would perform in the absence of an index or FORCE INDEX(some_index) if you'd like make sure MySQL to use's a particular index. By looking a the output of EXPLAIN you can see which indexes are being used. Sometimes, if you know your data well, you can outsmart the MySQL query optimizer. Though be careful when doing so as if the shape of your data changes your optimization might work against you. More details at [MySQL Manual Index-hints](http://dev.mysql.com/doc/refman/5.1/en/index-hints.html).


## Top optimization picks from the MySQL Documentation


The MySQL docs really are great at explaining a lot of this stuff and the optimization sections are well worth a read. Here I've just selected the bits that were the most useful as I worked through this area and expanded on them in one or two cases.



	
* From [MySQL SELECT Documentation](http://dev.mysql.com/doc/refman/5.0/en/select.html)

	
  * STRAIGHT_JOIN forces the optimizer to join the tables in the order in which they are listed in the FROM clause.

	
  * The Irish Penguin says: "This can be really really handy. For example, if you have a GROUP BY clause that references a column in a large table in a query featuring some JOINS, you probably will want to the table containing this column to be the first hit in the query - even if it produces a much higher number of _rows examined_ figure in the EXPLAIN output. My understanding is that the way MySQL decides on its query plan is to put the table that is likely to yield the fewest rows first. But this can be at loggerheads with GROUP BY clauses. It does a similar behaviour when choosing indexes as this [MySQL Performance Blog article](http://www.mysqlperformanceblog.com/2007/02/16/using-index-for-order-by-vs-restricting-number-of-rows/) states"




	
* From [MySQL INDEX ](http://dev.mysql.com/doc/refman/5.0/en/mysql-indexes.html) and [MULTIPLE-COLUMN INDEX](http://dev.mysql.com/doc/refman/5.0/en/multiple-column-indexes.html)

	
  * If the table has a multiple-column index, any leftmost prefix of the index can be used by the optimizer to find rows. For example, if you have a three-column index on (col1, col2, col3), you have indexed search capabilities on (col1), (col1, col2), and (col1, col2, col3).

	
  * If a multiple-column index exists on col1 and col2, the appropriate rows can be fetched directly. If separate single-column indexes exist on col1 and col2, the optimizer will attempt to use the Index Merge optimization (see Section 7.3.1.4, “Index Merge Optimization”), or attempt to find the most restrictive index by deciding which index finds fewer rows and using that index to fetch the rows.




	
* [](http://dev.mysql.com/doc/refman/5.0/en/index-merge-optimization.html)

	
  * If a range scan is possible on some key, the optimizer will not consider using Index Merge Union or Index Merge Sort-Union algorithms




	
* Consider running [OPTIMIZE TABLE](http://dev.mysql.com/doc/refman/5.0/en/optimize-table.html) if you have deleted a large part of a table or if you have made many changes to a table with variable-length rows

	
* From [MySQL Optimizer Issues](http://dev.mysql.com/doc/refman/5.0/en/optimizer-issues.html)

	
  * Use ANALYZE TABLE tbl_name to update the key distributions for the scanned table. See [ANALYZE TABLE Syntax](http://dev.mysql.com/doc/refman/5.0/en/analyze-table.html)




	
* From [InnoDB restrictions](http://dev.mysql.com/doc/refman/5.0/en/innodb-restrictions.html) and [InnoDB turning](http://dev.mysql.com/doc/refman/5.0/en/innodb-tuning.html)

	
  * An InnoDB table cannot contain more than 1000 columns

	
  * SHOW TABLE STATUS does not give accurate statistics on InnoDB tables, except for the physical size reserved by the table. The row count is only a rough estimate used in SQL optimization

	
  * Cascaded foreign key actions to not activate triggers



	
  * InnoDB does not store an index cardinality value in its tables. Instead, InnoDB computes a cardinality for a table the first time it accesses it after startup. With a large number of tables, this might take significant time. It is the initial table open operation that is important, so to “warm up” a table for later use, access it immediately after startup by issuing a statement such as SELECT 1 FROM tbl_name LIMIT 1.




	
* Relating to the [Group By Optimization](http://dev.mysql.com/doc/refman/5.0/en/group-by-optimization.html)

	
  * Usually a `GROUP BY` clause causes a scan of the whole table and the creation of a new temporary           table where all rows from each group are consecutive. This temporary table is then used to establish groups and apply           aggregate functions. MySQL can sometimes use indexes that avoid temporary table creation if the query is written in a certain way -  all `GROUP           BY` columns must reference attributes from the same index. Also           the index must stores its keys in order (for example, this           is a `BTREE` index and not a           `HASH` index). See this [InformIT article](http://www.informit.com/articles/article.aspx?p=377652) for the difference between BTEE and HASH indexes and more information

	
  * Very importantly, make sure that the column(s) involved in the GROUP BY clause are from the lead table in your query. If MySQL's Optimizer is choosing a different table as the lead table try using STRAIGHT_JOIN to force MySQL to first hit the table containing the columns that appear in the GROUP BY when executing the query. Why doesn't MySQL always do this by default? MySQL's Query Optimizer prefers to using indexes for restriction (WHERE clause) rather than sorting (GROUP BY or ORDER BY) that's why you sometimes need to give it this hint




	
* Relating to the [Limit Optimization](http://dev.mysql.com/doc/refman/5.0/en/limit-optimization.html)

	
  * The LIMIT clause can speed up things even when applied after an ORDER BY clause. **MySQL does not always need to finish the sorting before it can apply the limit. **In some cases, you can think of LIMIT as a buffer that MySQL fills up as it sorts the results - MySQL stops as soon as the buffer is filled. For example, if you use LIMIT 10 with ORDER BY, MySQL ends the sorting as soon as it has found the first 10 rows of the sorted result, rather than sorting the entire result. Here's some caveats

	
    * Avoid using a HAVING clause as this will prevent the optimizations

	
    * You really want the ordering to use an index. Otherwise if a filesort must be done, all rows that match the query without the LIMIT clause must be selected, and most or all of them must be sorted, before it can be ascertained that the first 10 rows have been found










## Some other random musings





	
* Interesting [debunking of the myth that MySQL violates the SQL standard](http://dev.mysql.com/tech-resources/articles/debunking-group-by-myths.html) when it comes to specifying (or omitting) columns referenced in the SELECT list of a query to also appear in the GROUP BY clause

	
* Another [post](http://www.mysqlperformanceblog.com/2006/09/06/wrong-group-by-makes-your-queries-fragile/) shows how GROUP BY can get you into a whole world of trouble on this score


And as if that wasn't enough, there'll be a few more updates to this article at a later date. Coffee permitting!
