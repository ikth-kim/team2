package com.team2.dbbuddy.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SampleDTO {
    private Integer id;
    private Integer tableId;
    private String dataJson;
    private String activeFl;
    private LocalDateTime regDt;
    private LocalDateTime chgDt;
}
