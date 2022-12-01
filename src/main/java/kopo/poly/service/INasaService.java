package kopo.poly.service;

import kopo.poly.dto.NasaDTO;

public interface INasaService {

    String apiURL = "https://api.nasa.gov/planetary/apod";

    NasaDTO getNasa() throws Exception;
}
