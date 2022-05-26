
package kopo.poly.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Slf4j
@Controller
public class StarController {

    @GetMapping(value = "/Star/StarList")
    public String Star000() {
        return "/Star/StarList";

    }

    @GetMapping(value = "History000")
    public String History000() {
        return "/History000";

    }







}
