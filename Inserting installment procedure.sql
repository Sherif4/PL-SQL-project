create or replace procedure insert_installments(v_id number, v_amount number, v_ins_no number)
is
    v_startdate date;       v_type varchar2(40);
    v_count number(2) :=1;
begin
    select CONTRACT_STARTDATE, CONTRACT_PAYMENT_TYPE
    into v_startdate, v_type
    from contracts
    where contract_id= v_id;
    
    case v_type
        when 'ANNUAL' then
            for v_count in 1 .. v_ins_no loop
                insert into installments_paid values
                (INSTALLMENTS_PAID_SEQ.nextval, v_id, v_startdate, v_amount,0);
                v_startdate := add_months(v_startdate, 12);
            end loop;
        when 'QUARTER' then
            for v_count in 1 .. v_ins_no loop
                insert into installments_paid values
                (INSTALLMENTS_PAID_SEQ.nextval, v_id, v_startdate, v_amount,0);
                v_startdate := add_months(v_startdate, 3);
            end loop;
        when 'HALF_ANNUAL' then
            for v_count in 1 .. v_ins_no loop
                insert into installments_paid values
                (INSTALLMENTS_PAID_SEQ.nextval, v_id, v_startdate, v_amount,0);
                v_startdate := add_months(v_startdate, 6);
            end loop;
        when 'MONTHLY' then
            for v_count in 1 .. v_ins_no loop
                insert into installments_paid values
                (INSTALLMENTS_PAID_SEQ.nextval, v_id, v_startdate, v_amount,0);
                v_startdate := add_months(v_startdate, 1);
            end loop;
    end case;
end;

--show errors