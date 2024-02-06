*----------------------------------------------------------------------*
***INCLUDE ZY_PR_WARSZ37_PROJEKT_O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
  SET TITLEBAR 'TITLE_100'.

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'STATUS_200'.
  SET TITLEBAR 'TITLE_200'.

  PERFORM: select_objects_order_head,
           create_objects_order_head.

  PERFORM: create_objects_order_pos,
           create_objects_doc_flow.

ENDMODULE.                 " STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS 'STATUS_300'.
  SET TITLEBAR 'TITLE_300'.

  PERFORM: select_objects_delivery_head,
           create_objects_delivery_head.

  PERFORM: create_objects_delivery_pos,
           create_objects_doc_flow.

ENDMODULE.                 " STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  LOOP AT SCREEN.
    IF rb_order = ''.
      IF screen-name = 'VBAK-VBELN'.
        screen-active = 0.
      ENDIF.
    ELSE.
      IF screen-name = 'VBAK-VBELN'.
        screen-active = 1.
        CLEAR likp-vbeln.
      ENDIF.
    ENDIF.
    MODIFY SCREEN.

    IF rb_delivery = ''.
      IF screen-name = 'LIKP-VBELN'.
        screen-active = 0.
      ENDIF.
    ELSE.
      IF screen-name = 'LIKP-VBELN'.
        screen-active = 1.
        CLEAR vbak-vbeln.
      ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.

ENDMODULE.                 " MODIFY_SCREEN  OUTPUT
