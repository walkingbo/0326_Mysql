/* sample 데이터 베이스를 사용*/
use sample;

/*테이블 생성구문*/
/*MyISAM은 조회에 유리 InnoDB는 삽입 및 갱신 그리고 삭제 작업에 유리*/
/*ArrayList 와 LinkedList의 특징과 동일*/
/*charset을 설정하지 않으면 한글 입력 안됨*/

CREATE TABLE contact(
	num integer AUTO_INCREMENT PRIMARY KEY,
	name varchar(15) not null,
	alias varchar(30) UNIQUE
)engine=MyISAM DEFAULT charset=utf8 AUTO_INCREMENT=1;

/*Contact 테이블에 전화번호(phone)를 저장할 컬럼(varchar(15))을 추가*/
Alter table contact add phone varchar(15);

/*phone이라는 컬럼을 mobile 이라는 컬럼으로 변경 -자료형은 그대로*/
alter table contact change phone mobile varchar(15);

/*데이터, 컬럼, 테이블을 삭제할 때는 삭제가 안되는 경우가 있는데, 이 경우는 대부분 외래키 설정 때문입니다. 이런 경우에는 외래키 옵션에 따라 삭제가 되기도 하고 안되기도 합니다.*/
alter table contact drop mobile;

/*테이블 삭제*/
drop table contact;

