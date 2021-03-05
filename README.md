## E-Commerce Database Design
An E-Commerce relational database is designed describing all the entity related to e-commerce using Microsoft SQL Server Management Studio. This has been created according to the guidelines given for POC 2 by BCT L&D team.

## Design Approach
The E-Commerce database design contains tables such as Users, UserAddresses, AddressType, Payments, Orders, Shipper, Categories, CartDetails and Suppliers. A user places an order for purchasing product which is supplied by a supplier. A user can place an order for multiple products and a particular product can be supplied by multiple suppliers and is under a particular category. Additionally, views, triggers and stored procedures are written for applying run-time conditions and better perfomance.

#### Views
* v_OrderPaymentDate: Creates virtual table to display Order Date and Payment Date of particular Order

#### Triggers
After Insert, Update and Delete triggers are applied on Users and Products table

#### Stored Procedure
* sp_GetCategoryProducts: To display all products for given category name
* sp_SupplierProducts: To display all products supplied by given supplier
* sp_getUserAddresses: To display all address of a particular user
* sp_getUserOrders: To display all orders ordered by particular user


### Tools used
 Microsoft SQL Server Management Studio 18
 
 ### SetUp
 Clone this repository: https://github.com/sakshibasapure/BCT-POC-2-Sakshi-Basapure.git

