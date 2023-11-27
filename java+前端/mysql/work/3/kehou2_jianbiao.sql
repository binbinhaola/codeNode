CREATE DATABASE ProductSales

CREATE TABLE Product(
	
	ProductID INT PRIMARY KEY AUTO_INCREMENT COMMENT'产品编号',
	ProductName VARCHAR(20) COMMENT'产品名称',
	Price INT COMMENT'产品价格'
	
)COMMENT'产品表' CHARSET='utf8';

CREATE TABLE Sales(

	ProductID INT COMMENT'产品编号',
	ClientName VARCHAR(20) COMMENT'客户名称',
	ProductNumber INT COMMENT'购买数量',
	SalesPrice INT COMMENT'售出价格/个',
	
	CONSTRAINT FOREIGN KEY fk_productID(ProductID)
	REFERENCES Product(ProductID)
	
)COMMENT'产品表' CHARSET='utf8';