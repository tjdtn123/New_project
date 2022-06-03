
package kopo.poly.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Slf4j
@Controller
@RequestMapping("/Star")
public class StarController {

    @GetMapping(value = "/StarList")
    public String Star000() {
        return "/Star/StarList";

    }

    @GetMapping(value = "History000")
    public String History000() {
        return "/History000";

    }







}
