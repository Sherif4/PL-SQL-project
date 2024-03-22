create or replace function calc_installment (v_total_fees number, v_deposit number, v_installments_no number)
return number
is
    v_fees number(20,2);
begin
    if v_deposit is null then
        v_fees := v_total_fees / v_installments_no;
    else 
         v_fees := (v_total_fees - v_deposit) / v_installments_no;
    end if;
return v_fees;
end;
show errors