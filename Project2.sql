 ---------------------------------
 --Project 2
 ---------------------------------						
 --Name: Karthik Yogendra Bangera
 --SUID: 291741900
 ---------------------------------
 
 --Design Changes:
 --******************
 --Had 3 benefits table in the table last time, replaced them with a single benefits table based on the instructor's solution.
 --Added a linking table between Employees and CourseSchedule named TeachingAssignment.
 --The EnrolledStudents are now linked to the CourseSchedule table, it makes more sense, previously it was linked to the Courses table.
 --Removed GraduationDate column from the DegreeDetails table, it wasn't required.
 

 --Table Creation Scripts(26 tables):
 --************************************
  --CREATE SCHEMA pr2;
  --	GO
 
  CREATE TABLE pr2.Address (
	 AddressId		INTEGER         PRIMARY KEY    IDENTITY(1,1),
	 Street1		VARCHAR(50)		NOT NULL,
	 Street2		VARCHAR(50),
	 City			VARCHAR(50)		NOT NULL,
	 State		    VARCHAR(20)		NOT NULL,	
	 ZIP		    VARCHAR(10)		NOT NULL
 );
  
  CREATE TABLE pr2.People (
	 PersonId		INTEGER			PRIMARY KEY    IDENTITY(1,1),
	 FirstName		VARCHAR(50)		NOT NULL,
	 MiddleName		VARCHAR(50),
	 LastName		VARCHAR(50)		NOT NULL,
	 NTID			VARCHAR(20)		NOT NULL,	
	 Password		VARCHAR(20)		NOT NULL,
	 DateOfBirth    DATE			NOT NULL,
	 SSN		    VARCHAR(20),
	 HomeAddress	INTEGER			NOT NULL		REFERENCES pr2.Address(AddressId),
	 LocalAddress	INTEGER							REFERENCES pr2.Address(AddressId)
 );

 CREATE TABLE pr2.JobDetails (
	 JobId				INTEGER			PRIMARY KEY    IDENTITY(1,1),
	 JobTitle			VARCHAR(50)		NOT NULL,
	 JobDescription		VARCHAR(300)	NOT NULL,
	 JobRequirements    VARCHAR(300),
	 MinPay				DECIMAL(10,2)	NOT NULL       CHECK  (Minpay >= 0),
	 MaxPay				DECIMAL(10,2)	NOT NULL       CHECK  (Maxpay >= 0),
	 IsUnion			VARCHAR(3)		NOT NULL	   DEFAULT 'Yes'
 );

 CREATE TABLE pr2.SelectOption (
	 SelectedId		INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 SelectedType	VARCHAR(50)		NOT NULL
 );

 CREATE TABLE pr2.Benefits (
	BenefitId           INTEGER        PRIMARY KEY    IDENTITY(1,1),
	BenefitCost         INTEGER        NOT NULL,
	BenefitDescription  VARCHAR(300),
	BenefitSelection    INTEGER        NOT NULL       REFERENCES pr2.SelectOption(SelectedId)
);

 CREATE TABLE pr2.EmployeeStatus (
	 StatusId		INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 Status			VARCHAR(50)		NOT NULL
 );
 
 CREATE TABLE pr2.Employees (
	EmployeeId     VARCHAR(20)    PRIMARY KEY,
	PersonId       INTEGER        NOT NULL       REFERENCES		pr2.People(PersonId),
	Status		   INTEGER						 REFERENCES		pr2.EmployeeStatus(StatusId),
	JobId		   INTEGER        NOT NULL       REFERENCES		pr2.JobDetails(JobId),
	YearlyPay      DECIMAL(10,2)  NOT NULL,
	HealthBenefits INTEGER        NOT NULL       REFERENCES		pr2.Benefits(BenefitId),
	VisionBenefits INTEGER        NOT NULL       REFERENCES		pr2.Benefits(BenefitId),
	DentalBenefits INTEGER        NOT NULL       REFERENCES		pr2.Benefits(BenefitId)
);

CREATE TABLE pr2.StudentStatus (
	 StatusId		INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 Status			VARCHAR(50)		NOT NULL
 );

 CREATE TABLE pr2.Students(
	StudentId				INTEGER	    PRIMARY KEY    IDENTITY(1,1),
	PersonId				INTEGER 	NOT NULL       REFERENCES    pr2.People(PersonId),
	Status					INTEGER					   REFERENCES    pr2.StudentStatus(StatusId)	
);

CREATE TABLE pr2.Colleges (
	 CollegeId		INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 CollegeName	VARCHAR(50)		NOT NULL
 );

 CREATE TABLE pr2.Specialization (
	 SpecializationId		INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 CollegeId				INTEGER 		NOT NULL       REFERENCES    pr2.Colleges(CollegeId),
	 Specialization			VARCHAR(50)		NOT NULL,
	 IsMajor				VARCHAR(3)		NOT NULL	   DEFAULT       'Yes'
 );

 CREATE TABLE pr2.DegreeDetails (
	StudentId			 INTEGER	     NOT NULL	  REFERENCES	pr2.Students(StudentId),
	SpecializationId     INTEGER         NOT NULL     REFERENCES	pr2.Specialization(SpecializationId) ,
	PRIMARY KEY (StudentId, SpecializationId),
	GPA					 DECIMAL(5,2)
 );
 
 CREATE TABLE pr2.StudentGradingStatus (
	 StatusId		INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 Status			VARCHAR(50)		NOT NULL
 ); 

 CREATE TABLE pr2.Grade (
	 Id				INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 Text			VARCHAR(20)		NOT NULL
 );

 CREATE TABLE pr2.Courses(
	CourseCode				VARCHAR(20)		NOT NULL,
	CourseNumber			INTEGER			NOT NULL,
	PRIMARY KEY (CourseCode,CourseNumber),
	CourseTitle				VARCHAR(50)		NOT NULL,
	CourseDescription		VARCHAR(500)
);

CREATE TABLE pr2.Prerequisites(
	ParentCourse			VARCHAR(20)		NOT NULL,
	ParentNumber			INTEGER			NOT NULL,
	ChildCourse				VARCHAR(20)		NOT NULL,
	ChildNumber				INTEGER			NOT NULL,
	PRIMARY KEY (ParentCourse,ParentNumber,ChildCourse,ChildNumber),
	FOREIGN KEY (ParentCourse, ParentNumber) REFERENCES pr2.Courses(CourseCode, CourseNumber),
	FOREIGN KEY (ChildCourse, ChildNumber)    REFERENCES pr2.Courses(CourseCode, CourseNumber)
);

 CREATE TABLE pr2.Building (
	 BuildingId		INTEGER			PRIMARY KEY	 IDENTITY(1,1),
	 BuildingName	VARCHAR(50)		NOT NULL
 );

 CREATE TABLE pr2.Projector (
	 ProjectorId		INTEGER			PRIMARY KEY	 IDENTITY(1,1),
	 ProjectorStatus	VARCHAR(50)		NOT NULL
 );

CREATE TABLE pr2.Classroom (
	ClassroomId		VARCHAR(20)  NOT NULL	PRIMARY KEY,
	Building		INTEGER      NOT NULL   REFERENCES pr2.Building(BuildingId),
	Projector		INTEGER      NOT NULL   REFERENCES pr2.Projector(ProjectorId),
	RoomNumber		VARCHAR(20)  NOT NULL,
	MaximumSeating	INTEGER      NOT NULL   CHECK(MaximumSeating>=0),
	NoOfWhiteBoards INTEGER      NOT NULL	CHECK(NoOfWhiteBoards>=0),
	OtherEquipments VARCHAR(20)  NULL
);

 CREATE TABLE pr2.Days (
	 DayId			INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 Day			VARCHAR(50)		NOT NULL
 );
 
 CREATE TABLE pr2.Semesters (
	 SemesterId			INTEGER			PRIMARY KEY	   IDENTITY(1,1),
	 Semester			VARCHAR(50)		NOT NULL
 );

 CREATE TABLE pr2.SemesterDetails(
	SemesterId		INTEGER	    PRIMARY KEY	 IDENTITY(1,1),
	Semester		INTEGER	    REFERENCES	 pr2.Semesters(SemesterId),
	Year			INTEGER	    NOT NULL,
	StartDate		DATE		NOT NULL,
	EndDate			DATE		NOT NULL,
	CHECK (EndDate > StartDate)
 );

 CREATE TABLE pr2.CourseSchedule
(
	CourseScheduleId		INTEGER			PRIMARY KEY IDENTITY(1,1),
	CourseCode				VARCHAR(20)		NOT NULL,
	CourseNumber			INTEGER			NOT NULL,
	FOREIGN KEY(CourseCode,CourseNumber)	REFERENCES pr2.Courses(CourseCode, CourseNumber),
	Classroom				VARCHAR(20)     REFERENCES pr2.Classroom(ClassroomId),
	Semester				INTEGER			NOT NULL   REFERENCES pr2.SemesterDetails(SemesterId),
	Capacity				INTEGER			NOT NULL   CHECK(Capacity>=0)
);

CREATE TABLE pr2.TeachingAssignment
(
	EmployeeId           VARCHAR(20)     NOT NULL	  REFERENCES	pr2.Employees(EmployeeId),
	CourseScheduleId     INTEGER         NOT NULL     REFERENCES	pr2.CourseSchedule(CourseScheduleId) ,
	PRIMARY KEY (EmployeeId, CourseScheduleId)
);

 CREATE TABLE pr2.EnrolledStudents(
	EnrollmentId	INTEGER	        PRIMARY KEY	   IDENTITY(1,1),
	CourseId	    INTEGER	        NOT NULL       REFERENCES    pr2.CourseSchedule(CourseScheduleId),
	StudentId	    INTEGER	        NOT NULL       REFERENCES    pr2.Students(StudentId),
	Status			INTEGER	        NOT NULL       REFERENCES    pr2.StudentGradingStatus(StatusId),
	Grade	        INTEGER	                       REFERENCES    pr2.Grade(Id)
);

 CREATE TABLE pr2.WeeklyCourseSchedule
(
	CourseScheduleId     INTEGER    NOT NULL     REFERENCES	pr2.CourseSchedule(CourseScheduleId),
	DayId				 INTEGER	NOT NULL     REFERENCES	pr2.Days(DayId),
	PRIMARY KEY (CourseScheduleId, DayId),
	StartTime			 TIME	         NOT NULL,
	EndTime     		 TIME            NOT NULL,
	CHECK (EndTime > StartTime)
);

--Data loading commands:
--************************
--Inserted 15 rows, considering home and local addresses would be different for some(12 persons in People table(6 employees+6 students)

INSERT INTO pr2.Address(Street1, Street2, City, State, ZIP)
	VALUES    ('437 Columbus Avenue', NULL, 'Syracuse',	'New York', 13210),
			  ('113 Travis Street', NULL, 'Austin', 'Texas', 78703),
			  ('212 WestCott Street', NULL, 'Syracuse',	'New York', 13210),
			  ('505 Colombia Avenue', NULL, 'Los Angeles', 'California', 90005),
			  ('301 Lancaster Avenue ', NULL, 'Syracuse', 'New York', 13210),
			  ('210 Altmira Street', NULL, 'Miami',	'Florida', 33101),
			  ('701 Comstock Avenue', NULL, 'Syracuse',	'New York', 13210),
			  ('102 Waverly Avenue', NULL, 'Syracuse', 'New York', 13210),
			  ('108 Glenville Street', NULL, 'Albany',	'New York', 12302),			  
			  ('127 Fenway Street', NULL, 'Boston', 'Massachusetts', 02108),
			  ('110 WestCott Street', NULL, 'Syracuse',	'New York', 13209),
			  ('456 Old Liverpool Road', NULL, 'Syracuse', 'New York', 13205),
			  ('1533 East Genesee Street', NULL, 'Syracuse', 'New York', 13206),
			  ('142 Lexington Avenue', NULL, 'Syracuse', 'New York', 13207),
			  ('216 Cherry Street', NULL, 'Syracuse',	'New York', 13208);

-- SELECT * FROM pr2.Address;

 INSERT INTO pr2.People(FirstName, MiddleName, LastName, NTID, Password, DateOfBirth, SSN, HomeAddress, LocalAddress)
	VALUES    ('Frank', NULL, 'Lampard', '291741908', 'Maestro08!', '1980-10-08', '518-22-1008', 2, 1),
			  ('Steven', NULL, 'Gerrard', '291741904', 'Captain04!', '1982-01-04', '518-24-1004', 4, 3),
			  ('David', NULL, 'Beckham', '291741907', 'Becks07!','1981-11-07','518-25-1007', 6, 5),
			  ('Wayne', NULL, 'Rooney', '291741910', 'Wazza10!','1985-03-10','518-55-1010', 7, 7),
			  ('John', NULL, 'Terry', '291741901', 'Leader26!','1979-10-08','518-26-1026', 9, NULL),
			  ('Gary', NULL, 'Cahill', '291741903', 'Deputy03!','1978-05-03','518-21-1003', 10, NULL),
			  ('Eden', NULL, 'Hazard', '291731900', 'Numero10!','1990-03-05','518-54-1011', 8, 8),
			  ('David', NULL, 'Luiz', '291731901', 'Geezer04!','1991-04-01','518-53-1113', 11, 11),
			  ('Diego', NULL, 'Costa', '291731902', 'Forward09!','1994-10-21','518-51-1203', 12, 12),
			  ('Cesc', NULL, 'Fabregas', '291731903', 'PassMaster04!','1992-12-01','518-56-1637', 13, 13),
			  ('Antonio', NULL, 'Conte', '291731904', 'Italia10!','1993-01-01','518-59-1937', 14, 14),
			  ('Victor', NULL, 'Moses', '291731905', 'Nigeria05!','1994-07-08','518-53-1263', 15, 15);

--SELECT * FROM pr2.People;

 INSERT INTO pr2.JobDetails(JobTitle, JobDescription, JobRequirements, MinPay, MaxPay, IsUnion)
	VALUES    ('Professor', 'Teach courses in their subject area and supervise graduate students working towards doctoral degree.',  'Minimum of a doctoral degree in an academic field of study and a minimum of 5 years teaching experience' , 89000, 98974, 'No'),
			  ('Associate Professor', 'Draw on extensive academic excellence to underpin and carry out research or scholarship, teaching, leadership and management in the field', 'Minimum of a doctoral degree in an academic field of study and a minimum of 2 years teaching experience', 65000, 69911, 'No'),
			  ('Assistant Professor', 'Role will involve a combination of research and teaching activities, with appropriate organisation of these activities and contribution(s) to departmental administration.', 'A doctoral degree and some teaching experience', 55000, 58662, 'No'),
			  ('Lecturer', 'Contact and teaching time with students, checking and assessing students work and invigilating exams', 'Minimum of a bachelor degree in an academic field of study', 44200, 48289, 'Yes' ),
			  ('Visiting Professor', 'A temporary appointment, often to fill a vacancy that has arisen due to temporary absence of a regular faculty member.', 'Minimum of a doctoral degree in an academic field of study and a minimum of 5 years teaching experience', 91480, 95600, 'No'),
			  ('Research Professor', 'Full-time research position with few or no teaching responsibilities', 'Minimum of a doctoral degree in an academic field of study and a minimum of 4 years research experience', 110100, 151000, 'No');

-- SELECT * FROM pr2.JobDetails;

 INSERT INTO pr2.SelectOption(SelectedType)
 VALUES ('Individual'),
		('Family'),
		('Opt-Out');

--SELECT * FROM pr2.SelectOption;

INSERT INTO pr2.Benefits(BenefitCost, BenefitDescription, BenefitSelection)
 VALUES (3000,'Outpatient Services',3),
		(4000,'Inpatient Services',2),
		(6000,'Emergency Services',1),		
		(5000,'Pediatric Services',2),
		(2000,'Therapy Services',1),
		(4000,'Lab Tests',3);

--SELECT * FROM pr2.Benefits;

  INSERT INTO pr2.EmployeeStatus(Status)
	VALUES    ('Active Full-Time'),
			  ('Active Part-Time'),
			  ('Laid Off'),
			  ('On Leave'),
			  ('Retired'),
			  ('Terminated');

--SELECT * FROM pr2.EmployeeStatus;

INSERT INTO pr2.Employees (EmployeeId, PersonId, Status, JobId, YearlyPay, HealthBenefits , VisionBenefits, DentalBenefits) 
VALUES	('PFLampard-01', 1 ,1,1, 93000.00 , 2 , 4 , 1 ),
		('APGerrard-02', 2 ,1,2, 69000.00 , 1 , 4 , 5 ),
		('APBeckham-03', 3 ,1,3, 57000.00 , 4 , 6 , 2 ),
		('LCRooney-04', 4 ,1,4, 45000.00 , 5 , 2 , 4 ),
		('VPTerry-05', 5 ,2,5, 92000.00 , 1 , 5 , 1 ),
		('VPCahill-06', 6 ,2,5, 92000.00 , 2 , 1 , 3 );

--SELECT * FROM pr2.Employees;

 INSERT INTO pr2.StudentStatus(Status)
	VALUES    ('Full-Time'),
			  ('Three-quarter time'),
			  ('Half-time'),
			  ('Less than half-time'),
			  ('Voluntary Withdrawal'),
			  ('Expelled');

--SELECT * FROM pr2.StudentStatus;

 INSERT INTO pr2.Students(PersonId, Status)
	VALUES    (7, 5),
			  (8, 2),
			  (9, 1),
			  (10, 1),
			  (11, 3),
			  (12, 1);

--SELECT * FROM pr2.Students;

 INSERT INTO pr2.Colleges(CollegeName)
 VALUES ('College of Journalism'),
		('College of Information Studies'),
		('College Of Engineering'),
		('Physics College'),
		('College of Mathematics'),
		('College of Management Studies');

 --SELECT * FROM pr2.Colleges;

 INSERT INTO pr2.Specialization(CollegeId, Specialization, IsMajor)
 VALUES (1,'Mass Media','Yes'),
		(2,'Information Management','Yes'),
		(3,'Computer Engineering','Yes'),
		(4,'Cosmology','Yes'),
		(5,'Data Analytics','No'),
		(2,'Computer Science','Yes');

--SELECT * FROM pr2.Specialization;

 INSERT INTO pr2.DegreeDetails(StudentId, SpecializationId, GPA)
 VALUES (1,1,3.5),
		(2,2,3.6),
		(3,3,3.6),
		(4,4,3.7),
		(5,5,4.0),
		(6,6,3.8);

--SELECT * FROM pr2.DegreeDetails;

 INSERT INTO pr2.StudentGradingStatus(Status)
	VALUES    ('Graded'),
			  ('Ungraded');

--SELECT * FROM pr2.StudentGradingStatus;

 INSERT INTO pr2.Grade(Text)
	VALUES    ('A'),
			  ('B'),
			  ('C'),
			  ('D');

 --SELECT * FROM pr2.Grade;

 INSERT INTO pr2.Courses(CourseCode, CourseNumber, CourseTitle, CourseDescription)
	VALUES    ('MM', 601, 'Principles of Journalism', 'Course based on stresses academic rigor, ethics, journalistic inquiry and professional practice'),
			  ('MM', 698, 'Introduction to Mass Media', 'Introduction to journalistic inquiry and professional practice'),
			  ('MM', 643, 'Newspaper Editing', 'Course based on writing and managing news articles and columns'),
			  ('IM', 623, 'Big Data', 'Course based on case studies of data processing applications'),
			  ('IM', 610, 'Introduction to Big Data', 'Course based on introduction to the big data landscape'),
			  ('CE', 681, 'Design Patterns', 'Project based course based on C#, can be taken only after completing prerequisites'),
			  ('CE', 621, 'Software Modelling and Analysis', 'Project based course based on C#'),
			  ('CE', 670, 'Object oriented design', 'Project based course based on C++'),
			  ('PH', 671, 'Quantum Physics', 'Project based course on Quantum field theory'),
			  ('MA', 654, 'Statistics', 'Course based on collection, analysis, interpretation, presentation, and organization of data'),
			  ('CS', 675, 'Design Analysis of Algorithms', 'Course based on calculations or other problem-solving operations on data structures'),
			  ('CS', 683, 'Introduction to Algorithms', 'Course based on study of different data structures');

--SELECT * FROM pr2.Courses;

INSERT INTO pr2.Prerequisites(ParentCourse, ParentNumber, ChildCourse, ChildNumber)
	VALUES    ('MM', 601, 'MM', 698),
			  ('MM', 601, 'MM', 643),
			  ('IM', 623, 'IM', 610),
			  ('CE', 681, 'CE', 621),
			  ('CE', 681, 'CE', 670),
			  ('CS', 675, 'CS', 683);

--SELECT * FROM pr2.Prerequisites;

 INSERT INTO pr2.Building
 VALUES ('Hall of Languages'),
		('H.B Crouse Hall'),
		('Link Hall'),
		('Bowne Hall'),
		('Center for Science and Technology'),
		('Hinds Hall');

--SELECT * FROM pr2.Building;

 INSERT INTO pr2.Projector
 VALUES ('Available'),
		('Not available');

 --SELECT * FROM pr2.Projector;

INSERT INTO pr2.ClassRoom (ClassroomId, Building, Projector, RoomNumber, MaximumSeating, NoOfWhiteBoards, OtherEquipments) 
VALUES	('01-HOL',1,2,'HOL-143',40,2,NULL),
		('02-HBC',2,1,'HBC-125',50,2,NULL),
		('03-LH',3,1,'LH-113',90,4,NULL),
		('04-BH',4,1,'BH-241',70,3,NULL),
		('05-CST',5,1,'CST-230',60,2,NULL),
		('06-HH',6,2,'HH-201',50,2,NULL);

 --SELECT * FROM pr2.ClassRoom;

 INSERT INTO pr2.Days
 VALUES ('Saturday'),
		('Sunday'),	
		('Monday'),
		('Tuesday'),
		('Wednesday'),
		('Thursday'),
		('Friday');

 --SELECT * FROM pr2.Days;

 INSERT INTO pr2.Semesters
 VALUES ('Spring'),
		('Summer'),	
		('Fall');

 --SELECT * FROM pr2.Semesters;

 INSERT INTO pr2.SemesterDetails(Semester, Year, StartDate, EndDate)
 VALUES (3,2013,'20130616','20131216'),
		(1,2014,'20140116','20140516'),
		(3,2014,'20140616','20141216'),
		(1,2015,'20150116','20150516'),
		(3,2015,'20150616','20151216'),
		(1,2016,'20160116','20160516'),
		(3,2016,'20160616','20161216');

  --SELECT * FROM pr2.SemesterDetails;

INSERT INTO pr2.CourseSchedule (CourseCode, CourseNumber, Classroom, Semester, Capacity)
VALUES	('CE', 681,'03-LH', 3, 80),
		('IM', 610,'01-HOL', 1, 35),
		('MA', 654,'05-CST', 3, 55),
		('MM', 601,'04-BH', 1, 64),
		('PH', 671,'06-HH', 3, 45),
		('CS', 675,'02-HBC', 1, 43);

  --SELECT * FROM pr2.CourseSchedule;

INSERT INTO pr2.TeachingAssignment (EmployeeId,CourseScheduleId) 
VALUES ('APBeckham-03',1),
	   ('APGerrard-02',2),
       ('LCRooney-04',3),
       ('PFLampard-01',4),
       ('VPCahill-06',5),
       ('VPTerry-05',6);
	   
  --SELECT * FROM pr2.TeachingAssignment;

  INSERT INTO pr2.EnrolledStudents (CourseId,StudentId,Status,Grade) 
  VALUES (1,3,1,1),
		 (1,6,1,2),
		 (3,2,2,NULL),
		 (3,5,2,NULL),
		 (5,2,1,2),
		 (5,4,1,1);

--SELECT * FROM pr2.EnrolledStudents;

INSERT INTO pr2.WeeklyCourseSchedule (CourseScheduleId , DayId , StartTime , EndTime) 
VALUES (1,3,'15:45:00','17:05:00'),
	   (2,4,'09:00:00','11:00:00'),
	   (3,5,'11:00:00','12:30:00'),
	   (4,6,'18:45:00','19:05:00'),
       (5,7,'15:00:00','17:00:00'),
       (6,7,'16:00:00','18:00:00');

--SELECT * FROM pr2.WeeklyCourseSchedule;

--Views(4 views):
--***************
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--View displaying the faculty's name, job title, courses, the day and time of their course
----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW pr2.facultyDetails AS 
SELECT pr2.People.FirstName + ' ' + pr2.People.LastName AS "FacultyName",pr2.JobDetails.JobTitle,pr2.Courses.CourseTitle,
	   pr2.Days.Day,pr2.WeeklyCourseSchedule.StartTime,pr2.WeeklyCourseSchedule.EndTime
			FROM pr2.Employees INNER JOIN pr2.People
				ON pr2.Employees.PersonId = pr2.People.PersonId
				INNER JOIN pr2.JobDetails
				ON pr2.JobDetails.JobId=pr2.Employees.JobId
				INNER JOIN pr2.TeachingAssignment
				ON pr2.Employees.EmployeeId = pr2.TeachingAssignment.EmployeeId
				INNER JOIN pr2.WeeklyCourseSchedule
				ON pr2.WeeklyCourseSchedule.CourseScheduleId = pr2.TeachingAssignment.CourseScheduleId
				INNER JOIN pr2.CourseSchedule
				ON pr2.WeeklyCourseSchedule.CourseScheduleId = pr2.CourseSchedule.CourseScheduleId
				INNER JOIN pr2.Courses
				ON pr2.Courses.CourseCode=pr2.CourseSchedule.CourseCode
				AND pr2.Courses.CourseNumber=pr2.CourseSchedule.CourseNumber
				INNER JOIN pr2.Days
				ON pr2.WeeklyCourseSchedule.DayId=pr2.Days.DayId;

--SELECT * FROM pr2.facultyDetails;
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--View displaying the student's name, student status, course taken, the day and time of their course
----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW pr2.studentDetails AS 
SELECT pr2.People.FirstName + ' ' + pr2.People.LastName AS "StudentName",pr2.StudentStatus.Status,pr2.Courses.CourseTitle,
	   pr2.Days.Day,pr2.WeeklyCourseSchedule.StartTime,pr2.WeeklyCourseSchedule.EndTime
			FROM pr2.Students INNER JOIN pr2.People
				ON pr2.Students.PersonId = pr2.People.PersonId
				INNER JOIN pr2.StudentStatus
				ON pr2.Students.Status=pr2.StudentStatus.StatusId
				INNER JOIN pr2.EnrolledStudents
				ON pr2.Students.StudentId=pr2.EnrolledStudents.StudentId
				INNER JOIN pr2.CourseSchedule
				ON pr2.EnrolledStudents.CourseId = pr2.CourseSchedule.CourseScheduleId
				INNER JOIN pr2.Courses
				ON pr2.Courses.CourseCode=pr2.CourseSchedule.CourseCode
				AND pr2.Courses.CourseNumber=pr2.CourseSchedule.CourseNumber
				INNER JOIN pr2.WeeklyCourseSchedule
				ON pr2.WeeklyCourseSchedule.CourseScheduleId=pr2.CourseSchedule.CourseScheduleId
				INNER JOIN pr2.Days
				ON pr2.WeeklyCourseSchedule.DayId=pr2.Days.DayId;

--SELECT * FROM pr2.studentDetails;
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--View displaying the course details, the semesters they are available in and where and when are the lectures held. 
----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW pr2.courseDetails AS 
SELECT pr2.Courses.CourseTitle,pr2.Semesters.Semester,pr2.Building.BuildingName,pr2.Classroom.RoomNumber,
		pr2.Days.Day,pr2.WeeklyCourseSchedule.StartTime,pr2.WeeklyCourseSchedule.EndTime
			FROM pr2.Courses INNER JOIN pr2.CourseSchedule
				ON pr2.Courses.CourseCode=pr2.CourseSchedule.CourseCode
				AND pr2.Courses.CourseNumber=pr2.CourseSchedule.CourseNumber
				INNER JOIN pr2.Semesters
				ON pr2.CourseSchedule.Semester=pr2.Semesters.SemesterId
				INNER JOIN pr2.Classroom
				ON pr2.CourseSchedule.Classroom=pr2.Classroom.ClassroomId
				INNER JOIN pr2.Building
				ON pr2.Classroom.Building=pr2.Building.BuildingId
				INNER JOIN pr2.WeeklyCourseSchedule
				ON pr2.WeeklyCourseSchedule.CourseScheduleId=pr2.CourseSchedule.CourseScheduleId
				INNER JOIN pr2.Days
				ON pr2.WeeklyCourseSchedule.DayId=pr2.Days.DayId;

--SELECT * FROM pr2.courseDetails;
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--View to display Background details of the student for a background check
----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW pr2.studentBackgroundCheck AS 
SELECT pr2.People.FirstName + ' ' + pr2.People.LastName AS "StudentName",pr2.Address.Street1,
	   pr2.Address.City,pr2.Address.ZIP,pr2.Specialization.Specialization,pr2.Colleges.CollegeName
			FROM pr2.Students INNER JOIN pr2.People
				ON pr2.Students.PersonId = pr2.People.PersonId
				INNER JOIN pr2.Address
				ON pr2.People.HomeAddress=pr2.Address.AddressId
				INNER JOIN pr2.DegreeDetails
				ON pr2.Students.StudentId=pr2.DegreeDetails.StudentId
				INNER JOIN pr2.Specialization
				ON pr2.DegreeDetails.SpecializationId=pr2.Specialization.SpecializationId
				INNER JOIN pr2.Colleges
				ON pr2.Specialization.CollegeId=pr2.Colleges.CollegeId;

--SELECT * FROM pr2.studentBackgroundCheck;

--Stored Procedures(2 stored procedures):
--***************************************
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--For some renovation reasons, a classroom is not available. Hence the department has to shift the scheduled course to a new classroom
--pr2.ChangeClassroom first checks is if the course is present in the course schedule
--It then checks to see if the new classroom exists
--The third check is to see if the new class is the same as the one undergoing renovation
--After all the checks, it will check for the capacity of the class and the scheduled course, based on the comparison the classroom is either assigned or an error message is shown
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE pr2.ChangeClassroom(@courseCode AS VARCHAR(20), @courseNumber AS INT, @newClass AS VARCHAR(20))
AS
BEGIN
IF NOT EXISTS(SELECT * FROM pr2.CourseSchedule WHERE CourseCode = @courseCode AND CourseNumber = @courseNumber)
	BEGIN
	 PRINT 'Error: This course has not been assigned a classroom and is not a part of the course schedule.'
	 RETURN
	END
	ELSE IF NOT EXISTS(SELECT * FROM pr2.Classroom WHERE ClassroomId = @newClass)
	BEGIN
	  PRINT 'Error: The classroom does not exist.'
	  RETURN
	END
	ELSE IF EXISTS(SELECT * FROM pr2.CourseSchedule WHERE CourseCode = @courseCode AND CourseNumber = @courseNumber AND Classroom=@newClass)
	BEGIN
	  PRINT 'Error: This is the classroom under renovation. Please select a new classroom'
	  RETURN
	END
	ELSE 
	BEGIN
	   DECLARE @courseCapacity AS INT;
	   DECLARE @classCapacity AS VARCHAR(20);
	   SET @courseCapacity = (SELECT Capacity FROM pr2.CourseSchedule WHERE CourseCode = @courseCode AND CourseNumber = @courseNumber);
	   SET @classCapacity = (SELECT MaximumSeating FROM pr2.Classroom WHERE ClassroomId = @newClass);
	   IF @classCapacity > @courseCapacity
	   BEGIN
	   UPDATE pr2.CourseSchedule
	   SET Classroom = @newClass
	   WHERE CourseCode = @courseCode 
	   AND 
	   CourseNumber = @courseNumber
	   PRINT 'The new class has been assigned successfully'
	   END
	   ELSE
	   BEGIN
	   PRINT 'Error: New class does not have sufficient capacity to accomodate students of the course'
	   END
	END
END;

--Error message 1
--EXEC pr2.ChangeClassroom 'CS', 623, '02-HBS';
--Error message 2
--EXEC pr2.ChangeClassroom 'CS', 675, '02-HBS';
--Error message 3
--EXEC pr2.ChangeClassroom 'CS', 675, '02-HBC';
--Error message 4
--EXEC pr2.ChangeClassroom 'CE', 681, '02-HBC';
--Success message(Excecuted, so now it will be error meesage 3)
--EXEC pr2.ChangeClassroom 'IM', 610, '02-HBC';
	
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--The procedure pr2.EnrollStudent is used to enroll a student into a course 
--It first checks if the course is available by checking the Course Schedule table
--The second check is for if the student's records exist in the database
--The third check is for if the student is already enrolled for the same course
--The fourth check is for the student's status, if he's eligible to enroll
--After all the checks are passed, the student is enrolled by inserting the details in the pr2.EnrolledStudents table
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE pr2.EnrollStudent(@courseCode AS VARCHAR(20), @courseNumber AS INT, @semester AS INT, @studentId AS INT)
AS
BEGIN 
DECLARE @semesterName AS VARCHAR(50)
DECLARE @studentStatus AS INT
 IF NOT EXISTS(SELECT * FROM pr2.CourseSchedule WHERE CourseCode = @courseCode AND CourseNumber = @courseNumber AND Semester = @semester)
	BEGIN
	 SET @semesterName=(SELECT Semester FROM pr2.Semesters WHERE SemesterId=@semester)
	 PRINT 'Error: This course is not available for the'+' '+@semesterName+' '+'semester'
	 RETURN
	END
ELSE IF NOT EXISTS(SELECT * FROM pr2.Students WHERE StudentId=@studentId)
	BEGIN
	  PRINT 'Error: The student details are incorrect'
	  RETURN
	END
ELSE IF EXISTS(SELECT * FROM pr2.EnrolledStudents WHERE StudentId=@studentId AND CourseId IN (SELECT CourseScheduleId FROM pr2.CourseSchedule WHERE CourseCode = @courseCode AND CourseNumber = @courseNumber AND Semester = @semester))
	BEGIN
	  PRINT 'Error: Student is already enrolled for this course'
	  RETURN
	END
ELSE 
	BEGIN
	  SET @studentStatus=(SELECT Status FROM pr2.Students WHERE StudentId=@studentId)
	  IF @studentStatus = 5 OR @studentStatus = 6
		BEGIN
		PRINT 'Error: Student is ineligible to be enrolled for this course'
		END
	  ELSE 
		 BEGIN
			DECLARE @CourseId AS INT
			SET @CourseId=(SELECT CourseScheduleId FROM pr2.CourseSchedule WHERE CourseCode = @courseCode AND CourseNumber = @courseNumber AND Semester = @semester)
			INSERT INTO pr2.EnrolledStudents(CourseId,StudentId,Status,Grade) 
			VALUES(@CourseId, @studentId, 2, NULL);
			PRINT 'Student has successfully been enrolled in the requested course'
		 END
	  RETURN
	END
END;

--Error Message 1
--EXEC pr2.EnrollStudent 'MA', 654, 1, 3;
--Error Message 2
--EXEC pr2.EnrollStudent 'MA', 654, 3, 11;
--Error Message 3
--EXEC pr2.EnrollStudent 'MA', 654, 3, 2;
--Error Message 4
--EXEC pr2.EnrollStudent 'MA', 654, 3, 1;
--Success Message(already executed so it will be error message 3 now)
--EXEC pr2.EnrollStudent 'MA', 654, 3, 3;

--Functions(2 functions):
--***********************
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--Function to display  the names of only those employees who have students under them.
----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION pr2.EmployeeAndStudentCount()
	RETURNS @return TABLE(FacultyName VARCHAR(100), NumberOfStudents INT)
	BEGIN
		INSERT INTO @return
		SELECT pr2.People.FirstName + ' ' + pr2.People.LastName AS "FacultyName", COUNT(*) AS "NoOfStudents"
				FROM pr2.EnrolledStudents INNER JOIN pr2.CourseSchedule
				ON pr2.EnrolledStudents.CourseId = pr2.CourseSchedule.CourseScheduleId
				INNER JOIN pr2.TeachingAssignment
				ON pr2.TeachingAssignment.CourseScheduleId = pr2.CourseSchedule.CourseScheduleId
				INNER JOIN pr2.Employees
				ON pr2.TeachingAssignment.EmployeeId = pr2.Employees.EmployeeId
				INNER JOIN pr2.People
				ON pr2.People.PersonId = pr2.Employees.PersonId
				GROUP BY pr2.People.FirstName + ' ' + pr2.People.LastName
		RETURN
	END;
	--SELECT * FROM pr2.EmployeeAndStudentCount();
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--Function to display  the names of only those students who have taken courses and the number of courses they have enrolled into.
----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION pr2.StudentAndCourseCount()
	RETURNS @return TABLE(StudentName VARCHAR(100), NumberOfCourses INT)
	BEGIN
		INSERT INTO @return
		SELECT pr2.People.FirstName + ' ' + pr2.People.LastName AS "Student Name", COUNT(*) AS "NoOfCoursesTaken"
			FROM pr2.EnrolledStudents INNER JOIN pr2.CourseSchedule
				ON pr2.EnrolledStudents.CourseId = pr2.CourseSchedule.CourseScheduleId
				INNER JOIN pr2.Students
				ON pr2.EnrolledStudents.StudentId = pr2.Students.StudentId
				INNER JOIN pr2.People
				ON pr2.People.PersonId = pr2.Students.PersonId
			GROUP BY pr2.People.FirstName + ' ' + pr2.People.LastName
		RETURN
	END;

	--SELECT * FROM pr2.StudentAndCourseCount();


