CLASS zcl_im_e05_miro_header_txt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_ex_mrm_header_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES ty_bukrs_range TYPE RANGE OF bukrs.

    CONSTANTS gc_tvarv_name TYPE rvari_vnam VALUE 'ZE05_BUKRS'.
    CONSTANTS gc_tvarv_type TYPE rsscr_kind VALUE 'S'.

    CLASS-DATA gt_bukrs  TYPE ty_bukrs_range.
    CLASS-DATA gv_loaded TYPE abap_bool.
    CLASS-METHODS get_bukrs
      RETURNING
        VALUE(rt_bukrs) TYPE ty_bukrs_range.
ENDCLASS.



CLASS ZCL_IM_E05_MIRO_HEADER_TXT IMPLEMENTATION.


  METHOD get_bukrs.
    IF gv_loaded = abap_false.
      SELECT sign, opti AS option, low, high
        FROM tvarvc
        WHERE name = @gc_tvarv_name
          AND type = @gc_tvarv_type
        INTO CORRESPONDING FIELDS OF TABLE @gt_bukrs.
      gv_loaded = abap_true.
    ENDIF.
    rt_bukrs = gt_bukrs.
  ENDMETHOD.


METHOD if_ex_mrm_header_check~headerdata_check.
  DATA lt_errprot TYPE mrm_tab_errprot.

  IF i_rbkpv-bktxt IS INITIAL.
    DATA(lt_bukrs) = get_bukrs( ).
    IF lt_bukrs IS NOT INITIAL AND i_rbkpv-bukrs IN lt_bukrs.

      APPEND VALUE #( msgty = 'E'
                      msgid = 'ZMM_E05'
                      msgno = '000'
                      msgv1 = i_rbkpv-bukrs ) TO lt_errprot.

      CALL FUNCTION 'MRM_PROT_FILL'
        tables
          t_errprot = lt_errprot.

    ENDIF.
  ENDIF.
ENDMETHOD.
ENDCLASS.
