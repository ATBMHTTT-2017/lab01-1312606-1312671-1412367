
--Tạo và phân quyền cho User BTVN_1
CONN SYS/system

CREATE USER BTVN_1 IDENTIFIED BY btvn1;
GRANT CREATE SESSION TO BTVN_1;
GRANT DBA, CONNECT TO BTVN_1;
GRANT ALL PRIVILEGES TO BTVN_1;
GRANT EXECUTE ON DBMS_RLS TO BTVN_1;
GRANT RESOURCE TO BTVN_1;
GRANT EXECUTE ON DBMS_RLS TO PUBLIC;

GRANT EXEMPT ACCESS POLICY TO BTVN_1;




--Tạo cơ sở dữ liệu
CONN BTVN_1/btvn1;

CREATE TABLE NHAN_VIEN
(
  MANV VARCHAR2(10) NOT NULL PRIMARY KEY,
  HOTEN NVARCHAR2(50) NOT NULL,
  DIACHI NVARCHAR2(100),
  DIENTHOAI VARCHAR2(15),
  EMAIL VARCHAR2(50),
  MAPHONG VARCHAR2(10),
  CHINHANH VARCHAR2(10),
  LUONG INT
);

CREATE TABLE CHI_NHANH
(
  MACN VARCHAR2(10) NOT NULL PRIMARY KEY,
  TENCN NVARCHAR2(50),
  TRUONGCHINHANH VARCHAR2(10)
);

CREATE TABLE CHI_TIEU
(
  MACHITIEU VARCHAR2(10) NOT NULL PRIMARY KEY,
  TENCHITIEU NVARCHAR2(50),
  SOTIEN INT,
  DUAN VARCHAR2(10)
);

CREATE TABLE PHAN_CONG
(
  MANV VARCHAR2(10) NOT NULL,
  DUAN VARCHAR2(10) NOT NULL,
  VAITRO NVARCHAR2(50),
  PHUCAP INT,
  CONSTRAINT PHAN_CONG_PK PRIMARY KEY(MANV, DUAN) ENABLE
);

CREATE TABLE PHONG_BAN
(
  MAPHONG VARCHAR2(10) NOT NULL PRIMARY KEY,
  TENPHONG NVARCHAR2(50) NOT NULL,
  TRUONGPHONG VARCHAR2(10),
  NGAYNHANCHUC DATE,
  SONHANVIEN INT,
  CHINHANH VARCHAR2(10)
);

CREATE TABLE DU_AN
(
  MADA VARCHAR2(10) NOT NULL PRIMARY KEY,
  TENDA NVARCHAR2(50),
  KINHPHI INT,
  PHONGCHUTRI VARCHAR2(10),
  TRUONGDA VARCHAR2(10)
);


ALTER TABLE CHI_TIEU
ADD CONSTRAINT FK_CHI_TIEU_DU_AN
FOREIGN KEY (DUAN)
REFERENCES DU_AN(MADA);

ALTER TABLE DU_AN
ADD CONSTRAINT FK_DU_AN_PHONG_BAN
FOREIGN KEY (PHONGCHUTRI)
REFERENCES PHONG_BAN(MAPHONG);

ALTER TABLE DU_AN
ADD CONSTRAINT FK_DU_AN_NHAN_VIEN
FOREIGN KEY (TRUONGDA)
REFERENCES NHAN_VIEN(MANV);

ALTER TABLE PHAN_CONG
ADD CONSTRAINT FK_PHAN_CONG_DU_AN
FOREIGN KEY (DUAN)
REFERENCES DU_AN(MADA);

ALTER TABLE PHONG_BAN
ADD CONSTRAINT FK_PHONG_BAN_CHI_NHANH
FOREIGN KEY (CHINHANH)
REFERENCES CHI_NHANH(MACN);

ALTER TABLE NHAN_VIEN
ADD CONSTRAINT FK_NHAN_VIEN_PHONG_BAN
FOREIGN KEY (MAPHONG)
REFERENCES PHONG_BAN(MAPHONG);

ALTER TABLE PHAN_CONG
ADD CONSTRAINT FK_PHAN_CONG_NHAN_VIEN
FOREIGN KEY (MANV)
REFERENCES NHAN_VIEN(MANV);

ALTER TABLE NHAN_VIEN
ADD CONSTRAINT FK_NHAN_VIEN_CHI_NHANH
FOREIGN KEY (CHINHANH)
REFERENCES CHI_NHANH(MACN);

ALTER TABLE CHI_NHANH
ADD CONSTRAINT FK_CHI_NHANH_NHAN_VIEN
FOREIGN KEY (TRUONGCHINHANH)
REFERENCES NHAN_VIEN(MANV);

