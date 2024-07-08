-- create database
create database sekolah;

-- masuk ke database sekolah
\c sekolah;

-- create tabel student

create table student (
    id int not null AUTO_INCREMENT, 
    first_name varchar(10) not null, 
    last_name varchar(10) default null, 
    email varchar(25) unique not null, 
    age int  default 18,
    gender varchar(6) not null
        check (gender = 'male' or 'female',
    date_of_birth date not null, 
    created_at timestamp with time zone UTC default now,
    PRIMARY KEY (Personid)
);