package kopo.poly.controller;


import kopo.poly.dto.CalendarDTO;
import kopo.poly.service.impl.CalendarServiceImpl;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping(value ="/calendar" )
@Slf4j
@Controller
public class CalendarController {

    @Resource(name = "CalendarService")
    private CalendarServiceImpl calendarService;





    @ResponseBody
    @GetMapping(value = "/getCalendar")
    public List<CalendarDTO> getCalendarList(HttpServletRequest request, HttpSession session) {
        log.info(getClass().getName()+ ".getCalendarList Starrt");
        List<CalendarDTO> rList = null;
        try {
            String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));
            CalendarDTO pDTO = new CalendarDTO();
            pDTO.setUser_id(user_id);


            rList = calendarService.getCalendar(pDTO);



        } catch (Exception e) {
            e.printStackTrace();
        }

        log.info(getClass().getName()+ ".getCalendarList End");
        return rList;

    }

    @ResponseBody
    @PatchMapping(value = "/updateCalendar")
    public CalendarDTO updateCalendar(HttpServletRequest request) {
        log.info(getClass().getName()+ ".updateCalendar Start");

        CalendarDTO pDTO = new CalendarDTO();




        log.info(getClass().getName()+ ".updateCalendar Start");
        return pDTO;
    }

}