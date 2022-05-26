package kopo.poly.dto;


import lombok.Getter;
import lombok.Setter;

/**
 * lombok은 코딩을 줄이기 위해 @어노테이션을 통한 자동 코드 완성기능임
 * @Getter => getter 함수를 작성하지 않았지만, 자동 생성
 * @Setter => setter 함수를 작성하지 않았지만, 자동 생성
 */
@Getter
@Setter
public class ReplyDTO {

	private String comments_id; // 기본키, 순번
	private String board_seq;
	private String user_id; // 작성자
	private String contents; // 글
	private String reg_dt; // 등록일

	@Override
	public String toString() {
		return "ReplyDTO [comments_id= " + comments_id + "board_seq= " + board_seq + "user_id= " + user_id + "contents= " + contents +
				"reg_dt= " + reg_dt + "]";
	}

}
