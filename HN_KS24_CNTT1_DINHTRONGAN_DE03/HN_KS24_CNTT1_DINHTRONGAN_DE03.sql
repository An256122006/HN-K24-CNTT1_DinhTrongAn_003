create database if not exists hackathon;
use hackathon;
drop table if exists Appointment;
drop table if exists Department;
drop table if exists Doctor;
drop table if exists Patient;
#1
create table Patient
(
    patient_id        varchar(5) primary key not null,
    patient_full_name VARCHAR(100)           not null,
    patient_dob       DATE                   not null,
    patient_gender    VARCHAR(10)            not null,
    patient_phone     VARCHAR(15) unique     not null
);
create table Doctor
(
    doctor_id        VARCHAR(5) primary key not null,
    doctor_full_name VARCHAR(100)           not null,
    doctor_specialty VARCHAR(100)           not null,
    doctor_phone     VARCHAR(15)            not null unique
);
create table Department
(
    department_id       VARCHAR(5) primary key not null,
    department_name     VARCHAR(100)           not null unique,
    department_location VARCHAR(100)           not null
);
create table Appointment
(
    appointment_id     INT auto_increment primary key not null,
    patient_id         VARCHAR(5)                     not null,
    doctor_id          VARCHAR(5)                     not null,
    department_id      VARCHAR(5)                     not null,
    appointment_date   DATE                           not null,
    appointment_status VARCHAR(20)                    not null,
    foreign key (patient_id) references Patient (patient_id),
    foreign key (doctor_id) references Doctor (doctor_id),
    foreign key (department_id) references Department (department_id)
);
#2
insert into Patient (patient_id, patient_full_name, patient_dob, patient_gender, patient_phone)
values ('P001', 'Nguyễn Văn An', '1995-03-15', 'Nam', '0912345678'),
       ('P002', 'Trần Thị Bích', '1998-07-22', 'Nữ', '0923456789'),
       ('P003', 'Lê Hoàng Minh', '1987-11-05', 'Nam', '0934567890'),
       ('P004', 'Phạm Thu Hà', '2000-01-18', 'Nữ', '0945678901'),
       ('P005', 'Võ Quốc Huy', '1992-09-30', 'Nam', '0956789012');
insert into Doctor (doctor_id, doctor_full_name, doctor_specialty, doctor_phone)
values ('D001',
        'BS. Nguyễn Thanh Tùng',
        'Nội khoa',
        '0901112222'),
       ('D002',
        'BS. Trần Minh Đức',
        'Ngoại khoa',
        '0902223333'),
       ('D003', 'BS. Lê Thị Lan',
        'Nhi khoa',
        '0903334444'),
       ('D004', 'BS. Phạm Quốc Bảo',
        'Tim mạch',
        '0904445555'),
       ('D005', 'BS. Võ Hoàng Yến',
        'Da liễu',
        '0905556666');
insert into Department (department_id, department_name, department_location)
VALUES ('DP01',
        'Khoa Nội',
        'Tầng 1'),
       ('DP02',
        'Khoa Ngoại',
        'Tầng 2'),
       ('DP03',
        'Khoa Nhi',
        'Tầng 3'),
       ('DP04',
        'Khoa Tim mạch',
        'Tầng 4'),
       ('DP05',
        'Khoa Da liễu',
        'Tầng 5');
insert into Appointment (patient_id, doctor_id, department_id, appointment_date, appointment_status)
values ('P001',
        'D001',
        'DP01',
        '2025-10-01',
        'Completed'),
       ('P002',
        'D003',
        'DP03',
        '2025-10-02',
        'Completed'),
       ('P003',
        'D004',
        'DP04',
        '2025-10-03',
        'Pending'),
       ('P004',
        'D002',
        'DP02',
        '2025-10-04',
        'Cancelled'),
       ('P005',
        'D005',
        'DP05',
        '2025-10-05',
        'Completed'),
       ('P001',
        'D005',
        'DP05',
        '2025-10-05',
        'Completed');
# 3
update Patient
set patient_phone='096536868'
where patient_id = 'P003';
select *
from Patient;
# 4
update Appointment
set appointment_status='Cancelled'
where appointment_id = 3;
select *
from appointment;
# 5
delete
from Appointment
where appointment_status = 'Cancelled'
  and appointment.appointment_date < '2025-10-04';
select *
from appointment;
# 6
select appointment_id, appointment_date, appointment_status
from Appointment
where appointment_status = 'Completed'
  and appointment_date > '2025-10-01';
# 7
select Patient.patient_full_name, Patient.patient_phone, Patient.patient_gender
from Patient
where patient_phone like '09%';
# 8
select appointment_id, appointment_date, patient_id
from Appointment
order by appointment_date desc;
# 9
select *
from Appointment
where appointment_status = 'Completed'
limit 3;
# 10
select patient_id, patient_full_name
from Patient
limit 3 offset 2;
# 11
select a.appointment_id, p.patient_full_name, D.doctor_id, a.appointment_date
from Appointment a
         join Patient p on p.patient_id = a.patient_id
         join Doctor D on a.doctor_id = D.doctor_id
where a.appointment_status = 'Completed';
# 12
select D.doctor_id, D.doctor_full_name
from Doctor D
         left join Appointment a on a.doctor_id = D.doctor_id;
# 13
select Appointment.appointment_status, count(appointment_status) as total_appointment
from Appointment
group by Appointment.appointment_status;
# 14
select p.patient_full_name, count(*) as Count_Appointment
from Appointment a
         join Patient p on p.patient_id = a.patient_id
group by p.patient_id
having Count_Appointment >= 2;
# 15

# 16
select p.patient_full_name, p.patient_phone
from appointment A
         join Patient p on p.patient_id = A.patient_id
         join Department D on A.department_id = D.department_id
where D.department_name = 'Khoa nội';
# 17
select A.appointment_id, p.patient_full_name, D2.doctor_full_name, D.department_name, A.appointment_status
from appointment A
         join Patient p on p.patient_id = A.patient_id
         join Department D on A.department_id = D.department_id
         join Doctor D2 on D2.doctor_id = A.doctor_id;