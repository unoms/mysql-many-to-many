# mysql-many-to-many
Example of many to many tables

There are three tables. The first one is the student table, the second one is subjects table. The table called student_subject represents a many-to-many relationship between the first two tables.

## student_assign_subject routine
That is a routine procedure to insert values into the student_assign_subject table. 

* The parameters of the routine are StudentName and SubjectName. 
* If there's no student in the student table corresponding to the given StudentName, the routine stops its action and signals SQLSTATE '45001'. 
* If there's no subject corresponding to the given SubjectName, the routine stops its action and signals SQLSTATE '45002'

**Note**: Please, remove the comments from the sql file to import correctly a demo database. 
