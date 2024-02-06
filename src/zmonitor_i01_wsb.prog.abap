*----------------------------------------------------------------------*
***INCLUDE ZY_PR_WARSZ37_PROJEKT_I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA: lv_ok_code TYPE sy-ucomm.

  MOVE ok_code TO lv_ok_code.

  CLEAR ok_code.

  CASE lv_ok_code.
    WHEN 'B' OR 'C' OR 'E'.
      LEAVE PROGRAM.

    WHEN 'BPRESS'.
      IF rb_order = 'X'.
        CALL SCREEN 0200.
      ENDIF.
      IF rb_delivery = 'X'.
        CALL SCREEN 0300.
      ENDIF.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  DATA: lv_ok_code_order TYPE sy-ucomm.

  MOVE ok_code_order TO lv_ok_code_order.

  CLEAR ok_code_order.

  CASE lv_ok_code_order.

    WHEN 'A1PRESS'.
      CLEAR: gt_delivery_head,
             gt_delivery_pos,
             gt_doc_flow.
      CLEAR: gv_invoice.
      CALL SCREEN 0300.

    WHEN 'A2PRESS'.
      IF gv_invoice IS NOT INITIAL.
        PERFORM print_invoice.
      ELSE.
        MESSAGE 'Wybierz dokument, dla którego chcesz wydrukować fakturę' TYPE 'I'.
      ENDIF.

    WHEN 'B'.
      CLEAR: gt_order_head,
             gt_order_pos,
             gt_doc_flow,
             gv_client_id,
             gv_client_name.
      CLEAR: gv_invoice.
      CALL SCREEN 0100.

    WHEN 'C' OR 'E'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0300 INPUT.
  DATA: lv_ok_code_delivery TYPE sy-ucomm.

  MOVE ok_code_delivery TO lv_ok_code_delivery.

  CLEAR ok_code_delivery.

  CASE lv_ok_code_delivery.

    WHEN 'A1PRESS'.
      CLEAR: gt_order_head,
             gt_order_pos,
             gt_doc_flow.
      CLEAR: gv_invoice.
      CALL SCREEN 0200.

    WHEN 'A2PRESS'.
      IF gv_invoice IS NOT INITIAL.
        PERFORM print_invoice.
      ELSE.
        MESSAGE 'Wybierz dokument, dla którego chcesz wydrukować fakturę' TYPE 'I'.
      ENDIF.

    WHEN 'B'.
      CLEAR: gt_delivery_head,
             gt_delivery_pos,
             gt_doc_flow,
             gv_client_id,
             gv_client_name.
      CLEAR: gv_invoice.
      CALL SCREEN 0100.

    WHEN 'C' OR 'E'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0300  INPUT
