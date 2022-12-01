package kopo.poly.service.impl;

import kopo.poly.dto.ChatDTO;
import kopo.poly.persistance.mapper.IChatMapper;
import kopo.poly.service.IChatService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

@Slf4j
@Service("ChatService")

public class ChatService implements IChatService {

    @Resource(name = "ChatMapper")
    private IChatMapper chatMapper;

    @Override
    public Set<String> getRoomList() throws Exception {

        log.info(this.getClass().getName() + ".getRoomList");
        return chatMapper.getRoomList();
    }

    @Override
    public List<ChatDTO> insertChat(ChatDTO pDTO) throws Exception{

        log.info(this.getClass().getName() + ".getRoomList Start!");

        if (chatMapper.insertChat(pDTO) == 1) {
            log.info("chatMapper.insertChat Success!");

            chatMapper.setTimeOutHour(CmmUtil.nvl(pDTO.getRoomName()), 240);

        } else {

            log.info("chatMapper.insertChat Fail!");
        }

        return getChat(pDTO);
    }

    @Override
    public List<ChatDTO> getChat(ChatDTO pDTO) throws Exception{

        log.info(this.getClass().getName()+ ".getChatStart!");

        return chatMapper.getChat(pDTO);
    }
}
