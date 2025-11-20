/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

--join macrovisits to visit-level counts of resources
--this creates duplicates of macrovists that will be subsequently de-duplicated


CREATE TABLE macrovisit_meta AS
SELECT distinct a.*, 
                b.dx_count, 
                c.drug_count, 
                d.proc_count, 
                e.meas_count, 
                f.obs_count, 
                g.covid_dx,
                --h.hcpc_anes, 
                --h.hcpc_er, 
                --h.hcpc_icu, 
                --h.hcpc_inpt, 
                --h.hcpc_obs, 
                --h.hcpc_office,
                h.sno_er,
                h.sno_icu,
                h.sno_inpt,
                h.sno_obs,
                h.sno_office,
                i.drg, 
                i.value_as_concept_name,
                j.cms_inpt, 
                k.max_cms_inpt,
                k.sum_cms_inpt,
                k.max_hcpc_office,
                k.sum_hcpc_office,
                k.max_hcpc_er,
                k.sum_hcpc_er,
                k.max_hcpc_obs,
                k.sum_hcpc_obs,
                k.max_hcpc_inpt,
                k.sum_hcpc_inpt,
                k.max_hcpc_icu,
                k.sum_hcpc_icu
 --case when lower(visit_concept_name) like ('%inpa%') then 1 end as inpt_visit,

FROM processed_microvisits_to_macrovisits a LEFT JOIN dx_count b on a.visit_occurrence_id = b.visit_occurrence_id
                                    LEFT JOIN drug_count c on a.visit_occurrence_id = c.visit_occurrence_id
                                    LEFT JOIN proc_count d on a.visit_occurrence_id = d.visit_occurrence_id
                                    LEFT JOIN meas_count e on a.visit_occurrence_id = e.visit_occurrence_id
                                    LEFT JOIN obs_count f on a.visit_occurrence_id = f.visit_occurrence_id
                                    LEFT JOIN visit_with_covid g on a.visit_occurrence_id = g.visit_occurrence_id
                                    LEFT JOIN visit_snomed h on a.visit_occurrence_id = h.visit_occurrence_id
                                    LEFT JOIN clean_drgs i on a.visit_occurrence_id = i.visit_occurrence_id
                                    LEFT JOIN inpt_hcpc_list j on a.visit_occurrence_id = j.visit_occurrence_id
                                    LEFT JOIN hcpc_list k on a.visit_occurrence_id = k.visit_occurrence_id
where macrovisit_id is not null
order by person_id, visit_start_date

