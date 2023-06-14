--REM   Script: ANDAI Mart - Kelompok 7
--REM   Andrian Tambunan
--Anas Azhar
--Ilham Insan Wafi
--Muhammad Daffa Ashdaqfillah

-- create user
CREATE USER kasir WITH PASSWORD 'kasir123';
CREATE USER pemasok WITH PASSWORD 'pemasok123';
CREATE USER manager WITH PASSWORD 'manager123';

-- kasir access
GRANT SELECT, INSERT, UPDATE ON TRANSAKSI, TRANSAKSI_DETAIL TO kasir;
GRANT SELECT, INSERT, UPDATE ON MEMBER TO kasir;
GRANT SELECT ON BARANG, RAK_GUDANG, RAK_GUDANG_DETAIL, KODE_TRANSAKSI, DISKON TO kasir;

-- pemasok access
GRANT SELECT, INSERT, UPDATE ON BARANG TO pemasok;

-- manager access
GRANT SELECT, INSERT, UPDATE ON KASIR TO manager;
GRANT SELECT, INSERT, UPDATE ON PEMASOK TO manager;
GRANT SELECT ON TRANSAKSI, TRANSAKSI_DETAIL, MEMBER, RAK_GUDANG, RAK_GUDANG_DETAIL, KODE_TRANSAKSI, BARANG, DISKON TO manager;

CREATE TABLE MEMBER(   
    M_NO CHAR(10) NOT NULL PRIMARY KEY,   
    M_NAMA VARCHAR(30),   
    M_JENISKEL CHAR(1),   
    M_TEMPATLAHIR VARCHAR(20),     
    M_TANGGALLAHIR DATE,     
    M_TANGGALDAFTAR DATE,  
    M_ALAMAT VARCHAR(50),     
    M_EMAIL VARCHAR(30),  
    M_PASSWORD VARCHAR(32), 
    M_NOTELP VARCHAR(13)  
    );
	
CREATE TABLE KASIR(  
    K_NO CHAR(2) NOT NULL PRIMARY KEY,  
    K_NAMA VARCHAR(30) NOT NULL,  
    K_ALAMAT VARCHAR(50) NOT NULL,  
    K_NOTELP VARCHAR(13) NOT NULL, 
    K_TGLMASUK DATE NOT NULL,  
    K_EMAIL VARCHAR(50) NOT NULL,  
    K_PASSWORD VARCHAR(20) NOT NULL, 
    K_TGLLAHIR DATE NOT NULL
    );
	
CREATE TABLE TRANSAKSI(   
    T_NO INT NOT NULL PRIMARY KEY,   
    T_ISCASHLESS CHAR(1) NOT NULL, 
    T_TGLPEMBELIAN TIMESTAMP NOT NULL,
    MEMBER_M_NO CHAR(10) NOT NULL,  
    FOREIGN KEY (MEMBER_M_NO) REFERENCES MEMBER(M_NO)   
    );
	

CREATE TABLE BARANG(   
    B_ID VARCHAR(5) NOT NULL PRIMARY KEY,   
    B_NAMA VARCHAR(50) NOT NULL,   
    B_HARGA DECIMAL(10,2) NOT NULL,
    B_STOK INT NOT NULL
    );

CREATE TABLE KASIR_DETAIL(  
    KD_NO INT NOT NULL PRIMARY KEY,  
    KASIR_K_NO CHAR(2) NOT NULL,  
    TRANSAKSI_T_NO INT NOT NULL,  
    FOREIGN KEY (KASIR_K_NO) REFERENCES KASIR(K_NO),  
    FOREIGN KEY (TRANSAKSI_T_NO) REFERENCES TRANSAKSI(T_NO)  
    );
	
CREATE TABLE TRANSAKSI_DETAIL(   
    TD_NO INT NOT NULL PRIMARY KEY,   
    TD_BANYAK_BARANG INT NOT NULL,   
    TRANSAKSI_T_NO INT NOT NULL,   
    BARANG_B_ID VARCHAR(5) NOT NULL, 
    FOREIGN KEY (TRANSAKSI_T_NO) REFERENCES TRANSAKSI(T_NO),  
    FOREIGN KEY (BARANG_B_ID) REFERENCES BARANG(B_ID)  
    );

CREATE TABLE RAK_GUDANG( 
    G_KODERAK INT NOT NULL PRIMARY KEY, 
    G_NAMA VARCHAR(20) NOT NULL, 
    G_ISFULL CHAR(1) NOT NULL 
    );

CREATE TABLE DISKON( 
    D_NO CHAR(3) NOT NULL PRIMARY KEY, 
    D_NAMA VARCHAR(60) NOT NULL, 
    D_DISKON DECIMAL(10, 2) NOT NULL, 
    BARANG_B_ID VARCHAR(5) NOT NULL, 
    FOREIGN KEY (BARANG_B_ID) REFERENCES BARANG(B_ID) 
    );

CREATE TABLE RAK_GUDANG_DETAIL( 
    GD_NO INT NOT NULL PRIMARY KEY, 
    RAK_GUDANG_G_KODERAK INT NOT NULL, 
    BARANG_B_ID VARCHAR(5) NOT NULL, 
    FOREIGN KEY (RAK_GUDANG_G_KODERAK) REFERENCES RAK_GUDANG(G_KODERAK), 
    FOREIGN KEY (BARANG_B_ID) REFERENCES BARANG(B_ID) 
    );
	
CREATE TABLE PEMASOK( 
    PEM_NO INT NOT NULL PRIMARY KEY, 
    PEM_PERUSAHAAN VARCHAR(30) NOT NULL, 
    PEM_NOTELP VARCHAR(15) NOT NULL, 
    PEM_ALAMAT VARCHAR(40) NOT NULL, 
    RAK_GUDANG_G_KODERAK INT NOT NULL,
    FOREIGN KEY (RAK_GUDANG_G_KODERAK) REFERENCES RAK_GUDANG(G_KODERAK)
    );

CREATE TABLE KODE_TRANSAKSI ( 
    KT_ID INT NOT NULL PRIMARY KEY, 
    KT_BARCODE VARCHAR(13), 
    KT_KADALUARSA DATE, 
    BARANG_B_ID VARCHAR(5) NOT NULL, 
    FOREIGN KEY (BARANG_B_ID) REFERENCES BARANG(B_ID) 
    );

INSERT INTO MEMBER (M_NO) VALUES ('P000000');
INSERT INTO MEMBER (M_NO, M_NAMA, M_JENISKEL, M_TEMPATLAHIR, M_TANGGALLAHIR, M_TANGGALDAFTAR, M_ALAMAT, M_EMAIL, M_PASSWORD, M_NOTELP) 
VALUES 
    ('P000001','ANISA', 'P','LAMONGAN', TO_DATE ('1975-09-10', 'yyyy-mm-dd'), TO_DATE('2022-05-09', 'YYYY-MM-DD'), 'MULYOREJO UTARA GG3 NO 12C', 'anisa1975@gmail.com', 'Nisacantik123', '081357627439'),
    ('P000002','HELGE', 'L','WINDEN', TO_DATE ('1953-10-25', 'yyyy-mm-dd'), TO_DATE('2022-05-09', 'YYYY-MM-DD'), 'WINDEN, JERMAN', 'helge.winden@gmail.com', 'Akunhelge1', '082291234213'),
    ('P000003','DEKU', 'L','TOKYO', TO_DATE ('2000-07-12', 'yyyy-mm-dd'), TO_DATE('2022-05-10', 'YYYY-MM-DD'), 'JEPANG', 'deku.oneforall@gmail.com', 'Dekudeku2003', '081333894213'),
    ('P000004','SHIGARAKI','L','TOKYO', TO_DATE ('1997-01-23', 'yyyy-mm-dd'), TO_DATE('2022-05-29', 'YYYY-MM-DD'), 'JEPANG', 'shigaraki.decay@gmail.com', 'shigarakigantengBanget7', '085701221181'),
    ('P000005', 'JOLYNE','P', 'FLORIDA', TO_DATE ('1992-07-01', 'yyyy-mm-dd'), TO_DATE('2022-05-29', 'YYYY-MM-DD'), 'AMERIKA SERIKAT', 'jolyne.cujoh@gmail.com', 'Jolynesayanganisa123', '082761234983'),
    ('P000006', 'JOSUKE','L', 'MORIOH', TO_DATE ('1983-04-20', 'yyyy-mm-dd'), TO_DATE('2022-05-30', 'YYYY-MM-DD'), 'JEPANG', 'josuke.higashikata@gmail.com', 'Josukesukajasuke2', '081627372488'),
    ('P000007', 'JONAS', 'L', 'WINDEN', TO_DATE ('2003-01-16', 'yyyy-mm-dd'), TO_DATE('2022-06-10', 'YYYY-MM-DD'), 'JERMAN', 'jonas.kahnwald@gmail.com', 'MiripNickJonas123', '081324213452'),
    ('P000008', 'SAITAMA','L', 'WINDEN', TO_DATE ('1990-04-21', 'yyyy-mm-dd'), TO_DATE('2022-06-12', 'YYYY-MM-DD'), 'JEPANG', 'saitama@gmail.com', 'SaitamBotak0', '085213244215'),
    ('P000009', 'SUBARU','L', 'NAGOYA', TO_DATE ('2002-04-01', 'yyyy-mm-dd'), TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'JEPANG', 'subaru@gmail.com', 'suBARUsayangku', '081521325332'),
    ('P000010', 'EMILIA', 'P', 'LUGNICA', TO_DATE ('2002-09-23', 'yyyy-mm-dd'), TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'LUGNICA', 'emilia@gmail.com', 'PanggilAkuLia123', '081521325332'),
    ('P000011', 'KIRYU SENTO', 'L', 'TOKYO', TO_DATE ('1996-02-12', 'yyyy-mm-dd'), TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'JEPANG', 'kamenraidabirudo@gmail.com', 'SBDSusah7', '082257213214'),
    ('P000012', 'TOKIWA SOGO', 'L', 'KYOTO', TO_DATE ('2002-03-19', 'yyyy-mm-dd'), TO_DATE('2022-06-22', 'YYYY-MM-DD'), 'JEPANG', 'omazio@gmail.com', 'sukaKamenRider2003', '082252113534'),
    ('P000013', 'HINO EIJI', 'L', 'OSAKA', TO_DATE ('1998-01-29', 'yyyy-mm-dd'), TO_DATE('2022-07-03', 'YYYY-MM-DD'), 'JEPANG', 'kamenraidaozu@gmail.com', 'sukaKamenRider2004', '085214521682'),
    ('P000014', 'HIMIKO', 'P', 'SENDAI', TO_DATE ('2005-08-07', 'yyyy-mm-dd'), TO_DATE('2022-07-05', 'YYYY-MM-DD'), 'JEPANG', 'togahimiko@gmail.com', 'dighostingAnisa2x', '081521421356'),
    ('P000015', 'AIZAWA', 'L', 'FUKUOKA', TO_DATE ('1996-04-19', 'yyyy-mm-dd'), TO_DATE('2022-07-11', 'YYYY-MM-DD'), 'JEPANG', 'aizawa.shouta@gmail.com', 'Mr.XPahlawankuPAA4', '081231521568'),
    ('P000016', 'REM', 'P', 'ONI VILLAGE', TO_DATE ('2000-02-02', 'yyyy-mm-dd'), TO_DATE('2022-07-15', 'YYYY-MM-DD'), 'JEPANG', 'rem@gmail.com', 'KentangSpiral123', '085213556908');

INSERT INTO KASIR (K_NO, K_NAMA, K_ALAMAT, K_NOTELP, K_TGLMASUK, K_EMAIL, K_PASSWORD, K_TGLLAHIR)  
VALUES 
    ('01', 'ANTON', 'KALISARI TIMUR NO 74', '03177833132', TO_DATE ('2022-11-18','yyyy-mm-dd'), 'ANTONGANTENG@GMAIL.COM', 'ANTONCINTAKAMU123',TO_DATE ('2000-01-10','yyyy-mm-dd')),
    ('02', 'BENI BABENI', 'KALIJUDAN BARAT 1A NO 33', '03175733111', TO_DATE ('2022-11-20','yyyy-mm-dd'), 'ABENI1708@GMAIL.COM', 'EMAILABENI',TO_DATE ('2002-08-17','yyyy-mm-dd')),
    ('03', 'SYEILA DARLING KURNIAWATI', 'PERUM VILA KALIJUDAN N0 35', '03175993119', TO_DATE ('2022-11-20','yyyy-mm-dd'), 'SYEILADARAKWSUPER1@GMAIL.COM', 'SYEILADARA',TO_DATE ('2003-01-01','yyyy-mm-dd')),
    ('04', 'WISNU', 'KALIJUDAN BARAT 2C NO 15', '03175763911', TO_DATE ('2022-11-20','yyyy-mm-dd'), 'WISNUGRAHA30@GMAIL.COM', 'WISNU123',TO_DATE ('2002-01-30','yyyy-mm-dd')),
    ('05', 'VINDYA IAN P', 'JLN MULYOREJO PERTANIAN NO 14', '03175733143', TO_DATE ('2022-11-21','yyyy-mm-dd'), 'ABENI1708@GMAIL.COM', 'EMAILABENI',TO_DATE ('2002-05-27','yyyy-mm-dd'));

INSERT INTO BARANG (B_ID, B_NAMA, B_HARGA, B_STOK) 
VALUES 
    ('MC600', 'MORINAGA CHIL KID PLATINUM 3 VANILA 600 GRAM', 246900, 30),
    ('VX950', 'VIDORAN XMART  3+ MADU VANILA 950 GRAM', 66700, 35),
    ('BB700', 'BEBELAC GOLD 3 VANILA 700 GRAM', 120400, 25),
    ('DF800', 'DANCOW FORTIGRO FULL CREAM 800 GRAM', 83500, 30),
    ('NJ145', 'NUTRIJELL PUDDING COKLAT 145 GRAM', 9900, 40),
    ('LF450', 'LA FONTE 450 GRAM', 16000, 35),
    ('ABCKM', 'ABC KECAP MANIS 520 ML', 18800, 35),
    ('ABCSA', 'ABC SAMBAL 135 ML', 6700, 40),
    ('PH350', 'PUCUK HARUM 350 ML', 3300, 25),
    ('YC500', 'YOU C1000 LEMON WATER 500 ML', 7250, 30),
    ('LWK22', 'LUWAK WHITE KOFFIE 220 ML', 4600, 35),
    ('PRI42', 'PRINGLES 42G', 8700, 30),
    ('MC135', 'ROMA MALKIST COKLAT 135 GRAM', 7500, 35),
    ('NVMES', 'NIVEA MEN EXTRA WHITE SPOT', 31900, 40),
    ('NVFSW', 'NIVEA MEN FACIAL SCRUB WHITENING', 31900, 35),
    ('NVOR9', 'NUVO FAMILY TOTAL PROTECT 900 ML', 32400, 35),
    ('RS770', 'RINSO ANTI NODA + MOLTO 770 GRAM', 19900, 35),
    ('SK800', 'SO KLIN LANTAI 800 ML', 10900, 30),
    ('NVOB9', 'NUVO FAMILY MILD PROTECT 900 ML', 32400, 30),
    ('INDAB', 'INDOMIE KUAH AYAM BAWANG', 3000, 30),
    ('INDGO', 'INDOMIE GORENG ORIGINAL', 3000, 35),
    ('INDST', 'INDOMIE KUAH SOTO', 3000, 30),
    ('MSKAB', 'MIE SEDAAP KUAH AYAM BAWANG', 3000, 30),
    ('MSGOR', 'MIE SEDAAP ORIGINAL', 3000, 40),
    ('MSKST', 'MIE SEDAAP KUAH SOTO', 3000, 40),
    ('BPL01', 'KEMEJA PUTIH', 60000, 30),
    ('BPL02', 'CELANA HITAM', 50000, 35),
    ('BPL03', 'DASI', 15000, 35),
    ('BPL04', 'SEPATU PANTOFEL', 100000, 30),
    ('BPLFS', 'BAJU PELATIHAN: FULL SET', 200000, 30),
    ('TSL30', 'PAKET DATA TELKOMSEL : 30GB', 105000, 30),
    ('TSL40', 'PAKET DATA TELKOMSEL : 40GB', 130000, 30),
    ('SRT15', 'PAKET DATA SMARTFREN : 15GB', 10000, 35),
    ('SRT30', 'PAKET DATA SMARTFREN : 30GB', 18000, 40),
    ('SND50', 'BUKU SINARDUNIA 6 BKS 50 LBR', 50000, 35),
    ('KKY50', 'BUKU KIKY 6BKS 50LBR', 80000, 35),
    ('BBS50', 'BUKU BIG BOSS 6BKS 50LBR', 85000, 40),
    ('PPR01', 'HVS PAPERONE A4 500LBR', 30000, 35),
    ('PPR02', 'HVS PAPERONE F4 500LBR', 30000, 40),
    ('SDU01', 'HVS SIDU A4 500LBR', 43000, 40),
    ('SDU02', 'HVS SIDU F4 500LBR', 43000, 35),
    ('SPU01', 'SAPU IJUK HIJAU', 18000, 35),
    ('SPU02', 'SAPU IJUK KUNING', 18000, 30),
    ('PEL01', 'PEL SUPER KUNING', 24000, 35),
    ('EBR01', 'EMBER PLASTIK 12L CAP NAGA', 23000, 35),
    ('KST01', 'KESET MOTIF WELCOME', 15000, 30),
    ('KPT01', 'KARPET MOTIF BUNGA MAWAR', 30000, 35),
    ('HST01', 'HAND SANITIZER ANTIS 100ML', 18000, 30),
    ('JAD01', 'JAM DINDING HELLO KITTY', 50000, 35),
    ('JAD02', 'JAM DINDING UPIN IPIN', 50000, 30),
    ('JAD03', 'JAM DINDING DORA', 50000, 30),
    ('JYS01', 'JOY STICK LOGITECH F710', 540000, 35),
    ('WEC01', 'WEBCAM ROG EYE S FULL HD 1080P', 1357000, 35),
    ('MOS01', 'MOUSE USB VOTRE', 12500, 35),
    ('MOS02', 'MOUSE WIRELESS LOGITECH G304', 499000, 35),
    ('KEY01', 'KEYBOARD WIRELESS LOGITECH K380', 260000, 40),
    ('SPT01', 'SPOTIFY PREMIUM 3BULAN', 54990, 40),
    ('GPY10', 'TOP UP GOPAY 10K', 12500, 35),
    ('GPY20', 'TOP UP GOPAY 20K', 22500, 30),
    ('GPY50', 'TOP UP GOPAY 20K', 52500, 35),
    ('OVO20', 'TOP UP OVO 20K', 22000, 30),
    ('OVO50', 'TOP UP OVO 50K', 52000, 35),
    ('OVO80', 'TOP UP OVO 80K', 82000, 35),
    ('TBL01', 'KERUPUK KULIT JUARA', 5000, 40),
    ('SBR01', 'SOSIS KANZLER', 4500, 40),
    ('PTL01', 'ROTI SANDWICH KACANG', 3000, 35),
    ('NSG01', 'BUBUR AYAM RASA ABON', 1500, 35),
    ('NSG02', 'BUBUR AYAM RASA ORIGINAL', 1500, 35),
    ('NSG03', 'BUBUR AYAM RASA KALDU AYAM', 17000, 40),
    ('RCR01', 'RICE COOKER MIYAKO KECIL', 150000, 45),
    ('TSS01', 'TISUUE PASSEO 250 SHEET', 18000, 40);

INSERT INTO TRANSAKSI(T_NO, T_TGLPEMBELIAN, T_ISCASHLESS, MEMBER_M_NO )  
VALUES 
    (1, TO_DATE ('2022-11-28 06:14:00','yyyy-mm-dd HH24:MI:SS'), '1', 'P000001'),
    (2, TO_DATE ('2022-11-28 08:02:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000015'),
    (3, TO_DATE ('2022-11-28 12:14:39','yyyy-mm-dd HH24:MI:SS'), '1', 'P000016'),
    (4, TO_DATE ('2022-11-28 15:21:23','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (5, TO_DATE ('2022-11-28 16:00:04','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (6, TO_DATE ('2022-11-28 16:00:20','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (7, TO_DATE ('2022-11-28 17:10:09','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (8, TO_DATE ('2022-11-28 17:10:20','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (9, TO_DATE ('2022-11-28 17:30:02','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (10, TO_DATE ('2022-11-29 09:00:00','yyyy-mm-dd HH24:MI:SS'), '1', 'P000002'),
    (11, TO_DATE ('2022-11-29 09:21:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000008'),
    (12, TO_DATE ('2022-11-29 09:50:44','yyyy-mm-dd HH24:MI:SS'), '1', 'P000003'),
    (13, TO_DATE ('2022-11-29 10:52:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000004'),
    (14, TO_DATE ('2022-11-29 10:59:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000007'),
    (15, TO_DATE ('2022-11-29 11:20:20','yyyy-mm-dd HH24:MI:SS'), '1', 'P000003'),
    (16, TO_DATE ('2022-11-29 11:24:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000009'),
    (17, TO_DATE ('2022-11-29 11:55:43','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (18, TO_DATE ('2022-11-29 12:00:01','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (19, TO_DATE ('2022-11-29 12:00:59','yyyy-mm-dd HH24:MI:SS'), '1','P000010'),
    (20, TO_DATE ('2022-11-29 12:20:20','yyyy-mm-dd HH24:MI:SS'), '1', 'P000011'),
    (21, TO_DATE ('2022-11-29 12:28:26','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (22, TO_DATE ('2022-11-29 13:04:23','yyyy-mm-dd HH24:MI:SS'), '0','P000000'),
    (23, TO_DATE ('2022-11-29 13:08:55','yyyy-mm-dd HH24:MI:SS'), '1', 'P000006'),
    (24, TO_DATE ('2022-11-29 13:25:20','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (25, TO_DATE ('2022-11-29 13:38:04','yyyy-mm-dd HH24:MI:SS'), '0','P000000'),
    (26, TO_DATE ('2022-11-29 13:39:06','yyyy-mm-dd HH24:MI:SS'), '0','P000000'),
    (27, TO_DATE ('2022-11-29 15:00:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000004'),
    (28, TO_DATE ('2022-11-29 16:06:08','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (29, TO_DATE ('2022-11-29 17:59:56','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (30, TO_DATE ('2022-11-30 06:20:26','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (31, TO_DATE ('2022-11-30 06:21:59','yyyy-mm-dd HH24:MI:SS'), '1', 'P000012'),
    (32, TO_DATE ('2022-11-30 07:21:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000013'),
    (33, TO_DATE ('2022-11-30 07:27:20','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (34, TO_DATE ('2022-11-30 07:47:20','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (35, TO_DATE ('2022-11-30 09:56:29','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (36, TO_DATE ('2022-11-30 10:06:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000005'),
    (37, TO_DATE ('2022-11-30 10:09:53','yyyy-mm-dd HH24:MI:SS'), '1', 'P000001'),
    (38, TO_DATE ('2022-11-30 10:21:53','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (39, TO_DATE ('2022-11-30 10:59:43','yyyy-mm-dd HH24:MI:SS'), '1', 'P000009'),
    (40, TO_DATE ('2022-11-30 11:25:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000013'),
    (41, TO_DATE ('2022-11-30 11:26:21','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (42, TO_DATE ('2022-11-30 16:27:58','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (43, TO_DATE ('2022-11-30 17:30:05','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (44, TO_DATE ('2022-11-30 17:50:17','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (45, TO_DATE ('2022-12-01 06:05:05','yyyy-mm-dd HH24:MI:SS'), '1', 'P000016'),
    (46, TO_DATE ('2022-12-01 06:26:27','yyyy-mm-dd HH24:MI:SS'),'1', 'P000012'),
    (47, TO_DATE ('2022-12-01 07:10:11','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (48, TO_DATE ('2022-12-01 07:13:17','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (49, TO_DATE ('2022-12-01 07:25:24','yyyy-mm-dd HH24:MI:SS'), '1', 'P000002'),
    (50, TO_DATE ('2022-12-01 09:02:58','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (51, TO_DATE ('2022-12-01 09:23:06','yyyy-mm-dd HH24:MI:SS'), '1', 'P000002'),
    (52, TO_DATE ('2022-12-01 09:44:39','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (53, TO_DATE ('2022-12-01 10:28:24','yyyy-mm-dd HH24:MI:SS'), '1', 'P000009'),
    (54, TO_DATE ('2022-12-01 11:21:23','yyyy-mm-dd HH24:MI:SS'), '1', 'P000002'),
    (55, TO_DATE ('2022-12-01 14:25:09','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (56, TO_DATE ('2022-12-01 15:20:10','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (57, TO_DATE ('2022-12-01 15:22:08','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (58, TO_DATE ('2022-12-01 15:24:06','yyyy-mm-dd HH24:MI:SS'), '1', 'P000004'),
    (59, TO_DATE ('2022-12-01 16:07:45','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (60, TO_DATE ('2022-12-01 16:34:36','yyyy-mm-dd HH24:MI:SS'), '1', 'P000006'),
    (61, TO_DATE ('2022-12-01 17:00:20','yyyy-mm-dd HH24:MI:SS'), '1', 'P000004'),
    (62, TO_DATE ('2022-12-01 17:22:18','yyyy-mm-dd HH24:MI:SS'), '0', 'P000000'),
    (63, TO_DATE ('2022-12-01 17:49:21','yyyy-mm-dd HH24:MI:SS'), '1', 'P000006');

INSERT INTO KASIR_DETAIL (KD_NO, KASIR_K_NO, TRANSAKSI_T_NO) 
VALUES 
    (1, '03', 1);
    (2, '04', 2);
    (3, '03', 3);
    (4, '01', 4);
    (5, '02', 5);
    (6, '03', 6);
    (7, '05', 7);
    (8, '05', 8);
    (9, '02', 9);
    (10, '03', 10);
    (11, '04', 11);
    (12, '05', 12);
    (13, '04', 13);
    (14, '05', 14);
    (15, '01', 15);
    (16, '02', 16);
    (17, '03', 17);
    (18, '02', 18);
    (19, '03', 19);
    (20, '05', 20);
    (21, '02', 21);
    (22, '01', 22);
    (23, '01', 23);
    (24, '03', 24);
    (25, '03', 25);
    (26, '04', 26);
    (27, '05', 27);
    (28, '01', 28);
    (29, '02', 29);
    (30, '03', 30);
    (31, '04', 31);
    (32, '04', 32);
    (33, '04', 33);
    (34, '05', 34);
    (35, '01', 35);
    (36, '02', 36);
    (37, '02', 37);
    (38, '01', 38);
    (39, '03', 39);
    (40, '03', 40);
    (41, '04', 41);
    (42, '01', 42);
    (43, '05', 43);
    (44, '03', 44);
    (45, '04', 45);
    (46, '05', 46);
    (47, '04', 47);
    (48, '03', 48);
    (49, '03', 49);
    (50, '02', 50);
    (51, '02', 51);
    (52, '04', 52);
    (53, '05', 53);
    (54, '03', 54);
    (55, '04', 55);
    (56, '01', 56);
    (57, '01', 57);
    (58, '02', 58);
    (59, '03', 59);
    (60, '04', 60);
    (61, '03', 61);
    (62, '03', 62);
    (63, '05', 63);

INSERT INTO TRANSAKSI_DETAIL (TD_NO, TRANSAKSI_T_NO, TD_BANYAK_BARANG, BARANG_B_ID)  
VALUES
    (1, 1, 3, 'BB700'),
    (2, 1, 1, 'DF800'),
    (3, 1, 1, 'ABCKM'),
    (4, 1, 2, 'PRI42'),
    (5, 2, 2, 'RS770'),
    (6, 2, 1, 'NVOB9'),
    (7, 3, 6, 'MSKAB'),
    (8, 3, 2, 'MSGOR'),
    (9, 3, 3, 'INDAB'),
    (10, 3, 1, 'INDGO'),
    (11, 4, 1, 'NVFSW'),
    (12, 4, 6, 'NVMES'),
    (13, 5, 6, 'RS770'),
    (14, 6, 3, 'SK800'),
    (15, 7, 10, 'PH350'),
    (16, 7, 3, 'YC500'),
    (17, 8, 5, 'LWK22'),
    (18, 8, 2, 'PRI42'),
    (19, 8, 6, 'PH350'),
    (20, 8, 1, 'YC500'),
    (21, 9, 10, 'INDGO'),
    (22, 10, 5, 'MSKST'),
    (23, 10, 1, 'NVMES'),
    (24, 11, 2, 'YC500'),
    (25, 11, 1, 'INDST'),
    (26, 12, 1, 'MC600'),
    (27, 13, 6, 'MSKAB'),
    (28, 13, 2, 'MSGOR'),
    (29, 14, 1, 'PRI42'),
    (30, 15, 1, 'LWK22'),
    (31, 16, 3, 'PH350'),
    (32, 16, 1, 'LF450'),
    (33, 17, 1, 'ABCKM'),
    (34, 17, 1, 'ABCSA'),
    (35, 18, 2, 'MC135'),
    (36, 19, 1, 'NVOR9'),
    (37, 19, 1, 'NVMES'),
    (38, 20, 2, 'MSKST'),
    (39, 20, 1, 'LWK22'),
    (40, 21, 1, 'INDGO'),
    (41, 22, 3, 'PH350'),
    (42, 23, 1, 'DF800'),
    (43, 24, 1, 'NVFSW'),
    (44, 24, 1, 'PRI42'),
    (45, 24, 2, 'INDGO'),
    (46, 25, 1, 'RS770'),
    (47, 25, 1, 'NVOB9'),
    (48, 26, 2, 'MSGOR'),
    (49, 27, 3, 'INDAB'),
    (50, 27, 1, 'INDGO'),
    (51, 28, 3, 'BB700'),
    (52, 29, 1, 'DF800'),
    (53, 29, 1, 'ABCKM'),
    (54, 30, 2, 'PRI42'),
    (55, 31, 2, 'RS770'),
    (56, 31, 1, 'NVOB9'),
    (57, 32, 6, 'MSKAB'),
    (58, 32, 2, 'MSGOR'),
    (59, 33, 3, 'INDAB'),
    (60, 34, 1, 'INDGO'),
    (61, 35, 3, 'BB700'),
    (62, 35, 1, 'DF800'),
    (63, 36, 1, 'ABCKM'),
    (64, 37, 2, 'PRI42'),
    (65, 37, 2, 'RS770'),
    (66, 37, 1, 'NVOB9'),
    (67, 38, 6, 'MSKAB'),
    (68, 38, 2, 'MSGOR'),
    (69, 39, 3, 'INDAB'),
    (70, 40, 1, 'INDGO'),
    (71, 41, 3, 'BB700'),
    (72, 42, 1, 'DF800'),
    (73, 42, 1, 'ABCKM'),
    (74, 43, 5, 'PRI42'),
    (75, 44, 2, 'RS770'),
    (76, 44, 1, 'NVOB9'),
    (77, 45, 8, 'MSKAB'),
    (78, 46, 2, 'MSGOR'),
    (79, 46, 3, 'INDAB'),
    (80, 47, 1, 'INDGO'),
    (81, 48, 1, 'PH350'),
    (82, 48, 3, 'INDGO'),
    (83, 49, 1, 'ABCKM'),
    (84, 50, 1, 'ABCSA'),
    (85, 50, 2, 'MC135'),
    (86, 51, 1, 'NVOR9'),
    (87, 52, 1, 'NVMES'),
    (88, 53, 2, 'MSKST'),
    (89, 54, 1, 'LWK22'),
    (90, 54, 1, 'INDGO'),
    (91, 55, 3, 'PH350'),
    (92, 55, 1, 'DF800'),
    (93, 56, 1, 'NVFSW'),
    (94, 57, 1, 'PRI42'),
    (95, 57, 2, 'INDGO'),
    (96, 58, 1, 'RS770'),
    (97, 59, 1, 'NVOB9'),
    (98, 60, 2, 'MSGOR'),
    (99, 60, 2, 'INDAB'),
    (100, 61, 1, 'RS770'),
    (101, 61, 1, 'LWK22'),
    (102, 62, 5, 'MC135'),
    (103, 62, 1, 'NVOB9'),
    (104, 63, 5, 'INDGO'),
    (105, 63, 5, 'INDST');

INSERT INTO KODE_TRANSAKSI (KT_ID, KT_BARCODE, KT_KADALUARSA, BARANG_B_ID) 
VALUES 
    (1, 'fGj9XCU7KYCkn', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'MC600'),
    (2, 'bz7jikzzVgmhd', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'VX950'),
    (3, 'raTNcBpFGFMDm', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'VX950'),
    (4, 'UaIiNgUn0huj7', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'VX950'),
    (5, '7f2zMQAH0EeEd', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'BB700'),
    (6, 'bDc3XJiKhw4uU', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'BB700'),
    (7, '9xN3ae2S29ZGd', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'BB700'),
    (8, 'fDHNuTr8uKocM', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'DF800'),
    (9, 'Baq0vz6ATmIUw', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'NJ145'),
    (10, 'FqPOyqsSfK0MV', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'NJ145'),
    (11, 'ZdjxYXphfZWTh', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'NJ145'),
    (12, 'Ocj5qpP7eq9iw', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'NJ145'),
    (13, 'qJuwrtXiryF2V', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'LF450'),
    (14, 'CWlS8gZ0DqLv9', TO_DATE ('2024-5-23','yyyy-mm-dd'), 'LF450'),
    (15, 'AkJYrFVBSjZsM', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'ABCKM'),
    (16, 'RkqeflsIsjgZJ', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'ABCKM'),
    (17, 'Sg4ySI8gS5Kp5', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'ABCKM'),
    (18, 'PSptLMYnjpNiG', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'ABCSA'),
    (19, 'gdRIUPFFgfNNH', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'PH350'),
    (20, 'J7jiwycTMsAnE', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'PH350'),
    (21, '0cdgI4yReXVDE', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'PH350'),
    (22, 'Qk6FjgYF2dZ2i', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'YC500'),
    (23, '4CT8YXmn96FJw', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'PRI42'),
    (24, 'MWH4zoDVcxfK5', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'PRI42'),
    (25, 'Y5qMsrJDkEX1z', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'PRI42'),
    (26, 'FATCZzo92e8Wg', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'PRI42'),
    (27, 'ZwUtej8XcPAys', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'PRI42'),
    (28, 'VCLBGyE4vjYVu', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'MC135'),
    (29, 'jwLDmCGF9RC9p', TO_DATE ('2025-9-26','yyyy-mm-dd'), 'NVMES'),
    (30, 'wW8t4ja7MoenA', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVMES'),
    (31, 'PgIicUKhqQQC9', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVFSW'),
    (32, 'pcFkzn5dVazAf', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVFSW'),
    (33, 'HCSNZahE29Pg5', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVFSW'),
    (34, 'lEybuXvHp532u', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVOR9'),
    (35, 'ci0dWrHCLNAVF', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVOR9'),
    (36, 'RsXWkVFPUBGX6', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVOR9'),
    (37, '09nA7whCC8XTb', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVOR9'),
    (38, 'lvb8p9jHjzIlU', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVOR9'),
    (39, 'pnPt9T7LvqeW9', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'RS770'),
    (40, 'fGJWZWL7wD9Jq', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'RS770'),
    (41, 'FYjGOqJdiLb4X', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'SK800'),
    (42, 'rxpSM8oinJuIo', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'SK800'),
    (43, 'ywO2KBqVtvqaa', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'SK800'),
    (44, '7Oh5AvKZzF5eS', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'NVOB9'),
    (45, 'rxpSM8oinJuIo', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'INDAB'),
    (46, 'ywO2KBqVtvqaa', TO_DATE ('2026-1-29','yyyy-mm-dd'), 'INDAB');

INSERT INTO RAK_GUDANG (G_KODERAK, G_NAMA, G_ISFULL) 
VALUES 
    (1, 'ALAT MANDI', 0),
    (2, 'ELEKTRONIK', 0),
    (3, 'ALAT TULIS', 0),
    (4, 'MINUMAN', 0),
    (5, 'ALAT RUMAH TANGGA', 0),
    (6, 'MAKANAN DAN SNACK', 0),
    (7, 'MATERIAL BANGUNAN', 0),
    (8, 'KEBERSIHAN', 0),
    (9, 'AKSESORIS', 0),
    (10, 'PAKAIAN', 0),
    (11, 'KESEHATAN', 0);

INSERT INTO PEMASOK(PEM_NO, PEM_PERUSAHAAN, PEM_NOTELP, PEM_ALAMAT, RAK_GUDANG_G_KODERAK) 
VALUES 
    (1, 'PT. MAYORA INDAH TBK.', '080637704', 'JL. TOMANG JAYA KAV 21-23, JAKARTA BARAT', 6),
    (2, 'PT. SINAR DUNIA MAKMUR', '0313529442', 'JL. RAJAWALI NO.31, SURABAYA', 3),
    (3, 'PT. UNILEVER INDONESIA TBK.', '0312989100', 'JL. RUNGKUT INDUSTRI 4 NO.5-11, SURABAYA', 1),
    (4, 'PT. INDOFOOD TBK.', '03199841202', 'JL. PUTIHSARI INDAH U76, SURABAYA', 6),
    (5, 'PT. NESTLE INDONESIA', '0313529448', 'JL. RAYA WARU NO.25, SIDOARJO', 4),
    (6, 'PT. SEMEN INDONESIA', '0313529456', 'JL. VETETAN NO.93, GRESIK', 7),
    (7, 'PT. CASA VERDE INDONESIA', '0313529763', 'JL. RAJAWALI NO.32, TANGGERANG', 9),
    (8, 'PT. FEVA INDONESIA', '0313527639', 'JL. GALAXY KLAMPIS NO.99, SURABAYA', 2),
    (9, 'PT. HERLINA INDAH', '0313977639', 'JL. JAKARTA NO.9, TANGGERANG', 11),
    (10, 'PT. PERKASA INDAH', '0313977632', 'JL. KERATON JAYA NO.72, TANGGERANG', 5),
    (11, 'PT. KING MAKMUR', '0313977630', 'JL. RAYA KERTAJAYA NO.11, SURABAYA', 8),
    (12, 'PT. ABC INDONESIA', '0313977739', 'JL. MUYOSATI NO.79, SURABAYA', 6),
    (13, 'PT. SIDOMUNCUL', '0313977690', 'JL. DIPONEGORO NO.9, TANGGERANG', 6),
    (14, 'PT. UNIQLO INDONESIA', '0313977691', 'JL. DIPONEGORO NO.10, TANGGERANG', 10);

INSERT INTO DISKON(D_NO, D_NAMA, D_DISKON, BARANG_B_ID) 
VALUES 
    ('D01', 'POTONGAN HARGA BAPEL SETIAP HARI SELASA', 10000, 'BPLFS'),
    ('D02', 'DISKON NUVO FAMILY MILD PROTECT 900 ML', 5000, 'NVOB9'),
    ('D03', 'CASHBACK WEBCAM ROG EYE S FULL HD 1080P', 100000, 'WEC01');

INSERT INTO RAK_GUDANG_DETAIL (GD_NO, RAK_GUDANG_G_KODERAK, BARANG_B_ID) 
VALUES 
    (1, 4, 'MC600'),
    (2, 11, 'VX950'),
    (3, 4, 'BB700'),
    (4, 4, 'DF800'),
    (5, 6, 'NJ145'),
    (6, 6, 'LF450'),
    (7, 6, 'ABCKM'),
    (8, 6, 'ABCSA'),
    (9, 4, 'PH350'),
    (10, 4, 'YC500'),
    (11, 4, 'LWK22'),
    (12, 6, 'MC135'),
    (13, 1, 'NVMES'),
    (14, 1, 'NVFSW'),
    (15, 1, 'NVOR9'),
    (16, 8, 'RS770'),
    (17, 8, 'SK800'),
    (18, 1, 'NVOB9'),
    (19, 6, 'INDAB'),
    (20, 6, 'INDGO'),
    (21, 6, 'INDST'),
    (22, 6, 'MSKAB'),
    (23, 6, 'MSGOR'),
    (24, 6, 'MSKST'),
    (25, 4, 'LWK22'),
    (26, 10, 'BPL01'),
    (27, 10, 'BPL02'),
    (28, 9, 'BPL03'),
    (29, 9, 'BPL04'),
    (30, 10, 'BPLFS'),
    (31, 3, 'SND50'),
    (32, 3, 'KKY50'),
    (33, 3, 'BBS50'),
    (34, 3, 'PPR01'),
    (35, 3, 'PPR02'),
    (36, 3, 'SDU01'),
    (37, 3, 'SDU02'),
    (38, 5, 'SPU01'),
    (39, 5, 'SPU02'),
    (40, 5, 'PEL01'),
    (41, 5, 'EBR01'),
    (42, 5, 'KST01'),
    (43, 5, 'KPT01'),
    (44, 8, 'HST01'),
    (45, 2, 'JAD01'),
    (46, 2, 'JAD02'),
    (47, 2, 'JAD03'),
    (48, 2, 'JYS01'),
    (49, 2, 'WEC01'),
    (50, 2, 'MOS01'),
    (51, 2, 'MOS02'),
    (52, 2, 'KEY01'),
    (53, 8, 'TSS01'),
    (54, 2, 'RCR01');

SELECT * FROM MEMBER;

SELECT * FROM TRANSAKSI;

SELECT * FROM KASIR;

SELECT * FROM BARANG;

SELECT * FROM TRANSAKSI_DETAIL;

SELECT * FROM KASIR_DETAIL;

SELECT * FROM RAK_GUDANG;

SELECT * FROM RAK_GUDANG_DETAIL;
