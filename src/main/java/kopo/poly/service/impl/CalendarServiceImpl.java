package kopo.poly.service.impl;

import kopo.poly.dto.CalendarDTO;
import kopo.poly.persistance.mapper.ICalendarMapper;
import kopo.poly.service.Calendar;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service("CalendarService")
public class CalendarServiceImpl implements Calendar {

    private final ICalendarMapper calendarMapper;
    public CalendarServiceImpl (ICalendarMapper calendarMapper) {
        this.calendarMapper = calendarMapper;
    }


    @Override
    public List<CalendarDTO> getCalendar(CalendarDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getCalendar Start!");
        log.info(this.getClass().getName() + ".getCalendar End!");

        return calendarMapper.getCalendar(pDTO);
    }

    @Transactional
    @Override
    public void insertCalendar(CalendarDTO pDTO) throws Exception{

        log.info(this.getClass().getName() + "insertCalendar Start!");
        log.info(this.getClass().getName() + "insertCalendar End!");

        calendarMapper.insertCalendar(pDTO);
    }

    @Transactional
    @Override
    public void updateCalendar(CalendarDTO pDTO) throws Exception{

        log.info(this.getClass().getName() + "updateCalendar Start!");
        log.info(this.getClass().getName() + "updateCalendar End!");

        calendarMapper.updateCalendar(pDTO);
    }

    @Transactional
    @Override
    public void deleteCalendar(CalendarDTO pDTO) throws Exception{

        log.info(this.getClass().getName() + "deleteCalendar Start!");
        log.info(this.getClass().getName() + "deleteCalendar End!");

        calendarMapper.deleteCalendar(pDTO);
    }

}
