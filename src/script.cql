LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/bugwerk/neo4j_case_study/main/language.csv' AS row
WITH row WHERE row.iso_code IS NOT NULL
MERGE (l:Language {languageID: row.iso_code})
  ON CREATE SET l.name = row.Name;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/bugwerk/neo4j_case_study/main/language.csv' AS row
WITH row WHERE row.family IS NOT NULL
MERGE (f:Family {familyName: row.family})
  ON CREATE SET f.name = row.family;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/bugwerk/neo4j_case_study/main/language.csv' AS row
WITH row WHERE row.genus IS NOT NULL
MERGE (g:Genus {genusName: row.genus})
  ON CREATE SET g.name = row.genus;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/bugwerk/neo4j_case_study/main/language.csv' AS row
WITH row WHERE row.macroarea IS NOT NULL
MERGE (r:Region {regionName: row.macroarea})
  ON CREATE SET r.name = row.macroarea;

CREATE INDEX language_id FOR (l:Language) ON (l.languageID);
CREATE INDEX family_id FOR (f:Family) ON (f.familyName);
CREATE INDEX genus_id FOR (g:Genus) ON (g.genusName);
CREATE INDEX region_id FOR (r:Region) ON (r.regionName);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/bugwerk/neo4j_case_study/main/language.csv' AS row
MATCH (l:Language {languageID: row.iso_code})
MATCH (g:Genus {genusName: row.genus})
MERGE (l)-[:PART_OF]->(g);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/bugwerk/neo4j_case_study/main/language.csv' AS row
MATCH (g:Genus {genusName: row.genus})
MATCH (f:Family {familyName: row.family})
MERGE (g)-[:SUBCLASS_OF]->(f);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/bugwerk/neo4j_case_study/main/language.csv' AS row
MATCH (l:Language {languageID: row.iso_code})
MATCH (r:Region {regionName: row.macroarea})
MERGE (l)-[:SPOKEN_IN]->(r);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/bugwerk/neo4j_case_study/main/language.csv' AS row
MATCH (f:Family {familyName: row.family})
MATCH (r:Region {regionName: row.macroarea})
MERGE (l)-[:PRESENT_IN]->(r);