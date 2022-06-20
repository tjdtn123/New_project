package kopo.poly.controller;

import kopo.poly.dto.StarDTO;
import kopo.poly.dto.UserInfoDTO;
import kopo.poly.service.IMongoService;
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
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Resource(name = "UserInfoService")
    private IUserInfoService userInfoService;

    @Resource(name = "MongoService")
    private IMongoService mongoService;

    @GetMapping(value = "/AdminPage")
    public String Admin_top() {
        return "/admin/AdminPage";

    }

    @GetMapping(value = "/Userinfo")
    private String Myinfo(ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {

        log.info(this.getClass().getName() + ".UserInfo Start!");

        String user_id = CmmUtil.nvl(request.getParameter("user_id"));

        log.info(user_id);
        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUser_id(user_id);

        UserInfoDTO rDTO = userInfoService.SelectUser(pDTO);

        if (rDTO == null) {
            rDTO = new UserInfoDTO();
        }

        model.addAttribute("Userinfo", rDTO);

        return "/admin/Userinfo";
    }
    @GetMapping(value = "/EditUserinfo")
    private String EditMyinfo(ModelMap model, HttpServletRequest request) throws Exception {

        log.info(this.getClass().getName() + ".EditMyinfo Start!");

        String user_id = CmmUtil.nvl(request.getParameter("user_id"));

        log.info("user_id : " + user_id);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUser_id(user_id);


        UserInfoDTO rDTO = userInfoService.SelectUser(pDTO);

        model.addAttribute("EditUserinfo", rDTO);

        return "/admin/EditUserinfo";
    }

    @GetMapping(value = "/UpdateUser")
    private String UpdateUser(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".UpdateUser Start!");

        String msg = "";

        try {

            String user_id = CmmUtil.nvl(request.getParameter("user_id"));
            String user_name = CmmUtil.nvl(request.getParameter("user_name"));
            String email = CmmUtil.nvl(request.getParameter("emailText")); // 공지글 여부
            String addr1 = CmmUtil.nvl(request.getParameter("addr1")); // 내용
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

            msg = "변경되었습니다";
        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".ChangePwd end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }


        return "/admin/MsgToAdminPage";
    }

    @GetMapping(value = "/DeleteUser")
    public String DeleteUser(HttpServletRequest request, ModelMap model, HttpSession session) {

        log.info(this.getClass().getName() + ".DeleteUser start!");

        String msg = "";

        try {

            String user_id = CmmUtil.nvl(request.getParameter("user_id")); // 글번호(PK)

            log.info("user_id : " + user_id);

            UserInfoDTO pDTO = new UserInfoDTO();

            pDTO.setUser_id(user_id);

            // 게시글 삭제하기 DB
            userInfoService.DeleteUser(pDTO);

            msg = "삭제되었습니다.";

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".DeleteUser end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        session.invalidate();
        return "/MsgToIndex";
    }

    @GetMapping(value = "/AdStarList")
    public String StarList(ModelMap model, HttpServletRequest request) throws Exception {

        log.info(this.getClass().getName() + ".selectAdStarList Start!");

        List<StarDTO> rList = mongoService.getAdStarList();

        model.addAttribute("rList",rList);

        log.info(this.getClass().getName() + ".selectAdStarList Start!");

        return "/admin/AdStarList";

    }


}
