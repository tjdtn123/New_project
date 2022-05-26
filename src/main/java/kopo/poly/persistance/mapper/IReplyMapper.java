package kopo.poly.persistance.mapper;

import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.ReplyDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IReplyMapper {

    //댓글 개수
    int commentCount() throws Exception;
    //댓글 목록
    List<ReplyDTO> commentList(ReplyDTO pDTO) throws Exception;

    //게시판 글 등록
    int commentInsert(ReplyDTO pDTO) throws Exception;

    //댓글 수정
    int commentUpdate(ReplyDTO pDTO) throws Exception;

    //댓글 삭제
    int commentDelete(ReplyDTO pDTO) throws Exception;


}
