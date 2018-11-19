CREATE OR REPLACE PACKAGE information_package IS
    TYPE row_info IS RECORD ( i_id information.info_id%TYPE,
    i_nickname information.nickname%TYPE,
    i_lec_name information.lection_name%TYPE,
    i_resourse information.resource_name%TYPE,
    i_link information.information_link%TYPE,
    i_date information."Date"%TYPE );
    TYPE tbl_information IS
        TABLE OF row_info;
    FUNCTION get_information RETURN tbl_information
        PIPELINED;

    PROCEDURE add_info (
        i_id         IN information.info_id%TYPE,
        i_nickname   IN information.nickname%TYPE,
        i_lec_name   IN information.lection_name%TYPE,
        i_resourse   IN information.resource_name%TYPE,
        i_link       IN information.information_link%TYPE,
        i_date       IN information."Date"%TYPE
    );

    PROCEDURE del_info (
        i_nickname   IN information.nickname%TYPE
    );

END information_package;
/

CREATE OR REPLACE PACKAGE BODY information_package IS 
    FUNCTION get_information 
    RETURN tbl_information
    PIPELINED
    IS
    cursor info_cur IS 
    SELECT
            *
    FROM
            information;
    BEGIN
        FOR cur IN info_cur LOOP
            PIPE ROW ( cur );
        END LOOP;
END get_information;

    PROCEDURE add_info (
        i_id         IN information.info_id%TYPE,
        i_nickname   IN information.nickname%TYPE,
        i_lec_name   IN information.lection_name%TYPE,
        i_resourse   IN information.resource_name%TYPE,
        i_link       IN information.information_link%TYPE,
        i_date       IN information."Date"%TYPE
    )
        IS
    BEGIN
        INSERT INTO information (
            info_id,
            nickname,
            lection_name,
            resource_name,
            information_link,
            "Date"
        ) VALUES (
            i_id,
            i_nickname,
            i_lec_name,
            i_resourse,
            i_link,
            i_date
        );

    END add_info;

    PROCEDURE del_info (
        i_nickname   IN information.nickname%TYPE
    )
        IS
    BEGIN
        DELETE FROM information
        WHERE
            information.nickname = i_nickname;

    END del_info;

end information_package;
/
