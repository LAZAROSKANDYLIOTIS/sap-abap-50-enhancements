CLASS zcl_im_e01_pr_requist_lk DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_ex_me_process_req_cust .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES ty_matkl_range TYPE RANGE OF matkl.

    CLASS-DATA gt_it_matkl TYPE ty_matkl_range.
    CLASS-DATA gv_loaded   TYPE abap_bool.

    CLASS-METHODS get_it_groups
      RETURNING VALUE(rt_matkl) TYPE ty_matkl_range.

    CLASS-METHODS is_invalid
      IMPORTING is_item           TYPE mereq_item
      RETURNING VALUE(rv_invalid) TYPE abap_bool.
ENDCLASS.



CLASS ZCL_IM_E01_PR_REQUIST_LK IMPLEMENTATION.


  METHOD get_it_groups.
    IF gv_loaded = abap_false.
      SELECT sign, opti AS option, low, high
        FROM tvarvc
        WHERE name = 'ZE01_IT_MATKL'
        AND type = 'S'
        INTO CORRESPONDING FIELDS OF TABLE @gt_it_matkl.

      gv_loaded = abap_true.
    ENDIF.
    rt_matkl = gt_it_matkl.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~check.
    INCLUDE mm_messages_mac.

    DATA(lt_items) = im_header->get_items( ).

    LOOP AT lt_items INTO DATA(ls_items).
      DATA(ls_item) = ls_items-item->get_data( ).

      IF is_invalid( ls_item ) = abap_true.
        mmpur_message_forced 'E' 'ZMM_E01' '001'
                             ls_item-bnfpo ls_item-matkl '' ''.
        ch_failed = abap_true.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~close.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~fieldselection_header.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~fieldselection_header_refkeys.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~fieldselection_item.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~fieldselection_item_refkeys.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~initialize.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~open.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~post.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~process_account.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~process_header.
  ENDMETHOD.


  METHOD if_ex_me_process_req_cust~process_item.
    INCLUDE mm_messages_mac.

    DATA(ls_item) = im_item->get_data( ).

    IF is_invalid( ls_item ) = abap_true.
      mmpur_message_forced 'E' 'ZMM_E01' '001'
                           ls_item-bnfpo ls_item-matkl '' ''.
    ENDIF.

  ENDMETHOD.


  METHOD is_invalid.
    DATA(lt_it_matkl) = get_it_groups( ).

    IF lt_it_matkl IS NOT INITIAL.
      IF is_item-matkl IN lt_it_matkl AND is_item-afnam IS INITIAL AND is_item-loekz IS INITIAL. " if in material group list and requistioner is not empy and item is not deleted
        rv_invalid = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
