package kopo.poly.service;

import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.MyDTO;
import kopo.poly.dto.ObsDTO;
import kopo.poly.dto.StarDTO;

import java.util.List;

public interface IMongoService {


    int collectObserver() throws Exception;

    List<ObsDTO> getObsList(String region) throws Exception;

    List<StarDTO> getStarList(String season) throws Exception;

    List<StarDTO> getAdStarList(Criteria cri) throws Exception;

    List<MyDTO> getMyStarList(String id) throws Exception;

    StarDTO getStarInfo(String star_name) throws Exception;

    MyDTO getMyStarInfo(String star_name) throws Exception;

    int updateAdStar(StarDTO pDTO) throws Exception;

    int InsertMine(MyDTO pDTO) throws Exception;

    int InsertStar(StarDTO pDTO) throws Exception;

    int deleteMyStar(MyDTO pDTO) throws Exception;

    int deleteAdStar(StarDTO pDTO) throws Exception;

    int countStar() throws Exception;

}
