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

-- store procedure/function  menghitung jumlah film  berdasarkan genre

CREATE OR REPLACE FUNCTION hitung_jumlah_film_berdasarkan_genre(
    genre_id_param INT
) RETURNS INT AS $$
DECLARE
    jumlah_film INT;
BEGIN
    jumlah_film=(select count (mg.gen_id) from movie m
    right join movie_genres mg on m.mov_id=mg.mov_id
    group by mg.gen_id
    having mg.gen_id = genre_id_param);

    RETURN jumlah_film;
END;
$$ LANGUAGE plpgsql;

--call function
select hitung_jumlah_film_berdasarkan_genre(1002) a;
