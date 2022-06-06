package kopo.poly.controller;

import kopo.poly.dto.UserInfoDTO;
import kopo.poly.service.IUserInfoService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Resource(name = "UserInfoService")
    private IUserInfoService userInfoService;


    @GetMapping(value = "/MyPage")
    private String MyPage() {
        return "/mypage/Mypage";
    }

    @GetMapping(value = "/Myinfo")
    private String Myinfo(ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".Myinfo Start!");

        String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));

        log.info(user_id);
        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUser_id(user_id);

        UserInfoDTO rDTO = userInfoService.SelectUser(pDTO);

        if (rDTO == null) {
            rDTO = new UserInfoDTO();
        }

        model.addAttribute("Myinfo", rDTO);

        return "/mypage/Myinfo";
    }


}
