CREATE OR REPLACE PACKAGE lection_theme_package IS type rowlection_theme is RECORD( u_theme lection_theme.lection_name%TYPE);
    TYPE tbl_lection_theme IS
        TABLE OF rowlection_theme;
    FUNCTION get_lection_theme 
    RETURN tbl_lection_theme
        PIPELINED;

    PROCEDURE add_theme (
        u_theme   IN lection_theme.lection_name%TYPE
    );

    PROCEDURE del_theme (
        u_theme   IN lection_theme.lection_name%TYPE
    );

    PROCEDURE update_theme (
        new_theme   IN lection_theme.lection_name%TYPE,
        old_theme   IN lection_theme.lection_name%TYPE
    );
end lection_theme_package;
/
    
CREATE OR REPLACE PACKAGE BODY lection_theme_package IS 
    
    FUNCTION get_lection_theme 
    RETURN tbl_lection_theme
        PIPELINED
        is
        
        cursor lection_cur is 
        select *
        from LECTION_THEME;
        begin
        for cur in lection_cur
        loop
            pipe row(cur);
        end loop;
    end get_lection_theme;
    
    PROCEDURE add_theme (
        u_theme   IN lection_theme.lection_name%TYPE
    ) is
    begin
    INSERT INTO LECTION_THEME
    (LECTION_NAME) VALUES ( u_theme );
    end add_theme;
    
    PROCEDURE del_theme (
        u_theme   IN lection_theme.lection_name%TYPE
    ) is
    begin
        delete from LECTION_THEME
        where LECTION_NAME = u_theme;
    end del_theme;

    PROCEDURE update_theme (
        new_theme   IN lection_theme.lection_name%TYPE, 
        old_theme IN lection_theme.lection_name%TYPE
    ) IS BEGIN
    UPDATE lection_theme
        SET
            lection_name = new_theme
    WHERE
        lection_name = old_theme;

END update_theme; 
end lection_theme_package;
/