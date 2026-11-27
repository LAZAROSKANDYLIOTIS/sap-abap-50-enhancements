"Name: \PR:SAPMV45A\FO:USEREXIT_MOVE_FIELD_TO_VBAK\SE:END\EI
ENHANCEMENT 0 ZE04_SO_DEFAULT_ORDER_REASON.

CONSTANTS: lc_ze04_tvarv_name TYPE rvari_vnam VALUE 'ZE04_DEFAULT_AUGRU',
           lc_ze04_tvarv_type TYPE rsscr_kind VALUE 'P',
           lc_ze04_auart      TYPE auart      VALUE 'TA'.
DATA: lv_augru TYPE char3.

IF vbak-auart = lc_ze04_auart AND svbak-tabix = 0 AND vbak-augru IS INITIAL.
  SELECT SINGLE low
    FROM tvarvc
    INTO lv_augru
    WHERE name = lc_ze04_tvarv_name
      AND type = lc_ze04_tvarv_type.

  IF sy-subrc = 0 AND lv_augru IS NOT INITIAL.
    vbak-augru = lv_augru.
  ENDIF.
ENDIF.


ENDENHANCEMENT.
