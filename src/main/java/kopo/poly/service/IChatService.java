package kopo.poly.service;

import kopo.poly.dto.ChatDTO;

import java.util.List;
import java.util.Set;

public interface IChatService {

    Set<String> getRoomList() throws Exception;

    List<ChatDTO> insertChat(ChatDTO pDTO)throws Exception;

    List<ChatDTO> getChat(ChatDTO pDTO) throws Exception;



}
