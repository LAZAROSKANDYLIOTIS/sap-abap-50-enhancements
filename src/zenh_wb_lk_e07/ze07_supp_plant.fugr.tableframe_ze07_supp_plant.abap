*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZE07_SUPP_PLANT
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZE07_SUPP_PLANT    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
