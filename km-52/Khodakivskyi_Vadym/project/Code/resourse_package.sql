CREATE OR REPLACE PACKAGE resourse_package IS type rowresourse is RECORD( u_resourse resourse.resource_name%TYPE);
    TYPE tbl_resourse IS
        TABLE OF rowresourse;
    FUNCTION get_resourse 
    RETURN tbl_resourse
        PIPELINED;

    PROCEDURE add_resourse (
        u_resourse in RESOURSE.RESOURCE_NAME%TYPE
    );

    PROCEDURE del_resourse (
        u_resourse in RESOURSE.RESOURCE_NAME%TYPE
    );

    PROCEDURE update_resourse (
        new_resourse in RESOURSE.RESOURCE_NAME%TYPE,
        old_resourse in RESOURSE.RESOURCE_NAME%TYPE
    );
end resourse_package;
/
    
CREATE OR REPLACE PACKAGE BODY resourse_package IS 
    
    FUNCTION get_resourse 
    RETURN tbl_resourse
        PIPELINED
        is
        
        cursor resourse_cur is 
        SELECT resourse.RESOURCE_NAME    
        from resourse;
        begin
        for cur in resourse_cur
        loop
            pipe row(cur);
        end loop;
    end get_resourse;
    
    PROCEDURE add_resourse (
        u_resourse in RESOURSE.RESOURCE_NAME%TYPE
    ) is
    begin
    INSERT INTO RESOURSE
    (RESOURCE_NAME) VALUES ( u_resourse );
    end add_resourse;
    
    PROCEDURE del_resourse (
        u_resourse in RESOURSE.RESOURCE_NAME%TYPE
    ) is
    begin
        delete from RESOURSE
        where RESOURCE_NAME = u_resourse;
    end del_resourse;

    PROCEDURE update_resourse (
        new_resourse in RESOURSE.RESOURCE_NAME%TYPE,
        old_resourse in RESOURSE.RESOURCE_NAME%TYPE
    ) IS BEGIN
    UPDATE RESOURSE
        SET
            RESOURCE_NAME = new_resourse
    WHERE
        RESOURCE_NAME = old_resourse;
    END update_resourse;
    
end resourse_package;
/