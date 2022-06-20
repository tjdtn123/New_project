package kopo.poly.service.impl;

import kopo.poly.dto.CalendarDTO;
import kopo.poly.persistance.mapper.ICalendarMapper;
import kopo.poly.service.Calendar;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("CalendarService")
public class CalendarServiceImpl implements Calendar {

    private final ICalendarMapper calendarMapper;
    public CalendarServiceImpl (ICalendarMapper calendarMapper) {
        this.calendarMapper = calendarMapper;
    }


    @Override
    public List<CalendarDTO> getCalendar(CalendarDTO pDTO) throws Exception {

        return calendarMapper.getCalendar(pDTO);
    }

    @Transactional
    @Override
    public void insertCalendar(CalendarDTO pDTO) throws Exception{

        calendarMapper.insertCalendar(pDTO);
    }
    @Transactional
    @Override
    public void updateCalendar(CalendarDTO pDTO) throws Exception{

        calendarMapper.updateCalendar(pDTO);
    }

    @Transactional
    @Override
    public void deleteCalendar(CalendarDTO pDTO) throws Exception{

        calendarMapper.deleteCalendar(pDTO);
    }

}
