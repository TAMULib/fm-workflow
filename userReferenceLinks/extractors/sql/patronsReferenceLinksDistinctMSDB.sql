SELECT mp.patron_id,
  mp.institution_id,
  NVL2(mp.institution_id, regexp_replace(mp.institution_id, '([[:digit:]]{3})-([[:digit:]]{2})-([[:digit:]]{4})', '\1\2\3'), 'MSDB_' || mp.patron_id) AS external_system_id,
  'MSDB' as schema
FROM MSDB.patron mp
  LEFT JOIN AMDB.patron ap ON regexp_replace(mp.institution_id, '([[:digit:]]{3})-([[:digit:]]{2})-([[:digit:]]{4})', '\1\2\3') = regexp_replace(ap.institution_id, '([[:digit:]]{3})-([[:digit:]]{2})-([[:digit:]]{4})', '\1\2\3')
WHERE mp.last_name IS NOT NULL
  AND ap.institution_id IS NULL
ORDER BY external_system_id
;