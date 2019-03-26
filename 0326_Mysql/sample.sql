use sample;

--회원테이블
create table usertbl(
userid char(15) not null primary key,
name varchar(20) not null,
birthyear int not null, 
addr char(100),
mobile char(11),
mdate date)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--구매테이블
create table buytbl(
num int auto_increment primary key,
userid char(8) not null,
productname char(10),
groupname char(10),
price int not null,
amount int not null,
foreign key (userid) references usertbl(userid) on delete cascade)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--데이터 삽입
insert into usertbl values('kty', '김태연',1989,'전주','01011111111', '1989-3-9');
insert into usertbl values('bsj', '배수지',1994,'광주','01022222222', '1994-10-10');
insert into usertbl values('ksh', '김설현',1995,'부천','01033333333', '1995-1-3');
insert into usertbl values('bjh', '배주현',1991,'대구','01044444444', '1991-3-29');
insert into usertbl values('ghr', '구하라',1991,'광주','01055555555', '1991-1-13');
insert into usertbl values('san', '산다라박',1984,'부산','01066666666', '1984-11-12');
insert into usertbl values('jsm', '전소미',2001,'캐나다','01077777777', '2001-3-9');
insert into usertbl values('lhl', '이효리',1979,'서울','01088888888', '1979-5-10');
insert into usertbl values('iyou', '아이유',1993,'서울','01099999999', '1993-5-19');
insert into usertbl values('ailee', '에일리',1989,'미국','01000000000', '1989-5-30');

commit;

insert into buytbl values(null, 'kty', '운동화', '잡화', 30, 2);
insert into buytbl values(null, 'kty', '노트북', '전자', 1000, 1);
insert into buytbl values(null, 'jsm', '운동화', '잡화', 30, 1);
insert into buytbl values(null, 'lhl', '모니터', '전자', 200, 1);
insert into buytbl values(null, 'bsj', '모니터', '전자', 200, 1);
insert into buytbl values(null, 'kty', '청바지', '잡화', 100, 1);
insert into buytbl values(null, 'lhl', '책', '서적', 15, 2);
insert into buytbl values(null, 'iyou', '책', '서적', 15, 7);
insert into buytbl values(null, 'iyou', '컴퓨터', '전자', 500, 1);
insert into buytbl values(null, 'bsj', '노트북', '전자', 1000, 1);
insert into buytbl values(null, 'bjh', '메모리', '전자', 50, 4);
insert into buytbl values(null, 'ailee', '운동화', '잡화', 30, 2);
insert into buytbl values(null, 'ghr', '운동화', '잡화', 30, 1);

commit;

/*usertbl 테이블의 모든 데이터를 조회*/
select *
from usertbl;

/*usertbl 테이블에서 userid와 name 만 조회*/
select userid,name

/*usertbl 테이블에서 name이 '김태연'인 데이터 조회*/
select * from usertbl where name = '김태연';

/*usertbl 테이블에서 birthyear 가 1990년 이후이고 addr이 '서울'인 데이터의 모든 컬럼을 조회*/
select * from usertbl where birthyear > 1990 and addr = '서울';

/*usertbl 테이블에서 birthyear 가 1990년 이후이거나 addr이 '서울'인 데이터의 userid와 name을 조회*/
select userid, name from usertbl where birthyear >1990 or addr = '서울';

/*usertbl 테이블에서 birthyear 가 1990년 부터 1993년 사이인 데이터의 모든 컬럼 조회*/
select * from usertbl where birthyear >= 1990 and birthyear <= 1993 ;
select * from usertbl where birthyear BETWEEN 1990 and 1993 ;
/*usertbl 테이블에서 name에 '라' 가 포함된 데이터의 모든 컬럼 조회*/
select * from usertbl where name LIKE '%라%';

/*usertbl 테이블에서 name이 '배' 로 시작하는 데이터의 모든 컬럼을 조회*/
select * from usertbl where name LIKE '배%' ;

/*buytbl 테이블에서 중복되지 않도록 userid를 조회 */
select DISTINCT userid from buytbl ;
select userid from buytbl group by userid ;

/*buytbl 테이블에서 userid 별로 데이터 개수와 price의 합계를 조회*/
select userid, COUNT(*), SUM(price) from buytbl group by userid ;

/*buytbl 테이블에서 userid 별로 데이터 개수와 price의 합계를 조회하는데, 데이터가 2개 이상인 데이터만 조회*/
select userid, COUNT(*), SUM(price) from buytbl group by userid HAVING count(*) >= 2;

/*usertbl 테이블의 데이터를 userid의 내림 차순으로 정렬해서 출력*/
select * from usertbl ORDER BY userid DESC;

/*usertbl 테이블의 데이터를 birthyear의 오름 차순으로 정렬해서 출력하는데, birthyear가 동일하면 name의 내림차순으로 정*/
select * from usertbl ORDER BY birthyear ASC, name DESC;

/*데이터를 정렬하고 앞에서부터 5개 가져오기*/ 
select * from usertbl ORDER BY birthyear ASC, name DESC LIMIT 5;

/*데이터를 정렬하고 두번째 부터 5개 가져오기*/
select * from usertbl ORDER BY birthyear ASC, name DESC LIMIT 1, 5;

/*usertbl 테이블의 name 과 buytbl 테이블의 productname을 함께 조회*/
SELECT name, productname from usertbl, buytbl WHERE usertbl.userid = buytbl.userid;

/*usertbl 테이블에서 userid와 mobile 그리고 buytbl에서 groupname을 조회 birthyear가 1993	이상인 데이터만 조회*/
SELECT usertbl.userid, mobile, groupname from usertbl, buytbl WHERE usertbl.userid = buytbl.userid and birthyear >= 1993;

/*usertbl 테이블의 name이 전소미인 데이터의 buytbl의 userid 와 productname 그리 groupname을 조회
 * ->테이블이 2개 있어야만 원하는 결과를 조회할 수 있는데 이전 상황과 다른 점은 조회할 열들이 buytbl 테이블에 존재한다.*/
SELECT buytbl.userid, productname, groupname from usertbl, buytbl WHERE usertbl.userid = buytbl.userid and name = '전소미' ;
SELECT userid, productname, groupname from buytbl WHERE userid = (select userid from usertbl where name ='전소미') ;

/*usertbl 테이블의 name이 전소미 또는 배수지 데이터의 buytbl의 userid 와 productname 그리 groupname을 조회 */
SELECT userid, productname, groupname from buytbl WHERE userid IN (select userid from usertbl where name ='전소미' or name = '배수지') ;
SELECT userid, productname, groupname from buytbl WHERE userid IN (select userid from usertbl where name IN ('전소미','배수지')) ;

-- 외래키가 없을 때는 not null, unique에 주의해서 삽
insert into usertbl(userid, name, birthyear, addr, mobile, mdate) values('kty1', '김태연', 1989, '전주', '01012345678', '1988-01-01');

-- 외래키가 있는 테이블은 외래키를 확인하고 삽입해야 한다.
insert into buytbl(userid, productname, groupname, price, amount) values('ggae','스파클링','음료수',5700,1);

SELECT * FROM buytbl;

/*buytbl 테이블에 num이 9번인 데이터가 있는지 확인*/
select * from buytbl where num = 9;
/*buytbl 테이블에서 num 이 9 번인 데이터의 price를 700000으로 수정*/
update buytbl set price = 700000 where num =9 ;

/* buytbl 테이블에서 num이 9번인 데이터를 삭제*/
delete FROM buytbl WHERE num = 9 ;

/*usertbl 테이블에 데이터를 삽입하는 프로시저*/
CREATE PROCEDURE insertuser(
	vuserid char(15), 
	vname varchar(10)CHARACTER SET utf8,
	vbirthyear int,
	vaddr char(100)CHARACTER SET utf8,
	vmobile char(11),
	vmdate date )	
BEGIN
	insert into usertbl(userid, name, birthyear, addr, mobile, mdate) VALUES(vuserid, vname, vbirthyear, vaddr, vmobile, vmdate);
END;

/*프로시저를 실행*/
CALL insertuser('joy','조이',1996,'jeju','01044452222','1999-02-02');

/*프로시저 삭제*/
drop PROCEDURE insertuser;

/*프로시저를 실행*/
CALL insertuser('jyp','박진', 1975,'강원','01077775222','1975-04-02');

/*확인*/
SELECT * FROM usertbl;

Select userid, name from usertbl where userid = 'kty';

Select distinct userid from usertbl ;

select avg(price) from buytbl;

