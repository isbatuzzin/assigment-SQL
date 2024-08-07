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
from (
    
        left join rating r on mg.mov_id=r.mov_id
) tabel_rating
where num_o_ratings is not null;

-- nomor 7
select m.mov_title 
from movie m, movie_direction md 
where 
    m.mov_id=md.mov_id and md.dir_id=(select dir_id from director where dir_fname ='James' and dir_lname='Cameron');

-- nomor 8
select distinct act_fname as actor_dan_sutradara
from actor
UNION 
select distinct dir_fname
from director;


-- nomor 9
-- mencari jumlah film yang bergenre 'Mystery', 'Drama', 'Adventure'
select gen_title, count(mov_id) 
from (select m.mov_id, mg.gen_id, g.gen_title  
        from movie
            left join movie_genres mg on m.mov_id=mg.mov_id
                left join genres g on g.gen_id=mg.gen_id
                    where gen_title in ('Mystery', 'Drama', 'Adventure')) tabel_genre 
group by gen_title;

-- nomor 10
-- Memberi label durasi film
select mov_id, mov_title, mov_time, 
    case 
        when mov_time < 100 then 'short movie'
        when mov_time between 100 and 130 then 'normal movie'
    else 'long movie'
    end as label_durasi_film
from movie;

