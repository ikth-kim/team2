-- =========================================
-- Database (Created manually or via connection, script focuses on tables)
-- =========================================

-- =========================================
-- Drop Tables
-- =========================================
DROP TABLE IF EXISTS TBL_SAMPLE;

DROP TABLE IF EXISTS COL_META;

DROP TABLE IF EXISTS TBL_META;

DROP TABLE IF EXISTS USERS;

-- =========================================
-- 1. Users Table
-- =========================================
CREATE TABLE USERS (
    ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '사용자 고유 ID',
    NAME VARCHAR(50) NOT NULL COMMENT '사용자 이름',
    EMAIL VARCHAR(100) NOT NULL UNIQUE COMMENT '사용자 이메일',
    PASSWORD VARCHAR(100) NOT NULL COMMENT '암호화된 비밀번호',
    ACTIVE_FL CHAR(1) DEFAULT 'Y' COMMENT '활성 여부 (Y/N)',
    REG_DT TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '가입일자',
    CONSTRAINT CK_USERS_ACTIVE_FL CHECK (ACTIVE_FL IN ('Y', 'N')),
    CONSTRAINT CK_USERS_EMAIL CHECK (EMAIL LIKE '%@%')
) ENGINE = InnoDB COMMENT = '사용자 테이블';

-- =========================================
-- 2. Tables Metadata
-- =========================================
CREATE TABLE TBL_META (
    ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '테이블 고유 ID',
    NAME VARCHAR(50) NOT NULL COMMENT '테이블 이름',
    DESCRIPTION VARCHAR(255) COMMENT '테이블 설명',
    REG_DT TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자'
) ENGINE = InnoDB COMMENT = '테이블 메타 데이터';

-- =========================================
-- 3. Columns Metadata
-- =========================================
CREATE TABLE COL_META (
    ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '컬럼 고유 ID',
    TABLE_ID INT NOT NULL COMMENT '테이블 ID(FK)',
    NAME VARCHAR(50) NOT NULL COMMENT '컬럼 이름',
    DATA_TYPE VARCHAR(50) NOT NULL COMMENT '데이터 타입',
    NULLABLE CHAR(1) DEFAULT 'Y' COMMENT 'NULL 허용 여부 (Y/N)',
    ORDER_NO INT DEFAULT 0 COMMENT '컬럼 순서',
    REG_DT TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
    CONSTRAINT CK_COL_META_NULLABLE CHECK (NULLABLE IN ('Y', 'N')),
    CONSTRAINT COL_META_FK1 FOREIGN KEY (TABLE_ID) REFERENCES TBL_META (ID) ON DELETE CASCADE
) ENGINE = InnoDB COMMENT = '컬럼 메타 데이터';

-- =========================================
-- 4. Sample Data Table
-- =========================================
CREATE TABLE TBL_SAMPLE (
    ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '데이터 고유 ID',
    TABLE_ID INT NOT NULL COMMENT '테이블 ID(FK)',
    DATA_JSON JSON NOT NULL COMMENT '컬럼-값 매핑(JSON)',
    ACTIVE_FL CHAR(1) DEFAULT 'Y' COMMENT '활성 여부 (Y/N)',
    REG_DT TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
    CHG_DT TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
    CONSTRAINT CK_TBL_SAMPLE_ACTIVE_FL CHECK (ACTIVE_FL IN ('Y', 'N')),
    CONSTRAINT TBL_SAMPLE_FK1 FOREIGN KEY (TABLE_ID) REFERENCES TBL_META (ID) ON DELETE CASCADE
) ENGINE = InnoDB COMMENT = '샘플 CRUD 학습용 데이터';

-- =========================================
-- Index Example
-- =========================================
CREATE INDEX IDX_USERS_EMAIL ON USERS (EMAIL);