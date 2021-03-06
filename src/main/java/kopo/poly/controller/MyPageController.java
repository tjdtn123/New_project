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
import javax.servlet.http.HttpServletRequest;
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
    @GetMapping(value = "/EditMyinfo")
    private String EditMyinfo(ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".EditMyinfo Start!");

        String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));

        log.info("user_id : " + user_id);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUser_id(user_id);


        UserInfoDTO rDTO = userInfoService.SelectUser(pDTO);

        model.addAttribute("EditMyinfo", rDTO);

        return "/mypage/EditMyinfo";
    }

    @GetMapping(value = "/UpdateUser")
    private String UpdateUser(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".UpdateUser Start!");

        String msg = "";

        try {

            String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));
            String user_name = CmmUtil.nvl(request.getParameter("user_name"));
            String email = CmmUtil.nvl(request.getParameter("emailText")); // ????????? ??????
            String addr1 = CmmUtil.nvl(request.getParameter("addr1")); // ??????
            String addr2 = CmmUtil.nvl(request.getParameter("sample6_detailAddress"));

            log.info("user_id : " + user_id);
            log.info("user_name : " + user_name);
            log.info("email : " + email);
            log.info("addr1 : " + addr1);
            log.info("addr2 : " + addr2);

            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setUser_id(user_id);
            pDTO.setUser_name(user_name);
            pDTO.setEmail(email);
            pDTO.setAddr1(addr1);
            pDTO.setAddr2(addr2);


            userInfoService.UpdateUser(pDTO);

            msg = "?????????????????????";
        } catch (Exception e) {

            // ????????? ???????????? ??????????????? ????????? ?????????
            msg = "?????????????????????. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".ChangePwd end!");

            // ?????? ????????? ????????????
            model.addAttribute("msg", msg);

        }


        return "/mypage/MsgToMyPage";
    }

    @GetMapping(value = "/DeleteUser")
    public String DeleteUser(HttpServletRequest request, ModelMap model, HttpSession session) {

        log.info(this.getClass().getName() + ".DeleteUser start!");

        String msg = "";

        try {

            String user_id = CmmUtil.nvl((String) session.getAttribute("user_id")); // ?????????(PK)

            log.info("user_id : " + user_id);

            UserInfoDTO pDTO = new UserInfoDTO();

            pDTO.setUser_id(user_id);

            // ????????? ???????????? DB
            userInfoService.DeleteUser(pDTO);

            msg = "?????????????????????.";

        } catch (Exception e) {
            msg = "?????????????????????. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".DeleteUser end!");

            // ?????? ????????? ????????????
            model.addAttribute("msg", msg);

        }

        session.invalidate();
        return "/MsgToIndex";
    }

}
