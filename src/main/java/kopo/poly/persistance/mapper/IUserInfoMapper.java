package kopo.poly.persistance.mapper;

import kopo.poly.dto.UserInfoDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IUserInfoMapper {

	//회원 가입
	void InsertUserInfo(UserInfoDTO uDTO) throws Exception;

	//비밀번호 변경
	void ChangePwd(UserInfoDTO uDTO) throws Exception;

	//회원 조회
	public UserInfoDTO SelectUser(UserInfoDTO uDTO) throws Exception;

	//id 유효성
	public int idCheck(String id);

	//로그인
	public UserInfoDTO Login(UserInfoDTO uDTO);
}
