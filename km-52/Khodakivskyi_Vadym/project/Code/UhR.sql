CREATE OR REPLACE PACKAGE uhr_package IS
    TYPE row_uhr IS RECORD ( u_id user_has_resourses.user_resourse_id%TYPE,
    u_nick user_has_resourses.author_nickname%TYPE,
    u_resourse user_has_resourses.resource_name%TYPE,
    u_date user_has_resourses."Date"%TYPE
    );
    TYPE tbl_uhr IS
        TABLE OF row_uhr;
    FUNCTION get_uhr (
        u_nick   IN user_has_resourses.author_nickname%TYPE DEFAULT NULL
    ) RETURN tbl_uhr
        PIPELINED;

    FUNCTION add_uhr (
        u_nick       IN user_has_resourses.author_nickname%TYPE,
        u_resourse   IN user_has_resourses.resource_name%TYPE
    ) RETURN VARCHAR2;

    PROCEDURE del_uhr (
        u_resourse   IN user_has_resourses.resource_name%TYPE
    );

    FUNCTION update_uhr (
        new_resourse   IN user_has_resourses.resource_name%TYPE,
        old_resourse   IN user_has_resourses.resource_name%TYPE
    ) RETURN VARCHAR2;

END uhr_package;
/

CREATE OR REPLACE PACKAGE BODY uhr_package IS

    FUNCTION get_uhr (
        u_nick   IN user_has_resourses.author_nickname%TYPE DEFAULT NULL
    ) RETURN tbl_uhr
        PIPELINED
    IS
        TYPE uhr_cursor_type IS REF CURSOR;
        uhr_cursor    uhr_cursor_type;
        cursor_data   row_uhr;
        query_str     VARCHAR2(1000);
    BEGIN
        query_str := 'SELECT * FROM USER_HAS_RESOURSES';
        IF
            u_nick IS NOT NULL
        THEN
            query_str := query_str
            || ' where TRIM(AUTHOR_NICKNAME) = trim('''
            || u_nick
            || ''')';
        END IF;

        OPEN uhr_cursor FOR query_str;

        LOOP
            FETCH uhr_cursor INTO cursor_data;
            EXIT WHEN ( uhr_cursor%notfound );
            PIPE ROW ( cursor_data );
        END LOOP;

    END get_uhr;

    FUNCTION add_uhr (
        u_nick       IN user_has_resourses.author_nickname%TYPE,
        u_resourse   IN user_has_resourses.resource_name%TYPE
    ) RETURN VARCHAR2 IS
        message   VARCHAR2(30);
    BEGIN
        message := 'ok';
        INSERT INTO user_has_resourses (
            user_resourse_id,
            author_nickname,
            resource_name,
            "Date"
        ) VALUES (
            uhr_id.NEXTVAL,
            u_nick,
            u_resourse,
            SYSDATE
        );

        COMMIT;
        RETURN message;
    EXCEPTION
        WHEN dup_val_on_index THEN
            message := 'this resourse already exist';
            RETURN message;
        WHEN OTHERS THEN
            message := 'you entered wrong data!!!';
            RETURN message;
    END add_uhr;

    PROCEDURE del_uhr (
        u_resourse   IN user_has_resourses.resource_name%TYPE
    )
        IS
    BEGIN
        DELETE FROM user_has_resourses WHERE
            resource_name = u_resourse;

        COMMIT;
    END del_uhr;

    FUNCTION update_uhr (
        new_resourse   IN user_has_resourses.resource_name%TYPE,
        old_resourse   IN user_has_resourses.resource_name%TYPE
    ) RETURN VARCHAR2 IS
        message   VARCHAR2(30);
    BEGIN
        message := 'ok';
        UPDATE user_has_resourses
            SET
                resource_name = new_resourse
        WHERE
            resource_name = old_resourse;

        COMMIT;
        RETURN message;
    EXCEPTION
        WHEN dup_val_on_index THEN
            message := 'this resourse already exist';
            RETURN message;
        WHEN OTHERS THEN
            message := 'you entered wrong data!!!';
            RETURN message;
    END update_uhr;

END uhr_package;
/