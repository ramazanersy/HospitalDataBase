

 

CREATE TABLE hasta ( 

hasta_id INT IDENTITY(1,1) PRIMARY KEY,
sigorta_id INT NOT NULL,
hasta_ad NVARCHAR(50) NOT NULL, 
hasta_soyad NVARCHAR(50) NOT NULL, 
hasta_tc CHAR(11) UNIQUE NOT NULL,
hasta_sikayet VARCHAR(100) NOT NULL, 
hasta_medeni_durum VARCHAR(10) NULL,  
hasta_dt DATE  NULL, 
hasta_cinsiyet VARCHAR(5) NULL, 
hasta_kan_grubu VARCHAR(10) NULL, 
hasta_telefon CHAR(11) NULL,
hasta_adres NVARCHAR(50) NULL,
FOREIGN KEY (sigorta_id) REFERENCES sigorta(sigorta_id)
);


CREATE TABLE doktor (

doktor_id INT PRIMARY KEY,
egitim_id INT NOT NULL,
doktor_ad NVARCHAR(50) NOT NULL, 
doktor_soyad NVARCHAR(50) NOT NULL, 
doktor_uzmalık_alanı VARCHAR(100) NOT NULL,
doktor_vardiya VARCHAR(30) NOT NULL,
doktor_deneyim NVARCHAR(MAX) NULL,
FOREIGN KEY (egitim_id) REFERENCES egitim(egitim_id)
);


CREATE TABLE randevu (

randevu_id INT PRIMARY KEY,
randevu_tarihi DATE NOT NULL,
hasta_id INT NOT NULL,
doktor_id INT NOT NULL,
randevu_iptal CHAR(1) DEFAULT '0',
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id),
FOREIGN KEY (doktor_id) REFERENCES doktor(doktor_id)
);


CREATE TABLE vaka (

vaka_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
vaka_tanı NVARCHAR(100) NOT NULL,
vaka_tanı_tarihi DATETIME NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id)
);


CREATE TABLE tedavi (

tedavi_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
doktor_id INT NOT NULL,
tedavi_turu VARCHAR(100) NOT NULL,
tedavi_suresi VARCHAR(30) NULL,
tedavi_yontemi NVARCHAR(150) NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id),
FOREIGN KEY (doktor_id) REFERENCES doktor(doktor_id)
);


CREATE TABLE geri_bildirim (

geri_bildirim_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
geri_donus NVARCHAR(MAX) NOT NULL,
geri_bildirim_tarihi DATE NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id)
);


CREATE TABLE ilac (

ilac_id INT PRIMARY KEY,
ilac_adi VARCHAR(200) NOT NULL,
ilac_türü VARCHAR(100) NOT NULL,
ilac_dozaj VARCHAR(50) NOT NULL,
ilac_stok INT NOT NULL,
ilac_baslangic_tarihi DATE NOT NULL,
ilac_bitis_tarihi DATE NULL,
ilac_yan_etki VARCHAR(50) NOT NULL
);


CREATE TABLE recete (

recete_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
doktor_id INT NOT NULL,
recete_kod CHAR(8) UNIQUE NOT NULL,
recete_yazılma_tarihi DATETIME NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id),
FOREIGN KEY (doktor_id) REFERENCES doktor(doktor_id)
);



CREATE TABLE telefon_kayıt (

tel_kayıt_id INT PRIMARY KEY,
tel_arayan_kisi NVARCHAR(50) NOT NULL,
tel_arayan_numara VARCHAR(15) NOT NULL
);


CREATE TABLE birim (

birim_id INT PRIMARY KEY,
birim_adi VARCHAR(50),
birim_tel CHAR(11)
);


CREATE TABLE fatura (

fatura_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
fatura_tutar DECIMAL(10,2) NOT NULL,
fatura_tarih DATETIME NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id)
);



CREATE TABLE sigorta (

sigorta_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
sigorta_turu VARCHAR(50) NOT NULL,
sigorta_no CHAR(11) NOT NULL,
sigorta_baslangic DATE NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id)
);



CREATE TABLE personel (

personel_id INT PRIMARY KEY,
birim_id INT NOT NULL,
personel_ad NVARCHAR(50) NOT NULL,
personel_soyad NVARCHAR(50) NOT NULL,
personel_pozisyon VARCHAR(100) NOT NULL,
FOREIGN KEY (birim_id) REFERENCES birim(birim_id)
);


CREATE TABLE hemsire (

hemsire_id INT PRIMARY KEY,
birim_id INT NOT NULL,
personel_id INT NOT NULL,
hemsire_ad NVARCHAR(50) NOT NULL,
hemsire_soyad NVARCHAR(50) NOT NULL,
FOREIGN KEY (birim_id) REFERENCES birim(birim_id),
FOREIGN KEY (personel_id) REFERENCES personel(personel_id)
);


CREATE TABLE izin (

izin_id INT PRIMARY KEY,
personel_id INT NOT NULL,
izin_tarih DATE NOT NULL,
izin_neden NVARCHAR(200) NOT NULL,
FOREIGN KEY (personel_id) REFERENCES personel(personel_id)
);


CREATE TABLE egitim (

egitim_id INT PRIMARY KEY,
egitim_adi NVARCHAR(200) NOT NULL,
egitim_tarih DATE NOT NULL
);


CREATE TABLE poliklinik (

poliklinik_id INT PRIMARY KEY,
poliklinik_adi VARCHAR(100) NOT NULL,
poliklinik_uzmanlık_alanı VARCHAR(100) NOT NULL,
poliklinik_kat INT NOT NULL
);


CREATE TABLE laboratuvar (

lab_id INT PRIMARY KEY,
lab_adi VARCHAR(100) NOT NULL,
lab_aciklama VARCHAR(MAX) NOT NULL
);


CREATE TABLE lab_sonuc (

lab_sonuc_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
lab_id INT NOT NULL,
lab_sonuc_adi VARCHAR(50) NOT NULL,
lab_sonuc_aciklama VARCHAR(255) NOT NULL,
lab_sonuc_tarih DATETIME NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id),
FOREIGN KEY (lab_id) REFERENCES laboratuvar(lab_id)
);


CREATE TABLE odalar (

oda_id INT PRIMARY KEY,
oda_no INT NOT NULL,
oda_tip VARCHAR(50) NOT NULL,
oda_durum VARCHAR(30) NOT NULL,
oda_kat INT NOT NULL,
oda_bolum VARCHAR(50) NOT NULL
);


CREATE TABLE yatak (

yatak_id INT PRIMARY KEY,
oda_id INT NOT NULL,
yatak_no INT NOT NULL,
yatak_durum VARCHAR(30) NOT NULL,
FOREIGN KEY (oda_id) REFERENCES odalar(oda_id)
);


CREATE TABLE tıbbi_cihaz (

cihaz_id INT PRIMARY KEY,
cihaz_ad VARCHAR(100) NOT NULL,
cihaz_seri_no VARCHAR(50) UNIQUE NOT NULL,
cihaz_tur VARCHAR(50) NOT NULL,
cihaz_marka VARCHAR(50) NOT NULL,
cihaz_durum VARCHAR(20) NOT NULL, 
cihaz_bolum VARCHAR(50) NOT NULL,
cihaz_alis_tarih DATE NOT NULL,
cihaz_alis_fiyati DECIMAL(10, 2) NOT NULL
);


CREATE TABLE yatıs (

yatıs_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
doktor_id INT NOT NULL,
yatak_id INT NOT NULL,
oda_id INT NOT NULL,
poliklinik_id INT NOT NULL,
yatis_tarih DATETIME NOT NULL,
cikis_tarih DATETIME NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id),
FOREIGN KEY (doktor_id) REFERENCES doktor(doktor_id),
FOREIGN KEY (yatak_id) REFERENCES yatak(yatak_id),
FOREIGN KEY (oda_id) REFERENCES odalar(oda_id),
FOREIGN KEY (poliklinik_id) REFERENCES poliklinik(poliklinik_id)
);


CREATE TABLE ameliyat (

ameliyat_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
doktor_id INT NOT NULL,
cihaz_id INT NOT NULL,
ameliyat_anestezi_turu VARCHAR(50) NOT NULL,
ameliyat_tarih DATETIME NOT NULL,
ameliyat_suresi INT NOT NULL,
ameliyat_tip VARCHAR(100) NOT NULL,                               
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id),
FOREIGN KEY (doktor_id) REFERENCES doktor(doktor_id),
FOREIGN KEY (cihaz_id) REFERENCES tıbbi_cihaz(cihaz_id)
);


CREATE TABLE acil_servis (

acil_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
acil_olay_tarihi DATE NOT NULL,
acil_olay_turu NVARCHAR(100) NOT NULL,
acil_mudahale_durum VARCHAR(50) NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id)
);


CREATE TABLE ziyaretci (

ziyaretci_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
ziyaretci_ad VARCHAR(50) NOT NULL,
ziyaretci_soyad VARCHAR(50) NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id)
);


CREATE TABLE refakatci (

refakatci_id INT PRIMARY KEY,
hasta_id INT NOT NULL,
refakatci_ad VARCHAR(50) NOT NULL,
refakatci_soyad VARCHAR(50) NOT NULL,
refakatci_tel VARCHAR(20) NOT NULL,
refakatci_adres VARCHAR(200) NULL,
refakatci_tarih DATE NOT NULL,
refakatci_bitis DATE NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id)
);


CREATE TABLE hasta_takip (

takip_id INT IDENTITY(1,1) PRIMARY KEY,
hasta_id INT NOT NULL, 
doktor_id INT NOT NULL, 
tedavi_id INT NOT NULL,
takip_tarihi DATE NOT NULL,
takip_durumu VARCHAR(50) NOT NULL,
takip_aciklama VARCHAR(100) NOT NULL,
FOREIGN KEY (hasta_id) REFERENCES hasta(hasta_id)
FOREIGN KEY (doktor_id) REFERENCES doktor(doktor_id)
FOREIGN KEY (tedavi_id) REFERENCES tedavi(tedavi_id)
);


CREATE TABLE eczane (

eczane_id INT IDENTITY(1,1) PRIMARY KEY,
eczane_adi NVARCHAR(50) NOT NULL,
eczane_adres NVARCHAR(200) NOT NULL,
eczane_email VARCHAR(100) NULL,
eczane_telefon VARCHAR(20) NOT NULL,
eczane_web_site NVARCHAR(100) NULL
);


CREATE TABLE eczane_stok (

stok_id INT IDENTITY(1,1) PRIMARY KEY,
eczane_id INT NOT NULL,
ilac_id INT NOT NULL,
stok_adet INT NOT NULL,
stok_alis_fiyat DECIMAL(10,2) NOT NULL,
stok_satis_fiyat DECIMAL(10,2) NOT NULL,
FOREIGN KEY (eczane_id) REFERENCES eczane(eczane_id),
FOREIGN KEY (ilac_id) REFERENCES ilac(ilac_id)
);
                                                                                                                                                                                                chatgpt abim de kontrol etti ama yine de bi sende gözden geçirir misin acaba acabaaaa👉🏻👈🏻  bi de şimdi bi fotoğraf atacağım ona bakabilir misin?
