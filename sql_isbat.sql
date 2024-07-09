-- nomor 3 tabel student
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

-- nomor 4 dataset film
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


-- nomor 5 dataset ninja
-- query tanda index
select nama, desa from ninja where email='naruto@mail.com';

explain select nama, desa from ninja where email='naruto@mail.com';

-- buat index email
create index email_idx on ninja (email);

-- lihat hasil index
\d ninja;

set enable_seqscan = off;

-- test
explain select nama, desa from ninja where email='naruto@mail.com';


-- nomor 6
select *, rank() over (
            partition by gen_id
            order by num_o_ratings desc) as ranking_film 
from (select m.mov_id, mg.gen_id,  r.num_o_ratings from movie m
    right join movie_genres mg on m.mov_id=mg.mov_id
        left join rating r on mg.mov_id=r.mov_id
) tabel_rating
where num_o_ratings is not null;

-- nomor 7


-- nomor 8


-- nomor 9


-- nomor 10


