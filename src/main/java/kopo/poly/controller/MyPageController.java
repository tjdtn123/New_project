package kopo.poly.controller;

import kopo.poly.dto.MyDTO;
import kopo.poly.dto.UserInfoDTO;
import kopo.poly.service.IMongoService;
import kopo.poly.service.IUserInfoService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Resource(name = "UserInfoService")
    private IUserInfoService userInfoService;

    @Resource(name ="MongoService")
    private IMongoService mongoService;


    @GetMapping(value = "/MyPage")
    private String MyPage() {
        return "/mypage/Mypage";
    }

    @GetMapping(value = "/EditMyinfo")
    private String EditMyinfo(ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".EditMyinfo Start!");

        String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));

        log.info(user_id);
        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUser_id(user_id);

        UserInfoDTO rDTO = userInfoService.SelectUser(pDTO);

        if (rDTO == null) {
            rDTO = new UserInfoDTO();
        }

        model.addAttribute("EditMyinfo", rDTO);

        return "/mypage/EditMyinfo";
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



    @PostMapping(value = "/UpdateUser")
    private String UpdateUser(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".UpdateUser Start!");

        String msg = "";

        try {

            String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));
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


        return "/mypage/MsgToMyPage";
    }

    @PostMapping(value = "/DeleteUser")
    public String DeleteUser(HttpServletRequest request, ModelMap model, HttpSession session) {

        log.info(this.getClass().getName() + ".DeleteUser start!");

        String msg = "";

        try {

            String user_id = CmmUtil.nvl((String) session.getAttribute("user_id")); // 글번호(PK)

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



    @GetMapping(value = "/listMystars")
    public String listMyStars(HttpSession session, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".listMyStars Start!");

        String id = CmmUtil.nvl((String) session.getAttribute("user_id"));

        List<MyDTO> rList = mongoService.getMyStarList(id);

        model.addAttribute("rList",rList);


        log.info(this.getClass().getName() + ".listMyStars Start!");

        return "/mypage/MyStarList";
    }

    @GetMapping(value = "/MyStarInfo")
    public String MyStarInfo(HttpServletRequest request, ModelMap model) throws Exception{
        log.info(this.getClass().getName() + ".MyStarInfo Start!");

        String star_name = CmmUtil.nvl(request.getParameter("star_name"));


        MyDTO rDTO = mongoService.getMyStarInfo(star_name);

        model.addAttribute("rDTO",rDTO);


        log.info(this.getClass().getName() + ".MyStarInfo End!");

        return "/mypage/MyStarInfo";
    }
    @ResponseBody
    @GetMapping(value = "/deleteStar")
    public String deleteMyStar(HttpServletRequest request, HttpSession session, ModelMap model) throws  Exception {

        log.info(this.getClass().getName() + ".deleteMyStar Start!");

        String msg;
        String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));
        String star_name = CmmUtil.nvl(request.getParameter("star_name"));

        MyDTO pDTO = new MyDTO();

        pDTO.setUser_id(user_id);
        pDTO.setStar_name(star_name);

        int res = mongoService.deleteMyStar(pDTO);

        if (res == 1) {
            msg = "삭제되었습니다.";
            model.addAttribute("msg", msg);
            log.info(this.getClass().getName() + ".deleteMyStar End!");
            return msg;
        } else {
            msg = "fail";
            log.info(this.getClass().getName() + ".deleteMyStar End!");
            return msg;

        }




    }


}
