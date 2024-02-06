*&---------------------------------------------------------------------*
*& Include ZY_PR_WARSZ37_PROJEKT_TOP                         Pula modułów     ZY_PR_WARSZ37_PROJEKT
*&
*&---------------------------------------------------------------------*

PROGRAM zy_pr_warsz37_projekt.

TABLES: vbak, likp, vbfa.

DATA: ok_code           TYPE sy-ucomm,
      rb_order          TYPE xfld VALUE 'X',        "Radio Button 'Zamówienia' z domyślnym wyborem
      rb_delivery       TYPE xfld,                  "Radio Button 'Dostawy'
      ok_code_order     TYPE sy-ucomm,
      ok_code_delivery  TYPE sy-ucomm,
      gv_client_id      TYPE vbak-kunnr,
      gv_client_name    TYPE kna1-name1,
      gv_client_street  TYPE kna1-stras,
      gv_client_poscode TYPE kna1-pstlz,
      gv_client_city    TYPE kna1-ort01,

      gv_invoice        TYPE vbrk-vbeln.

* --------------------------
* DEKLARACJA TYPÓW STRUKTURALNYCH
* 1. Zamówienie
TYPES:
  BEGIN OF ts_order_head,
    vbeln TYPE vbak-vbeln,
    netwr TYPE vbak-netwr,
    waerk TYPE vbak-waerk,
    bstdk TYPE vbkd-bstdk,
    vbelv TYPE vbfa-vbelv,
    t_color TYPE lvc_t_scol,
  END OF ts_order_head.

* 2. Pozycja zamówienia
TYPES:
  BEGIN OF ts_order_pos,
    vbeln   TYPE vbap-vbeln,
    posnr   TYPE vbap-posnr,
    matnr   TYPE vbap-matnr,
    arktx   TYPE vbap-arktx,
    kwmeng  TYPE vbap-kwmeng,
    vrkme   TYPE vbap-vrkme,
  END OF ts_order_pos.

* 3. Dostawa
TYPES:
  BEGIN OF ts_delivery_head,
    vbeln   TYPE likp-vbeln,
    lfdat   TYPE likp-lfdat,
    btgew   TYPE likp-btgew,
    gewei   TYPE likp-gewei,
  END OF ts_delivery_head.

* 4. Pozycja dostawy
TYPES:
  BEGIN OF ts_delivery_pos,
    vbeln   TYPE lips-vbeln,
    posnr   TYPE lips-posnr,
    matnr   TYPE lips-matnr,
    arktx   TYPE lips-arktx,
    lfimg   TYPE lips-lfimg,
    vrkme   TYPE lips-vrkme,
  END OF ts_delivery_pos.

* 5. Obieg dokumentów
TYPES:
  BEGIN OF ts_doc_flow,
    vbeln TYPE tds_docflow-vbeln,
    description TYPE tds_docflow-description,
    vbtyp_n TYPE tds_docflow-vbtyp_n,
  END OF ts_doc_flow.

DATA: gs_doc_flow TYPE ts_doc_flow,
      gt_doc_flow TYPE TABLE OF ts_doc_flow.

DATA: gt_docflow TYPE tdt_docflow,
      gs_docflow TYPE tds_docflow.
* --------------------------



* --------------------------
* DEKLARACJA STRUKTUR & TABEL
DATA: gs_order_head     TYPE ts_order_head,
      gt_order_head     TYPE TABLE OF ts_order_head,
      gs_order_pos      TYPE ts_order_pos,
      gt_order_pos      TYPE TABLE OF ts_order_pos,
      gs_delivery_head  TYPE ts_delivery_head,
      gt_delivery_head  TYPE TABLE OF ts_delivery_head,
      gs_delivery_pos   TYPE ts_delivery_pos,
      gt_delivery_pos   TYPE TABLE OF ts_delivery_pos.


* --------------------------
* DEKLARACJA Koloroków
DATA: gs_color TYPE lvc_s_scol, "Color structure
      gs_layout TYPE lvc_s_layo.
* --------------------------


* --------------------------
* DEKLARACJA CONTAINERS & ALV
DATA: g_container_order_head      TYPE scrfname VALUE 'CONTAINER_ORDER_HEAD',
      g_custom_cont_order_head    TYPE REF TO cl_gui_custom_container,
      grid_order_head             TYPE REF TO cl_gui_alv_grid,

      g_container_order_pos       TYPE scrfname VALUE 'CONTAINER_ORDER_POS',
      g_custom_cont_order_pos     TYPE REF TO cl_gui_custom_container,
      grid_order_pos              TYPE REF TO cl_gui_alv_grid,

      g_container_delivery_head   TYPE scrfname VALUE 'CONTAINER_DELIVERY_HEAD',
      g_custom_cont_delivery_head TYPE REF TO cl_gui_custom_container,
      grid_delivery_head          TYPE REF TO cl_gui_alv_grid,

      g_container_delivery_pos    TYPE scrfname VALUE 'CONTAINER_DELIVERY_POS',
      g_custom_cont_delivery_pos  TYPE REF TO cl_gui_custom_container,
      grid_delivery_pos           TYPE REF TO cl_gui_alv_grid,

      g_container_doc_flow        TYPE scrfname VALUE 'CONTAINER_DOCUMENT_FLOW',
      g_custom_cont_doc_flow      TYPE REF TO cl_gui_custom_container,
      grid_doc_flow               TYPE REF TO cl_gui_alv_grid.
* --------------------------


DATA: g_container_main_screen     TYPE scrfname VALUE 'CONTAINER_MAIN_SCREEN',
      g_custom_cont_main_screen   TYPE REF TO cl_gui_custom_container,
      picture_main_screen         TYPE REF TO cl_gui_picture.
