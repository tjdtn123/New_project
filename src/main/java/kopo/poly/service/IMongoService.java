package kopo.poly.service;

import kopo.poly.dto.MyDTO;
import kopo.poly.dto.ObsDTO;
import kopo.poly.dto.StarDTO;

import java.util.List;

public interface IMongoService {

    int collectObserver() throws Exception;

    List<ObsDTO> getObsList(String region) throws Exception;

    List<StarDTO> getStarList(String season) throws Exception;

    StarDTO getStarInfo(String star_name) throws Exception;

    int InsertMine(MyDTO pDTO) throws Exception;



}
