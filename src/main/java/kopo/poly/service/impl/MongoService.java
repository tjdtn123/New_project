package kopo.poly.service.impl;

import kopo.poly.dto.MyDTO;
import kopo.poly.dto.ObsDTO;
import kopo.poly.dto.StarDTO;
import kopo.poly.persistance.mapper.IMongoMapper;
import kopo.poly.service.IMongoService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.LinkedList;
import java.util.List;

@Slf4j
@Service("MongoService")

public class MongoService implements IMongoService {

    @Resource(name = "MongoMapper")
    private IMongoMapper mongoMapper; // MongoDB에 저장할 Mapper

    @Override
    public int collectObserver() throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".collectObserver Start!");

        int res = 0;

        List<ObsDTO> pList = new LinkedList<>();

        // 멜론 Top100 중 50위까지 정보 가져오는 페이지
        String url = "https://terms.naver.com/entry.naver?docId=2012642&cid=60236&categoryId=60236";

        // JSOUP 라이브러리를 통해 사이트 접속되면, 그 사이트의 전체 HTML소스 저장할 변수
        Document doc = Jsoup.connect(url).get();

        // <div class="service_list_song"> 이 태그 내에서 있는 HTML소스만 element에 저장됨
        Elements elements = doc.select("table tbody tr");
        log.info(CmmUtil.nvl(String.valueOf(elements)));

        // Iterator을 사용하여 멜론차트 정보를 가져오기
        // 멜론 50위까지 차크

        for (Element element : elements) {
            Elements tdContents = element.select("td");

            if (tdContents.size() != 0) {

                // 크롤링을 통해 데이터 저장하기
                String region = CmmUtil.nvl(tdContents.get(1).text()); // 지역
                String name = CmmUtil.nvl(tdContents.get(2).text()); // 이름
                String pageurl = CmmUtil.nvl(tdContents.get(3).text()); // 홈페이지
                String phone = CmmUtil.nvl(tdContents.get(4).text()); // 전화번호
                String type = CmmUtil.nvl(tdContents.get(5).text()); // 유형
                //String singer = CmmUtil.nvl(songInfo.select("div.ellipsis.rank02 a").eq(0).text()); // 가수

                log.info("region : " + region);
                log.info("name : " + name);
                log.info("pageurl : " + pageurl);
                log.info("phone : " + phone);
                log.info("type : " + type);


                // 가수와 노래 정보가 모두 수집되었다면, 저장함
                if ((region.length() > 0) && (phone.length() > 0)) {

                    ObsDTO pDTO = new ObsDTO();
                    pDTO.setRegion(region);
                    pDTO.setObs_name(name);
                    pDTO.setPageurl(pageurl);
                    pDTO.setPhone(phone);
                    pDTO.setType(type);

                    // 한번에 여러개의 데이터를 MongoDB에 저장할 List 형태의 데이터 저장하기
                    pList.add(pDTO);

                }
            }
        }

        // 생성할 컬렉션명
        String colNm = "OBSERVER";

        // MongoDB에 데이터저장하기
        res = mongoMapper.insertSong(pList, colNm);




        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".collectObserver End!");

        return res;
    }

    @Override
    public List<ObsDTO> getObsList(String region) throws Exception {

        log.info(this.getClass().getName() + ".getObsList Start!");

        // MongoDB에 저장된 컬렉션 이름
        String colNm = "OBSERVER";

        List<ObsDTO> rList = null;


        rList = mongoMapper.getObsList(colNm, region);


        if (rList == null){
            rList = new LinkedList<>();
        }

        log.info(this.getClass().getName() + ".getObsList End!");

        return rList;
    }

    @Override
    public List<StarDTO> getStarList(String season) throws Exception {

        log.info(this.getClass().getName() + ".getStarList Start!");

        // MongoDB에 저장된 컬렉션 이름
        String colNm = "STARS_02";

        List<StarDTO> rList = null;

        rList = mongoMapper.getStarList(colNm,season);

        if (rList == null){
            rList = new LinkedList<>();
        }

        log.info(this.getClass().getName() + ".getStarList End!");

        return rList;
    }

    @Override
    public StarDTO getStarInfo(String star_name) throws Exception {

        log.info(this.getClass().getName() + ".getStarList Start!");

        // MongoDB에 저장된 컬렉션 이름
        String colNm = "STARS_02";

        StarDTO rDTO = null;

        rDTO = mongoMapper.getStarInfo(colNm,star_name);

        if (rDTO == null){
            rDTO = new StarDTO();
        }

        log.info(this.getClass().getName() + ".getStarList End!");

        return rDTO;
    }

    @Override
    public int InsertMine(MyDTO pDTO) throws  Exception{
        log.info(this.getClass().getName() + ".InsertMine Start!");
        int res =0;
        String colNm = "MyStar";
        mongoMapper.InsertMine(colNm, pDTO);
        res =1;
        log.info(this.getClass().getName() + ".InsertMine End!");
        return res;

    }

}
