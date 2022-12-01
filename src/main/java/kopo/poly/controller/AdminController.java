package kopo.poly.controller;

import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.PageMakeDTO;
import kopo.poly.dto.StarDTO;
import kopo.poly.dto.UserInfoDTO;
import kopo.poly.service.IMongoService;
import kopo.poly.service.IUserInfoService;
import kopo.poly.service.impl.AwsS3Service;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Resource(name = "UserInfoService")
    private IUserInfoService userInfoService;

    @Resource(name = "MongoService")
    private IMongoService mongoService;

    @Autowired
    private AwsS3Service s3Service;

    @GetMapping(value = "/AdminPage")
    public String Admin_top() {
        return "/admin/AdminPage";

    }

    @GetMapping(value = "/StarReg")
    public String InsertStar() {
        return "/admin/StarReg";

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

    @GetMapping(value = "/AdStarInfo")
    public String AdStarInfo(HttpServletRequest request, ModelMap model) throws Exception{
        log.info(this.getClass().getName() + ".AdStarInfo Start!");

        String star_name = CmmUtil.nvl(request.getParameter("star_name"));

        StarDTO rDTO = mongoService.getStarInfo(star_name);

        model.addAttribute("rDTO",rDTO);


        log.info(this.getClass().getName() + ".AdStarInfo End!");

        return "/admin/AdStarInfo";
    }

    @PostMapping(value = "/UpdateUser")
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
    public String StarList(ModelMap model, HttpServletRequest request, Criteria cri) throws Exception {

        log.info(this.getClass().getName() + ".selectAdStarList Start!");

        List<StarDTO> rList = mongoService.getAdStarList(cri);
        if (rList == null) {
            rList = new ArrayList<>();

        }

        int total = mongoService.countStar();

        PageMakeDTO pageMake = new PageMakeDTO(cri, total);


        model.addAttribute("rList",rList);
        model.addAttribute("pageMaker",pageMake);


        log.info(this.getClass().getName() + ".selectAdStarList End!");

        return "/admin/AdStarList";

    }
    @PostMapping(value = "/insertAdStar")
    public String insertStar(MultipartHttpServletRequest request, HttpSession session, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".insertStar Start!");
        String msg = "";
        int res;
        try {
            String star_name = CmmUtil.nvl(request.getParameter("star_name"));
            String position = CmmUtil.nvl(request.getParameter("position"));
            String season = CmmUtil.nvl(request.getParameter("season"));
            String star_count = CmmUtil.nvl(request.getParameter("star_cnt"));
            String size = CmmUtil.nvl(request.getParameter("size"));

            if(!Objects.requireNonNull(request.getFile("picture")).isEmpty()) {
                MultipartFile file = request.getFile("picture");
                String imgPath = s3Service.uploadImage(file);
                String imglink = "https://d3aimtz26nv519.cloudfront.net/" + imgPath;


                StarDTO pDTO = new StarDTO();

                pDTO.setStar_name(star_name);
                pDTO.setPosition(position);
                pDTO.setSeason(season);
                pDTO.setStar_cnt(star_count);
                pDTO.setPicture(imglink);
                pDTO.setSize(size);

                 res = mongoService.InsertStar(pDTO);
               if (res == 1){
                   msg = "등록되었습니다";
                   model.addAttribute("msg", msg);

                   log.info(this.getClass().getName() + ".InsertStar End!");
                   return "/admin/MsgToAdList";
               }else {
                   msg = "이미 있는 별자리입니다";
                   model.addAttribute("msg", msg);

                   log.info(this.getClass().getName() + ".InsertStar End!");
                   return "/admin/MsgToAdList";

               }

            }else {

                StarDTO pDTO = new StarDTO();

                pDTO.setStar_name(star_name);
                pDTO.setPosition(position);
                pDTO.setSeason(season);
                pDTO.setStar_cnt(star_count);
                pDTO.setSize(size);
                res =mongoService.InsertStar(pDTO);
                if (res == 1){
                    msg = "등록되었습니다.";
                    model.addAttribute("msg", msg);
                    log.info(this.getClass().getName() + ".InsertStar End!");

                    return "/admin/MsgToAdList";
                } else {
                    msg = "이미 있는 별자리입니다.";
                    model.addAttribute("msg", msg);
                    log.info(this.getClass().getName() + ".InsertStar End!");

                    return "/admin/MsgToAdList";
                }

            }
        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();
        }finally {

            log.info(this.getClass().getName() + ".InsertStar End!");
            model.addAttribute("msg", msg);

        }
            return "/admin/MsgToAdList";
    }

    @PostMapping(value = "/AdUpdate")
    public String updateAdStar(MultipartHttpServletRequest request, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".updateAdStar Start!");

        String msg = "";
        try {
            String ori_name = CmmUtil.nvl(request.getParameter("ori_name"));
            StarDTO oDTO = new StarDTO();
            oDTO.setStar_name(ori_name);
            mongoService.deleteAdStar(oDTO);




            String star_name = CmmUtil.nvl(request.getParameter("star_name"));
            String position = CmmUtil.nvl(request.getParameter("position"));
            String season = CmmUtil.nvl(request.getParameter("season"));
            String star_count = CmmUtil.nvl(request.getParameter("star_cnt"));
            String size = CmmUtil.nvl(request.getParameter("size"));

            if(!Objects.requireNonNull(request.getFile("picture")).isEmpty()) {
                MultipartFile file = request.getFile("picture");
                String imgPath = s3Service.uploadImage(file);
                String imglink = "https://d3aimtz26nv519.cloudfront.net/" + imgPath;


                StarDTO pDTO = new StarDTO();

                pDTO.setStar_name(star_name);
                pDTO.setPosition(position);
                pDTO.setSeason(season);
                pDTO.setStar_cnt(star_count);
                pDTO.setPicture(imglink);
                pDTO.setSize(size);

                mongoService.InsertStar(pDTO);
                msg = "수정되었습니다";
                model.addAttribute("msg", msg);
                log.info(this.getClass().getName() + ".updateAdStar End!");

                return "/admin/MsgToAdList";
            }else {

                StarDTO pDTO = new StarDTO();

                pDTO.setStar_name(star_name);
                pDTO.setPosition(position);
                pDTO.setSeason(season);
                pDTO.setStar_cnt(star_count);
                pDTO.setSize(size);
                mongoService.InsertStar(pDTO);
                msg = "수정되었습니다.";
                model.addAttribute("msg", msg);
                log.info(this.getClass().getName() + ".updateAdStar End!");

                return "/admin/MsgToAdList";
            }
        }catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();
        }finally {

            log.info(this.getClass().getName() + ".InsertStar End!");
            model.addAttribute("msg", msg);

        }
        return "/admin/MsgToAdList";
    }



    @GetMapping(value = "/AdStarEdit")
    public String EditStar(HttpServletRequest request, ModelMap model) throws Exception{
        log.info(this.getClass().getName() + ".EditStar Start!");

        String star_name = CmmUtil.nvl(request.getParameter("star_name"));
        log.info(star_name);

        StarDTO rDTO = mongoService.getStarInfo(star_name);

        rDTO.getStar_name();

        model.addAttribute("rDTO",rDTO);


        log.info(this.getClass().getName() + ".EditStar End!");

        return "/admin/AdStarEdit";
    }






    @ResponseBody
    @GetMapping(value = "/deleteStar")
    public String deleteAdStar(HttpServletRequest request, ModelMap model) throws  Exception {

        log.info(this.getClass().getName() + ".deleteAdStar Start!");

        String msg;
        String star_name = CmmUtil.nvl(request.getParameter("star_name"));
        log.info(star_name);

        StarDTO pDTO = new StarDTO();
        pDTO.setStar_name(star_name);

        int res = mongoService.deleteAdStar(pDTO);

        if (res == 1) {
            msg = "삭제되었습니다.";
            model.addAttribute("msg", msg);
            log.info(this.getClass().getName() + ".deleteAdStar End!");
            return msg;
        } else {
            msg = "fail";
            log.info(this.getClass().getName() + ".deleteAdStar End!");
            return msg;

        }




    }

}
