package kopo.poly.controller;


import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.PageMakeDTO;
import kopo.poly.dto.UserInfoDTO;
import kopo.poly.service.IUserInfoService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 *
 * slf4j는 스프링 프레임워크에서 로그 처리하는 인터페이스 기술이며,
 * 로그처리 기술인 log4j와 logback과 인터페이스 역할 수행함
 * 스프링 프레임워크는 기본으로 logback을 채택해서 로그 처리함
 * */
@Slf4j
@Controller
public class UserInfoController {

    @Resource(name = "UserInfoService")
    private IUserInfoService userInfoService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping(value = "LoginPage")
    public String LoginPage() {
        return "/LoginPage";

    }

    @GetMapping(value = "register")
    public String Register() {
        return "/register";

    }
    @GetMapping("/Logout")
     public String Logout(HttpSession session, ModelMap model){
        String msg = "로그아웃 되었습니다";
        session.invalidate();
        model.addAttribute("msg", msg);
    return "/LogoutPage";
    }
    @GetMapping(value = "FindPwd")
    public String FindPwd() {
        return "/FindPwd";

    }
    @GetMapping(value = "PwdChange")
    public String PwdChange() {
        return "/PwdChange";

    }


    @PostMapping("/Login")
    public String Login(HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".Login start!");
        String msg = "";


        String user_id = CmmUtil.nvl(request.getParameter("user_id"));
        String password = CmmUtil.nvl(request.getParameter("password"));


        log.info("user_id : " + user_id);
        log.info("password : " + password);


        UserInfoDTO pDTO = new UserInfoDTO();

        pDTO.setUser_id(user_id);
        pDTO.setPassword(password);

        UserInfoDTO uDTO = userInfoService.Login(pDTO);


        msg = "로그인 성공";
        if (!passwordEncoder.matches(password, uDTO.getPassword())) {

            msg = "아이디 또는 비밀번호를 확인해주세요.";
            model.addAttribute("msg", msg);

            return "/MsgToLogin";

        }
        else if(Objects.equals(CmmUtil.nvl(uDTO.getUser_id()), "admin")) {

                session.setAttribute("user_id", uDTO.getUser_id());
                log.info(this.getClass().getName() + ".Login end!");

                log.info(uDTO.toString());
                // 결과 메시지 전달하기

                return "/admin/AdminPage";
        }

        else
        session.setAttribute("user_id", uDTO.getUser_id());
        log.info(this.getClass().getName() + ".Login end!");

        log.info(uDTO.toString());
        // 결과 메시지 전달하기
        model.addAttribute("msg", msg);
        return "/MsgToLogin";


    }
    @PostMapping(value = "/Userinfoinsert")
    public String userinfoInsert(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".UserInfoInsert start!");

        String msg = "";

        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */
            String user_id = CmmUtil.nvl(request.getParameter("user_id"));
            String password = CmmUtil.nvl(request.getParameter("password")); // 제목
            String user_name = CmmUtil.nvl(request.getParameter("user_name"));
            String email = CmmUtil.nvl(request.getParameter("emailText")); // 공지글 여부
            String addr1 = CmmUtil.nvl(request.getParameter("addr1")); // 내용
            String addr2 = CmmUtil.nvl(request.getParameter("sample6_detailAddress"));

            /*
             * ####################################################################################
             * 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함 반드시 작성할 것
             * ####################################################################################
             */
            log.info("user_id : " + user_id);
            log.info("password : " + password);
            log.info("user_name : " + user_name);
            log.info("email : " + email);
            log.info("addr1 : " + addr1);
            log.info("addr2 : " + addr2);



            UserInfoDTO uDTO = new UserInfoDTO();

            uDTO.setUser_id(user_id);
            uDTO.setPassword(password);
            uDTO.setUser_name(user_name);
            uDTO.setEmail(email);
            uDTO.setAddr1(addr1);
            uDTO.setAddr2(addr2);

            /*
             * 게시글 등록하기위한 비즈니스 로직을 호출
             */
            userInfoService.InsertUserInfo(uDTO);

            // 저장이 완료되면 사용자에게 보여줄 메시지
            msg = "등록되었습니다.";


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".userinfoinsert end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        return "/MsgToLogin";
    }
    @PostMapping(value = "/ChangePwd")
    public String ChangePwd(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".ChangePwd start!");

        String msg = "";

        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */
            String user_id = CmmUtil.nvl((String) session.getAttribute("user_id")); // 아이디
            String password = CmmUtil.nvl(request.getParameter("password")); // 제목


            /*
             * ####################################################################################
             * 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함 반드시 작성할 것
             * ####################################################################################
             */
            log.info("user_id : " + user_id);
            log.info("password : " + password);

            UserInfoDTO uDTO = new UserInfoDTO();

            uDTO.setUser_id(user_id);
            uDTO.setPassword(password);

            /*
             * 게시글 등록하기위한 비즈니스 로직을 호출
             */
            userInfoService.ChangePwd(uDTO);

            // 저장이 완료되면 사용자에게 보여줄 메시지
            msg = "변경되었습니다.";


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

        return "/MsgToLogin";
    }
    @GetMapping(value = "/admin/UserList")
    public String UserList(ModelMap model, Criteria cri)
            throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".UserList start!");
        // 공지사항 리스트 가져오기
        List<UserInfoDTO> rList = userInfoService.getUserList(cri);

        if (rList == null) {
            rList = new ArrayList<>();

        }

        //전체 글 개수
        int total = userInfoService.userListCnt();

        //페이징 객체
        PageMakeDTO pageMake = new PageMakeDTO(cri, total);


        // 조회된 리스트 결과값 넣어주기
        model.addAttribute("rList", rList);
        model.addAttribute("pageMaker",pageMake);

        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".UserList end!");

        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/admin/UserList";

    }


    @PostMapping("/register/idCheck")
    @ResponseBody
    public int idCheck(@RequestParam("user_id") String id){
        log.info("userIdCheck 진입");
        log.info("전달받은 id:"+id);
        int cnt = userInfoService.idCheck(id);
        log.info("확인 결과:"+cnt);
        return cnt;
    }


}
