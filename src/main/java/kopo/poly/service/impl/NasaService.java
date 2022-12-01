package kopo.poly.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import kopo.poly.dto.NasaDTO;
import kopo.poly.service.INasaService;
import kopo.poly.util.NetworkUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;

@Slf4j
@Service("NasaService")
public class NasaService implements INasaService {

    @Value("${nasa.api.key}")
    private String apiKey;

    @Override
    public NasaDTO getNasa() throws Exception{

        log.info(this.getClass().getName() + ".getNasa Start!");

        String apiParam = "?api_key=" + apiKey;
        log.info("apiParam " + apiParam);

        String json = NetworkUtil.get(INasaService.apiURL + apiParam);
        log.info("json" + json);

        Map<String, Object> rMap = new ObjectMapper().readValue(json, LinkedHashMap.class);

        String title =  rMap.get("title").toString();
        String explanation = rMap.get("explanation").toString();
        String picture = rMap.get("url").toString();

        log.info("title : " + title);
        log.info("explanation : " + explanation);
        log.info("Picture : " + picture);

        NasaDTO rDTO = new NasaDTO();

        rDTO.setTitle(title);
        rDTO.setExplanation(explanation);
        rDTO.setPicture(picture);

        log.info(this.getClass().getName() + ".getNasa End!");

        return rDTO;

    }

}
