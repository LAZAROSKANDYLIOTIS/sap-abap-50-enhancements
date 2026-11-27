CLASS zcl_im_e03_po_item_req DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_badi_interface .
    INTERFACES if_ex_me_process_po_cust .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS gc_doctype  TYPE esart VALUE 'NB'.
    CONSTANTS gc_currency TYPE waers VALUE 'INR'.
    CONSTANTS gc_limit    TYPE bwert VALUE '10000'.

    CLASS-METHODS is_invalid
      IMPORTING
        !io_item          TYPE REF TO if_purchase_order_item_mm
      RETURNING
        VALUE(rv_invalid) TYPE abap_bool .
    CLASS-METHODS raise_message
      IMPORTING
        !io_item TYPE REF TO if_purchase_order_item_mm .
ENDCLASS.



CLASS ZCL_IM_E03_PO_ITEM_REQ IMPLEMENTATION.


  METHOD if_ex_me_process_po_cust~check.
    LOOP AT im_header->get_items( ) INTO DATA(ls_items).
      IF is_invalid( ls_items-item ) = abap_true.
        raise_message( ls_items-item ).
        ch_failed = abap_true.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~close.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~fieldselection_header.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~fieldselection_header_refkeys.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~fieldselection_item.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~fieldselection_item_refkeys.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~initialize.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~open.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~post.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~process_account.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~process_header.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~process_item.
    IF is_invalid( im_item ) = abap_true.
      raise_message( im_item ).
    ENDIF.
  ENDMETHOD.


  METHOD if_ex_me_process_po_cust~process_schedule.
  ENDMETHOD.


  METHOD is_invalid.
    DATA(ls_item)   = io_item->get_data( ).
    DATA(ls_header) = io_item->get_header( )->get_data( ).

    IF ls_header-bsart = gc_doctype
       AND ls_header-waers = gc_currency
       AND ls_item-netwr > gc_limit
       AND ls_item-afnam IS INITIAL
       AND ls_item-loekz IS INITIAL.
      rv_invalid = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD raise_message.
    INCLUDE mm_messages_mac.

    DATA(ls_item)   = io_item->get_data( ).
    DATA(lv_itemno) = CONV string( ls_item-ebelp ).
    DATA(lv_limit)  = |{ gc_limit NUMBER = USER DECIMALS = 0 }|.

    mmpur_message_forced 'E' 'ZMM_E03' '000' lv_itemno lv_limit gc_currency ''.
  ENDMETHOD.
ENDCLASS.
