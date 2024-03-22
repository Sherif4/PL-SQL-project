create or replace function calc_installments_no (v_months number, v_type varchar2)
return number
is
    v_in_number number (5);
begin
    if v_type = 'ANNUAL' then
        v_in_number := v_months /12; 
    elsif v_type = 'QUARTER' then
        v_in_number := v_months /3;
    elsif v_type = 'HALF_ANNUAL' then
        v_in_number := v_months/6;
    else 
        v_in_number := v_months;
    end if;
    
    return v_in_number;
end;

show errors