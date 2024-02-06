FORM select_objects_order_head .

  IF vbak-kunnr IS NOT INITIAL.                         " SELECT dla zamówień po numerze klienta
    SELECT DISTINCT vbak~vbeln vbak~netwr vbak~waerk vbkd~bstdk vbfa~vbelv
      INTO CORRESPONDING FIELDS OF TABLE gt_order_head
      FROM vbak
      LEFT JOIN vbkd
      ON vbak~vbeln = vbkd~vbeln
      LEFT JOIN vbfa
      ON vbak~vbeln = vbfa~vbelv
      WHERE vbak~kunnr = vbak-kunnr.

    SELECT SINGLE vbak~kunnr INTO gv_client_id         " Przypisanie numeru klienta do gv_client_id
      FROM vbak
      WHERE vbak~kunnr = vbak-kunnr.
  ENDIF.

  IF vbak-vbeln IS NOT INITIAL.
    SELECT DISTINCT vbak~vbeln vbak~netwr vbak~waerk vbkd~bstdk  " SELECT dla zamówień po numerze zamówienia
      INTO CORRESPONDING FIELDS OF TABLE gt_order_head
      FROM vbak
      LEFT JOIN vbkd
      ON vbak~vbeln = vbkd~vbeln
      LEFT JOIN vbfa
      ON vbak~vbeln = vbfa~vbelv
      WHERE vbak~vbeln = vbak-vbeln.

    SELECT SINGLE vbak~kunnr INTO gv_client_id          " Przypisanie numeru klienta do gv_client_id
      FROM vbak
      WHERE vbak~vbeln = vbak-vbeln.
  ENDIF.

* Przypisanie danych klienta do gv_client_id
  SELECT SINGLE kna1~name1 INTO gv_client_name
    FROM kna1
    WHERE kna1~kunnr = gv_client_id.

  SELECT SINGLE kna1~stras INTO gv_client_street
    FROM kna1
    WHERE kna1~kunnr = gv_client_id.

  SELECT SINGLE kna1~pstlz INTO gv_client_poscode
    FROM kna1
    WHERE kna1~kunnr = gv_client_id.

  SELECT SINGLE kna1~ort01 INTO gv_client_city
    FROM kna1
    WHERE kna1~kunnr = gv_client_id.



ENDFORM.


FORM select_objects_delivery_head.
  IF vbak-kunnr IS NOT INITIAL.
    SELECT likp~vbeln likp~lfdat likp~btgew likp~gewei  " SELECT dla dostaw po numerze klienta
      INTO TABLE gt_delivery_head
      FROM likp
      WHERE likp~kunag = vbak-kunnr.

    SELECT SINGLE likp~kunag INTO gv_client_id          " Przypisanie numeru klienta do numeru klienta
      FROM likp
      WHERE likp~kunag = vbak-kunnr.
  ENDIF.

  IF likp-vbeln IS NOT INITIAL.                         " SELECT dla zamówień po numerze dostawy
    SELECT likp~vbeln likp~lfdat likp~btgew likp~gewei
      INTO TABLE gt_delivery_head
      FROM likp
      WHERE likp~vbeln = likp-vbeln.

    SELECT SINGLE likp~kunag INTO gv_client_id          " Przypisanie numeru klienta do numeru zamówienia
      FROM likp
      WHERE likp~vbeln = likp-vbeln.
  ENDIF.

* Przypisanie danych klienta do gv_client_id
  SELECT SINGLE kna1~name1 INTO gv_client_name
    FROM kna1
    WHERE kna1~kunnr = gv_client_id.

  SELECT SINGLE kna1~stras INTO gv_client_street
    FROM kna1
    WHERE kna1~kunnr = gv_client_id.

  SELECT SINGLE kna1~pstlz INTO gv_client_poscode
    FROM kna1
    WHERE kna1~kunnr = gv_client_id.

  SELECT SINGLE kna1~ort01 INTO gv_client_city
    FROM kna1
    WHERE kna1~kunnr = gv_client_id.
ENDFORM.
