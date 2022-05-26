package kopo.poly.service.impl;

import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.BoardDTO;
import kopo.poly.dto.ReplyDTO;
import kopo.poly.persistance.mapper.IBoardMapper;
import kopo.poly.persistance.mapper.IReplyMapper;
import kopo.poly.service.IBoardService;
import kopo.poly.service.IReplyService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service("ReplyService")
public class ReplyService implements IReplyService {

    private final IReplyMapper replyMapper;

    @Autowired
    public ReplyService(IReplyMapper replyMapper) {
        this.replyMapper = replyMapper;
    }

    @Override
    public List<ReplyDTO> commentList(ReplyDTO pDTO) throws Exception {

        return replyMapper.commentList(pDTO);
    }

    @Transactional
    @Override
    public int commentInsert(ReplyDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".InsertBoardInfo start!");
        log.info(this.getClass().getName() + ".InsertBoardInfo end!");

        return replyMapper.commentInsert(pDTO);
    }

    @Override
    @Transactional
    public int commentUpdate(ReplyDTO pDTO) throws Exception {
        return replyMapper.commentUpdate(pDTO);
    }

    @Override
    @Transactional
    public int commentDelete(ReplyDTO pDTO) throws Exception {

        return replyMapper.commentDelete(pDTO);
    }


}
