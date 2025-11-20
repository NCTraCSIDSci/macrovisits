/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/
--include many other metadata columns commented out in case there's a future need for any of them

CREATE TABLE macrovisit_fact AS
    SELECT distinct b.person_id,
        a.*,
        b.max_resources,
        b.covid_dx,
        --b.sno_er,
        --b.sno_icu,
        --b.sno_inpt,
        --b.sno_obs,
        --b.sno_office,
        --max_hcpc_office,
        --max_sum_hcpc_office,
        --max_hcpc_er,
        --max_sum_hcpc_er,
        --max_hcpc_obs,
        --max_sum_hcpc_obs,
        --max_hcpc_inpt,
        --max_sum_hcpc_inpt,
        --max_hcpc_icu,
        --max_sum_hcpc_icu
        b.drg,
        b.max_dx_count,
        b.max_proc_count,
        b.max_meas_count,
        b.max_obs_count,
        b.max_cms_inpt,
        b.max_sum_cms_inpt,
        c.all_office,
        c.all_er, 
        c.all_obs,
        c.all_inpt,
        c.all_icu,
        c.resources_bucket,
        d.likely_hospitalization
FROM microvisit_flags a LEFT JOIN macro_create_resources b on a.macrovisit_id = b.macrovisit_id
                        LEFT JOIN macro_filter c on a.macrovisit_id = c.macrovisit_id
                        LEFT JOIN hospital_list d on a.macrovisit_id = d.macrovisit_id



