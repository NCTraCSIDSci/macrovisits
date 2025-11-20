/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/
    --for sites that put hcpcs at beginning of strings

CREATE TABLE beg_hcpcs AS
select * from (

SELECT *, regexp_extract(procedure_source_value, '(^[A-Z]{1}[0-9]+|^[0-9]+)') as hcpc
FROM omop.procedure_occurrence
where data_partner_id in ( )

) a 
where length(hcpc)=5

