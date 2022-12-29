SELECT Firstname from Employees where EmployeeID>5
SELECT EmployeeID, Firstname,LastName,BirthDate from Employees where YEAR(BirthDate) =1960
SELECT EmployeeID, Firstname,LastName,BirthDate from Employees where  YEAR(BirthDate) <1965  and YEAR(BirthDate)>1950

SELECT EmployeeID, Firstname,LastName,Title,Address,Country, BirthDate from Employees where  Country='UK' And TitleOfCourtesy='Ms.'

SELECT EmployeeID, Firstname,LastName,Title,Address,Country, BirthDate from Employees where TitleOfCourtesy='Mr.'or  Year(Getdate()) -Year(BirthDate)>60;

select * from Employees  order by TitleOfCourtesy asc ,BirthDate desc

select * from Employees 
where FirstName between 'Janet' and 'Robert' order by 3
select  FirstName, [year_] =year(BirthDate)from  Employees where Year(BirthDate) In(1950,1955,1960)

select COUNT(EmployeeID) from Employees
Order by EmployeeID

SELECT * from Employees where  SUBSTRING(FirstName,1,1)='A' 

SELEct * from Employees where LastName Like '%N'

Select* from Employees where FirstName like'%e%'

SELEct * from Employees where FirstName Like  'A%' or FirstName  Like 'L%'
SELEct * from Employees where FirstName  Like '%[RT]%'

SELEct * from Employees where FirstName  between 'j' and 'r' order by FirstName


SELEct * from Employees where FirstName  Like '%[J-R]%' order by FirstName



--1
SELEct * from Employees where FirstName  Like '%A_E%' order by FirstName

--2
Select * from Employees where FirstName Like '%A__E%'

--3
Select * from Employees where FirstName not Like 'E%'

--4
Select * from Employees where FirstName not Like 'T%'

--5
Select * from Employees where FirstName not Like '_A%' OR FirstName not Like '_T%'
Select * from Employees where FirstName not Like '_[AT]%'


--6
Select *from Employees where FirstName Like 'LA%' or  FirstName Like 'LN%'or  FirstName Like 'AA%'or  FirstName Like 'LB%'

--7
Select * from Employees
WHERE FirstName LIKE '%\_%' ESCAPE '\'

--_____________________________________________________________________

Create database MyWindRNET101
GO



create Table Position(
Id int primary key not null identity,
Name nvarchar(300) not null,
)
create Table Employees(
Id int primary key not null identity,
FirstName nvarchar(200) not null,
LastName nvarChar(200) not null,
FatherName nvarchar(200) not null,
PositionId int,
foreign key (PositionId) references Position (Id ),
)

create Table Branch(
Id int primary key not null identity,
Branch nvarchar(300) not null,
)

create Table Product(
Id int primary key not null identity,
Name nvarchar(300) not null,
SalesPrice money ,
PurchasePrice money,
)


create Table Sales(
Id int primary key not null identity,
SalesDate datetime default getdate() not null,
ProductId int,
foreign key (ProductId) references Product(Id),
EmployeeId int,
foreign key (EmployeeId) references Employee(Id),
BranchId int,
foreign key (BranchId) references Branch (Id )
)


insert into Position
values ('Sales Manager'),('Sales Consult'),('The Fahla'),('CEO')
GO
Insert into Employee
values('Fazil','Hasanvic','Famil',1)  ,('Huseyn','Hasanvic','Asim',2),('Murat','Vuranok','Vuranok',2); 
Go
insert into Branch
values ('Khirdalan'),('Sumqait'),('Ganja'),('Ganja 2')
Go
insert into Product 
values ('Apple',12,10),('banana',98,24),('Egg',13,11),('Green Veg',125,108),('Vhisky',400,10)
GO
insert into Sales
values(getdate(),1,1,1),(getdate(),1,2,1),(getdate(),1,1,2),(getdate(),1,1,3),(getdate(),1,3,1)




-- 2)get all sales price
Select SUM(SalesPrice)as SumPrice from( Sales
inner join Product on Sales.ProductId=Product.Id)

--3)
Select SUM(SalesPrice)as CurrentMountPrice  from( Sales
inner join Product on Sales.ProductId=Product.id)
where Month(SalesDate) Like Month(GetDate()) 



--1)
Select Employee.FirstName ,Product.Name,Branch,PurchasePrice,SalesPrice from Sales 
inner join
Product on Sales.id =Product.Id
inner join Branch 
Branch on Sales.id =Branch.Id
inner join Employee
Employee on Sales.EmployeeId =Employee.Id


--4

Select COUNT(Product.Id) as MaxSale ,Employee.FirstName from Sales
inner join
Product on Sales.ProductId =Product.Id
inner join
Employee on Sales.EmployeeId=Employee.Id
group by
Employee.FirstName

--5
Select Branch,COUNT(Branch.Id)as CountSale from Sales
inner join Branch
on Branch.Id=Sales.BranchId
where Day(Sales.SalesDate)=DAY(GETDATE())
group by Branch.Branch
order by CountSale desc

--6

Select Name ,COUNT(ProductId) as ProductCount from( Sales
inner join Product on Sales.ProductId=Product.id)
where Month(SalesDate) Like Month(GetDate()) 
group by Product.Name

