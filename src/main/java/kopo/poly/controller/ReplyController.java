package kopo.poly.controller;

import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.PageMakeDTO;
import kopo.poly.dto.ReplyDTO;
import kopo.poly.service.IBoardService;
import kopo.poly.service.IReplyService;
import kopo.poly.service.impl.AwsS3Service;
import kopo.poly.service.impl.ReplyService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/comment")

public class ReplyController {
    @Resource(name = "ReplyService")
    private IReplyService replyService;

    /**
     * GetMapping은 GET방식을 통해 접속되는 URL 호출에 대해 실행되는 함수로 설정함을 의미함
     * PostMapping은 POST방식을 통해 접속되는 URL 호출에 대해 실행되는 함수로 설정함을 의미함
     * GetMapping(value = "index") =>  GET방식을 통해 접속되는 URL이 index인 경우 아래 함수를 실행함
     */


    @GetMapping(value = "/list")
    private List<ReplyDTO> ListReply (HttpServletRequest request, ModelMap model) throws Exception {
        String board_seq = CmmUtil.nvl(request.getParameter("board_seq"));
        ReplyDTO pDTO = new ReplyDTO();
        pDTO.setBoard_seq(board_seq);


        return replyService.commentList(pDTO);

    }

    @PostMapping(value = "/update")
    private int UpdateReply (HttpServletRequest request, ModelMap model) throws Exception {

        String comments_id = CmmUtil.nvl(request.getParameter("comments_id")); // 제목
        String contents = CmmUtil.nvl(request.getParameter("contents")); // 내용

        log.info("comments_id : " + comments_id);
        log.info("contents : " + contents);

        ReplyDTO pDTO = new ReplyDTO();

        pDTO.setComments_id(comments_id);
        pDTO.setContents(contents);

        return replyService.commentUpdate(pDTO);
    }

    @PostMapping(value = "/insert")
    public int InsertReply(HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".commentInsert start!");



            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */

            String user_id = CmmUtil.nvl((String) session.getAttribute("user_id"));//CmmUtil.nvl((String) session.getAttribute("user_id"));
            String board_seq = CmmUtil.nvl(request.getParameter("board_seq")); // 제목
            String contents = CmmUtil.nvl(request.getParameter("contents")); // 내용

            /*
             * ####################################################################################
             * 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함 반드시 작성할 것
             * ####################################################################################
             */
            log.info("user_id : " + user_id);
            log.info("board_seq : " + board_seq);
            log.info("contents : " + contents);

            //if(!Objects.requireNonNull(request.getFile("file")).isEmpty())
            ReplyDTO pDTO = new ReplyDTO();
            pDTO.setUser_id(user_id);
            pDTO.setBoard_seq(board_seq);
            pDTO.setContents(contents);
            /*
             * 게시글 등록하기위한 비즈니스 로직을 호출
             */

        return replyService.commentInsert(pDTO);
    }

    @PostMapping(value = "/delete/{comments_id}")
    private int DeleteReply(HttpServletRequest request) throws Exception{
        String comments_id = CmmUtil.nvl(request.getParameter("comments_id"));
        ReplyDTO pDTO = new ReplyDTO();
        pDTO.setComments_id(comments_id);

        return replyService.commentDelete(pDTO);
    }



}
