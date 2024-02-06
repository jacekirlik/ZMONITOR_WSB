*&---------------------------------------------------------------------*
*&  Include           ZY_PR_WARSZ37_PROJ_C01
*&---------------------------------------------------------------------*


CLASS cl_event_receiver_order DEFINITION DEFERRED.
CLASS cl_event_receiver_order DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_double_click FOR EVENT double_click OF cl_gui_alv_grid IMPORTING e_column e_row es_row_no.
ENDCLASS.
CLASS cl_event_receiver_order IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE gt_order_head INTO gs_order_head INDEX es_row_no-row_id.
    IF sy-subrc = 0.

      SELECT vbap~vbeln vbap~posnr vbap~matnr vbap~arktx vbap~kwmeng vbap~vrkme
        INTO TABLE gt_order_pos
        FROM vbap
        WHERE vbeln = gs_order_head-vbeln.

      CALL FUNCTION 'SD_DOCUMENT_FLOW_GET'
        EXPORTING
          iv_docnum  = gs_order_head-vbeln
        IMPORTING
          et_docflow = gt_docflow.

      CLEAR: gt_doc_flow,
             gv_invoice.

      LOOP AT  gt_docflow INTO gs_docflow.
        CASE gs_docflow-vbtyp_n.
          WHEN 'C'.
            gs_doc_flow-vbeln = gs_docflow-vbeln.
            gs_doc_flow-description = gs_docflow-description.
            gs_doc_flow-vbtyp_n = gs_docflow-vbtyp_n.
            APPEND gs_doc_flow  TO gt_doc_flow.
          WHEN 'J'.
            gs_doc_flow-vbeln = gs_docflow-vbeln.
            gs_doc_flow-description = gs_docflow-description.
            gs_doc_flow-vbtyp_n = gs_docflow-vbtyp_n.
            APPEND gs_doc_flow  TO gt_doc_flow.
          WHEN 'M'.
            gs_doc_flow-vbeln = gs_docflow-vbeln.
            gs_doc_flow-description = gs_docflow-description.
            gs_doc_flow-vbtyp_n = gs_docflow-vbtyp_n.
            APPEND gs_doc_flow  TO gt_doc_flow.
            gv_invoice = gs_docflow-vbeln.
        ENDCASE.
      ENDLOOP.

      PERFORM create_objects_order_pos.
      PERFORM create_objects_doc_flow .

    ENDIF.
  ENDMETHOD.
ENDCLASS.


CLASS cl_event_receiver_delivery DEFINITION DEFERRED.
CLASS cl_event_receiver_delivery DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_double_click FOR EVENT double_click OF cl_gui_alv_grid IMPORTING e_column e_row es_row_no.
ENDCLASS.
CLASS cl_event_receiver_delivery IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE gt_delivery_head INTO gs_delivery_head INDEX es_row_no-row_id.
    IF sy-subrc = 0.

      SELECT lips~vbeln lips~posnr lips~matnr lips~arktx lips~lfimg lips~vrkme
        INTO TABLE gt_delivery_pos
        FROM lips
        WHERE vbeln = gs_delivery_head-vbeln.

      CALL FUNCTION 'SD_DOCUMENT_FLOW_GET'
        EXPORTING
          iv_docnum  = gs_delivery_head-vbeln
        IMPORTING
          et_docflow = gt_docflow.

      CLEAR: gt_doc_flow,
             gv_invoice.

      LOOP AT  gt_docflow INTO gs_docflow.
        CASE gs_docflow-vbtyp_n.
          WHEN 'C'.
            gs_doc_flow-vbeln = gs_docflow-vbeln.
            gs_doc_flow-description = gs_docflow-description.
            gs_doc_flow-vbtyp_n = gs_docflow-vbtyp_n.
            APPEND gs_doc_flow  TO gt_doc_flow.
          WHEN 'J'.
            gs_doc_flow-vbeln = gs_docflow-vbeln.
            gs_doc_flow-description = gs_docflow-description.
            gs_doc_flow-vbtyp_n = gs_docflow-vbtyp_n.
            APPEND gs_doc_flow  TO gt_doc_flow.
          WHEN 'M'.
            gs_doc_flow-vbeln = gs_docflow-vbeln.
            gs_doc_flow-description = gs_docflow-description.
            gs_doc_flow-vbtyp_n = gs_docflow-vbtyp_n.
            APPEND gs_doc_flow  TO gt_doc_flow.
            gv_invoice = gs_docflow-vbeln.
        ENDCASE.
      ENDLOOP.

      PERFORM create_objects_delivery_pos.
      PERFORM create_objects_doc_flow .

    ENDIF.
  ENDMETHOD.
ENDCLASS.


CLASS cl_event_receiver_flow DEFINITION DEFERRED.
CLASS cl_event_receiver_flow DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_double_click FOR EVENT double_click OF cl_gui_alv_grid IMPORTING e_column e_row es_row_no.
ENDCLASS.
CLASS cl_event_receiver_flow IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE gt_doc_flow INTO gs_doc_flow INDEX es_row_no-row_id.
    IF sy-subrc = 0.

      CASE gs_doc_flow-vbtyp_n.
        WHEN 'C'.
          SET PARAMETER ID 'AUN' FIELD gs_doc_flow-vbeln.
          CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
        WHEN 'J'.
          SET PARAMETER ID 'VL' FIELD gs_doc_flow-vbeln.
          CALL TRANSACTION 'VL03N' AND SKIP FIRST SCREEN.
        WHEN 'M'.
          SET PARAMETER ID 'VF' FIELD gs_doc_flow-vbeln.
          CALL TRANSACTION 'VF03' AND SKIP FIRST SCREEN.
      ENDCASE.

    ENDIF.
  ENDMETHOD.
ENDCLASS.


* --------------------------
* DEKLARACJA EVENTÓW
DATA: event_receiver_order    TYPE REF TO cl_event_receiver_order,
      event_receiver_delivery TYPE REF TO cl_event_receiver_delivery,
      event_receiver_flow     TYPE REF TO cl_event_receiver_flow.

* --------------------------
