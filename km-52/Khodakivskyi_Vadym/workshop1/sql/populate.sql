INSERT INTO "User"
(LOGIN, PASS, NICKNAME, NAME, FACULTY_NAME, COURSE_NUMBER)VALUES
('vadya', 'vadya', 'vadimka', 'Vadym', 'Applied mathematics', 4);

INSERT INTO "User"
(LOGIN, PASS, NICKNAME, SURNAME, FACULTY_NAME, COURSE_NUMBER)VALUES
('petua228', '234', 'Petya', 'Petrov', 'Applied mathematics', 3);

INSERT INTO "User"
(LOGIN, PASS, NICKNAME, FACULTY_NAME, COURSE_NUMBER)VALUES
('vALERA', '17151978', 'valeron', 'IASA', 2);

INSERT INTO "User"
(LOGIN, PASS, NICKNAME, NAME, SURNAME, FACULTY_NAME, COURSE_NUMBER)VALUES
('HEDGHOG', 'asdfgh', 'flaffy', 'Fedor', 'Ivanov', 'FBMI', 1);

INSERT INTO RESOURSE
(RESOURCE_NAME)VALUES ('www.wikipedia.ua');

INSERT INTO RESOURSE
(RESOURCE_NAME) VALUES ('www.studhelp.ua');

INSERT INTO RESOURSE
(RESOURCE_NAME) VALUES ('www.studpedia.ua');

INSERT INTO RESOURSE
(RESOURCE_NAME) VALUES ('www.pidruchniki.ua');

INSERT INTO LECTION_THEME
(LECTION_NAME) VALUES ('Math logarithm');

INSERT INTO LECTION_THEME
(LECTION_NAME) VALUES ('Integration methods');

INSERT INTO LECTION_THEME
(LECTION_NAME) VALUES ('Programming on Python');

INSERT INTO LECTION_THEME
(LECTION_NAME) VALUES ('Numerical methods');

INSERT INTO "User has lection theme"
(LECTION_NAME, NICKNAME) values ('Math logarithm', 'vadimka');

INSERT INTO "User has lection theme"
(LECTION_NAME, NICKNAME) values ('Math logarithm', 'flaffy');

INSERT INTO "User has lection theme"
(LECTION_NAME, NICKNAME) values ('Programming on Python', 'vadimka');

INSERT INTO "User has lection theme"
(LECTION_NAME, NICKNAME) values ('Integration methods', 'valeron');

INSERT INTO "User has resourses"
(RESOURCE_NAME, NICKNAME) values ('www.wikipedia.ua', 'vadimka');

INSERT INTO "User has resourses"
(RESOURCE_NAME, NICKNAME) values ('www.studpedia.ua', 'flaffy');

INSERT INTO "User has resourses"
(RESOURCE_NAME, NICKNAME) values ('www.studpedia.ua', 'Petya');

INSERT INTO "User has resourses"
(RESOURCE_NAME, NICKNAME) values ('www.pidruchniki.ua', 'valeron');

INSERT INTO INFORMATION
(NICKNAME,LECTION_NAME,RESOURCE_NAME,INFORMATION_LINK, "Date") 
VALUES 
('valeron', 'Integration methods', 'www.pidruchniki.ua', 'https://telegra.ph/Integration-methods',TO_DATE('2003/05/03', 'yyyy/mm/dd'));

INSERT INTO INFORMATION
(NICKNAME,LECTION_NAME,RESOURCE_NAME,INFORMATION_LINK, "Date") 
VALUES 
('Petya', 'Programming on Python', 'www.studpedia.ua', 'https://telegra.ph/Programming-on-Python',TO_DATE('2005/05/03', 'yyyy/mm/dd'));

INSERT INTO INFORMATION
(NICKNAME,LECTION_NAME,RESOURCE_NAME,INFORMATION_LINK, "Date") 
VALUES 
('vadimka', 'Math logarithm', 'www.wikipedia.ua', 'https://telegra.ph/Math-logarithm',TO_DATE('2005/05/03', 'yyyy/mm/dd'));

INSERT INTO INFORMATION
(NICKNAME,LECTION_NAME,RESOURCE_NAME,INFORMATION_LINK, "Date") 
VALUES 
('flaffy', 'Programming on Python', 'www.wikipedia.ua', 'https://telegra.ph/Programming-on-Python',TO_DATE('2005/05/03', 'yyyy/mm/dd'));