WITH
  total_bibs AS (
    SELECT COUNT(*)
    FROM AMDB.bib_master
  )
SELECT /*+ FIRST_ROWS(1000) */ t.bib_id,
  t.suppress_in_opac,
  'BIB_AMDB_INSTANCE' AS instance_schema,
  'BIB_AMDB_SOURCE' AS source_schema,
  rtrim(AMDB.getBibBlob(t.bib_id)) AS marc_record,
  (SELECT * FROM total_bibs) AS bib_total
FROM AMDB.bib_master t
ORDER BY t.bib_id
;