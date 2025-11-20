/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

--apply various filters to try to clean macrovisits
--ignore small subset of sites whose data is too low quality


CREATE TABLE macro_filter AS
select A.*,
concat(resources_bucket,'-',concat(all_office, all_er, all_obs, all_inpt, all_icu)) as resource_group,
concat(data_partner_id, resources_bucket) as site_resources,
concat(all_office, all_er, all_obs, all_inpt, all_icu) as all_group, 
case when max_resources>25 or all_inpt=1 or all_icu=1 then 1 else 0 end as likely_hospitalization,
concat(any_inpt,"-",resources_bucket) as inpt_w_resources from (
    
SELECT *,
case when los between 11 and 19 then '>=11' 
     when los between 20 and 29 then '>=20'
     when los between 30 and 39 then '>=30'
     when los between 40 and 49 then '>=40'
     when los>=50 then '>=50'
     else los end as los_bucket, 

case when max_resources is null then '0'
     when max_resources= 0 then '0'
     when max_resources between 1 and 25 then '1-25'
     when max_resources between 26 and 50 then '26-50'
     when max_resources between 51 and 75 then '51-75'
     when max_resources between 76 and 100 then '76-100'
     else '100+' end as resources_bucket, 
     
     concat(max_hcpc_office, max_hcpc_er, max_hcpc_obs, max_hcpc_inpt, max_hcpc_icu) as hcpc_group,
     concat(sno_office, sno_er, sno_obs, sno_inpt, sno_icu) as sno_group,

     case when max_hcpc_office+sno_office>0 then 1 else 0 end as all_office,
     case when max_hcpc_er+sno_er>0 then 1 else 0 end as all_er,
     case when max_hcpc_obs+sno_obs>0 then 1 else 0 end as all_obs,
     case when max_hcpc_inpt+sno_inpt>0 then 1 else 0 end as all_inpt,
     case when max_hcpc_icu+sno_icu>0 then 1 else 0 end as all_icu,

     case when max_hcpc_inpt+sno_inpt+max_hcpc_icu+sno_icu>0 then 1 else 0 end as any_inpt, 

     case when max_resources>25 then 1 else 0 end as final_a,
     case when max_hcpc_inpt+sno_inpt>0 or max_hcpc_icu+sno_icu>0 then 1 else 0 end as final_b

FROM macro_create_resources
) A
--where data_partner_id not in ( )
--and (drg is not null or max_cms_inpt=1 or max_resources>=50 or all_inpt=1 or all_icu=1)

--where concat(data_partner_id, resources_bucket) not in (  )
--where drg is not null or all_inpt=1 or all_icu=1 or max_resources>=100
--max_resources>=26 or all_inpt=1 or all_icu=1 or
--where (hcpc_inpt='1' or sno_inpt='1' or hcpc_icu='1' or sno_icu ='1') or max_resources>25

--where data_partner_id not in (  )

