CREATE VIEW OrdersView AS
SELECT O.idOrders,ItemQuantity,BillAmount FROM ORDERS O
LEFT JOIN ORDERDETAILS OD ON O.idOrders=OD.OrderID
WHERE ItemQuantity > 2