
package kopo.poly.controller;


import kopo.poly.dto.StarDTO;
import kopo.poly.service.IMongoService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Slf4j
@Controller
@RequestMapping("/Star")
public class StarController {

    @Resource(name = "MongoService")
    private IMongoService mongoService;

    @GetMapping(value = "/selectSeason")
    public String SelectRegion() {
        return "/Star/selectSeason";

    }
    @GetMapping(value = "/StarList")
    public String StarList(ModelMap model, HttpServletRequest request) throws Exception {

        log.info(this.getClass().getName() + ".selectStarList Start!");

        String season = CmmUtil.nvl(request.getParameter("season"));
        log.info(season);

        List<StarDTO> rList = mongoService.getStarList(season);

        model.addAttribute("rList",rList);

        log.info(this.getClass().getName() + ".selectObserver Start!");

        return "/Star/StarList";

    }








    @GetMapping(value = "History000")
    public String History000() {
        return "/History000";

    }







}
