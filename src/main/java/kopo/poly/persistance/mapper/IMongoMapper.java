package kopo.poly.persistance.mapper;

import kopo.poly.dto.MyDTO;
import kopo.poly.dto.ObsDTO;
import kopo.poly.dto.StarDTO;

import java.util.List;

public interface IMongoMapper {

    int insertSong(List<ObsDTO> pList, String colNm) throws Exception;

    List<ObsDTO> getObsList(String colNm, String region) throws Exception;

    List<StarDTO> getStarList(String colNm, String season) throws Exception;

    List<StarDTO> getAdStarList(String colNm) throws Exception;

    StarDTO getStarInfo (String colNm ,String star_name) throws Exception;

    int InsertMine (String colNm, MyDTO pDTO) throws Exception;
}
