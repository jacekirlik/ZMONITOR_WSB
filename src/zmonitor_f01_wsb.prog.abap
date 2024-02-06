*&---------------------------------------------------------------------*
*&  Include           ZY_PR_WARSZ37_PROJEKT_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  CREATE_OBJECTS_ORDER_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_objects_order_head .
  IF g_custom_cont_order_head IS INITIAL.
    CREATE OBJECT g_custom_cont_order_head
      EXPORTING
        container_name = g_container_order_head.

    CREATE OBJECT grid_order_head
      EXPORTING
        i_parent = g_custom_cont_order_head.

    DATA(gt_fcat) = VALUE lvc_t_fcat( ( fieldname = 'VBELN' coltext = 'Dokument' outputlen = 12 col_pos = 1 emphasize = 'C510' datatype = 'NUMC' )
                                      ( fieldname = 'BSTDK' coltext = 'Data zamówienia' outputlen = 10 col_pos = 2 )
                                      ( fieldname = 'NETWR' coltext = 'Wartość' outputlen = 15 col_pos = 3 )
                                      ( fieldname = 'WAERK' coltext = 'Waluta' outputlen = 5 col_pos = 4 ) ).

    DATA(gt_exclude) = VALUE ui_functions( ( cl_gui_alv_grid=>mc_mb_subtot )
                                           ( cl_gui_alv_grid=>mc_fc_print_back )
                                           ( cl_gui_alv_grid=>mc_mb_view )
                                           ( cl_gui_alv_grid=>mc_mb_variant )
                                           ( cl_gui_alv_grid=>mc_fc_graph )
                                           ( cl_gui_alv_grid=>mc_fc_info ) ).

    PERFORM color_cells_without_deliv.

    CALL METHOD grid_order_head->set_table_for_first_display
      EXPORTING
        it_toolbar_excluding = gt_exclude
        is_layout            = gs_layout
      CHANGING
        it_fieldcatalog      = gt_fcat
        it_outtab            = gt_order_head.

    CREATE OBJECT event_receiver_order.
    SET HANDLER event_receiver_order->handle_double_click FOR grid_order_head.

  ELSE.
    PERFORM color_cells_without_deliv.
    grid_order_head->refresh_table_display( ).
  ENDIF.
ENDFORM.                    " CREATE_OBJECTS_ORDER_HEADER

*&---------------------------------------------------------------------*
*&      Form  CREATE_OBJECTS_ORDER_POS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_objects_order_pos .
  IF g_custom_cont_order_pos IS INITIAL.
    CREATE OBJECT g_custom_cont_order_pos
      EXPORTING
        container_name = g_container_order_pos.

    CREATE OBJECT grid_order_pos
      EXPORTING
        i_parent = g_custom_cont_order_pos.

    DATA(gt_fcat) = VALUE lvc_t_fcat( ( fieldname = 'VBELN' coltext = 'Dokument' outputlen = 12 col_pos = 1 emphasize = 'C510' datatype = 'NUMC' )
                                      ( fieldname = 'POSNR' coltext = 'Pozycja' outputlen = 5 col_pos = 2 )
                                      ( fieldname = 'MATNR' coltext = 'Materiał' outputlen = 15 col_pos = 3 )
                                      ( fieldname = 'ARKTX' coltext = 'Nazwa' outputlen = 35 col_pos = 4 )
                                      ( fieldname = 'KWMENG' coltext = 'Ilość' outputlen = 15 col_pos = 5 )
                                      ( fieldname = 'VRKME' coltext = 'Jednostka' outputlen = 5 col_pos = 6 ) ).

    DATA(gt_exclude) = VALUE ui_functions( ( cl_gui_alv_grid=>mc_fc_excl_all ) ).

    CALL METHOD grid_order_pos->set_table_for_first_display
      EXPORTING
        it_toolbar_excluding = gt_exclude
      CHANGING
        it_fieldcatalog      = gt_fcat
        it_outtab            = gt_order_pos.

  ELSE.
    grid_order_pos->refresh_table_display( ).
  ENDIF.
ENDFORM.                    " CREATE_OBJECTS_ORDER_POS

*&---------------------------------------------------------------------*
*&      Form  CREATE_OBJECTS_DELIVERY_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_objects_delivery_head .
  IF g_custom_cont_delivery_head IS INITIAL.
    CREATE OBJECT g_custom_cont_delivery_head
      EXPORTING
        container_name = g_container_delivery_head.

    CREATE OBJECT grid_delivery_head
      EXPORTING
        i_parent = g_custom_cont_delivery_head.

    DATA(gt_fcat) = VALUE lvc_t_fcat( ( fieldname = 'VBELN' coltext = 'Dokument' outputlen = 12 col_pos = 1 emphasize = 'C110' datatype = 'NUMC' )
                                      ( fieldname = 'LFDAT' coltext = 'Data dostawy' outputlen = 10 col_pos = 2 )
                                      ( fieldname = 'BTGEW' coltext = 'Waga' outputlen = 15 col_pos = 3 )
                                      ( fieldname = 'GEWEI' coltext = 'Jednostka' outputlen = 5 col_pos = 4 ) ).

    DATA(gt_exclude) = VALUE ui_functions( ( cl_gui_alv_grid=>mc_mb_subtot )
                                           ( cl_gui_alv_grid=>mc_fc_print_back )
                                           ( cl_gui_alv_grid=>mc_mb_view )
                                           ( cl_gui_alv_grid=>mc_mb_variant )
                                           ( cl_gui_alv_grid=>mc_fc_graph )
                                           ( cl_gui_alv_grid=>mc_fc_info ) ).

    CALL METHOD grid_delivery_head->set_table_for_first_display
      EXPORTING
        it_toolbar_excluding = gt_exclude
      CHANGING
        it_fieldcatalog      = gt_fcat
        it_outtab            = gt_delivery_head.

    CREATE OBJECT event_receiver_delivery.
    SET HANDLER event_receiver_delivery->handle_double_click FOR grid_delivery_head.

  ELSE.
    grid_delivery_head->refresh_table_display( ).
  ENDIF.

ENDFORM.                    " CREATE_OBJECTS_DELIVERY_HEADER

*&---------------------------------------------------------------------*
*&      Form  CREATE_OBJECTS_DELIVERY_POS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_objects_delivery_pos .
  IF g_custom_cont_delivery_pos IS INITIAL.

    CREATE OBJECT g_custom_cont_delivery_pos
      EXPORTING
        container_name = g_container_delivery_pos.

    CREATE OBJECT grid_delivery_pos
      EXPORTING
        i_parent = g_custom_cont_delivery_pos.

    DATA(gt_fcat) = VALUE lvc_t_fcat( ( fieldname = 'VBELN' coltext = 'Dokument' outputlen = 12 col_pos = 1 emphasize = 'C110' datatype = 'NUMC' )
                                      ( fieldname = 'POSNR' coltext = 'Pozycja' outputlen = 5 col_pos = 2 )
                                      ( fieldname = 'MATNR' coltext = 'Materiał' outputlen = 15 col_pos = 3 )
                                      ( fieldname = 'ARKTX' coltext = 'Nazwa' outputlen = 35 col_pos = 4 )
                                      ( fieldname = 'LFIMG' coltext = 'Ilość' outputlen = 15 col_pos = 5 )
                                      ( fieldname = 'VRKME' coltext = 'Jednostka' outputlen = 5 col_pos = 6 ) ).

    DATA(gt_exclude) = VALUE ui_functions( ( cl_gui_alv_grid=>mc_fc_excl_all ) ).

    CALL METHOD grid_delivery_pos->set_table_for_first_display
      EXPORTING
        it_toolbar_excluding = gt_exclude
      CHANGING
        it_fieldcatalog      = gt_fcat
        it_outtab            = gt_delivery_pos.

  ELSE.
    grid_delivery_pos->refresh_table_display( ).
  ENDIF.
ENDFORM.                    " CREATE_OBJECTS_DELIVERY_POS

*&---------------------------------------------------------------------*
*&      Form  CREATE_OBJECTS_ORDER_DETAIL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_objects_doc_flow .
  IF g_custom_cont_doc_flow IS INITIAL.

    CREATE OBJECT g_custom_cont_doc_flow
      EXPORTING
        container_name = g_container_doc_flow.

    CREATE OBJECT grid_doc_flow
      EXPORTING
        i_parent = g_custom_cont_doc_flow.

    DATA(gt_fcat) = VALUE lvc_t_fcat( ( fieldname = 'VBELN' coltext = 'Dokument' outputlen = 12 col_pos = 1 datatype = 'NUMC' )
                                      ( fieldname = 'DESCRIPTION' coltext = 'Typ dokumentu' outputlen = 22 col_pos = 2 ) ).

    DATA(gt_exclude) = VALUE ui_functions( ( cl_gui_alv_grid=>mc_fc_excl_all ) ).

    CALL METHOD grid_doc_flow->set_table_for_first_display
      EXPORTING
        it_toolbar_excluding = gt_exclude
      CHANGING
        it_fieldcatalog      = gt_fcat
        it_outtab            = gt_doc_flow.

    CREATE OBJECT event_receiver_flow.
    SET HANDLER event_receiver_flow->handle_double_click FOR grid_doc_flow.

  ELSE.
    grid_doc_flow->refresh_table_display( ).
  ENDIF.
ENDFORM.                    " CREATE_OBJECTS_ORDER_FLOW

*&---------------------------------------------------------------------*
*&      Form  color_cells_without_deliv
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM color_cells_without_deliv .
  LOOP AT gt_order_head ASSIGNING FIELD-SYMBOL(<fs_order_head>).
    IF <fs_order_head>-vbelv = ''.
      CLEAR gs_color.
      gs_color-fname = 'VBELN'.
      gs_color-color-col = 6.
      gs_color-color-int = 0.
      APPEND gs_color TO <fs_order_head>-t_color.
    ENDIF.
  ENDLOOP.
  gs_layout-ctab_fname = 'T_COLOR'.
ENDFORM.                    " color_cells_without_deliv

*&---------------------------------------------------------------------*
*&      Form  PRINT_INVOICE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM print_invoice .

  DATA: lv_fm_name      TYPE rs38l_fnam.
  DATA: ls_nast         TYPE nast,
        ls_bil_invoice  TYPE lbbil_invoice.
  DATA: ls_print_data_to_read TYPE lbbil_print_data_to_read.

  SELECT SINGLE * FROM nast
    INTO ls_nast
    WHERE nast~kappl = 'V3'
    AND nast~objky = gv_invoice
    AND nast~nacha = '1'.

  FIELD-SYMBOLS: <fs_print_data_to_read> TYPE xfeld.
  DO.
    ASSIGN COMPONENT sy-index OF STRUCTURE ls_print_data_to_read TO <fs_print_data_to_read>.
    IF sy-subrc <> 0. EXIT. ENDIF.
    <fs_print_data_to_read> = 'X'.
  ENDDO.

  CALL FUNCTION 'LB_BIL_INV_OUTP_READ_PRTDATA'
    EXPORTING
      if_bil_number         = ls_nast-objky
      is_print_data_to_read = ls_print_data_to_read
      if_parvw              = ls_nast-parvw
      if_parnr              = ls_nast-parnr
      if_language           = ls_nast-spras
    IMPORTING
      es_bil_invoice        = ls_bil_invoice.

  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname = 'ZZLB_BIL_INVOICE'
    IMPORTING
      fm_name  = lv_fm_name.

  CALL FUNCTION lv_fm_name
    EXPORTING
      is_bil_invoice = ls_bil_invoice
      is_nast        = ls_nast
      is_repeat      = ''.
ENDFORM.                    " PRINT_INVOICE
