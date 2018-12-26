create or replace view information_view as
select *
from INFORMATION;
/

CREATE or replace TRIGGER trg_delete_info
    instead of delete on information_view
    REFERENCING OLD as deleted_row
    for each ROW
    begin
        :deleted_row.deleted := CURRENT_TIMESTAMP;
    end;
/