use QuanLyBanHang;
-- Hiển thị tất cả customer có đơn hàng trên 150000
select * from Customer
join orders on Orders.cID = Customer.cID
where oTotalPrice> 150000;
-- Hiển thị sản phẩm chưa được bán cho bất cứ ai
select * from Product 
where  Product.pID not in(
select Product.pID from Product
join OrderDetail on OrderDetail.pID = Product.pID
);
-- Hiển thị tất cả đơn hàng mua trên 2 sản phẩm
select * from Orders 
-- join OrderDetail on OrderDetail.oID = Orders.oID
where Orders.oID in (
select oID from OrderDetail
group by oID
having count(oID)>1
);
-- Hiển thị đơn hàng có tổng giá tiền lớn nhất
select * from Orders 
where oTotalPrice = (
select Max(oTotalPrice) from Orders
);
-- Hiển thị sản phẩm có giá tiền lớn nhất
select * from Product 
where pPrice = (
select Max(pPrice) from Product
);
-- Hiển thị người dùng nào mua nhiều sản phẩm “Bep Dien” nhất
select DISTINCT * from Customer 
where Customer.cID = (
select Customer.cID from Customer 
join Orders on Orders.cID = Customer.cID
join OrderDetail on OrderDetail.oID =Orders.oID
join Product on Product.pID =OrderDetail.pID
where Product.pName = 'Bep Dien'
group by Orders.cID
order by count(pName ) desc LIMIT 1
);