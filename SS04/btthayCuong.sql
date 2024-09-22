use baitapthayCuong;
alter table building add constraint c1 FOREIGN KEY (host_id) REFERENCES host(id);
alter table building add constraint c2 FOREIGN KEY (contractor_id) REFERENCES contractor(id);

alter table design add constraint c3 FOREIGN KEY (building_id) REFERENCES building(id);
alter table design add constraint c4 FOREIGN KEY (architect_id) REFERENCES architect(id);


alter table work add constraint c5 FOREIGN KEY (building_id) REFERENCES building(id);
alter table work add constraint c6 FOREIGN KEY (worker_id) REFERENCES worker(id);

-- Hiển thị toàn bộ nội dung của bảng Architect
select * from architect;
-- Hiển thị những năm sinh có thể có của các kiến trúc sư
select DISTINCT birthday from architect
where birthday is not null;
-- Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh tăng dần)
select name, birthday from architect
order by birthday;
-- Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh giảm dần)
select name, birthday from architect
order by birthday desc;
-- Hiển thị danh sách các công trình có chi phí từ thấp đến cao. Nếu 2 công trình có chi phí bằng nhau sắp xếp tên thành phố theo bảng chữ cái building
select * from building
order by cost, city;

-- Hiển thị tất cả thông tin của kiến trúc sư "le thanh tung"
select * from architect
where name = "le thanh tung";
-- Hiển thị tên, năm sinh các công nhân có chuyên môn hàn hoặc điện
select * from worker;
select * from worker
where skill in ("han","dien");
-- Hiển thị tên các công nhân có chuyên môn hàn hoặc điện và năm sinh lớn hơn 1948
select * from worker
where skill in ("han","dien") and birthday > 1948;
-- Hiển thị những công nhân bắt đầu vào nghề khi dưới 20 (birthday + 20 > year)
select * from worker
where year-birthday>20;
-- Hiển thị những công nhân có năm sinh 1945, 1940, 1948 (Bằng 2 cách)
select * from worker
where birthday in ("1945","1940","1948");
select * from worker
where birthday = "1945" or birthday = "1940" or birthday = "1948";

-- Tìm những công trình có chi phí đầu tư từ 200 đến 500 triệu đồng (Bằng 2 cách)
select * from building;
select * from building
where cost >= 200 and cost <= 500;

select * from building
where cost between 200 and 500;

-- Tìm kiếm những kiến trúc sư có họ là nguyen: % chuỗi
select * from architect
where name like "nguyen %";
-- Tìm kiếm những kiến trúc sư có tên đệm là anh
select * from architect
where name like "% anh %";
-- Tìm kiếm những kiến trúc sư có tên bắt đầu th và có 3 ký tự
select * from architect
where name like "%th_";
-- Tìm chủ thầu không có phone
select * from contractor;
select * from contractor
where phone is null;
select city, Sum(cost) from building
group by city
having Sum(cost)>2000;


-- EX05
-- Thống kê tổng số kiến trúc sư
select count(id) as 'tong so kien truc su' from architect;
-- Thống kê tổng số kiến trúc sư nam
select count(id) as 'tong so kien truc su' from architect where sex =1;
-- Tìm ngày tham gia công trình nhiều nhất của công nhân

select sum(total) from baitapthayCuong.work group by worker_id 
order by sum(total) desc limit 1;

-- Tìm ngày tham gia công trình ít nhất của công nhân
select sum(total) from baitapthayCuong.work group by worker_id 
order by sum(total) limit 1;

-- Tìm tổng số ngày tham gia công trình của tất cả công nhân
select sum(total) from work;

-- Tìm tổng chi phí phải trả cho việc thiết kế công trình của kiến trúc sư có Mã số 1
select sum(benefit) from design where architect_id = 1;

-- Tìm trung bình số ngày tham gia công trình của công nhân
SELECT AVG(total) FROM work;
-- Hiển thị thông tin kiến trúc sư: họ tên, tuổi
select name, 2024-birthday as age from architect;
-- Tính thù lao của kiến trúc sư: Thù lao = benefit * 1000
select architect.*, sum(benefit)*100 as 'thu lao' from design 
join architect on architect.id=  design.architect_id
group by architect.id;

-- Exercise 06
-- Hiển thị thông tin công trình có chi phí cao nhất
select max(cost) from building;
-- Hiển thị thông tin công trình có chi phí lớn hơn tất cả các công trình được xây dựng ở Cần Thơ
select * from building
where cost > all (
SELECT cost from building where city = "can tho"
);
-- Hiển thị thông tin công trình có chi phí lớn hơn một trong các công trình được xây dựng ở Cần Thơ
select * from building
where cost > some (
SELECT cost from building where city = "can tho"
);
-- Hiển thị thông tin công trình chưa có kiến trúc sư thiết kế_____________
select * from building 
cross join design on design.building_id = building.id
where architect_id is null
-- Hiển thị thông tin các kiến trúc sư cùng năm sinh và cùng nơi tốt nghiệp
SELECT *
FROM architect A, architect B
WHERE A.id <> B.id
and A.birthday = B.birthday
AND A.place = B.place 
ORDER BY A.place;

-- Exercise 07
-- Hiển thị thù lao trung bình của từng kiến trúc sư
select avg(benefit) *1000 from design;
-- Hiển thị chi phí đầu tư cho các công trình ở mỗi thành phố
select city ,sum(cost) from building 
group by city;
-- Tìm các công trình có chi phí trả cho kiến trúc sư lớn hơn 50
select sum(benefit) from design
group by building_id
having sum(benefit)> 50;
-- Tìm các thành phố có ít nhất một kiến trúc sư tốt nghiệp
select DISTINCT place from architect;

-- Exercise 08
-- Hiển thị tên công trình, tên chủ nhân và tên chủ thầu của công trình đó
select building.name as 'ten cong trinh', host.name as 'ten chu nhan', contractor.name as 'ten chu thau' from building
join contractor on contractor.id =building.contractor_id
join host on host.id =building.host_id;
-- Hiển thị tên công trình (building), tên kiến trúc sư (architect) và
-- thù lao của kiến trúc sư ở mỗi công trình (design)
select building.name as 'ten cong trinh', architect.name as 'tên kiến trúc sư', design.benefit as 'thù lao' from design
join architect on architect.id =design.architect_id
join building on building.id =design.building_id;

-- Hãy cho biết tên và địa chỉ công trình (building) do chủ thầu Công ty xây dựng số 6 thi công (contractor)
select building.name, building.address from building
join contractor on contractor.id = building.contractor_id
where contractor.name  = 'cty xd so 6';
-- Tìm tên và địa chỉ liên lạc của các chủ thầu (contractor) thi công công trình ở Cần Thơ (building) do kiến trúc sư le kim dungLê Kim Dung thiết kế (architect, design)
select contractor.name, contractor.address from contractor
join building  on building.contractor_id = contractor.id
join design  on building.id =design.building_id
join architect  on architect.id =design.architect_id
where	architect.name = 'le kim dung'
and building.city = 'can tho';

-- Hãy cho biết nơi tốt nghiệp của các kiến trúc sư (architect) đã thiết kế (design) công trình Khách Sạn Quốc Tế ở Cần Thơ (building)
select architect.place from architect
join design on design.architect_id= architect.id
join building on building.id = design.building_id
where building.city = 'can tho'
and building.name = 'khach san quoc te';
-- Cho biết họ tên, năm sinh, năm vào nghề của các công nhân có chuyên môn hàn hoặc điện (worker) 
-- đã tham gia các công trình (work) mà chủ thầu Lê Văn Sơn (contractor) đã trúng thầu (building)
select worker.name,worker.birthday, worker.year from worker
join work on work.worker_id = worker.id
join  building on building.id = work.building_id
join contractor on contractor.id = building.contractor_id
where worker.skill in ('han','dien')
and contractor.name = 'le van son';
-- Những công nhân nào (worker) đã bắt đầu tham gia công trình Khách sạn Quốc Tế ở Cần Thơ (building) 
-- trong giai đoạn từ ngày 15/12/1994 đến 31/12/1994 (work) số ngày tương ứng là bao nhiêu
select worker.*, building.id, work.total from worker
join work on work.worker_id = worker.id
join building on work.building_id = building.id
where building.name = 'khach san quoc te'
and work.date between '1994-12-15' and '1994-12-31';

-- Cho biết họ tên và năm sinh của các kiến trúc sư đã tốt nghiệp ở TP Hồ Chí Minh (architect) 
-- và đã thiết kế ít nhất một công trình (design) có kinh phí đầu tư trên 400 triệu đồng (building)
select DISTINCT architect. name, architect.birthday from architect
join design on design.architect_id = architect.id
join building on design.building_id = building.id
where building.cost > 400; 
-- Cho biết tên công trình có kinh phí cao nhất
select building.name FROM building
where cost = (
select max(cost) FROM building
);

-- Cho biết tên các kiến trúc sư (architect) vừa thiết kế các công trình (design)
-- do Phòng dịch vụ sở xây dựng (contractor) thi công vừa thiết kế các công trình do chủ thầu Lê Văn Sơn thi công
 select architect.name,contractor.* from architect
 join design on design.architect_id = architect.id
 join building on design.building_id = building.id
 join contractor on building.contractor_id = contractor.id
where contractor.name in ('le van son','phong dich vu so xd');
-- ???

-- Cho biết họ tên các công nhân (worker) có tham gia (work) các công trình ở Cần Thơ (building)
-- nhưng không có tham gia công trình ở Vĩnh Long
select  * from  worker
WHERE  worker.id in(
select worker.id from  worker
join work on work.worker_id =worker.id
join building on work.building_id = building.id
where building.city = 'can tho'
);
-- Cho biết tên của các chủ thầu đã thi công các công trình có kinh phí lớn hơn tất cả các công trình 
-- do chủ thầu phòng Dịch vụ Sở xây dựng thi công
select DISTINCT contractor.name, building.cost from contractor
JOIN building on contractor.id = building.contractor_id
where building.cost >
(SELECT max(cost) FROM building
JOIN contractor on contractor.id = building.contractor_id
where contractor.name = 'phong dich vu so xd');
-- Cho biết họ tên các kiến trúc sư có thù lao thiết kế một công trình nào đó 
-- dưới giá trị trung bình thù lao thiết kế cho một công trình
select DISTINCT architect.* from architect
join design on design.architect_id =architect.id
where design.benefit > (
select avg(benefit) from design );
-- Tìm họ tên và chuyên môn của các công nhân (worker) tham gia (work)
-- các công trình do kiến trúc sư Le Thanh Tung thiet ke (architect) (design)
select DISTINCT worker.name, worker.skill from worker
join work on work.worker_id = worker.id
join building on building.id = work.building_id
join design on design.building_id = building.id
join architect on architect.id = design.architect_id
where architect.name = 'le thanh tung';

-- Tìm các cặp tên của chủ thầu có trúng thầu các công trình tại cùng một thành phố
-- self join

-- Tìm tổng kinh phí của tất cả các công trình theo từng chủ thầu
select contractor.*, sum(building.cost) FROM contractor
join building on building.contractor_id = contractor.id
group by contractor.id;
-- Cho biết họ tên các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
select architect.name, sum(design.benefit) from architect
join design on design.architect_id =architect.id
group by design.architect_id
HAVING sum(design.benefit) > 25;
-- Tìm tổng số công nhân đã than gia ở mỗi công trình
select building.*, count(work.worker_id) from building
left join work on work.building_id =building.id
group by building.id;
-- Tìm tên và địa chỉ công trình có tổng số công nhân tham gia nhiều nhất

select building.*, count(work.worker_id) from building
left join work on work.building_id =building.id
group by building.id
having count(work.worker_id) = 
(select count(work.worker_id) from building
left join work on work.building_id =building.id
group by building.id
order by count(work.worker_id) desc limit 1);
-- Cho biêt tên các thành phố và kinh phí trung bình cho mỗi công trình của từng thành phố tương ứng
select building.city, avg(cost) from building
group by city;
-- Cho biết họ tên các công nhân có tổng số ngày tham gia vào các công trình lớn hơn tổng số ngày tham gia của công nhân Nguyễn Hồng Vân
select worker.*, sum(work.total) from work
join worker on worker.id = work.worker_id
group by id
having sum(work.total)> (
select sum(work.total) from work
join worker on worker.id = work.worker_id
where worker.name = 'nguyen hong van'
group by id
);
-- Cho biết tổng số công trình mà mỗi chủ thầu đã thi công tại mỗi thành phố
SELECT contractor.name, count(building.city) 
FROM contractor
left join building on building.contractor_id =contractor.id
GROUP BY  contractor.id;

-- pivot table

-- Cho biết họ tên công nhân có tham gia ở tất cả các công trình
