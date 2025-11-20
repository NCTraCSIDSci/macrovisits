/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

CREATE TABLE hcpc_list AS
SELECT visit_occurrence_id, 
    max(hcpc_office) as max_hcpc_office, 
    sum(hcpc_office) as sum_hcpc_office,
    max(hcpc_er) as max_hcpc_er,
    sum(hcpc_er) as sum_hcpc_er,
    max(hcpc_obs) as max_hcpc_obs,
    sum(hcpc_obs) as sum_hcpc_obs,
    max(hcpc_inpt) as max_hcpc_inpt,
    sum(hcpc_inpt) as sum_hcpc_inpt,
    max(hcpc_icu) as max_hcpc_icu,
    sum(hcpc_icu) as sum_hcpc_icu,
    max(cms_inpt_hcpc) as max_cms_inpt,
    sum(cms_inpt_hcpc) as sum_cms_inpt
FROM hcpc_groups
group by visit_occurrence_id

