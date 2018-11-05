create or replace trigger lection_theme_del 
before delete 
on LECTION_THEME
DECLARE
x NUMBER;
begin 
    select count(*) into x
    from LECTION_THEME;
    if x < 4 THEN
        raise_application_error(-20000,'Theme less than 4');
    end if;
end;

delete from LECTION_THEME where LECTION_NAME = 'Math logarithm';

