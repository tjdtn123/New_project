package kopo.poly.persistance.mapper.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import kopo.poly.Criteria.Criteria;
import kopo.poly.dto.MyDTO;
import kopo.poly.dto.ObsDTO;
import kopo.poly.dto.StarDTO;
import kopo.poly.persistance.mapper.AbstractMongoDBComon;
import kopo.poly.persistance.mapper.IMongoMapper;
import kopo.poly.repository.StarRepository;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Slf4j
@Component("MongoMapper")
public class MongoMapper extends AbstractMongoDBComon implements IMongoMapper {

    @Autowired
    StarRepository starRepository;


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

        log.info(this.getClass().getName() + ".getObsList Start!");

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
        log.info(this.getClass().getName() + ".getObsList End!");

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
            String position = CmmUtil.nvl(doc.getString("position"));
            String seasoni = CmmUtil.nvl(doc.getString("season"));
            String star_cnt = CmmUtil.nvl(doc.getString("star_cnt"));
            String picture = CmmUtil.nvl(doc.getString("picture"));

            log.info("star_name : " + star_name);
            log.info("position : " + position);
            log.info("season : " + seasoni);
            log.info("star_cnt : " + star_cnt);
            log.info("picture : " + picture);

            StarDTO rDTO = new StarDTO();

            rDTO.setStar_name(star_name);
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
    public List<StarDTO> getAdStarList(String colNm, Criteria cri) throws Exception {

        log.info(this.getClass().getName() + ".getAdStarList Start!");

        // 조회 결과를 전달하기 위한 객체 생성하기
        List<StarDTO> rList = new LinkedList<>();

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        // 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
        Document projection = new Document();
        projection.append("star_name", "$star_name");
        projection.append("position", "$position");
        projection.append("season", "$season");
        projection.append("star_cnt", "$star_cnt");
        projection.append("picture", "$picture");

        // MongoDB는 무조건 ObjectId가 자동생성되며, ObjectID는 사용하지 않을때, 조회할 필요가 없음
        // ObjectId를 가지고 오지 않을 때 사용함
        projection.append("_id", 0);

        // MongoDB의 find 명령어를 통해 조회할 경우 사용함
        // 조회하는 데이터의 양이 적은 경우, find를 사용하고, 데이터양이 많은 경우 무조건 Aggregate 사용한다.
        FindIterable<Document> rs = col.find().projection(projection).skip(cri.getSkip()).limit(cri.getAmount());

        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }

            // 조회 잘되나 출력해 봄
            String star_name = CmmUtil.nvl(doc.getString("star_name"));
            String position = CmmUtil.nvl(doc.getString("position"));
            String seasoni = CmmUtil.nvl(doc.getString("season"));
            String star_cnt = CmmUtil.nvl(doc.getString("star_cnt"));
            String picture = CmmUtil.nvl(doc.getString("picture"));

            log.info("star_name : " + star_name);
            log.info("position : " + position);
            log.info("season : " + seasoni);
            log.info("star_cnt : " + star_cnt);
            log.info("picture : " + picture);

            StarDTO rDTO = new StarDTO();

            rDTO.setStar_name(star_name);
            rDTO.setPosition(position);
            rDTO.setSeason(seasoni);
            rDTO.setStar_cnt(star_cnt);
            rDTO.setPicture(picture);

            // 레코드 결과를 List에 저장하기
            rList.add(rDTO);

        }
        log.info(this.getClass().getName() + ".getAdStarList End!");

        return rList;
    }

    @Override
    public List<MyDTO> getMyStarList(String colNm, String id) throws Exception {

        log.info(this.getClass().getName() + ".getAdStarList Start!");

        // 조회 결과를 전달하기 위한 객체 생성하기
        List<MyDTO> rList = new LinkedList<>();

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        Document query = new Document();
        query.append("user_id", id);

        // 조회 결과 중 출력할 컬럼들(SQL의 SELECT절과 FROM절 가운데 컬럼들과 유사함)
        Document projection = new Document();

        projection.append("star_name", "$star_name");
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
            String position = CmmUtil.nvl(doc.getString("position"));
            String seasoni = CmmUtil.nvl(doc.getString("season"));
            String star_cnt = CmmUtil.nvl(doc.getString("star_cnt"));
            String picture = CmmUtil.nvl(doc.getString("picture"));

            log.info("star_name : " + star_name);
            log.info("position : " + position);
            log.info("season : " + seasoni);
            log.info("star_cnt : " + star_cnt);
            log.info("picture : " + picture);

            MyDTO rDTO = new MyDTO();

            rDTO.setStar_name(star_name);
            rDTO.setPosition(position);
            rDTO.setSeason(seasoni);
            rDTO.setStar_cnt(star_cnt);
            rDTO.setPicture(picture);

            // 레코드 결과를 List에 저장하기
            rList.add(rDTO);

        }
        log.info(this.getClass().getName() + ".getMyStarList End!");

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
        projection.append("star_cnt", "$star_cnt");
        projection.append("size", "$size");
        projection.append("season", "$season");
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
            String size = CmmUtil.nvl(doc.getString("size"));
            String picture = CmmUtil.nvl(doc.getString("picture"));

            log.info("star_name : " + star_namei);
            log.info("position : " + position);
            log.info("season : " + seasoni);
            log.info("size : " + size);
            log.info("star_cnt : " + star_cnt);
            log.info("picture : " + picture);



            rDTO.setStar_name(star_name);
            rDTO.setPosition(position);
            rDTO.setSeason(seasoni);
            rDTO.setStar_cnt(star_cnt);
            rDTO.setPicture(picture);
            rDTO.setSize(size);


            // 레코드 결과를 List에 저장하기
        }

        log.info(this.getClass().getName() + ".getStarInfo End!");

        return rDTO;

    }

    @Override
    public MyDTO getMyStarInfo(String colNm, String star_name) throws Exception {

        log.info(getClass().getName() + ".getMyStarInfo Start!");

        MyDTO rDTO = new MyDTO();

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

            MyDTO uDTO = new MyDTO();

            uDTO.setStar_name(star_name);
            uDTO.setPosition(position);
            uDTO.setSeason(seasoni);
            uDTO.setStar_cnt(star_cnt);
            uDTO.setPicture(picture);

            rDTO = uDTO;
            // 레코드 결과를 List에 저장하기
        }

        log.info(this.getClass().getName() + ".getMyStarInfo End!");

        return rDTO;

    }

    @Override
    public int updateAdStar(String pColNm, StarDTO pDTO) throws  Exception {

        log.info(this.getClass().getName() + ".updateStar Start!");

        int res = 0;

        MongoCollection<Document> col = mongodb.getCollection(pColNm);

        log.info("pColNm : " + pColNm);

        Document query = new Document();
        query.append("star_name", pDTO.getStar_name());

        FindIterable<Document> rs = col.find(query);

        rs.forEach(doc -> col.deleteOne(doc));

        col.insertOne(new Document(new ObjectMapper().convertValue(pDTO, Map.class)));

        res = 1;

        log.info((this.getClass().getName() + ".updateStar End"));

        return  res;
    }

    @Override
    public int InsertMine(String colNm, MyDTO pDTO) throws Exception{
        log.info(getClass().getName() + ".InsertMine Start!");
        int res = 0;

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        col.insertOne(new Document(new ObjectMapper().convertValue(pDTO, Map.class)));

        res = 1;

        log.info(getClass().getName() + ".InsertMine End!");

        return res;
    }

    @Override
    public int InsertStar(String colNm, StarDTO pDTO) throws Exception{
        log.info(getClass().getName() + ".InsertStar Start!");
        int res = 0;
        try {
            MongoCollection<Document> col = mongodb.getCollection(colNm);

            col.insertOne(new Document(new ObjectMapper().convertValue(pDTO, Map.class)));

        }catch (Exception e) {
            return res;

        }


            res = 1;

            log.info(getClass().getName() + ".InsertStar End!");
            return res;





    }

    @Override
    public int deleteMyStar(String pColNm,MyDTO pDTO) throws  Exception {

        log.info(this.getClass().getName() + ".deleteStar Start!");

        int res = 0;

        MongoCollection<Document> col = mongodb.getCollection(pColNm);

        Document query = new Document();
        query.append("user_id", pDTO.getUser_id());
        query.append("star_name", pDTO.getStar_name());


        FindIterable<Document> rs = col.find(query);

        rs.forEach(doc -> col.deleteOne(doc));

        res = 1;

        log.info(this.getClass().getName() + ".deleteStar End!");

        return  res;
    }

    @Override
    public int deleteAdStar(String pColNm,StarDTO pDTO) throws  Exception {

        log.info(this.getClass().getName() + ".deleteAdStar Start!");

        int res = 0;

        MongoCollection<Document> col = mongodb.getCollection(pColNm);

        Document query = new Document();
        query.append("star_name", pDTO.getStar_name());

        FindIterable<Document> rs = col.find(query);

        rs.forEach(doc -> col.deleteOne(doc));

        res = 1;

        log.info(this.getClass().getName() + ".deleteAdStar End!");

        return  res;
    }

    @Override
    public int countStar(String colNm) throws Exception{
        log.info(getClass().getName() + ".countStar Start!");
        int total;
        List<StarDTO> rList = new LinkedList<>();
        MongoCollection<Document> col = mongodb.getCollection(colNm);
        Document projection = new Document();
        projection.append("_id", "id");

        FindIterable<Document> rs = col.find().projection(projection);
        for (Document doc : rs) {
            if (doc == null) {
                doc = new Document();

            }
            String ids = CmmUtil.nvl(doc.getString("id"));
            StarDTO uDTO = new StarDTO();

            uDTO.setStar_name(ids);
            rList.add(uDTO);
        }
        total = rList.size();
        log.info(String.valueOf(total));

        log.info(getClass().getName() + ".countStar End!");

        return total;
    }
}
