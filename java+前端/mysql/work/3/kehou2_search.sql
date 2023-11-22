INSERT INTO Product VALUE('1','HP1200打印机','2000'),
('2','LX360兼容机','4800'),
('3','IBM350笔记本','11000'),
('4','BM360笔记本','12000');

INSERT INTO Sales VALUE('2','北大青鸟','10','4500'),
('1','北大青鸟','25','1800'),
('3','联想集团','10','11000'),
('2','联想集团','30','4500'),
('1','联想集团','20','1800'),
('3','北大方正','40','10000'),
('3','诺基亚','20','10500');

SELECT ClientName,ProductNumber,SalesPrice
FROM sales
WHERE ProductNumber >'15';

SELECT product.ProductName,SUM(sales.SalesPrice*sales.ProductNumber) AS 销售额
FROM product
JOIN sales ON product.ProductID=sales.ProductID
GROUP BY product.ProductName

SELECT product.ProductName,SUM(sales.ProductNumber) AS 销售数
FROM product
JOIN sales ON product.ProductID=sales.ProductID
GROUP BY product.ProductName

SELECT product.ProductName,SUM(sales.ProductNumber) AS 销售数
FROM product
JOIN sales ON product.ProductID=sales.ProductID
GROUP BY product.ProductName 
ORDER BY SUM(sales.ProductNumber) DESC LIMIT 1

SELECT product.ProductName,SUM(sales.ProductNumber) AS 销售数
FROM product
JOIN sales ON product.ProductID=sales.ProductID
GROUP BY product.ProductName 
HAVING SUM(sales.ProductNumber)>40

SELECT product.ProductName,sales.ClientName,sales.ProductNumber
FROM product
JOIN sales ON product.ProductID=sales.ProductID
WHERE product.ProductName='IBM350笔记本'

UPDATE sales 
SET clientName='北大青鸟APTECH'
WHERE clientName='北大青鸟'