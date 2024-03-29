package com.kh.solodent.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.solodent.board.common.Pagination;
import com.kh.solodent.board.model.exception.BoardException;
import com.kh.solodent.board.model.service.MoimService;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.BoardScrap;
import com.kh.solodent.board.model.vo.Declare;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.board.model.vo.ReplyLike;
import com.kh.solodent.member.model.vo.Member;

@Controller
public class MoimController {
	
	@Autowired
	private MoimService mService;

	@RequestMapping("list.moim")
	public String selectMoimList(@RequestParam(value="page", required=false) Integer page, Model model) {
		
		int currentPage = 1;
		if(page!=null) {
			currentPage = page;
		}
		int listCount =  mService.getListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		ArrayList<Moim> list = mService.selectMoimList(pi);

	
		if(list !=null && list.size()>0 ) {
			ArrayList<Attachment> attmlist = mService.selectMoimAttm(list);
			/**** 조회수 / 좋아요수 / 댓글수 / 스크랩수 *****/ 
			ArrayList<Integer> replyCount = mService.getPageReplyCount(list);
			ArrayList<Integer> likeCount = mService.getPageLikeCount(list);
			ArrayList<Integer> scrapCount = mService.getPageScrapCount(list);
			
			model.addAttribute("pi",pi);
			model.addAttribute("list",list);
			model.addAttribute("attmlist", attmlist);
			model.addAttribute("replyCount",replyCount);
			model.addAttribute("likeCount",likeCount);
			model.addAttribute("scrapCount",scrapCount);
			if(list.size()>2) {
				/***********상위랭크 게시글 세 개*************/
				ArrayList<Moim> topBoard = getTopBoard();
				model.addAttribute("topBoard", topBoard);
			}
			return "moimhome";
		} else {
			model.addAttribute("msg", "모임게시글이 없습니다!");
			return "moimhome";
		}
	}
	
	@RequestMapping("write.moim")
	public String writeMoim() {
		return "moimwrite";
	}
	
	/**모임 게시글 삽입
	 * @param moim
	 * @param moimdate
	 * @param sido
	 * @param gugun
	 * @param attachments
	 * @param request
	 * @return
	 */
	@RequestMapping("insertBoard.moim")
	public String insertBoard(@ModelAttribute Moim moim, 
			@RequestParam("moimdate") String moimdate,
			@RequestParam(value="sido1", required=false) String sido, 
			@RequestParam(value="gugun1", required=false) String gugun, 
			@RequestParam("attachment") ArrayList<MultipartFile> attachments,
			HttpServletRequest request) {

		/*userId*/		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getId();
		moim.setUserId(userId);

		/*moimdate*/
		Date start = Date.valueOf(moimdate.split(" 부터 ")[0]);
		Date end = Date.valueOf(moimdate.split(" 부터 ")[1]);
		moim.setMoimStart(start);
		moim.setMoimEnd(end);
		
		/*local*/
		String local = null;
		if(!sido.trim().equals("")) {
			local = sido + " " + gugun;
		}
		moim.setLocal(local);
		
		/*attachment*/
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		for(int i=0; i<attachments.size(); i++) {
			MultipartFile attachment = attachments.get(i);
			
			if(attachment != null && !attachment.isEmpty()) {
				String[] returnArr = saveFile(attachment, request);
				
				if(returnArr[1] != null) {
					Attachment attach = new Attachment();
					attach.setRawname(attachment.getOriginalFilename());
					attach.setRename(returnArr[1]);
					attach.setFileRoute(returnArr[0]);
					
					list.add(attach);
				}
			}
		}
		
		for(int i=0; i<list.size(); i++) {
			if(i==0) {
				list.get(i).setIsThum("Y");
			} else {
				list.get(i).setIsThum("N");
			}
		}
		
		int result = mService.insertMoim(moim,list);
		if(result>0) {
			return "redirect:list.moim";
		} else {
			throw new BoardException("모임게시글 작성 실패");
		}
	}
	
	/** Attachment 저장 */
	private String[] saveFile(MultipartFile attachment, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources"); // WEBAPP > resources까지 접근
		String savePath = root + "\\uploadFiles"; //DB에 전달할 값
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		int ranNum = (int) (Math.random() * 100000);
		String rawname = attachment.getOriginalFilename();
		String rename = sdf.format(new Date(System.currentTimeMillis())) + ranNum + rawname.substring(rawname.lastIndexOf("."));
		String fileRoute = folder + "\\" + rename; //fileRoute는 실제로 저장하는 곳, savePath는 DB전달값

		try {
			attachment.transferTo(new File(fileRoute));
		} catch (Exception e) {
			System.out.println("파일 전송 에러 : " + e.getMessage());
		}

		String[] returnArr = new String[2];
		returnArr[0] = savePath;
		returnArr[1] = rename;

		return returnArr;
	}
	
	/**모임게시글 상세detail 조회**/
	@RequestMapping("selectMoim.moim")
	public ModelAndView selectMoim(
			@RequestParam("boardId") int boardId, 
			@RequestParam("userId") String userId,
			@RequestParam(value="page", required=false) Integer page,
			ModelAndView mv,
			HttpSession session) {

		Member m = (Member)session.getAttribute("loginUser");
		String loginId = null;
		if(m!=null) {
			loginId = m.getId();
		}

		boolean yn = false;
		if(!userId.equals(loginId)) {
			yn = true;
		}
		
		Moim moim = mService.selectMoim(boardId, yn);
		/**
		 * moim : 모임 상세글 정보
		 * list : 첨부파일 리스트
		 * replyList : 댓글 리스트
		 * replyLikeCount  : replyList 별로 좋아요(총) 수
		 * isReplyLikeCountList : replyList 별로 좋아요(나의) 여부를 리스트로 반환
		 * isLike : 좋아요 눌렀는지
		 * isScrap : 스크랩 했는지
		 */
		ArrayList<Attachment> list = mService.selectAttmList((Integer) boardId);
		ArrayList<Reply> replyList = mService.getBoardReplyList(boardId);

		ArrayList<Integer> replyLikeCount = null;
		if(replyList.size()>0) {
			replyLikeCount = mService.getBoardReplyLikeCount(replyList);
		}
		int boardScrapCount = mService.getBoardScrapCount(boardId);
		int boardLikeCount = mService.getBoardLikeCount(boardId);
		
		// 로그인시 1이나 0을 반영하는 좋아요 조회
		int isLike = 0;
		int isScrap = 0;
		ArrayList<Integer> isReplyLikeCountList = null;
		if(loginId != null) {
			Like like = new Like(boardId, loginId);
			isLike = isLike(like);
			BoardScrap scrap = new BoardScrap(loginId, boardId);
			isScrap = isScrap(scrap);
			if(replyList.size()>0) {
				isReplyLikeCountList = mService.getisReplyLikeList(replyList, loginId);
			}
		}
		
		if(moim!=null) {
			if(page!=null) {
				mv.addObject("moim",moim).addObject("page",page).addObject("list",list).
				addObject("replyList",replyList).addObject("replyLikeCount",replyLikeCount).
				addObject("boardScrapCount",boardScrapCount).addObject("boardLikeCount",boardLikeCount).
				addObject("isLike",isLike).addObject("isScrap", isScrap).
				addObject("isReplyLikeCountList", isReplyLikeCountList).
				setViewName("moimdetail");
			}else {
				mv.addObject("moim",moim).addObject("list",list).
				addObject("replyList",replyList).addObject("replyLikeCount",replyLikeCount).
				addObject("boardScrapCount",boardScrapCount).addObject("boardLikeCount",boardLikeCount).
				addObject("isLike",isLike).addObject("isScrap",isScrap).
				addObject("isReplyLikeCountList", isReplyLikeCountList).
				setViewName("moimdetail");
			}
		} else {
			throw new BoardException("모임 게시글 상세보기 실패");
		}
		
		return mv;
	}

	private int isLike(Like like) {
		return mService.isLike(like);
	}
	
	@RequestMapping(value = "setBoardLike.moim")
	@ResponseBody
	public String setBoardLike(@ModelAttribute Like likevo, 
			HttpServletResponse response,
			Model model) {
		if(isLike(likevo)==0) { // 한 번 더 문턱 걸기
			mService.setBoardLike(likevo);
		}
		int count = mService.getBoardLikeCount(likevo.getBoardId());
		return String.valueOf(count);
	}
	
	@RequestMapping(value = "deleteBoardLike.moim")
	@ResponseBody
	public String deleteBoardLike(@ModelAttribute Like likevo, 
			HttpServletResponse response) {
		if(isLike(likevo)==1) {
			mService.deleteBoardLike(likevo);
		}
		int count = mService.getBoardLikeCount(likevo.getBoardId());
		return String.valueOf(count);
	}
	
	private int isScrap(BoardScrap scrap) {
		return mService.isScrap(scrap);
	}
	
	@RequestMapping(value = "setScrap.moim")
	@ResponseBody
	public String setScrap(@ModelAttribute BoardScrap scrapvo, 
			HttpServletResponse response) {
		if(isScrap(scrapvo)==0) { // 한 번 더 문턱 걸기
			mService.setScrap(scrapvo);
		}
		int count = mService.getBoardScrapCount(scrapvo.getBoardId());
		return String.valueOf(count);
	}
	
	@RequestMapping(value = "deleteScrap.moim")
	@ResponseBody
	public String deleteScrap(@ModelAttribute BoardScrap scrapvo, 
			HttpServletResponse response,
			Model model) {
		if(isScrap(scrapvo)==1) {
			mService.deleteScrap(scrapvo);
		}
		int count = mService.getBoardScrapCount(scrapvo.getBoardId());
		return String.valueOf(count);
	}
	
	/**
	 * 모임게시글 수정 페이지로
	 */
	@RequestMapping("update.moim")
	public String updateMoim(@RequestParam("bId") int boardId, 
			@RequestParam("pi") int page,
			Model model	) {		
		System.out.println(model);
		Moim moim = mService.selectMoim(boardId, false);
		ArrayList<Attachment> list = mService.selectAttmList((Integer) boardId);
		model.addAttribute("moim",moim);
		model.addAttribute("page",page);
		model.addAttribute("list",list);
		return "edit";
	}

	/** 삭제 
	 */
	@RequestMapping("delete.moim")
	public String deleteBoard(@RequestParam("bId") int boardId) {
		int result = mService.deleteBoard(boardId);
		System.out.println(result);
		if (result > 0) {
			return "redirect:list.moim";
		} else {
			throw new BoardException("게시글 삭제 실패");
		}
	}
	
	//****************************댓글********************************//
	/** 댓글 작성**/
	@RequestMapping(value = "insertReply.moim")
	public void insertReply(@ModelAttribute Reply r, HttpServletResponse response) {
		
		int result = mService.insertReply(r);
		
		ArrayList<Reply> list = mService.getBoardReplyList(r.getBoardId());
		ArrayList<Integer> replyLikeCount = mService.getBoardReplyLikeCount(list);
		ArrayList<Integer> isReplyLikeCountList = mService.getisReplyLikeList(list, r.getUserId());
		
		HashMap<String, ArrayList> paramap = new HashMap<>();
		paramap.put("list", list);
		paramap.put("replyLikeCount", replyLikeCount);
		paramap.put("isReplyLikeCountList", isReplyLikeCountList);
		
		response.setContentType("application/json; charset=UTF-8");

		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd"); // 형식 지정 후
		Gson gson = gb2.create(); // gson만들기
		try {
			gson.toJson(paramap, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	/** 댓글 삭제 **/
	@RequestMapping("deleteReply.moim")
	@ResponseBody
	public int deleteReply(@RequestParam("replyId") int replyId,
			HttpServletResponse response) {
		return mService.deleteReply(replyId);
	}
	
	private int isReplyLike(ReplyLike rLikevo) {
		return mService.isReplyLike(rLikevo);
	}
	
	/** 댓글 좋아요 **/
	@RequestMapping(value = "setReplyLike.moim")
	@ResponseBody
	public String setReplyLike(@ModelAttribute ReplyLike rLikevo, 
			HttpServletResponse response,
			Model model) {
		int result = 0;
		if(isReplyLike(rLikevo)==0) { // 한 번 더 문턱 걸기
			result = mService.setReplyLike(rLikevo);
		}
		return result+"";
	}
	
	@RequestMapping(value = "deleteReplyLike.moim")
	@ResponseBody
	public String deleteReplyLike(@ModelAttribute ReplyLike rLikevo, 
			HttpServletResponse response) {
		int result = 0;
		if(isReplyLike(rLikevo)==1) {
			result = mService.deleteReplyLike(rLikevo);
		}
		System.out.println(result);
		return result+"";
	}//댓글 좋아요까지 =========================

	/** 좋아요 + 조회수 + 스크랩 많은 게시글 상단 노출
	 */
	public ArrayList<Moim> getTopBoard(){
		return mService.getTopBoard();
	}
	
	/************ 검색 ***************/
	@RequestMapping("search.moim")
	public String searchMoim(
			@RequestParam(value="moimStatus", required=false) String moimStatus,
			@RequestParam(value="moimCategory", required=false) String moimCate,
			@RequestParam(value="sido1", required=false) String sido, 
			@RequestParam(value="gugun1", required=false) String gugun, 
			@RequestParam(value="selectOption",required=false) String selectOption,
			@RequestParam(value="searchContent",required=false) String searchContent,
			Model model,
			HttpServletRequest request) {
		
		/*
		System.out.println(moimStatus); on이나 null
		System.out.println(moimCate); 동아리 혹은 동아리,취미활동 혹은 null
		System.out.println(sido); 전체 혹은 대전광역시 등의 지역명 시/도 선택
		System.out.println(gugun); 전체 혹은 구 혹은 빈 값
		System.out.println(selectOption); title이 기본
		System.out.println(searchContent); 내용 혹은 빈 값
		*/
		ArrayList<String> pageMsg = new ArrayList<>();
		HashMap<String,Object> paramap = new HashMap<>();
		
		if(moimStatus!=null) {
			paramap.put("moimStatus", "Y");
			pageMsg.add("모집중");
		}
		if(moimCate !=null) {
			String[] categories = moimCate.trim().split(",");
//			ArrayList<String> cates = new ArrayList<>();
//			for(String cate : categories){
//				cates.add(cate);
//			}
			paramap.put("cates", categories); // 이건 매퍼에서 LIST로 돌려야 함
			pageMsg.add("모집 유형이 "+moimCate);
		} 
		System.out.println(paramap.get("cates"));
		
		if(!(sido.trim().equals("시/도 선택") || sido.trim().equals("전체"))){
			if(gugun.trim().equals("전체")){
				paramap.put("local", "%"+sido.trim()+"%");
				pageMsg.add("지역은 "+paramap.get("local"));
			} else {
				paramap.put("local", sido.trim()+" "+gugun.trim());
				pageMsg.add("지역은 "+paramap.get("local"));
			}
		} else {
			paramap.put("local", "%");
		}

		if(!searchContent.trim().equals("")) {
			switch(selectOption) {
				case "title": paramap.put("title", "%"+searchContent.trim()+"%"); 
							  pageMsg.add("제목에 \""+searchContent.trim()+"\"을 포함하는");break;
				case "content": paramap.put("content", "%"+searchContent.trim()+"%"); 
								pageMsg.add("내용에 \""+searchContent.trim()+"\"을 포함하는");break;
				case "nickname": paramap.put("nickname", "%"+searchContent.trim()+"%");
								pageMsg.add("작성자에 \""+searchContent.trim()+"\"을 포함하는");break;
			}
		}
		ArrayList<Moim> searchList = mService.searchMoim(paramap);
		
		/*** 전달 메세지 ***/
		String str = "";
		for(String s : pageMsg) {
			str += " ✅" + s;
		}
		
		if(searchList != null && searchList.size()>0  ) {
			ArrayList<Attachment> attmlist = mService.selectMoimAttm(searchList);
			
			/**** 조회수 / 좋아요수 / 댓글수 / 스크랩수 *****/ 
			ArrayList<Integer> replyLikeCount = mService.getPageReplyCount(searchList);
			ArrayList<Integer> likeCount = mService.getPageLikeCount(searchList);
			ArrayList<Integer> scrapCount = mService.getPageScrapCount(searchList);
			
			model.addAttribute("list",searchList);
			model.addAttribute("attmlist", attmlist);
			model.addAttribute("replyLikeCount",replyLikeCount);
			model.addAttribute("likeCount",likeCount);
			model.addAttribute("scrapCount",scrapCount);
			model.addAttribute("str",str);
			return "moimsearch";
		} else {
			model.addAttribute("str", str);
			model.addAttribute("msg", "게시글을 찾을 수 없어요!");
			return "moimsearch";
		}
	}
	
	@RequestMapping("declare-popup.moim")
	public String declarePopup() {
		return "declare-popup";
	}
	
	@RequestMapping("declare.moim")
	public String declareBoard(
			@ModelAttribute Declare dcl, 
			Model model) {
		int isDeclared = mService.getIsDeclared(dcl);
		if(isDeclared>0) {
			model.addAttribute("dclmsg","이미 신고한 게시글입니다.");
			return "declared-popup";
		} else {
			int result = mService.declareBoard(dcl);
			if (result > 0) {
				model.addAttribute("dclmsg", "신고한 게시글입니다.");
				return "declared-popup";
			} else {
				model.addAttribute("dclmsg", "신고할 수 없습니다.");
				return "declared-popup";
			}
		}
	}
	
	/**
	 * 모임게시글 수정하고 해당 모임게시글 페이지로 **********************************
	 */
	@RequestMapping("updateBoard.moim")
	public String updateBoardMoim(
			@ModelAttribute Moim moim, 
			@RequestParam("page") int page,
			@RequestParam("moimdate") String moimdate,
			@RequestParam(value="sido1", required=false) String sido, 
			@RequestParam(value="gugun1", required=false) String gugun, 
			@RequestParam("deleteAttm") String[] deleteAttm,
			@RequestParam("attachment") ArrayList<MultipartFile> files,
			HttpServletRequest request, Model model	) {
		
		/*moimdate*/
		Date start = Date.valueOf(moimdate.split(" 부터 ")[0]);
		Date end = Date.valueOf(moimdate.split(" 부터 ")[1]);
		moim.setMoimStart(start);
		moim.setMoimEnd(end);
		
		/*local*/
		String local = null;
		if(!sido.trim().equals("")) {
			local = sido + " " + gugun;
		}
		moim.setLocal(local);
		
		for(String s: deleteAttm) { // 기존에 있는 파일들 중 삭제할 파일 =>
			s = s.trim();
		}
		
		/************attachment= list(=attach) ==> 새로 추가할 친구들******/
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		for(int i=0; i<files.size(); i++) {
			MultipartFile upload = files.get(i);
			
			if(!upload.getOriginalFilename().equals("")) {
				String[] returnArr = saveFile(upload, request);
				
				if(returnArr[1]!=null) {
					Attachment attach = new Attachment();
					attach.setRawname(upload.getOriginalFilename());
					attach.setRename(returnArr[1]);
					attach.setFileRoute(returnArr[0]);
				}
			}
		}
		
		for(int i=0; i<list.size();i++) {
			System.out.println(list.get(i));
		}
		
		/***************삭제할 친구들*********************/
		ArrayList<String> delRename = new ArrayList<>();
		ArrayList<String> isThum = new ArrayList<>(); //썸네일인지
		
		for(String rename : deleteAttm) {  //name="deleteAttm"으로 받아온 값들의 value 2022113019315270991814.JPG/N
			if(!rename.equals("")) {
				String[] split = rename.split("/");
				delRename.add(split[0]);
				isThum.add(split[1]);
			}
		}
		
		int deleteAttmResult = 0;
		boolean existBeforeAttm = true;
		
		if(!delRename.isEmpty()) {
			deleteAttmResult = mService.deleteAttm(delRename); // DB에서 삭제
			if(deleteAttmResult>0) {
				for(String rename:delRename) {
					deleteFile(rename, request); //프로젝트에서 삭제
				}
			}
			if(delRename.size()==deleteAttm.length) { //기존파일을 전부 삭제하겠다고 한 경우
				existBeforeAttm = false;
				if(list.isEmpty()) { // 기존 파일도 모두 삭제하고, 새로 등록한 파일목록도 비워져있는 경우를 상정
				}
			} else { // 기존 파일이 남아있다면
				for(String th : isThum) {
					if(th.equals("Y") ) {
						mService.updateAttmLevel(moim.getBoardId());
						break;
					}
				}
			}
		}
		
		for (int i=0; i<list.size();i++) { // 새로 추가할 첨부파일 리스트의 썸네일 여부 판별
			Attachment a = list.get(i);
			a.setBoardId(moim.getBoardId());
			
			if(existBeforeAttm) {
				a.setIsThum("N");
			} else {
				if(i==0) {
					a.setIsThum("Y");
				} else {
					a.setIsThum("N");
				}
			}
		} // =======여기까지가 세팅 끝=============
		
		int updateMoimResult = mService.updateMoim(moim);
		int updateAttmResult = 0;
		if(!list.isEmpty()) {
			updateAttmResult = mService.insertNewAttmUpdate(moim, list);
		}
		
		model.addAttribute("moim", moim);
		model.addAttribute("boardId", moim.getBoardId());
		model.addAttribute("userId",moim.getUserId() );
		model.addAttribute("page", page);
		return "redirect:selectMoim.moim";

	}

	private void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root+"\\uploadFiles";
		
		File f = new File(savePath+"\\"+fileName);
		if(f.exists()){
			f.delete();
		}
	}
	
	

	
	
	
	
	
}
