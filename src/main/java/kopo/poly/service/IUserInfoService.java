package kopo.poly.service;

import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.UserInfoDTO;

import java.util.List;

public interface IUserInfoService {

    void InsertUserInfo(UserInfoDTO uDTO) throws Exception;

    void ChangePwd(UserInfoDTO uDTO) throws Exception;

    int idCheck(String id);

    int userListCnt() throws Exception;

    List<UserInfoDTO> getUserList(Criteria cri) throws Exception;

    UserInfoDTO Login(UserInfoDTO uDTO )throws Exception;

    UserInfoDTO SelectUser(UserInfoDTO uDTO) throws Exception;

    void UpdateUser(UserInfoDTO uDTO) throws Exception;

    void DeleteUser(UserInfoDTO uDTO) throws Exception;

}
