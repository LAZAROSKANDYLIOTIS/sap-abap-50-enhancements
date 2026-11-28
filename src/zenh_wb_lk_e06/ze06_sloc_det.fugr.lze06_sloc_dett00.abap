*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZE06_SLOC_DET...................................*
DATA:  BEGIN OF STATUS_ZE06_SLOC_DET                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZE06_SLOC_DET                 .
CONTROLS: TCTRL_ZE06_SLOC_DET
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZE06_SLOC_DET                 .
TABLES: ZE06_SLOC_DET                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
