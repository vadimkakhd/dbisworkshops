CREATE OR REPLACE PACKAGE uht_package IS
    TYPE row_uht IS RECORD ( u_id user_has_theme.user_theme_id%TYPE,
    u_nick user_has_theme.author_nickname%TYPE,
    u_theme user_has_theme.lection_name%TYPE,
    u_date user_has_theme."Date"%TYPE );
    TYPE tbl_uht IS
        TABLE OF row_uht;
    FUNCTION get_uht (
        u_nick   IN user_has_theme.author_nickname%TYPE DEFAULT NULL
    ) RETURN tbl_uht
        PIPELINED;

    FUNCTION add_uht (
        u_nick    IN user_has_theme.author_nickname%TYPE,
        u_theme   IN user_has_theme."Date"%TYPE
    ) RETURN VARCHAR2;

    PROCEDURE del_uht (
        u_theme   IN user_has_theme.lection_name%TYPE
    );

    FUNCTION update_uht (
        new_theme   IN user_has_theme.lection_name%TYPE,
        old_theme   IN user_has_theme.lection_name%TYPE
    ) RETURN VARCHAR2;

END uht_package;
/

CREATE OR REPLACE PACKAGE BODY uht_package IS

    FUNCTION get_uht (
        u_nick   IN user_has_theme.author_nickname%TYPE DEFAULT NULL
    ) RETURN tbl_uht
        PIPELINED
    IS
        TYPE uht_cursor_type IS REF CURSOR;
        uht_cursor    uht_cursor_type;
        cursor_data   row_uht;
        query_str     VARCHAR2(1000);
    BEGIN
        query_str := 'SELECT * FROM USER_HAS_THEME';
        IF
            u_nick IS NOT NULL
        THEN
            query_str := query_str
            || ' where TRIM(AUTHOR_NICKNAME) = trim('''
            || u_nick
            || ''')';
        END IF;

        OPEN uht_cursor FOR query_str;

        LOOP
            FETCH uht_cursor INTO cursor_data;
            EXIT WHEN ( uht_cursor%notfound );
            PIPE ROW ( cursor_data );
        END LOOP;

    END get_uht;

    FUNCTION add_uht (
        u_nick    IN user_has_theme.author_nickname%TYPE,
        u_theme   IN user_has_theme."Date"%TYPE
    ) RETURN VARCHAR2 IS
        message   VARCHAR2(30);
    BEGIN
        message := 'ok';
        INSERT INTO USER_HAS_THEME (
            USER_THEME_ID,
            author_nickname,
            LECTION_NAME,
            "Date"
        ) VALUES (
            uht_id.NEXTVAL,
            u_nick,
            u_theme,
            SYSDATE
        );

        COMMIT;
        RETURN message;
    EXCEPTION
        WHEN dup_val_on_index THEN
            message := 'this theme already exist';
            RETURN message;
        WHEN OTHERS THEN
            message := 'you entered wrong data!!!';
            RETURN message;
    END add_uht;

    PROCEDURE del_uht (
        u_theme   IN user_has_theme.lection_name%TYPE
    )
        IS
    BEGIN
        DELETE FROM user_has_theme WHERE
            lection_name = u_theme;

        COMMIT;
    END del_uht;

    FUNCTION update_uht (
        new_theme   IN user_has_theme.lection_name%TYPE,
        old_theme   IN user_has_theme.lection_name%TYPE
    ) RETURN VARCHAR2 IS
        message   VARCHAR2(30);
    BEGIN
        message := 'ok';
        UPDATE user_has_theme
            SET
                lection_name = new_theme
        WHERE
            lection_name = old_theme;

        COMMIT;
        RETURN message;
    EXCEPTION
        WHEN dup_val_on_index THEN
            message := 'this theme already exist';
            RETURN message;
        WHEN OTHERS THEN
            message := 'you entered wrong data!!!';
            RETURN message;
    END update_uht;

END uht_package;
/