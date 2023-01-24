CREATE VIEW OrdersView AS
SELECT O.idOrders,ItemQuantity,BillAmount FROM ORDERS O
LEFT JOIN ORDERDETAILS OD ON O.idOrders=OD.OrderID
WHERE ItemQuantity > 2

TASK 2

SELECT
	O.CustomerID,
	CONCAT(C.FIRSTNAME,' ',C.LASTNAME) AS FullName,
	O.idOrders as Order_ID,
	O.BillAmount as Cost,
	CT.CuisineName as Menu_Name,
	MI.ItemName AS Course_Name
FROM ORDERS O
	LEFT JOIN CUSTOMERS C ON O.CustomerID = C.CustomerId
	LEFT JOIN OrderDetails OD ON O.IdOrders = OD.OrderID
	LEFT JOIN MenuItems MI ON OD.MenuItemId = MI.IdMenuITems
	LEFT JOIN Menu M ON OD.MenuItemId = M.idMenuItems
	LEFT JOIN CuisineType CT ON M.Cuisine = CT.idCuisineType

TASK 3

SELECT
	MI.ItemName AS Course_Name
FROM ORDERS O
	LEFT JOIN OrderDetails OD ON O.IdOrders = OD.OrderID
	LEFT JOIN MenuItems MI ON OD.MenuItemId = MI.IdMenuITems
	LEFT JOIN Menu M ON OD.MenuItemId = M.idMenuItems
WHERE 1=1
	AND OD.ItemQuantity > 2


TASK 1

CREATE PROCEDURE GetMaxQuantity()
SELECT
SUM(ItemQuantity) AS MAX_QUANTITY_IN_ORDER
FROM OrderDetails
GROUP BY OrderID
ORDER BY MAX_QUANTITY_IN_ORDER DESC
LIMIT 1

TASK 2

PREPARE GetOrderDetail FROM 
'SELECT 
	OD.OrderId,
	ItemQuantity AS Quantity,
    BillAmount AS Cost
FROM ORDERDETAILS OD
LEFT JOIN ORDERS O ON OD.OrderID = O.idOrders
WHERE CustomerID = ?;'

TASK 3
CREATE PROCEDURE CancelOrder
(	
	IN OrderID INT
)
DELETE FROM ORDERS
WHERE idOrders = OrderID;
