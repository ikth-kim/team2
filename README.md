# 📌 프로젝트 소개 (Project Introduction)

## 프로젝트 이름
**DB Buddy**

---

## 1️⃣ 프로젝트 개요

**GUI 기반 CRUD 학습용 웹 DBMS**

이 프로젝트는 SQL 문을 직접 작성하지 않아도, 버튼과 입력폼을 통해 CRUD(Create, Read, Update, Delete)를 수행하고, 내부에서 어떤 SQL이 실행되는지 직관적으로 확인할 수 있는 교육용 웹 도구입니다.

- **목표**: SQL 문 구조와 DB 동작 원리를 직관적으로 이해
- **특징**: SQL 직접 입력 X / 안전한 범위 내 CRUD / GUI 기반

---

# 📌 기획 (Planning)

## 2️⃣ 요구사항

### 필수 기능
1. **테이블 목록 조회**
   - DB에 어떤 테이블이 있는지 확인
2. **테이블 컬럼 구조 확인**
   - 컬럼 이름, 데이터 타입, NULL 여부
3. **조회(Read)**
   - 컬럼 체크 후 SELECT 문 자동 생성
   - 실행 결과 테이블 표시
4. **추가(Create)**
   - 입력 폼으로 새 데이터 추가
5. **수정(Update)**
   - PK 기준 단일 행 수정
6. **삭제(Delete)**
   - PK 기준 단일 행 삭제
7. **SQL 미리보기**
   - 어떤 SQL이 실행되는지 화면에 표시

### 제한 사항
- SQL 직접 입력 X
- JOIN, WHERE 자유 입력 X
- 다중 행 Update/Delete X

---

## 3️⃣ 시스템 설계

### 3.1 유스케이스 (Use Case)

사용자(학생)가 시스템을 통해 어떤 기능을 수행할 수 있는지 보여주는 다이어그램입니다.

```mermaid
usecaseDiagram
    actor "User (Learner)" as U
    package "DB Buddy System" {
        usecase "테이블 목록 조회" as UC1
        usecase "테이블 상세(컬럼) 확인" as UC2
        usecase "데이터 조회 (SELECT)" as UC3
        usecase "데이터 추가 (INSERT)" as UC4
        usecase "데이터 수정 (UPDATE)" as UC5
        usecase "데이터 삭제 (DELETE)" as UC6
        usecase "SQL 미리보기" as UC7
    }
    U --> UC1
    U --> UC2
    U --> UC3
    U --> UC4
    U --> UC5
    U --> UC6
    UC3 ..> UC7 : include
    UC4 ..> UC7 : include
    UC5 ..> UC7 : include
    UC6 ..> UC7 : include
```

### 3.2 ERD (Entity Relationship Diagram)

프로젝트에서 사용하는 데이터베이스 스키마 구조입니다. 메타데이터 기반으로 동적인 테이블 관리가 가능하도록 설계되었습니다.

```mermaid
erDiagram
    USERS {
        INT ID PK "사용자 고유 ID"
        VARCHAR NAME "이름"
        VARCHAR EMAIL "이메일 (Unique)"
        VARCHAR PASSWORD "비밀번호"
        CHAR ACTIVE_FL "활성여부"
        TIMESTAMP REG_DT "가입일"
    }

    TBL_META {
        INT ID PK "테이블 ID"
        VARCHAR NAME "테이블명"
        VARCHAR DESCRIPTION "설명"
        TIMESTAMP REG_DT "등록일"
    }

    COL_META {
        INT ID PK "컬럼 ID"
        INT TABLE_ID FK "테이블 ID"
        VARCHAR NAME "컬럼명"
        VARCHAR DATA_TYPE "데이터 타입"
        CHAR NULLABLE "NULL 허용 여부"
        INT ORDER_NO "정렬 순서"
    }

    TBL_SAMPLE {
        INT ID PK "데이터 ID"
        INT TABLE_ID FK "테이블 ID"
        JSON DATA_JSON "데이터(JSON)"
        CHAR ACTIVE_FL "활성여부"
        TIMESTAMP REG_DT "등록일"
        TIMESTAMP CHG_DT "수정일"
    }

    TBL_META ||--|{ COL_META : "defines columns for"
    TBL_META ||--|{ TBL_SAMPLE : "contains data for"
```

---

# 📌 개발자 가이드 (Developer Guide)

## 4️⃣ 팀원 역할 (예시)

| 역할 | 담당 |
|------|------|
| 팀장(전공자) | 전체 구조 설계, Spring Boot + MyBatis 설정, 통합 테스트 |
| 팀원1 | DB 테이블/컬럼 정의, 샘플 데이터 삽입 |
| 팀원2 | 테이블 목록/컬럼 체크 UI, SELECT 문 미리보기 |
| 팀원3 | Create / Update 폼 구현 |
| 팀원4 | Delete 기능, SELECT 실행 결과 표시 |

> 참고: 모두 개발자로 참여, 기능 단위로 역할 분담

---

## 5️⃣ 프로젝트 진행 전략

1. 팀장이 전체 구조 설계 및 초기 API 구현
2. DB 담당이 테이블과 샘플 데이터 준비
3. UI 담당이 컬럼 체크박스 및 SELECT 미리보기 구현
4. CRUD 담당이 Create/Update/Delete 폼 제작
5. 팀장 통합 테스트 및 최종 검증

---

## 6️⃣ 트러블슈팅 (DB 연결 문제 해결)

애플리케이션 실행 시 DB 연결 권한 오류(`Access denied`, `DROP command denied`)가 발생할 경우, 아래 SQL을 **ROOT 계정**으로 실행하여 사용자를 생성하고 권한을 부여하세요.

```sql
-- 1. 사용자 생성 (localhost 전용)
CREATE USER IF NOT EXISTS 'swcamp'@'localhost' IDENTIFIED BY 'swcamp';

-- 2. 권한 부여 (모든 권한)
GRANT ALL PRIVILEGES ON GUI_CRUD_DBMS.* TO 'swcamp'@'localhost';

-- 3. 권한 적용
FLUSH PRIVILEGES;
```
