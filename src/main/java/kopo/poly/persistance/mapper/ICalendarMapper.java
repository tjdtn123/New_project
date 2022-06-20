package kopo.poly.persistance.mapper;

import kopo.poly.dto.CalendarDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ICalendarMapper {

    List<CalendarDTO> getCalendar(CalendarDTO pDTO) throws Exception;

    void insertCalendar(CalendarDTO pDTO) throws Exception;

    void updateCalendar(CalendarDTO pDTO) throws Exception;

    void deleteCalendar(CalendarDTO pDTO) throws Exception;
}
