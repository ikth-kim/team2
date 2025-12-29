package com.team2.householdledger.ledger.dto;

import lombok.Data;
import java.time.LocalDate;

/**
 * 가계부 내역 DTO
 * Table: ledgers
 */
@Data
public class LedgerDTO {
    private Long ledgerNo; // ledger_no (PK)
    private Long userNo; // user_no (FK)
    private String commCd; // comm_cd (FK - 카테고리 코드)
    private Integer amount; // amount (금액)
    private LocalDate transDt; // trans_dt (거래 날짜)
    private String memo; // memo (메모/비고)
    private String statusCd; // status_cd (상태 'Y'/'N')

    // 추가 필드 (DB 컬럼 외)
    private String categoryNm; // 카테고리명 (fn_get_comm_nm 사용 결과)
}
