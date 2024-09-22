use ex04;
-- Hiển thị số lượng sinh viên theo từng địa chỉ nơi ở.
select address, count(address) from student
group by address;
-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select * from subject
join mark on subject.subjectId = mark.subject_id
where mark.mark = (
select MAX(mark) from mark
);
-- Tính điểm trung bình các môn học của từng học sinh.
select student.*, AVG(mark) from student
join mark on mark.student_id= student.studentId
group by studentId;
-- Hiển thị những bạn học viên có điểm trung bình các môn học nhỏ hơn bằng 70.
select student.*, AVG(mark) from student
left join mark on mark.student_id= student.studentId
group by studentId
having AVG(mark) <= 7.0;
-- Hiển thị thông tin học viên có điểm trung bình các môn lớn nhất.
select student.*, AVG(mark)from student
left join mark on mark.student_id= student.studentId
group by studentId 
order by AVG(mark) desc limit 1;

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select student.*, AVG(mark)from student
left join mark on mark.student_id= student.studentId
group by studentId 
order by AVG(mark) desc ;