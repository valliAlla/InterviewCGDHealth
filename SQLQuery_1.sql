USE cgd;

SELECT cdm_version, vocabulary_version FROM dbo.cdm_source;

SELECT  concept_id FROM dbo.concept WHERE concept_code='I48.0';


SELECT  * FROM dbo.concept WHERE concept_name='Epoetin Alfa' AND domain_id='Drug' AND concept_class_id='Ingredient';

SELECT * FROM concept_relationship WHERE concept_id_1=(SELECT concept_id FROM concept WHERE concept_code='105694');


SELECT * FROM person WHERE person_id IN (SELECT person_id from condition_era WHERE condition_concept_id IN (SELECT concept_id from concept WHERE concept_name='Anemia' AND domain_id='Condition'));

SELECT c.concept_name AS gender, COUNT(p.person_id) AS count FROM concept c JOIN person p ON c.concept_id=p.gender_concept_id GROUP BY c.concept_name;

SELECT * FROM person WHERE person_id IN (SELECT person_id from observation WHERE observation_date between '2009-01-01' and '2010-12-31');

SELECT * from person where person_id IN (select person_id from procedure_occurrence where procedure_concept_id=(select concept_id from concept where concept_name='Dialysis procedure' and domain_id='Procedure'))

select * from provider where provider_id in (select provider_id from procedure_occurrence where procedure_concept_id=(select concept_id from concept where concept_name='Dialysis procedure' AND domain_id='Procedure')) order by provider_id DESC;

select person.person_id from person INNER JOIN drug_era ON
person.person_id = drug_era.person_id INNER JOIN condition_era ON
person.person_id = condition_era.person_id INNER JOIN visit_occurrence ON
person.person_id = visit_occurrence.person_id where drug_era.drug_concept_id IN (SELECT  concept_id FROM dbo.concept WHERE concept_name='Epoetin Alfa' AND domain_id='Drug' AND concept_class_id='Ingredient') AND
condition_era.condition_concept_id IN (SELECT concept_id from concept WHERE concept_name='Anemia' AND domain_id='Condition') AND 
visit_occurrence.visit_start_date BETWEEN '2009-01-01' AND '2010-12-31' GROUP BY person.person_id;

