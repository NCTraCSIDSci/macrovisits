# Macrovisits

## Summary
Logic and code used to build macrovisits & high confidence hospitalizations in N3C's OMOP encounters data.  

This work was necessitated by the large amount of heterogeneity in site encounters data in the N3C harmonized OMOP visit_occurrence table.  I believe this large heterogeneity is a result of:

--a current OMOP design strategy to not bring in site EHR source values for facility visit identifiers (e.g. the account number from EPIC vs the encounter number)
--implementation and configuration differences in site EHR encounter design
--OMOP encounter to visit_occurrence mapping differences between sites

The end result of this in the initial visit_occurrence table was an inability to confidently differentiate between inpatient and non-inpatient visits.  

The initial portion of the program (the scaffold programs) was the initial programmatic post-hoc remediation to try to re-identify longitudinal visits by re-bundling the atomic visit components into longitudinal visits.  Atomic visit components (or microvisits) after bundling were re-numbered with distinct primary keys in the 'macrovisit_to_microvisit' table.  However, upon further analysis it was clear that while some macrovisits were hospitaliations other macrovisits were likely some other type of longitudinal visit or multi-service facility visit that wsa not inpatient status.  

The rest of the program (files 1a through 9b) then calculates a large amount of inpatient-focused encounter metadata to subsequently classify macrovisits as likely inpatient hospitalizations or flag other pertinent aspects of interest on the macrovisit.  

This code was developed and tuned focused on the OMOP visit_occurrence data occurring in the N3C enclave and the identified issues and heterogeneity in those data.  Some program modifications will likely be necessary and performance of this approach is unknown in other OMOP-based data systems. 

For more information on the underlying issues that led to macrovisit development, and the quantified results of applying this solution refer to our paper on this topic:  

"Clinical encounter heterogeneity and methods for resolving in networked EHR data: a study from N3C and RECOVER programs"
https://academic.oup.com/jamia/article-abstract/30/6/1125/7136721
