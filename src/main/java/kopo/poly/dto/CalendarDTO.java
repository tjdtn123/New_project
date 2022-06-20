package kopo.poly.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CalendarDTO {
    private int calendar_No;
    private String user_id;
    private String title;
    private String memo;
    private String start;
    private String end;
}