# ZMONITOR_WSB - Project WSB Merito

This small project has been created during postgraduate studies: ***“Software Engineering for SAP ERP and ABAP software development”*** on **WSB Merito University Warsaw** in partnership with with **SAP University Alliances**.

## I. Main goal
The goal of the project was to create an intuitive and easy-to-use dialog application that will allow monitoring of sales orders and ongoing tracking of their execution. The premise of the solution focuses on a 3-step sales process: 
-	Sales order
-	Delivery
-	Sales Invoice.

## II. Functionalities
Navigating the application has been designed on 3 screens. Depending on the screen the user is on, the following functionalities have been implemented in the application. 

1. Home screen
    - Order and delivery search engine using Radio Button
    - Welcome section

2. Orders screen
    - Orders 
        -	Orders as ALV list from the menu
        -	Highlighting orders for which deliveries have not been created
        -	Double-click to view details
        -	Additional button to smoothly move to the deliveries screen
    -	Customer data - dialog output fields with data on the selected customer
    -	Document circulation
        -	Existing documents in circulation for 3 stage process as ALV list. 
        -	Double-click to invoke standard SAP transactions for the selected document type
        -	Additional button to generate invoice printout
    - Order items
        -	Purchase order items as ALV list 

3. Deliveries screen
    -	Deliveries
        -	Deliveries as ALV list from the menu
        -	Double click to view details
        -	Additional button to smoothly switch to the orders screen
    -	Customer data - dialog output fields with data on the selected customer
    -	Document circulation
        -	Existing documents in circulation for 3 stage process as ALV list. 
        -	Double-click to invoke standard SAP transactions for the selected document type
        -	Additional button to generate invoice printout
    -	Delivery items
        -	Delivery items as an ALV list

> [!NOTE]
> More details you can find as well on atached PDF documentation: **“Monitor_Documentation_PL”**. Aavailable in Polish. 
