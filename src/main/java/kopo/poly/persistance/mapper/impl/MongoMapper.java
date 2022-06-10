package kopo.poly.persistance.mapper.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import kopo.poly.dto.MyDTO;
import kopo.poly.dto.ObsDTO;
import kopo.poly.dto.StarDTO;
import kopo.poly.persistance.mapper.AbstractMongoDBComon;
import kopo.poly.persistance.mapper.IMongoMapper;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Slf4j
@Component("MongoMapper")
public class MongoMapper extends AbstractMongoDBComon implements IMongoMapper {


    @Override
    public int insertSong(List<ObsDTO> pList, String colNm) throws Exception {

        log.info(this.getClass().getName() + ".insertObs Start!");

        int res = 0;

        if (pList == null) {
            pList = new LinkedList<>();
        }

        // 데이터를 저장할 컬렉션 생성
        super.createCollection(colNm, "collectTime");

        // 저장할 컬렉션 객체 생성
        MongoCollection<Document> col = mongodb.getCollection(colNm);

        for (ObsDTO pDTO : pList) {
            if (pDTO == null) {
                pDTO = new ObsDTO();

            }

            // 레코드 한개씩 저장하기
            col.insertOne(new Document(new ObjectMapper().convertValue(pDTO, Map.class)));

        }

        res = 1;

        log.info(this.getClass().getName() + ".insertObs End!");

        return res;
    }

    @Override
    public List<ObsDTO> getObsList(String colNm, String region) throws Exception {

        log.info(this.getClass().getName() + ".getSongList Start!");

        // 조회 결과를 전달하기 위한 객체 생성하기
        List<ObsDTO> rList = new LinkedList<>();

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        Document query = new Document();
        query.append("region",region);

        // 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
        Document projection = new Document();
        projection.append("region", "$region");
        projection.append("obs_name", "$obs_name");
        projection.append("pageurl", "$pageurl");
        projection.append("phone", "$phone");
        projection.append("type", "$type");

        // MongoDB는 무조건 ObjectId가 자동생성되며, ObjectID는 사용하지 않을때, 조회할 필요가 없음
        // ObjectId를 가지고 오지 않을 때 사용함
        projection.append("_id", 0);

        // MongoDB의 find 명령어를 통해 조회할 경우 사용함
        // 조회하는 데이터의 양이 적은 경우, find를 사용하고, 데이터양이 많은 경우 무조건 Aggregate 사용한다.
        FindIterable<Document> rs = col.find(query).projection(projection);

        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }

            // 조회 잘되나 출력해 봄
            String regioni = CmmUtil.nvl(doc.getString("region"));
            String obs_name = CmmUtil.nvl(doc.getString("obs_name"));
            String pageurl = CmmUtil.nvl(doc.getString("pageurl"));
            String phone = CmmUtil.nvl(doc.getString("phone"));
            String type = CmmUtil.nvl(doc.getString("type"));

            log.info("region : " + regioni);
            log.info("obs_name : " + obs_name);
            log.info("pageurl : " + pageurl);
            log.info("phone : " + phone);
            log.info("type : " + type);

            ObsDTO rDTO = new ObsDTO();

            rDTO.setRegion(regioni);
            rDTO.setObs_name(obs_name);
            rDTO.setPageurl(pageurl);
            rDTO.setPhone(phone);
            rDTO.setType(type);

            // 레코드 결과를 List에 저장하기
            rList.add(rDTO);

        }
        log.info(this.getClass().getName() + ".getSongList End!");

        return rList;
    }

    @Override
    public List<StarDTO> getStarList(String colNm, String season) throws Exception {

        log.info(this.getClass().getName() + ".getStarList Start!");

        // 조회 결과를 전달하기 위한 객체 생성하기
        List<StarDTO> rList = new LinkedList<>();

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        Document query = new Document();
        query.append("season",season);

        // 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
        Document projection = new Document();
        projection.append("star_name", "$star_name");
        projection.append("sc_name", "$sc_name");
        projection.append("position", "$position");
        projection.append("season", "$season");
        projection.append("star_cnt", "$star_cnt");
        projection.append("picture", "$picture");

        // MongoDB는 무조건 ObjectId가 자동생성되며, ObjectID는 사용하지 않을때, 조회할 필요가 없음
        // ObjectId를 가지고 오지 않을 때 사용함
        projection.append("_id", 0);

        // MongoDB의 find 명령어를 통해 조회할 경우 사용함
        // 조회하는 데이터의 양이 적은 경우, find를 사용하고, 데이터양이 많은 경우 무조건 Aggregate 사용한다.
        FindIterable<Document> rs = col.find(query).projection(projection);

        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }

            // 조회 잘되나 출력해 봄
            String star_name = CmmUtil.nvl(doc.getString("star_name"));
            String sc_name = CmmUtil.nvl(doc.getString("sc_name"));
            String position = CmmUtil.nvl(doc.getString("position"));
            String seasoni = CmmUtil.nvl(doc.getString("season"));
            String star_cnt = CmmUtil.nvl(doc.getString("star_cnt"));
            String picture = CmmUtil.nvl(doc.getString("picture"));

            log.info("star_name : " + star_name);
            log.info("sc_name : " + sc_name);
            log.info("position : " + position);
            log.info("season : " + seasoni);
            log.info("star_cnt : " + star_cnt);
            log.info("picture : " + picture);

            StarDTO rDTO = new StarDTO();

            rDTO.setStar_name(star_name);
            rDTO.setSc_name(sc_name);
            rDTO.setPosition(position);
            rDTO.setSeason(season);
            rDTO.setStar_cnt(star_cnt);
            rDTO.setPicture(picture);

            // 레코드 결과를 List에 저장하기
            rList.add(rDTO);

        }
        log.info(this.getClass().getName() + ".getStarList End!");

        return rList;
    }

    @Override
    public StarDTO getStarInfo(String colNm, String star_name) throws Exception {

        log.info(getClass().getName() + ".getStarInfo Start!");

        StarDTO rDTO = new StarDTO();

        MongoCollection<Document> col = mongodb.getCollection(colNm);


        Document query = new Document();
        query.append("star_name", star_name);

        Document projection = new Document();
        projection.append("star_name", "$star_name");
        projection.append("position", "$position");
        projection.append("season", "$season");
        projection.append("star_cnt", "$star_cnt");
        projection.append("picture", "$picture");

        projection.append("_id", 0);

        FindIterable<Document> rs = col.find(query).projection(projection);

        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }
            String star_namei = CmmUtil.nvl(doc.getString("star_name"));
            String position = CmmUtil.nvl(doc.getString("position"));
            String seasoni = CmmUtil.nvl(doc.getString("season"));
            String star_cnt = CmmUtil.nvl(doc.getString("star_cnt"));
            String picture = CmmUtil.nvl(doc.getString("picture"));

            log.info("star_name : " + star_namei);
            log.info("position : " + position);
            log.info("season : " + seasoni);
            log.info("star_cnt : " + star_cnt);
            log.info("picture : " + picture);

            StarDTO uDTO = new StarDTO();

            uDTO.setStar_name(star_name);
            uDTO.setPosition(position);
            uDTO.setSeason(seasoni);
            uDTO.setStar_cnt(star_cnt);
            uDTO.setPicture(picture);

            rDTO = uDTO;
            // 레코드 결과를 List에 저장하기
        }

        log.info(this.getClass().getName() + ".getStarInfo End!");

        return rDTO;

    }

    @Override
    public int InsertMine(String colNm, MyDTO pDTO) throws Exception{
        log.info(getClass().getName() + ".InsertMine Start!");
        int res = 0;

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        col.insertOne(new Document(new ObjectMapper().convertValue(pDTO, Map.class)));

        res = 1;

        log.info(getClass().getName() + ".InsertMine Start!");

        return res;
    }
}
