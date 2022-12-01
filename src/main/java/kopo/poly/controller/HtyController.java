package kopo.poly.controller;

import kopo.poly.dto.MyDTO;
import kopo.poly.dto.ObsDTO;
import kopo.poly.dto.StarDTO;
import kopo.poly.service.IMongoService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

@Slf4j
@Controller
public class HtyController {
    public static int INDENT_FACTOR = 4;
    @Resource(name = "MongoService")
    private IMongoService mongoService;

    @GetMapping(value = "/observer/selectRegion")
    public String SelectRegion() {
        return "/observer/selectRegion";

    }


    @GetMapping(value =  "/observer/collectObs")
    public String collectObserver(ModelMap model) throws Exception{

        log.info(this.getClass().getName() + ".collectObserver Start!");

        String msg;

        int res = mongoService.collectObserver();

        if (res == 1) {
            msg = "success";

        }else{
            msg = "fail";
        }

        log.info(this.getClass().getName() + ".collectObserver ENd!");

        model.addAttribute("msg",msg);

        return "/observer/MsgToHome";

    }

    @ResponseBody
    @GetMapping(value = "/observer/obsPage")
    public List<ObsDTO> Obspage(HttpServletRequest request, ModelMap model) throws Exception{
        log.info(this.getClass().getName() + ".selectObserver Start!");

        String region = CmmUtil.nvl(request.getParameter("region"));
        log.info(region);

        List<ObsDTO> rList = mongoService.getObsList(region);

        model.addAttribute("rList",rList);



        log.info(this.getClass().getName() + ".selectObserver End!");

        return rList;
    }

    @GetMapping(value = "/Star/StarInfo")
    public String StarInfo(HttpServletRequest request, ModelMap model) throws Exception{
        log.info(this.getClass().getName() + ".selectStarInfo Start!");

        String star_name = CmmUtil.nvl(request.getParameter("star_name"));

        StarDTO rDTO = mongoService.getStarInfo(star_name);

        model.addAttribute("rDTO",rDTO);


        log.info(this.getClass().getName() + ".selectStarInfo End!");

        return "/Star/StarInfo";
    }
    @ResponseBody
    @PostMapping(value="/Star/insertmine")
    public String InsertMine(HttpServletRequest request,ModelMap model, HttpSession session) throws Exception{
        log.info(this.getClass().getName() + ".InsertMine Start!");
        String msg;



        String user_id = CmmUtil.nvl((String)session.getAttribute("user_id"));
        String star_name = CmmUtil.nvl(request.getParameter("star_name"));
        String position = CmmUtil.nvl(request.getParameter("position"));
        String season = CmmUtil.nvl(request.getParameter("season"));
        String star_cnt = CmmUtil.nvl(request.getParameter("star_cnt"));
        String picture = CmmUtil.nvl(request.getParameter("picture"));

        MyDTO pDTO = new MyDTO();

        pDTO.setUser_id(user_id);
        pDTO.setStar_name(star_name);
        pDTO.setPosition(position);
        pDTO.setSeason(season);
        pDTO.setStar_cnt(star_cnt);
        pDTO.setPicture(picture);


        int res = mongoService.InsertMine(pDTO);

        if (res == 1) {
            msg = "success";
            model.addAttribute("msg", msg);
            log.info(this.getClass().getName() + ".InsertMine End!");
            return msg;

        }
        else {

            msg = "fail";

            log.info(this.getClass().getName() + ".InsertMine End!");
            return msg;
        }
    }



    @GetMapping(value = "/Astro/selectDate")
    public String SelectDate() {

        return "/Astro/selectDate";

    }



    @GetMapping(value = "/Astro/test")

    public String test(ModelMap model, HttpServletRequest request) throws MalformedURLException,
            IOException, ParseException {
        //xml을 Json형식으로 변환
        log.info(this.getClass().getName() + ".xml to json start!");

        String year = CmmUtil.nvl(request.getParameter("year"));
        String month = CmmUtil.nvl(request.getParameter("month"));


        HttpURLConnection conn = (HttpURLConnection) new URL("http://apis.data.go.kr/B090041/openapi/service/AstroEventInfoService/getAstroEventInfo?"
                + "ServiceKey=oThJMbfU%2FWNX0OaMTfVfg7iP%2FysoIW9p%2FtfgGFtccPJjgvoMlTXF%2BEKwsesm%2Bneiugst4PREez3oA2MOkIcCgQ%3D%3D&solYear=" + year + "&solMonth=" + month).openConnection();
        conn.connect();
        BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
        BufferedReader reader = new BufferedReader(new InputStreamReader(bis));
        StringBuffer st = new StringBuffer();
        String line;
        while ((line = reader.readLine()) != null) {
            st.append(line);
        }
        String avx = st.toString();
        JSONObject xmlJSONObj = XML.toJSONObject(st.toString());
        String jsonPrettyPrintString = xmlJSONObj.toString(INDENT_FACTOR);

//----------------------------------------------------------------------------------------
        //Json 파싱
        JSONObject Obj = new JSONObject(xmlJSONObj.toString(INDENT_FACTOR));
        JSONObject response = (JSONObject)Obj.get("response");
        JSONObject body = (JSONObject)response.get("body");
        JSONObject items = (JSONObject)body.get("items");
        JSONArray item = (JSONArray)items.get("item");

        String astroTitle = (String) ((JSONObject) item.get(0)).get("astroTitle");
        String locdate = String.valueOf(((JSONObject) item.get(0)).get("locdate"));
        String astroEvent = (String) ((JSONObject) item.get(0)).get("astroEvent");
        String astroTime = (String) ((JSONObject) item.get(0)).get("astroTime");

        model.addAttribute("astroTitle", astroTitle);
        model.addAttribute("locdate", locdate);
        model.addAttribute("astroEvent", astroEvent);
        model.addAttribute("astroTime", astroTime);

    return "Astro/test";

    }


}