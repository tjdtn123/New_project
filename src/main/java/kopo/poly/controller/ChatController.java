package kopo.poly.controller;


import kopo.poly.Handler.ChatHandler;
import kopo.poly.dto.ChatDTO;
import kopo.poly.service.IChatService;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

@Slf4j
@Controller
@RequestMapping(value = "/chat")
public class ChatController {

    @Resource(name = "ChatService")
    private IChatService chatService;


/*
    private static Set<Session> clients = Collections.synchronizedSet(new LinkedHashSet<>());

    private static Map<String,String> roomInfo = Collections.synchronizedMap(new LinkedHashMap<>());
*/

    @RequestMapping(value = "intro")
    public String intro() throws Exception{
        return "/chat/intro";
    }

    @RequestMapping(value = "room")
    public String room() throws Exception{
        return "/chat/chatroom";
    }

    @RequestMapping(value = "roomList")
    @ResponseBody
    public Set<String> roomList() throws Exception{
        log.info(this.getClass().getName() + ".roomList Start!");

        log.info(this.getClass().getName() + ".roomList Ends!");

        return ChatHandler.roomInfo.keySet();
    }

    @PostMapping(value = "insertChat")
    @ResponseBody
    public List<ChatDTO> msg (HttpServletRequest request, HttpSession session)
            throws Exception{

        log.info(this.getClass().getName() + ".msg Start!");

        String room_name = CmmUtil.nvl(request.getParameter("roomName"));
        String userNm = CmmUtil.nvl(request.getParameter("name"));
        String msg = CmmUtil.nvl(request.getParameter("msg"));

        log.info("userNm : " + userNm);
        log.info("room_name : " + room_name);
        log.info("msg : " + msg);

        List<ChatDTO> rList = null;

        if (msg.length() > 0) {
            ChatDTO pDTO = new ChatDTO();

            pDTO.setRoomName("Chat_" + room_name);
            pDTO.setName(userNm);
            pDTO.setMsg(msg);
            pDTO.setDate(DateUtil.getDateTime("yyyy.MM.dd hh:mm:ss"));

            rList = chatService.insertChat(pDTO);

            if (rList == null){
                rList = new LinkedList<>();
            }

            pDTO = null;

        }

        log.info(this.getClass().getName() + ".msg End!");

        return rList;
    }

    @PostMapping(value = "getMsg")
    @ResponseBody
    public  List<ChatDTO> getMsg(HttpServletRequest request)
            throws Exception {

        log.info(this.getClass().getName() + ".getMsg Start!");

        String room_name = CmmUtil.nvl(request.getParameter("roomName"));

        log.info("room_name : " + room_name);

        ChatDTO pDTO = new ChatDTO();

        pDTO.setRoomName("Chat_" + room_name);

        List<ChatDTO> rList = chatService.getChat(pDTO);

        if (rList == null ) {
            rList = new LinkedList<>();

        }

        log.info(String.valueOf(rList));

        pDTO = null;

        log.info(this.getClass().getName() + ".getMsg End!");

        return rList;
    }

    /*@OnOpen
    public void onOpen(Session session, @PathParam("roomName") String roomName,
                        @PathParam("userName") String userName) throws  Exception {
        log.info(this.getClass().getName() + ".onOpen Start!");

        log.info("session : " + session);
        log.info("session id:" + session.getId());
        log.info("roomName : " + roomName);
        log.info("userName : " + userName);

        String roomNameHash = EncryptUtil.encHashSHA256(roomName);

        session.getUserProperties().putIfAbsent("roomName", roomNameHash);
        session.getUserProperties().putIfAbsent("userName", userName);

        log.info("session roomName : " + session.getUserProperties().get("roomName"));

        clients.stream().forEach(s -> {
            log.info("s.room : " + s.getUserProperties().get("roomName"));
            log.info("s.userName : " + s.getUserProperties().get("userName"));

            if (roomNameHash.equals(s.getUserProperties().get("roomName"))) {

                try {


                    ChatDTO cDTO = new ChatDTO();
                    cDTO.setName("관리자");
                    cDTO.setMsg(userName + " 님이 " + roomName + " 채팅방에 입장하셨습니다.");
                    cDTO.setDate(DateUtil.getDateTime("yyyyMMdd hh:mm:ss"));

                    String json = new ObjectMapper().writeValueAsString(cDTO);
                    log.info("json : " + json);

                    s.getBasicRemote().sendText(json);

                    cDTO = null;


                } catch (IOException e) {
                    log.info("Error : " + e);
                }

            }

        });

        if (!clients.contains(session)) {

            clients.add(session);

            roomInfo.put(roomName, roomNameHash);

            log.info("session open : " +session);

        }

        log.info(this.getClass().getName() + ".onOpen End!");

    }

    @OnMessage
    public void onMessage(Session session, String msg, @PathParam("roomName") String roomName,
                          @PathParam("userName") String userName) throws Exception{

        log.info(this.getClass().getName() + ".onMessage Start!");

        log.info("receive message : " + msg);
        log.info("receive session : " + session);
        log.info("receive roomName : " + roomName);
        log.info("receive userName : " + userName);

        String roomNameHash = roomInfo.get(roomName);

        log.info("roomNameHash : " + roomNameHash);

        clients.stream().forEach(s -> {

            if (roomNameHash.equals(s.getUserProperties().get("roomName"))) {
                try {

                    ChatDTO cDTO = new ObjectMapper().readValue(msg, ChatDTO.class);

                    cDTO.setDate(DateUtil.getDateTime("yyyy-MM-dd hh:mm:ss"));

                    s.getBasicRemote().sendText(new ObjectMapper().writeValueAsString(cDTO));


                } catch (IOException e) {
                    log.info("Error : " + e);

                }

            }
        });

        log.info(this.getClass().getName() + ".onMessage End");

    }

    @OnError
    public void onError(Throwable e) throws Exception{
        log.info(this.getClass().getName() + ".onError Start!");

        log.info(this.getClass().getName() + ".onError : " + e);

        log.info(this.getClass().getName() + ".onError End!");
    }

    @OnClose
    public void onClose(Session session, @PathParam("roomName") String roomName,
                        @PathParam("userName") String userName) {

        log.info(this.getClass().getName() + ".onClose Start!");
        log.info("receive roomName : " + roomName);
        log.info("receive userName : " + userName);

        String roomNameHash = roomInfo.get(roomName);
        log.info("roomNameHash : " + roomNameHash);

        clients.remove(session);

        clients.stream().forEach(s -> {

            log.info("s.room : " + s.getUserProperties().get("roomName"));
            log.info("s.userName : " +s.getUserProperties().get("userName"));

            if (roomNameHash.equals(s.getUserProperties().get("roomname"))) {

                try {

                    ChatDTO cDTO = new ChatDTO();
                    cDTO.setName("관리자");
                    cDTO.setMsg(userName + " 님이 " + roomName + "채팅방에 퇴장하셨습니다.");
                    cDTO.setDate(DateUtil.getDateTime("yyyyMMdd"));

                    String json = new ObjectMapper().writeValueAsString(cDTO);
                    log.info("json : " + json);

                    s.getBasicRemote().sendText(json);

                    cDTO = null;


                } catch (IOException e) {
                    log.info("Error : " + e);
                }

            }
        });
        log.info(this.getClass().getName() + ".onClose End!");

    }
*/


    
}
