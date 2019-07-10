# Disable-Enaabling-Indexes-and-Constraints
Two Procedures for disabling and enabling indexes and Constraints.
These procedures can run on Oracle on any schema.

ETL Developers loads everyday a huge amount of data.
Loading data into tables may take longer than it should be.
So, they need to speedup the loading to avoid a long time of loading that can overlap with the next day and may be a big problem.

One of the known tips for improving the insert process is to disable indexes.
Yes, Indexes maybe useful in querying the data but it takes time to organize the new data while inserting them.
So, we disable the indexes before loading and then enabling them after we have successfully loaded the data.

Also disabling the constraints may improve the loading too.

So, I was assigned to make 2 stored procedures to disable and enable indexes and constraints in ORACLE databases.

Here is the first version you can have a look and you can contribute also on updating them and creating similar procedures for other databases.
