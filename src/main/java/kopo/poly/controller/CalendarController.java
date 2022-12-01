package kopo.poly.controller;


import kopo.poly.dto.CalendarDTO;
import kopo.poly.service.impl.CalendarServiceImpl;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(value ="/calendar" )
@Slf4j
@Controller
public class CalendarController {

    @Resource(name = "CalendarService")
    private CalendarServiceImpl calendarService;

    @GetMapping(value = "/caltest")
    public String Caltest() {

        return "/calendar/caltest";
    }


    @ResponseBody
    @GetMapping(value = "/getCalendar")
    public List<Map<String, Object>> getCalendarList(HttpServletRequest request, HttpSession session) throws Exception {
        log.info(getClass().getName()+ ".getCalendarList Start");



        String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));
        CalendarDTO pDTO = new CalendarDTO();
        pDTO.setUser_id(user_id);

        List<CalendarDTO> rList = calendarService.getCalendar(pDTO);

        JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();

        HashMap<String, Object> hash = new HashMap<>();

        for (int i = 0; i < rList.size(); i++) {
            hash.put("calendar_No", rList.get(i).getCalendar_No());
            hash.put("title", rList.get(i).getTitle());
            hash.put("memo", rList.get(i).getMemo());
            hash.put("start", rList.get(i).getStart());
            hash.put("end", rList.get(i).getEnd());
            hash.put("user_id", rList.get(i).getUser_id());

            jsonObj = new JSONObject(hash);
            jsonArr.add(jsonObj);

        }

        if (rList.size() != 0){

            log.info(rList.get(0).getTitle());
            log.info(rList.get(0).getMemo());
        }





        log.info(getClass().getName()+ ".getCalendarList End");
        return jsonArr;

    }


    @ResponseBody
    @PostMapping(value = "/insertCalendar")
    public String insertCalendar(HttpServletRequest request, HttpSession session) throws Exception {
        log.info(getClass().getName()+ ".insertCalendar Start");

        String msg = "성공";

        String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));
        String title = CmmUtil.nvl(request.getParameter("title"));
        String memo = CmmUtil.nvl(request.getParameter("memo"));
        String start = CmmUtil.nvl(request.getParameter("start"));
        String end = CmmUtil.nvl(request.getParameter("end"));

        log.info("user_id : " +user_id);
        log.info("title : " +title);
        log.info("memo : " +memo);
        log.info("start : " +start);
        log.info("end : " +end);

        CalendarDTO pDTO = new CalendarDTO();

        pDTO.setUser_id(user_id);
        pDTO.setTitle(title);
        pDTO.setMemo(memo);
        pDTO.setStart(start);
        pDTO.setEnd(end);

        calendarService.insertCalendar(pDTO);

        log.info(getClass().getName()+ ".insertCalendar End");

        return msg;

    }

    @ResponseBody
    @PostMapping(value = "/updateCalendar")
    public String updateCalendar(HttpServletRequest request, HttpSession session) throws Exception {
        log.info(getClass().getName()+ ".updateCalendar Start");

        String msg = "성공";

        int calendar_No = Integer.parseInt(request.getParameter("calendar_No"));
        String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));
        String title = CmmUtil.nvl(request.getParameter("title"));
        String memo = CmmUtil.nvl(request.getParameter("memo"));
        String start = CmmUtil.nvl(request.getParameter("start"));
        String end = CmmUtil.nvl(request.getParameter("end"));

        log.info("calendar_No : " + calendar_No);
        log.info("user_id : " +user_id);
        log.info("title : " +title);
        log.info("memo : " +memo);
        log.info("start : " +start);
        log.info("end : " +end);

        CalendarDTO pDTO = new CalendarDTO();

        pDTO.setCalendar_No(calendar_No);
        pDTO.setUser_id(user_id);
        pDTO.setTitle(title);
        pDTO.setMemo(memo);
        pDTO.setStart(start);
        pDTO.setEnd(end);

        calendarService.updateCalendar(pDTO);

        log.info(getClass().getName()+ ".updateCalendar End");

        return msg;


    }


    @ResponseBody
    @PostMapping(value = "/deleteCalendar")
    public String deleteCalendar(HttpServletRequest request, HttpSession session) throws Exception{
        log.info(this.getClass().getName() + ".deleteCalendar Start!");
        String msg = "성공";

        String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));
        String title = CmmUtil.nvl(request.getParameter("title"));
        String memo = CmmUtil.nvl(request.getParameter("memo"));

        log.info("user_id : " +user_id);
        log.info("title : " +title);
        log.info("memo : " +memo);


        CalendarDTO pDTO = new CalendarDTO();

        pDTO.setUser_id(user_id);
        pDTO.setTitle(title);
        pDTO.setMemo(memo);

        calendarService.deleteCalendar(pDTO);

        log.info(getClass().getName()+ ".updateCalendar End");

        return msg;
    }
}