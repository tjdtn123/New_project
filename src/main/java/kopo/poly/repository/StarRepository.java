package kopo.poly.repository;


import kopo.poly.dto.StarDTO;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface StarRepository extends MongoRepository<StarDTO, String> {
}
