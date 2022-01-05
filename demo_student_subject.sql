CREATE DATABASE university CHARSET utf8 COLLATE utf8_general_ci;
USE university;

CREATE TABLE student (
    StudentId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    StudentName VARCHAR(50),
    PRIMARY KEY(StudentId)
);

INSERT INTO student(StudentName) VALUES ('Fedor'), ('Ivan'), ('Olga'), ('Dasha'), ('Peter');

CREATE TABLE subjects (
    SubjectId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    SubjectName VARCHAR(50),
    PRIMARY KEY(SubjectId)
);

INSERT INTO subjects(SubjectName) VALUES ('C++'), ('JS'), ('C#'), ('Python'), ('MySQL');

--Many to Many table
CREATE TABLE student_subject (
    StudentId INT UNSIGNED NOT NULL,
    SubjectId INT UNSIGNED NOT NULL,
    PRIMARY KEY( StudentId, SubjectId),
    INDEX(StudentId),
    INDEX(SubjectId),
    CONSTRAINT fk_student_student 
    FOREIGN KEY (StudentId) REFERENCES student(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_subjects FOREIGN KEY (SubjectId) REFERENCES subjects(SubjectId) ON DELETE CASCADE ON UPDATE CASCADE
);

--Procedure to insert into the student_subject table
DROP PROCEDURE IF EXISTS student_assign_subject;
DELIMITER $$
CREATE PROCEDURE student_assign_subject(IN student_name VARCHAR(50), IN subject_name VARCHAR(50))
BEGIN
    DECLARE stId, sbId INT;
    DECLARE EXIT HANDLER FOR SQLSTATE '45001' SELECT 'NO SUCH STUDENT'; 
    DECLARE EXIT HANDLER FOR SQLSTATE '45002' SELECT 'NO SUCH SUBJECT';
   

    SELECT StudentId INTO stId FROM student WHERE StudentName = student_name;
    IF stId IS NULL THEN SIGNAL SQLSTATE '45001';
    END IF;
   
    SELECT SubjectId INTO sbId FROM subjects WHERE SubjectName = subject_name;
    IF sbId IS NULL THEN SIGNAL SQLSTATE '45002';
    END IF;

    INSERT INTO student_subject(StudentId, SubjectId) VALUES (stId, sbId);
END $$
DELIMITER ;

--Populate a little bit the many-to-many table
CALL student_assign_subject('Peter', 'JS');
CALL student_assign_subject('Ivan', 'C++');
CALL student_assign_subject('Dasha', 'Python');


-- VIEW for more readable info from the many-to-many table
CREATE VIEW studentName_subjectName AS SELECT student.StudentName, subjects.SubjectName 
FROM student_subject 
JOIN student ON student_subject.StudentId = student.StudentId 
JOIN subjects ON student_subject.SubjectId = subjects.SubjectId; 
