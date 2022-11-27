package com.kh.solodent.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.member.model.vo.Member;

@Controller
public class MoimController {
	

	@Autowired
	private MoimService mService;

	/** 모임게시판 리스트 조회
	 * 
	 * @param page
	 * @param model
	 * @return
	 */
	@RequestMapping("list.moim")
	public String selectMoimList(@RequestParam(value="page", required=false) Integer page, Model model) {
		
		/**
		 * 멤버DB랑 로그인 메소드 구현하기 전까지 
		 * application 영역에 id 랑 닉네임 관리자로 설정
		 * 추후 삭제 예정
		 *******************************************/
//		ServletContext application = request.getSession().getServletContext();
//		application.setAttribute("memberId", "admin");
//		application.setAttribute("nickname", "관리자");
		/*******************************************/
		
		int currentPage = 1;
		if(page!=null) {
			currentPage = page;
		}
		int listCount =  mService.getListCount();
//		System.out.println("모임 listcount :" + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		System.out.println("pi:"+pi);
		ArrayList<Moim> list = mService.selectMoimList(pi);
		ArrayList<Attachment> attmlist = mService.selectMoimAttm(list);
//		for(int i=0; i<attmlist.size(); i++) {
//			System.out.println(attmlist.get(i).getBoardId() + attmlist.get(i).getRename());
//		}
		
		/**** 조회수 / 좋아요수 / 댓글수 / 스크랩수 *****/ 
		ArrayList<Integer> replyLikeCount = mService.getPageReplyCount(list);
		ArrayList<Integer> likeCount = mService.getPageLikeCount(list);
		ArrayList<Integer> scrapCount = mService.getPageScrapCount(list);
		
		/***********상위랭크 게시글 세 개*************/
		ArrayList<Moim> topBoard = getTopBoard();
	
		if(list !=null) {
			model.addAttribute("pi",pi);
			model.addAttribute("list",list);
//			System.out.println(list);
			model.addAttribute("attmlist", attmlist);
			model.addAttribute("replyLikeCount",replyLikeCount);
			model.addAttribute("likeCount",likeCount);
			model.addAttribute("scrapCount",scrapCount);
			model.addAttribute("topBoard", topBoard);
			return "moimhome";
		} else {
			throw new BoardException("모임게시글 조회 실패");
		}
	}
	
	
	@RequestMapping("write.moim")
	public String writeMoim() {
		return "moimwrite";
	}
	
	/**모임 게시글 삽입
	 * 
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
		
//		System.out.println("insertBoard.moim에서 모임: " + moim);
		
		int result = mService.insertMoim(moim,list);
		if(result>0) {
			return "redirect:list.moim";
		} else {
			throw new BoardException("모임게시글 작성 실패");
		}
	}
	
	/** Attachment 저장
	 * 
	 */
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
		
//		System.out.println("original"+rawname);
//		System.out.println("rename"+rename);
//		System.out.println("fileRoute"+fileRoute);

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
	
	/**모임게시글 상세 조회**/
	@RequestMapping("selectMoim.moim")
	public ModelAndView selectMoim(
			@RequestParam("boardId") int boardId, 
			@RequestParam("userId") String userId,
			@RequestParam("page") int page,
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
		if(loginId != null) {
			Like like = new Like(boardId, loginId);
			isLike = isLike(like);
		}
		
		if(moim!=null) {
			mv.addObject("moim",moim).addObject("page",page).addObject("list",list).addObject("replyList",replyList).addObject("replyLikeCount",replyLikeCount).addObject("boardScrapCount",boardScrapCount).addObject("boardLikeCount",boardLikeCount).addObject("isLike",isLike).setViewName("moimdetail");
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
	public String setBoardLike(@ModelAttribute Like likevo, HttpServletResponse response) {
		System.out.println("setBoardLike들어옴");
		mService.setBoardLike(likevo);
		int count = mService.getBoardLikeCount(likevo.getBoardId());
		System.out.println(count);
		return String.valueOf(count);
		
	}
	
	@RequestMapping(value = "deleteBoardLike.moim")
	@ResponseBody
	public String deleteBoardLike(@ModelAttribute Like likevo, HttpServletResponse response) {
		System.out.println("deleteBoardLike들어옴");
		mService.deleteBoardLike(likevo);
		int count = mService.getBoardLikeCount(likevo.getBoardId());
		System.out.println(count);
		return String.valueOf(count);
	}
	

	/**
	 * 모임게시글 수정
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
	
	/** 좋아요 조회
	 * 
	 */
	/** 좋아요 수정
	 * 
	 */

	/** 댓글 작성
	 * 
	 */
	@RequestMapping(value = "insertReply.moim")
	public void insertReply(@ModelAttribute Reply r, HttpServletResponse response) {
		
		System.out.println(r);
		System.out.println(response);
		
		int result = mService.insertReply(r);
		if(result>0) {
			System.out.println("댓글달기성공");
		}
		ArrayList<Reply> list = mService.getBoardReplyList(r.getBoardId());

		response.setContentType("application/json; charset=UTF-8");

		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd"); // 형식 지정 후
		Gson gson = gb2.create(); // gson만들기
		try {
			gson.toJson(list, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}	
	
	// (1) 한글 인코딩 (2) 객체형식
	/*
	 * @RequestMapping(value="insertReply.bo",
	 * produces="application/json; charset=UTF-8")
	 * 
	 * @ResponseBody public String insertReply(@ModelAttribute Reply r) { int result
	 * = bService.insertReply(r); ArrayList<Reply> list =
	 * bService.selectReply(r.getRefBoardId());
	 * 
	 * JSONArray array = new JSONArray(); for(Reply reply : list) { JSONObject json
	 * = new JSONObject(); json.put("replyId", reply.getReplyId());
	 * json.put("replyContent", reply.getReplyContent()); json.put("refBoardId",
	 * reply.getRefBoardId()); json.put("replyWriter", reply.getReplyWriter());
	 * json.put("replyCreateDate", reply.getReplyCreateDate());
	 * json.put("replyModifyDate", reply.getReplyModifyDate());
	 * json.put("replyStatus", reply.getReplyStatus());
	 * 
	 * array.put(json); } return array.toString(); }
	 */

	
	
	/** 댓글 삭제
	 * 
	 */
	

	/** 댓글 좋아요(추천)
	 * 
	 */
	
	
	
	/**스크랩
	 *
	 */
	
	/** 좋아요 + 조회수 + 스크랩 많은 게시글 상단 노출
	 * 
	 */
	public ArrayList<Moim> getTopBoard(){
		return mService.getTopBoard();
	}
	 
	
	/** 좋아요 많은 댓글 상단 노출
	 * 
	 */
	
	
	
	
	/** 모집중 => 모집완료
	 * 
	 */
	public void setMoimStatusRefDate(Date from, Date to) {
		LocalDate currentDate = LocalDate.now();
		// 오늘날짜 , 시작날짜 , 마감날짜
		// 시작날짜 < 오늘날짜 < 마감날짜
		// 오늘날짜 < 시작날짜
		// 마감날짜 < 오늘날짜
		
		
	}
	
	
	
	
	
}
