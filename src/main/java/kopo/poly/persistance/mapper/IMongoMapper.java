package kopo.poly.persistance.mapper;

import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.MyDTO;
import kopo.poly.dto.ObsDTO;
import kopo.poly.dto.StarDTO;

import java.util.List;

public interface IMongoMapper {

    int countStar(String colNm) throws Exception;

    int insertSong(List<ObsDTO> pList, String colNm) throws Exception;

    List<ObsDTO> getObsList(String colNm, String region) throws Exception;

    List<StarDTO> getStarList(String colNm, String season) throws Exception;

    List<StarDTO> getAdStarList(String colNm, Criteria cri) throws Exception;

    List<MyDTO> getMyStarList(String colNm, String id) throws Exception;

    StarDTO getStarInfo (String colNm ,String star_name) throws Exception;

    MyDTO getMyStarInfo (String colNm ,String star_name) throws Exception;

    int updateAdStar(String colNm,StarDTO pDTO) throws Exception;
    int deleteMyStar(String colNm, MyDTO pDTO) throws  Exception;

    int deleteAdStar(String colNm, StarDTO pDTO) throws  Exception;

    int InsertMine (String colNm, MyDTO pDTO) throws Exception;

    int InsertStar (String colNm, StarDTO pDTO) throws Exception;
}
