package kopo.poly.service;

import kopo.poly.dto.CalendarDTO;

import java.util.List;

public interface Calendar {

    List<CalendarDTO> getCalendar(CalendarDTO pDTO) throws Exception;

    void insertCalendar(CalendarDTO pDTO) throws Exception;

    void updateCalendar(CalendarDTO pDTO) throws Exception;

    void deleteCalendar(CalendarDTO pDTO) throws Exception;

}
