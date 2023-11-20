create database MarketDB2;
USE MarketDB2;

create table Occupation
(
  Id int identity primary key,
  Name nvarchar(25)
);

create table Employees
(
  Id int identity primary key,
  Name nvarchar(50) NOT NULL,
  Surname nvarchar(50) default 'XXX',
  PatronymicName nvarchar(50) default 'XXX',
  Salary money NOT NULL,
  DepartmentId int references Occupation(Id)
);

create table Branches
(
  Id int identity primary key,
  Name nvarchar(50)
);

create table Products
(
  Id int identity primary key,
  Name nvarchar(25) NOT NULL,
  BuyPrice money NOT NULL,
  SellPrice money NOT NULL
);

create table  Product_Sales
(
  Id int identity primary key,
  ProductId int REFERENCES Products(Id),
  EmployeeId int references Employees(Id),
  BranchId int references Branches(Id),
  SaleDate datetime NOT NULL DEFAULT GETDATE()
);

INSERT INTO Occupation (Name) VALUES ('Cashier'), ('Packer'), ('Security'), ('Maintenance');

INSERT INTO Employees (Name, Surname, PatronymicName, Salary, DepartmentId) VALUES
('John', 'Price', 'MacTavish', 1500, 1),
('Alex', 'Mason', 'David', 1200, 3),
('Nikolai', 'Belinski', 'Dmitri', 1000, 4),
('Samantha', 'Maxis', 'Edward', 1300, 2),
('Frank', 'Woods', 'Joseph', 1100, 3),
('Simon', 'Riley', NULL, 1400, 1);

INSERT INTO Branches (Name) VALUES ('Khalqhlar'), ('Hazi Aslanov'), ('Ahmedli'), ('Elmler');

INSERT INTO Products (Name, BuyPrice, SellPrice) VALUES
('Nuclear Warhead', 500, 700),
('Emp Device', 1000, 1500),
('Door Charge', 100, 150),
('Bread', 250, 350),
('Claymore', 750, 1000);


INSERT INTO Product_Sales (ProductId, EmployeeId,BranchId,SaleDate) VALUES
(1, 5,1,'2023-11-20 21:11:00'),
(1, 3,2,'2022-11-20 20:11:00'),
(2, 4,3,'2023-11-10 12:11:00'),
(3, 5,4,'2023-10-10 22:11:00'),
(4, 6,4,'2022-11-20 23:11:00'),
(5, 1,4,'2022-11-20 05:11:00');

-- 1

SELECT E.Name as [Employee Name], P.Name AS [Product Name], B.Name AS [Branch Name], P.SellPrice, P.BuyPrice
FROM Product_Sales PS left join Products P on PS.ProductId = P.Id
left join Employees E on PS.EmployeeId = E.Id
left join Branches B on PS.BranchId = B.Id

-- 2

SELECT SUM(P.SellPrice) AS TotalSaleAmount FROM Product_Sales PS left join Products P on P.Id = PS.ProductId

-- 3

SELECT SUM(P.SellPrice) AS TotalSellPrice, MONTH(GETDATE()) AS Month
FROM Product_Sales PS left join Products P on P.Id = PS.ProductId
WHERE MONTH(PS.SaleDate) = MONTH(GETDATE())

