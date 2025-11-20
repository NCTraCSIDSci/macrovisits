/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

--aggregate binary proc-visit flags up up to the visit level
--deprecate hcpc flags and update to concept only

CREATE TABLE visit_snomed AS
SELECT distinct visit_occurrence_id, 
                --max(hcpc_anes) as hcpc_anes, 
                --max(hcpc_er) as hcpc_er, 
                --max(hcpc_icu) as hcpc_icu, 
                --max(hcpc_inpt) as hcpc_inpt, 
                --max(hcpc_obs) as hcpc_obs, 
                --max(hcpc_office) as hcpc_office,
                max(sno_er) as sno_er,
                max(sno_icu) as sno_icu,
                max(sno_inpt) as sno_inpt,
                max(sno_obs) as sno_obs,
                max(sno_office) as sno_office
FROM visits_with_procs
group by visit_occurrence_id

