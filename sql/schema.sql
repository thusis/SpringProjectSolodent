


insert into
	chatMessage
values(
	seq_chatting_no.nextval,
	#{memberId},
	#{srNo},
	#{chatContent},
	default
)
 	

CREATE TABLE "TBL_CHATROOM" (	
	"CHATROOM_ID" NUMBER NOT NULL ENABLE, 	
	"SEND_ID" VARCHAR2(30) NOT NULL , 
	"RECEIVED_ID" VARCHAR2(30) NOT NULL , 
	"CONTENT" VARCHAR2(500) NOT NULL , 
	"READ_CNT" NUMBER DEFAULT 0,
	"SEND_DATE" DATE NOT NULL , 
	"READ_DATE" DATE ,
	CONSTRAINT "PK_TBL_CHATROOM" PRIMARY KEY ("CHATROOM_ID")
);

SELECT sysdate FROM dual


CREATE SEQUENCE  seq_chatroom START WITH 1 INCREMENT BY 1  MAXVALUE 9999999999999999999999999999  CYCLE nocache;


 	