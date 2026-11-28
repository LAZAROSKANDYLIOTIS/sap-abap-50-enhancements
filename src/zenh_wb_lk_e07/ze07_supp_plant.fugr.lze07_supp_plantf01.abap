*----------------------------------------------------------------------*
***INCLUDE LZE07_SUPP_PLANTF01.
*----------------------------------------------------------------------*

FORM ze07_new_entry.
  ze07_supp_plant-created_by = sy-uname.
  ze07_supp_plant-created_on = sy-datum.
ENDFORM.

FORM ze07_before_save.
  DATA lv_index TYPE sy-tabix.

  LOOP AT total.
    " only changed entries (new entries are handled in event 05)
    CHECK <action> = aendern.

    " find the same line in EXTRACT (what the user sees)
    READ TABLE extract WITH KEY <vim_xtotal_key>.
    IF sy-subrc = 0.
      lv_index = sy-tabix.
    ELSE.
      CLEAR lv_index.
    ENDIF.

    " work on the line through the table work area
    ze07_supp_plant = <vim_total_struc>.
    ze07_supp_plant-changed_by = sy-uname.
    ze07_supp_plant-changed_on = sy-datum.
    <vim_total_struc> = ze07_supp_plant.

    MODIFY total.

    " keep EXTRACT in sync
    CHECK lv_index > 0.
    extract = total.
    MODIFY extract INDEX lv_index.
  ENDLOOP.

  sy-subrc = 0.
ENDFORM.
