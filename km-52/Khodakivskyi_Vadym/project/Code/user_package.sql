CREATE OR REPLACE PACKAGE user_package IS
    PROCEDURE add_user (
        u_nickname   IN "User".nickname%TYPE,
        u_login      IN "User".login%TYPE,
        u_pass       IN "User".pass%TYPE,
        u_name       IN "User".name%TYPE,
        u_surname    IN "User".surname%TYPE,
        u_faculty    IN "User".faculty_name%TYPE,
        u_course     IN "User".course_number%TYPE
    );

    PROCEDURE deluser (
        u_nickname   IN "User".nickname%TYPE
    );

END user_package;
/

CREATE OR REPLACE PACKAGE BODY user_package IS

    PROCEDURE add_user (
        u_nickname   IN "User".nickname%TYPE,
        u_login      IN "User".login%TYPE,
        u_pass       IN "User".pass%TYPE,
        u_name       IN "User".name%TYPE,
        u_surname    IN "User".surname%TYPE,
        u_faculty    IN "User".faculty_name%TYPE,
        u_course     IN "User".course_number%TYPE
    )
        IS
    BEGIN
        INSERT INTO "User" (
            login,
            pass,
            nickname,
            name,
            surname,
            faculty_name,
            course_number
        ) VALUES (
            u_login,
            u_pass,
            u_nickname,
            u_name,
            u_surname,
            u_faculty,
            u_course
        );

    END add_user;

    PROCEDURE deluser (
        u_nickname   IN "User".nickname%TYPE
    )
        IS
    BEGIN
        DELETE FROM "User"
        WHERE
            "User".nickname = u_nickname;

    END deluser;

END user_package;
/