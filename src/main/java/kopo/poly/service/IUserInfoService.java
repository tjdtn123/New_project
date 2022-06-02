package kopo.poly.service;

import kopo.poly.dto.UserInfoDTO;

public interface IUserInfoService {

    void InsertUserInfo(UserInfoDTO uDTO) throws Exception;

    void ChangePwd(UserInfoDTO uDTO) throws Exception;

    int idCheck(String id);

    UserInfoDTO Login(UserInfoDTO uDTO )throws Exception;

    UserInfoDTO SelectUser(UserInfoDTO uDTO) throws Exception;



}
