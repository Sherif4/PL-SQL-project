select * from installments_paid;

set serveroutput on
declare
    cursor contracts_cur is
    select * from contracts;
    v_installment_no number(3);     v_installment_amount number (8,2);
    v_months number (4);
begin
    for v_contracts_record in contracts_cur loop
        v_months := months_between(v_contracts_record.CONTRACT_ENDDATE, v_contracts_record.CONTRACT_STARTDATE);
        v_installment_no := calc_installments_no(v_months, v_contracts_record.CONTRACT_PAYMENT_TYPE);
        v_installment_amount := calc_installment(v_contracts_record.CONTRACT_TOTAL_FEES, 
                                v_contracts_record.CONTRACT_DEPOSIT_FEES, v_installment_no);
        insert_installments(v_contracts_record.contract_id, v_installment_amount, v_installment_no);
       -- dbms_output.put_line(v_contracts_record.CONTRACT_ID||', number of installments: '||v_installment_no||
        --                     ', installment_amount: '||v_installment_amount);
    end loop;
end;

select * from installments_paid;
