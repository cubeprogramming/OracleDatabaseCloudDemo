/* CREATE POLLER TABLE AND LOADING PACKAGE */

--------------------------------------------------------
--  DDL for Table MyProject_BATCH
--------------------------------------------------------

 -- DROP TABLE MyProject_BATCH;

  CREATE TABLE MyProject_BATCH 
  (	
    SEQNO NUMBER,
    SB_BATCH VARCHAR2(50),
    STATUS VARCHAR2(50),    
    POLLER_READ NUMBER DEFAULT 0, 
    TIMESTAMP DATE, 
    LAST_TIMESTAMP DATE,
    ERROR_CODE	VARCHAR2(200 BYTE),
    ERROR_DETAIL	VARCHAR2(500 BYTE)
  ) ;
--------------------------------------------------------
--  Constraints for Table MyProject_BATCH
--------------------------------------------------------

  ALTER TABLE MyProject_BATCH MODIFY (POLLER_READ NOT NULL ENABLE);
  ALTER TABLE MyProject_BATCH MODIFY (SEQNO NOT NULL ENABLE);
  ALTER TABLE MyProject_BATCH ADD CONSTRAINT MyProject_BATCH_PK PRIMARY KEY (SEQNO) ENABLE;
  
--------------------------------------------------------
--  Sequence for Table MyProject_BATCH
--------------------------------------------------------

 -- DROP SEQUENCE  SEQ_MYPROJECT_BATCH;
  
  CREATE SEQUENCE  SEQ_MYPROJECT_BATCH  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1;
  
--------------------------------------------------------
--  Loading package for Table MyProject_BATCH
--------------------------------------------------------

create or replace PACKAGE PCK_MYPROJECT_BATCH AS 

  PROCEDURE startMyProjectBatch;

END PCK_MYPROJECT_BATCH;
/ 

create or replace PACKAGE BODY PCK_MYPROJECT_BATCH AS

  PROCEDURE startMyProjectBatch AS
  
    v_error_code NUMBER;
    v_error_message VARCHAR2(255);
  BEGIN
    v_error_code := SQLCODE;
    
    IF v_error_code = 0 OR v_error_code = 100 THEN
      v_error_code := null;
      v_error_message := null;
    ELSE
      v_error_message := SQLERRM;
    END IF;
  
    INSERT INTO MYPROJECT_BATCH
    (                
      SEQNO,
      SB_BATCH,
      STATUS,
      POLLER_READ,
      TIMESTAMP,
      ERROR_CODE,
      ERROR_DETAIL            
    )
    VALUES
    (                
      SEQ_MYPROJECT_BATCH.nextval,
      TO_CHAR(sysdate, 'ddmmyyyy_hh24miss'),
      'IN_PROCESS',
      0,
      SYSDATE,
      v_error_code,
      v_error_message            
    );
  
  EXCEPTION       
    WHEN OTHERS THEN
      raise_application_error(-20101, 'Exception occurred in PCK_MYPROJECT_BATCH.startMyProjectBatch procedure 
       with message: '||SQLERRM);  
  END startMyProjectBatch;

END PCK_MYPROJECT_BATCH;

/

/* CREATE BOOK TABLE AND LOADING DATA */

--------------------------------------------------------
--  DDL for Table MyProject_BOOKS
--------------------------------------------------------

 -- DROP TABLE MyProject_BOOKS;

  CREATE TABLE MyProject_BOOKS 
  (	
    SEQNO NUMBER,
    TITLE VARCHAR2(50),
    AUTHOR VARCHAR2(50),    
    ISBN VARCHAR2(50), 
    PUBLISHED DATE, 
    GENERE VARCHAR2(50)
  ) ;
--------------------------------------------------------
--  Constraints for Table MyProject_BOOKS
--------------------------------------------------------
  
  ALTER TABLE MyProject_BOOKS MODIFY (SEQNO NOT NULL ENABLE);
  ALTER TABLE MyProject_BOOKS ADD CONSTRAINT MyProject_BOOKS_PK PRIMARY KEY (SEQNO) ENABLE;
  ALTER TABLE MyProject_BOOKS MODIFY (TITLE NOT NULL ENABLE);
  ALTER TABLE MyProject_BOOKS MODIFY (ISBN NOT NULL ENABLE);
  
  
--------------------------------------------------------
--  Sequence for Table MyProject_BOOKS
--------------------------------------------------------

 -- DROP SEQUENCE  SEQ_MyProject_BOOKS;
  
  CREATE SEQUENCE  SEQ_MyProject_BOOKS  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1;
  
--------------------------------------------------------
--  Data for Table MyProject_BOOKS
--------------------------------------------------------  
  
  Insert into MyProject_BOOKS (SEQNO,TITLE,AUTHOR,ISBN,PUBLISHED,GENERE) 
   values (SEQ_MyProject_BOOKS.nextval, 'Hamlet','William Shakespeare','978-0486272788',TO_DATE('1937','YYYY'),'Novel');
   
  Insert into MyProject_BOOKS (SEQNO,TITLE,AUTHOR,ISBN,PUBLISHED,GENERE) 
   values (SEQ_MyProject_BOOKS.nextval, 'Groovy in Action','Dierk Konig','1-932394-84-2',TO_DATE('2007','YYYY'),'Software manual');  
   
  COMMIT;