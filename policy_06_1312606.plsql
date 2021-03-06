--CAU 6

--CONN KHANH_TOAN_2/btvn1

--Tao ham chinh sach 1 - Tra ve ma nhan vien

CREATE OR REPLACE FUNCTION THONG_TIN_PHONG_NV_1(P_SCHEMA VARCHAR2, P_OBJ VARCHAR2)
RETURN VARCHAR2
AS
  PRAGMA AUTONOMOUS_TRANSACTION;
  USERNAME VARCHAR2(10);
  TEMP VARCHAR2(200);
BEGIN
  USERNAME := SYS_CONTEXT('USERENV', 'SESSION_USER');
  
  SELECT MAPHONG INTO TEMP
  FROM PHONG_BAN
  WHERE TRUONGPHONG = USERNAME; 
  IF (TEMP != NULL)
  THEN
    RETURN '';
  END IF;
  
  SELECT MACN INTO TEMP
  FROM CHI_NHANH
  WHERE TRUONGCHINHANH = USERNAME; 
  IF (TEMP != NULL)
  THEN
    RETURN '';
  END IF;
  
  SELECT MADA INTO TEMP
  FROM DU_AN
  WHERE TRUONGDA = USERNAME; 
  IF (TEMP != NULL)
  THEN
    RETURN '';
  END IF;
  
  SELECT MANV INTO TEMP
  FROM NHAN_VIEN
  WHERE MANV = USERNAME;  
  TEMP := 'MANV = ' || TEMP;
  RETURN TEMP;
  
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE ('No Data Found');
END THONG_TIN_PHONG_NV_1;


--Tao ham chinh sach 2 - Tra ve ma phong cua nhan vien

CREATE OR REPLACE FUNCTION THONG_TIN_PHONG_NV_2(P_SCHEMA VARCHAR2, P_OBJ VARCHAR2)
RETURN VARCHAR2
AS
  PRAGMA AUTONOMOUS_TRANSACTION;
  USERNAME VARCHAR2(10);
  TEMP VARCHAR2(200);
BEGIN
  USERNAME := SYS_CONTEXT('USERENV', 'SESSION_USER');
  
  SELECT MAPHONG INTO TEMP
  FROM PHONG_BAN
  WHERE TRUONGPHONG = USERNAME; 
  IF (TEMP != NULL)
  THEN
    RETURN '';
  END IF;
  
  SELECT MACN INTO TEMP
  FROM CHI_NHANH
  WHERE TRUONGCHINHANH = USERNAME; 
  IF (TEMP != NULL)
  THEN
    RETURN '';
  END IF;
  
  SELECT MADA INTO TEMP
  FROM DU_AN
  WHERE TRUONGDA = USERNAME; 
  IF (TEMP != NULL)
  THEN
    RETURN '';
  END IF;
  
  SELECT MAPHONG INTO TEMP
  FROM NHAN_VIEN
  WHERE MANV = USERNAME;  
  TEMP := 'MAPHONG = ' || TEMP;
  RETURN TEMP;
  
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE ('No Data Found');
END THONG_TIN_PHONG_NV_2;

--Gan ham chinh sach 1 vao bang NHAN_VIEN

BEGIN
  DBMS_RLS.ADD_POLICY (OBJECT_SCHEMA => 'KHANH_TOAN_2',
  OBJECT_NAME => 'NHAN_VIEN',
  POLICY_NAME => 'p_NV_XEM_THONG_TIN_CA_NHAN_1',
  FUNCTION_SCHEMA => 'KHANH_TOAN_2',
  POLICY_FUNCTION => 'THONG_TIN_PHONG_NV_1',
  STATEMENT_TYPES => 'SELECT',
  SEC_RELEVANT_COLS => 'LUONG',
  SEC_RELEVANT_COLS_OPT => dbms_rls.ALL_ROWS,
  UPDATE_CHECK => TRUE);
END;

--Gan ham chinh sach 2 vao bang NHAN_VIEN

BEGIN
  DBMS_RLS.ADD_POLICY (OBJECT_SCHEMA => 'KHANH_TOAN_2',
  OBJECT_NAME => 'NHAN_VIEN',
  POLICY_NAME => 'p_NV_XEM_THONG_TIN_CA_NHAN_2',
  FUNCTION_SCHEMA => 'KHANH_TOAN_2',
  POLICY_FUNCTION => 'THONG_TIN_PHONG_NV_2',
  STATEMENT_TYPES => 'SELECT',
  UPDATE_CHECK => TRUE);
END;

--Cap quyen cho Role R_NHAN_VIEN

GRANT CREATE SESSION TO R_NHAN_VIEN;
GRANT SELECT ON NHAN_VIEN TO R_NHAN_VIEN;
GRANT R_NHAN_VIEN TO NV003, NV004, NV005, NV006, NV007, NV008, NV010, NV012, NV013, NV014, NV015, NV016, NV018, NV019, NV021, NV022;
