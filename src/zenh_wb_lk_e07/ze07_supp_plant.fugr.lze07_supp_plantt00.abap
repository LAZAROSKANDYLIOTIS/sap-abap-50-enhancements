*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZE07_SUPP_PLANT.................................*
DATA:  BEGIN OF STATUS_ZE07_SUPP_PLANT               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZE07_SUPP_PLANT               .
CONTROLS: TCTRL_ZE07_SUPP_PLANT
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZE07_SUPP_PLANT               .
TABLES: ZE07_SUPP_PLANT                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
