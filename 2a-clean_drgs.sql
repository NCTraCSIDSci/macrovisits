/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

--take out apparent blank drg observations & HCPC 99072 that includes 'DRG'
--also deduplicate observations where multiple DRGs (eg, APR & MS) are submitted for same visit

CREATE TABLE clean_drgs AS
select * from (

SELECT distinct *, row_number() over (partition by person_id order by observation_source_value) as row
FROM omop.observations
where observation_source_value !='DRGID:   DRG:'
and observation_source_value !='99072|PR ADDL SUPL MATRL&STAF TM DRG PHE RES-TR NF'
and observation_source_value is not null

) a 
where row=1

