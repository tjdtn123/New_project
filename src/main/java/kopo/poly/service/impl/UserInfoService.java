package kopo.poly.service.impl;

import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.UserInfoDTO;
import kopo.poly.persistance.mapper.IUserInfoMapper;
import kopo.poly.service.IUserInfoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service("UserInfoService")
public class UserInfoService implements IUserInfoService {

    private final IUserInfoMapper userinfoMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    public UserInfoService(IUserInfoMapper userinfoMapper) {
        this.userinfoMapper = userinfoMapper;
    }




    @Transactional
    @Override
    public void InsertUserInfo(UserInfoDTO uDTO) throws Exception {

        log.info(this.getClass().getName() + ".InsertUserInfo start!");

        String password = uDTO.getPassword();
        String encodePassword = passwordEncoder.encode(password);
        uDTO.setPassword(encodePassword);

        userinfoMapper.InsertUserInfo(uDTO);
        log.info(this.getClass().getName() + ".InsertUserInfo start!");
    }
    @Transactional
    @Override
    public void ChangePwd(UserInfoDTO uDTO) throws Exception {

        log.info(this.getClass().getName() + ".ChangePwd start!");

        String password = uDTO.getPassword();
        String encodePassword = passwordEncoder.encode(password);
        uDTO.setPassword(encodePassword);

        userinfoMapper.ChangePwd(uDTO);

        log.info(this.getClass().getName() + ".ChangePwd end!");
    }

    @Transactional
    @Override
    public void UpdateUser(UserInfoDTO uDTO) throws Exception {

        log.info(this.getClass().getName() + ".Updateuser start!");

        userinfoMapper.UpdateUser(uDTO);

    }

    @Transactional
    @Override
    public void DeleteUser(UserInfoDTO uDTO) throws Exception {

        log.info(this.getClass().getName() + ".Deleteuser start!");

        userinfoMapper.DeleteUser(uDTO);

    }

    @Override
    public List<UserInfoDTO> getUserList(Criteria cri) throws Exception {

        log.info(this.getClass().getName() + ".getUserList start!");
        log.info(this.getClass().getName() + ".getUserList End!");
        return userinfoMapper.getUserList(cri);

    }

    @Override
    public int userListCnt() throws Exception {
        return userinfoMapper.userListCnt();
    }
    @Override
    public int idCheck(String id) {
        int cnt = userinfoMapper.idCheck(id);
        return cnt;
    }

    @Override
    public UserInfoDTO Login(UserInfoDTO uDTO) {


        return userinfoMapper.Login(uDTO);
    }

    @Override
    public UserInfoDTO SelectUser(UserInfoDTO uDTO) throws Exception{

        log.info(this.getClass().getName() + ".SelectUser Start!");

        return userinfoMapper.SelectUser(uDTO);
    }


}

