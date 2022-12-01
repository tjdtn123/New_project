package kopo.poly.controller;


import kopo.poly.dto.NasaDTO;
import kopo.poly.dto.PapagoDTO;
import kopo.poly.service.INasaService;
import kopo.poly.service.IPapagoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@Slf4j
@RequestMapping(value = "nasa")
@RestController
public class NasaController {

    @Resource(name = "NasaService")
    private INasaService nasaService;

    @Resource(name = "PapagoService")
    private IPapagoService papagoService;

    @GetMapping(value = "getNasa")
    public NasaDTO getNasa() throws Exception{
        log.info(this.getClass().getName() + ".getNasa start!");

        NasaDTO rDTO = nasaService.getNasa();

        if (rDTO == null) {
            rDTO = new NasaDTO();

        }

        PapagoDTO pDTO = new PapagoDTO();
        pDTO.setText(rDTO.getTitle());

        PapagoDTO tDTO = papagoService.translate(pDTO);

        if (tDTO == null) {
            tDTO = new PapagoDTO();
        }

        rDTO.setTitle(tDTO.getTranslatedText());

        pDTO.setText(rDTO.getExplanation());
        tDTO = papagoService.translate(pDTO);


        rDTO.setExplanation(tDTO.getTranslatedText().replace(".",".\n"));
        log.info("new String : " + rDTO.getExplanation());


        log.info(this.getClass().getName() + ".getNasa end!");

        return rDTO;
    }
}
