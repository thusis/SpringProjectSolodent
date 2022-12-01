package com.kh.solodent.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;

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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.solodent.board.model.exception.BoardException;
import com.kh.solodent.board.model.service.BoardService;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.BoardScrap;
import com.kh.solodent.board.model.vo.Declare;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.board.model.vo.ReplyLike;
import com.kh.solodent.board.model.vo.Tip;
import com.kh.solodent.board.model.vo.Used;
import com.kh.solodent.board.tip.Pagination;
import com.kh.solodent.member.model.vo.Member;


@Controller
public class BoardController {
	@Autowired
	private BoardService bService;
	
	public String[] saveFile(MultipartFile file, HttpServletRequest req) {
		String savePath = req.getSession().getServletContext().getRealPath("resources") + "\\uploadFiles";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		int ranNum = (int)(Math.random()*100000);
		String oName = file.getOriginalFilename();
		
		String rName = sdf.format(new Date(System.currentTimeMillis())) + ranNum + oName.substring(oName.lastIndexOf("."));
		
		String rNamePath = folder + "\\" + rName;
		
		try {
			file.transferTo(new File(rNamePath));
		} catch (Exception e) {
			System.out.println("파일 전송 에러 :" + e.getMessage());
		}
		
		String[] returnArr = new String[2];
		returnArr[0] = savePath;
		returnArr[1] = rName;
		
		return returnArr;
	}
	
	public void deleteFile(String fName, HttpServletRequest req) {
		String savePath = req.getSession().getServletContext().getRealPath("resources") + "\\uploadFiles";
		
		File f = new File(savePath + "\\" + fName);
		
		if(f.exists()) 
			f.delete();
	}
	
	
	@RequestMapping("usedList.bo")
	public String boardUsedList(Model model, HttpServletRequest req) {
		
		ArrayList<Board> bList = bService.selectUsedList(2);
		ArrayList<Used> uList = bService.selectUsedDetailList();
		ArrayList<Attachment> aList = bService.selectAttmList(null);
		
		
		if(bList != null) {
			model.addAttribute("bList", bList);
			model.addAttribute("aList", aList);
			model.addAttribute("uList", uList);
			return "boardUsedList";
		} else {
			throw new BoardException("중고거래 게시글 조회 실패");
		}
		
	}
	
	@RequestMapping("enrollUsed.bo")
	public String enrollUsed() {
		return "enrollUsed";
	}
	
	@RequestMapping("insertItem.bo")
	public String insertItem(@ModelAttribute Board b, @RequestParam("file") ArrayList<MultipartFile> files,
												HttpServletRequest req, @ModelAttribute Used used,
												@RequestParam("sido1") String sido, @RequestParam("gugun1") String gugun) {
		
		String userId = ((Member)req.getSession().getAttribute("loginUser")).getId(); //수정사항
		b.setUserId(userId);  //수정사항
		b.setBoardCode(2);
		
		
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		for(int i=0 ; i<files.size() ; i++) {
			MultipartFile upload = files.get(i);
			
			if(!upload.getOriginalFilename().equals("")) {
				String[] arr = saveFile(upload, req);
				
				if(arr[1] != null) {
					Attachment a = new Attachment();
					a.setRawname(upload.getOriginalFilename());
					a.setRename(arr[1]);
					a.setFileRoute(arr[0]);
					a.setBoardId(b.getBoardId());
					a.setBoardCode(2);
					list.add(a);
				}
			}
		}
		
		for(int i=0 ; i<list.size() ; i++) {
			if(i == 0)
				list.get(i).setIsThum("Y");
			else
				list.get(i).setIsThum("N");
		}
	
		used.setLocal(sido + " " + gugun);
		
		int boardResult = bService.insertBoard(b);
		int attmResult = bService.insertAttm(list);
		int usedResult = bService.insertUsed(used);
		
		if(boardResult + attmResult + usedResult >= 3) {
			return "redirect:usedList.bo";
		} else {
			throw new BoardException("중고 등록 실패");
		}
		
	}
	
	@RequestMapping("selectUsed.bo")
	public String selectUsed(@RequestParam("bId") Integer bId, @RequestParam("writer") String writer,
												Model model, HttpServletRequest req) {
		Member m = (Member)req.getSession().getAttribute("loginUser");
		String loginUser = m.getId();
		String loginId = m.getId();
		String login = null;
		
		if(loginUser != null) {
			login = loginUser;
		}
		
		boolean yn = false;
		if(!writer.equals(login)) {
			yn = true;
		}
		
		Board b = bService.selectBoard(bId, yn);
		ArrayList<Attachment> aList = bService.selectAttmList(bId);
		Used u = bService.selectUsed(bId);
		Like like = new Like(bId, loginId);
		int isLike = bService.isLike(like);
		int likeCount = bService.selectLikeCount(bId);
		String nickName = bService.selectNickName(b.getUserId());
		
		if(b !=null) {
			model.addAttribute("b", b);
			model.addAttribute("aList", aList);
			model.addAttribute("u", u);
			model.addAttribute("isLike", isLike);
			model.addAttribute("likeCount", likeCount);
			model.addAttribute("nickName", nickName); //수정사항
			return "usedDetail";
		} else {
			throw new BoardException("중고거래 게시글 상세보기 실패");
		}
	}
	
	@RequestMapping("addLike.bo")
	@ResponseBody
	public String addLike(@ModelAttribute Like like) {
		bService.addLike(like);
		int result = bService.selectLikeCount(like.getBoardId());
		String str = String.valueOf(result);
		
		return str;
	}
	
	@RequestMapping("deleteLike.bo")
	@ResponseBody
	public String deleteLike(@ModelAttribute Like like) {
		bService.deleteLike(like);
		int result = bService.selectLikeCount(like.getBoardId());
		String str = String.valueOf(result);
		
		return str;
	}
	
	@RequestMapping("delete.bo")
	public String deleteUsed(@RequestParam("boardId") int boardId) {
		
		int bResult = bService.deleteBoard(boardId);
		int uResult = bService.deleteUsed(boardId);
		
		if(bResult + uResult == 2) {
			return "redirect:usedList.bo";
		} else {
			throw new BoardException("중고거래 게시글 삭제 실패");
		}
	}
	
	@RequestMapping("searchUsed.bo")
	public String searchUsed(@RequestParam(value = "local", required = false) String local, 
												@RequestParam(value = "category", required = false) String category,
												@RequestParam(value = "searchWhere", required = false) String searchWhere,
												@RequestParam(value = "word", required = false) String word,
												Model model) {
		
		if(local != null) {
			local = local.replace("+", " ");
		}
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("local", local);
		map.put("category", category);
		map.put("searchWhere", searchWhere);
		map.put("word", word);
		
		System.out.println(searchWhere);
		
		ArrayList<Board> bList = bService.searchUsed(map);
		ArrayList<Used> uList = bService.selectUsedDetailList();
		ArrayList<Attachment> aList = bService.selectAttmList(null);
		
		if(bList != null) {
			model.addAttribute("bList", bList);
			model.addAttribute("uList", uList);
			model.addAttribute("aList", aList);
		} else {
			throw new BoardException("검색 조회 실패");
		}
		
		return "boardUsedList";
	}
	
	@RequestMapping("editUsed.bo")
	public String editUsed(@RequestParam("bId") int bId, Model model) {
		
		Board b = bService.selectBoard(bId, false);
		ArrayList<Attachment> aList = bService.selectAttmList(bId);
		Used u = bService.selectUsed(bId);
		
		if(b != null) {
			model.addAttribute("b", b);
			model.addAttribute("aList", aList);
			model.addAttribute("u", u);
			
			return "editUsed";
		} else {
			throw new BoardException("거래 게시글 수정화면 가기 실패");
		}
	}
	
	@RequestMapping("updateItem.bo")
	public String updateItem(@RequestParam("deleteAttm") String[] deleteAttm, @ModelAttribute Board b,
											HttpServletRequest req, @ModelAttribute Used used, Model model,
											@RequestParam("file") ArrayList<MultipartFile> files,
											@RequestParam("sido1") String sido, @RequestParam("gugun1") String gugun) {
		
		System.out.println(b);
		System.out.println(Arrays.toString(deleteAttm));
		System.out.println(files);
		System.out.println(used);
		System.out.println(sido);
		System.out.println(gugun);
		
		b.setBoardCode(2);
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		for(int i=0 ; i<files.size() ; i++) {
			MultipartFile upload = files.get(i);
			if(!upload.getOriginalFilename().equals("")) {
				String[] returnArr = saveFile(upload, req);
				if(returnArr[1] != null) {
					Attachment a = new Attachment();
					a.setRawname(upload.getOriginalFilename());
					a.setRename(returnArr[1]);
					a.setFileRoute(returnArr[0]);
					list.add(a);
				}
			}
		}
		
		ArrayList<String> delRename = new ArrayList<String>();
		ArrayList<String> isThumList = new ArrayList<String>();
		
		for(String rename : deleteAttm) {
			if(!rename.equals("")) {
				String[] split = rename.split("_");
				delRename.add(split[0]);
				isThumList.add(split[1]);
			}
		}
		
		int deleteAttmResult = 0;
		boolean existBeforeAttm = true;
		if(!delRename.isEmpty()) {
			deleteAttmResult = bService.deleteAttm(delRename);
			
			if(deleteAttmResult > 0) {
				for(String rename : delRename) {
					deleteFile(rename, req);
				}
			}

			System.out.println("delrename" + delRename.size());
			System.out.println("deleteattm" + deleteAttm.length);
			if(delRename.size() == deleteAttm.length) {
				existBeforeAttm = false;
			} else {
				for(String s : isThumList) {
					if(s.equals("Y")) {
						bService.updateIsThum(b.getBoardId());
						break;
					}
				}
			}
		}
		
		for(int i=0 ; i<list.size() ; i++) {
			Attachment a = list.get(i);
			a.setBoardId(b.getBoardId());
			
			if(existBeforeAttm) {
				a.setIsThum("N");
			} else {
				if(i == 0) {
					a.setIsThum("Y");
				} else {
					a.setIsThum("N");
				}
			}
		}
		
		int updateBoardResult = bService.updateBoard(b);
		
		int updateAttmResult = 0;
		String loc = sido + " " + gugun;
		used.setLocal(loc);
		int updateUsedResult = bService.updateUsed(used);
		if(!list.isEmpty()) {
			updateAttmResult = bService.insertAttm(list);
		}
		
		if(updateAttmResult +updateBoardResult + updateUsedResult == list.size() + 2) {
			model.addAttribute("bId", b.getBoardId());
			model.addAttribute("writer", ((Member)req.getSession().getAttribute("loginUser")).getNickName());
			return "redirect:selectUsed.bo";
		} else {
			throw new BoardException("중고거래 게시글 수정 실패");
		}
	}
	
	//여기서부터 팁게시판
	
	@RequestMapping("tipList.bo")
	public String tipList(Model model, @RequestParam(value = "page", required = false) Integer page) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = bService.getListCount(3);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6); 
			
		ArrayList<Board> bList = bService.selectBoardList(pi, 3);
		ArrayList<Attachment> aList = bService.selectAttmList(null);
		ArrayList<Tip> tList = bService.selectTipList();
		ArrayList<Integer> likeCountList = new ArrayList<Integer>();
		
		for(Board b : bList) {
			likeCountList.add(bService.boardLikeCount(b.getBoardId()));
		}
		
		if(bList != null) {
			model.addAttribute("bList", bList);
			model.addAttribute("aList", aList);
			model.addAttribute("tList", tList);
			model.addAttribute("pi", pi);
			model.addAttribute("likeCountList", likeCountList);
			return "boardTipList";
		} else {
			throw new BoardException("꿀팁 게시판 조회 실패");
		}
	}
	
	@RequestMapping("enrollTip.bo")
	public String enrollTip() {
		return "enrollTip";
	}
	
	@RequestMapping("insertTip.bo")
	public String insertTip(@ModelAttribute Board b, @RequestParam("tipCate") String category,
											@RequestParam(value = "file", required = false) ArrayList<MultipartFile> files, HttpServletRequest req) {
		
		String userId = ((Member)req.getSession().getAttribute("loginUser")).getId();
		b.setUserId(userId);
		b.setBoardCode(3);
		
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		if(files != null) {
			for(int i=0 ; i<files.size() ; i++) {
				MultipartFile upload = files.get(i);
				
				if(!upload.getOriginalFilename().equals("")) {
					String[] arr = saveFile(upload, req);
					
					if(arr[1] != null) {
						Attachment a = new Attachment();
						a.setRawname(upload.getOriginalFilename());
						a.setRename(arr[1]);
						a.setFileRoute(arr[0]);
						a.setBoardId(b.getBoardId());
						a.setBoardCode(3);
						list.add(a);
					}
				}
			}
		}
		
		for(int i=0 ; i<list.size() ; i++) {
			if(i == 0)
				list.get(i).setIsThum("Y");
			else
				list.get(i).setIsThum("N");
		}
		
		int boardResult = bService.insertBoard(b);
		int attmResult = 0;
		if(list.size() != 0) {
			 attmResult = bService.insertAttm(list);
		}
		int tipResult = bService.insertTip(category);
		
		if(boardResult + attmResult + tipResult >= 2) {
			return "redirect:tipList.bo";
		} else {
			throw new BoardException("꿀팁 등록 실패");
		}
	}
	
	@RequestMapping("searchTip.bo")
	public String searchTip(@RequestParam(value = "category", required = false) String category, 
											@RequestParam(value = "searchWhere", required = false) String searchWhere,
											@RequestParam(value = "word", required = false) String word,
											@RequestParam(value = "page", required = false) Integer page,
											Model model) {
	
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("category", category);
		map.put("searchWhere", searchWhere);
		map.put("word", word);
		map.put("boardCode", 3);
		
				
		ArrayList<Board> bListCount = bService.selectSearchTipList(map, null);
		int listCount = bListCount.size();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		ArrayList<Board> bList = bService.selectSearchTipList(map, pi);
		ArrayList<Tip> tList = bService.selectTipList();
		ArrayList<Attachment> aList = bService.selectAttmList(null);
		
		ArrayList<Integer> likeCountList = new ArrayList<Integer>();
		
		for(Board b : bList) {
			likeCountList.add(bService.boardLikeCount(b.getBoardId()));
		}
		
		if(bList != null) {
			model.addAttribute("bList", bList);
			model.addAttribute("tList", tList);
			model.addAttribute("aList", aList);
			model.addAttribute("pi", pi);
			model.addAllAttributes(map);
			model.addAttribute("likeCountList", likeCountList);
			
			return "boardTipList";
		} else {
			throw new BoardException("팁게시판 검색조회 실패");
		}
	}
	
	@RequestMapping("selectTip.bo")
	public String selectTip(@RequestParam("bId") Integer bId, @RequestParam("writer") String writer,
											Model model, HttpServletRequest req) {
		
		Member m = (Member)req.getSession().getAttribute("loginUser");
		String loginId = m.getId();
		String login = null;
		
		if(loginId != null) {
			login = loginId;
		}
		System.out.println(writer);
		boolean yn = false;
		if(!writer.equals(login)) {
			yn = true;
		}
		
		Board b = bService.selectBoard(bId, yn);
		ArrayList<Attachment> aList = bService.selectAttmList(bId);
		ArrayList<Reply> rList = bService.selectReply(bId);
		ArrayList<Integer> likeCountList = new ArrayList<Integer>();
		ArrayList<Integer> isReplyLikeList = new ArrayList<Integer>();
		HashMap<String, Object> scrapMap = new HashMap<>();
		scrapMap.put("userId", loginId);
		scrapMap.put("boardId", b.getBoardId());
		int isScrap = bService.isScrap(scrapMap);
		
		
		for(Reply reply : rList) {
			likeCountList.add(bService.replyLikeCount(reply.getReplyId()));
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("userId", loginId);
			map.put("replyId",reply.getReplyId());
			isReplyLikeList.add(bService.isReplyLikeList(map));
		}
		Like like = new Like(bId, loginId);
		int isLike = bService.isLike(like);
		int likeCount = bService.selectLikeCount(bId);
		String nickName = bService.selectNickName(b.getUserId());
		
		if(b !=null) {
			model.addAttribute("b", b);
			model.addAttribute("aList", aList);
			model.addAttribute("isLike", isLike);
			model.addAttribute("likeCount", likeCount);
			model.addAttribute("nickName", nickName);
			model.addAttribute("rList", rList);
			model.addAttribute("likeCountList", likeCountList);
			model.addAttribute("isReplyLikeList", isReplyLikeList);
			model.addAttribute("isScrap", isScrap);
			return "tipDetail";
		} else {
			throw new BoardException("팁게시글 선택 실패");
		}
	}
	
	@RequestMapping("editTip.bo")
	public String editTip(@RequestParam("bId") int bId, Model model) {
		
		Board b = bService.selectBoard(bId, false);
		ArrayList<Attachment> aList = bService.selectAttmList(bId);
		Tip t = bService.selectTip(bId);
		
		if(b != null) {
			model.addAttribute("b", b);
			model.addAttribute("aList", aList);
			model.addAttribute("t", t);
			
			return "editTip";
		} else {
			throw new BoardException("꿀팁 게시글 수정화면 가기 실패");
		}
	}
	
	@RequestMapping("updateTip.bo")
	public String updateTip(@RequestParam(value = "deleteAttm", required = false) String[] deleteAttm, @ModelAttribute Board b,
											HttpServletRequest req, Model model,
											@RequestParam(value = "file", required = false) ArrayList<MultipartFile> files,
											@RequestParam("tipCate") String category ) {
		
		
		
		b.setBoardCode(3);
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		if(files != null) {
			for(int i=0 ; i<files.size() ; i++) {
				MultipartFile upload = files.get(i);
				if(!upload.getOriginalFilename().equals("")) {
					String[] returnArr = saveFile(upload, req);
					if(returnArr[1] != null) {
						Attachment a = new Attachment();
						a.setRawname(upload.getOriginalFilename());
						a.setRename(returnArr[1]);
						a.setFileRoute(returnArr[0]);
						list.add(a);
					}
				}
			}
		}
		
		ArrayList<String> delRename = new ArrayList<String>();
		ArrayList<String> isThumList = new ArrayList<String>();
		
		for(String rename : deleteAttm) {
			if(!rename.equals("")) {
				String[] split = rename.split("_");
				delRename.add(split[0]);
				isThumList.add(split[1]);
			}
		}
		
		int deleteAttmResult = 0;
		boolean existBeforeAttm = true;
		if(!delRename.isEmpty()) {
			deleteAttmResult = bService.deleteAttm(delRename);
			
			if(deleteAttmResult > 0) {
				for(String rename : delRename) {
					deleteFile(rename, req);
				}
			}

			System.out.println("delrename" + delRename.size());
			System.out.println("deleteattm" + deleteAttm.length);
			if(delRename.size() == deleteAttm.length) {
				existBeforeAttm = false;
			} else {
				for(String s : isThumList) {
					if(s.equals("Y")) {
						bService.updateIsThum(b.getBoardId());
						break;
					}
				}
			}
		}
		
		for(int i=0 ; i<list.size() ; i++) {
			Attachment a = list.get(i);
			a.setBoardId(b.getBoardId());
			
			if(existBeforeAttm) {
				a.setIsThum("N");
			} else {
				if(i == 0) {
					a.setIsThum("Y");
				} else {
					a.setIsThum("N");
				}
			}
		}
		
		int updateBoardResult = bService.updateBoard(b);
		
		int updateAttmResult = 0;
		
		Tip tip = new Tip(b.getBoardId(), category);
		int updateTipResult = bService.updateTip(tip);
		if(!list.isEmpty()) {
			updateAttmResult = bService.insertAttm(list);
		}
		
		if(updateAttmResult +updateBoardResult + updateTipResult == list.size() + 2) {
			model.addAttribute("bId", b.getBoardId());
			model.addAttribute("writer", ((Member)req.getSession().getAttribute("loginUser")).getId());
			return "redirect:selectTip.bo";
		} else {
			throw new BoardException("꿀팁 게시글 수정 실패");
		}
	}
	
	@RequestMapping("deleteTip.bo")
	public String deleteTip(@RequestParam("boardId") int boardId) {
		
		int bResult = bService.deleteBoard(boardId);
		int tResult = bService.deleteTip(boardId);
		
		if(bResult + tResult == 2) {
			return "redirect:tipList.bo";
		} else {
			throw new BoardException("꿀팁 게시글 삭제 실패");
		}
	}

	@RequestMapping("insertReply.bo")
	public void insertReply(@ModelAttribute Reply r, HttpServletResponse resp, HttpServletRequest req) {
		
		r.setUserId(((Member)req.getSession().getAttribute("loginUser")).getId());
		int result = bService.insertReply(r);
		
		ArrayList<Reply> rList = bService.selectReply(r.getBoardId());
		ArrayList<Integer> likeCountList = new ArrayList<>();
		ArrayList<Integer> isReplyLikeList = new ArrayList<Integer>();
		
		for(Reply reply : rList) {
			likeCountList.add(bService.replyLikeCount(reply.getReplyId()));
			
			HashMap<String, Object> likeMap = new HashMap<String, Object>();
			likeMap.put("userId", r.getUserId());
			likeMap.put("replyId", reply.getReplyId());
			isReplyLikeList.add(bService.isReplyLikeList(likeMap));
		}
		
		HashMap<String,  Object> map = new HashMap<>();
		map.put("rList", rList);
		map.put("likeCountList", likeCountList);
		map.put("isReplyLikeList", isReplyLikeList);
		resp.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		try {
			gson.toJson(map, resp.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("addReplyLike.bo")
	@ResponseBody
	public String addReplyLike(@ModelAttribute ReplyLike r) {
		bService.addReplyLike(r);
		int replyLikeCount = bService.replyLikeCount(r.getReplyId());
		
		String str = String.valueOf(replyLikeCount);
		
		return str;
	}
	
	@RequestMapping("deleteReplyLike.bo")
	@ResponseBody
	public String deleteReplyLike(@ModelAttribute ReplyLike r) {
		bService.deleteReplyLike(r);
		int replyLikeCount = bService.replyLikeCount(r.getReplyId());
		String str = String.valueOf(replyLikeCount);
		
		System.out.println(str);
		return str;
	}
	
	@RequestMapping("boardScrap.bo")
	@ResponseBody
	public String boardScrap(@ModelAttribute BoardScrap bs) {
		bService.boardScrap(bs);
		
		return "";
	}
	@RequestMapping("deleteScrap.bo")
	@ResponseBody
	public String deleteScrap(@ModelAttribute BoardScrap bs) {
		bService.deleteScrap(bs);
		
		return "";
	}
	
	@RequestMapping("deleteReply.bo")
	public void deletetReply(@RequestParam("replyId") int replyId, @RequestParam("boardId") int boardId,
												@RequestParam("userId") String userId,
												HttpServletResponse resp, HttpServletRequest req) {
		
//		r.setUserId(((Member)req.getSession().getAttribute("loginUser")).getId());
		int result = bService.deleteReply(replyId);
		
		ArrayList<Reply> rList = bService.selectReply(boardId);
		ArrayList<Integer> likeCountList = new ArrayList<>();
		ArrayList<Integer> isReplyLikeList = new ArrayList<Integer>();
		
		for(Reply reply : rList) {
			likeCountList.add(bService.replyLikeCount(reply.getReplyId()));
			
			HashMap<String, Object> likeMap = new HashMap<String, Object>();
			likeMap.put("userId", userId);
			likeMap.put("replyId", reply.getReplyId());
			isReplyLikeList.add(bService.isReplyLikeList(likeMap));
		}
		
		HashMap<String,  Object> map = new HashMap<>();
		map.put("rList", rList);
		map.put("likeCountList", likeCountList);
		map.put("isReplyLikeList", isReplyLikeList);
		resp.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		try {
			gson.toJson(map, resp.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("editReply.bo")
	public void editReply(@ModelAttribute Reply r, HttpServletResponse resp, HttpServletRequest req, 
			@RequestParam("boardId") int boardId, @RequestParam("userId") String userId) {
		
//		r.setUserId(((Member)req.getSession().getAttribute("loginUser")).getId());
//		int result = bService.insertReply(r);
		
		int result = bService.updateReply(r);
		
		ArrayList<Reply> rList = bService.selectReply(r.getBoardId());
		ArrayList<Integer> likeCountList = new ArrayList<>();
		ArrayList<Integer> isReplyLikeList = new ArrayList<Integer>();
		
		for(Reply reply : rList) {
			likeCountList.add(bService.replyLikeCount(reply.getReplyId()));
			
			HashMap<String, Object> likeMap = new HashMap<String, Object>();
			likeMap.put("userId", r.getUserId());
			likeMap.put("replyId", reply.getReplyId());
			isReplyLikeList.add(bService.isReplyLikeList(likeMap));
		}
		
		HashMap<String,  Object> map = new HashMap<>();
		map.put("rList", rList);
		map.put("likeCountList", likeCountList);
		map.put("isReplyLikeList", isReplyLikeList);
		resp.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		try {
			gson.toJson(map, resp.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("declareBoard.bo")
	public String declareBoard(@RequestParam("boardWriter") String writer, @RequestParam("boardId") int boardId,
												   @RequestParam("boardTitle") String boardTitle, HttpServletRequest req, Model model) {

		model.addAttribute("boardId", boardId);
		model.addAttribute("boardWriter", writer);
		model.addAttribute("boardTitle", boardTitle);
		model.addAttribute("loginUser", ((Member)req.getSession().getAttribute("loginUser")).getId());

		System.out.println("팝업");
		return "dPopup";
	}

	@RequestMapping("insertDeclare.bo")
	public String insertDeclare(@ModelAttribute Declare d, Model model) {

		//이미 신고했나 확인해야함
		int checkAlreadyDeclare = bService.checkAlreadyDeclare(d);
		if(checkAlreadyDeclare == 0) {
			
			int result = bService.insertDeclare(d);
			
			if(result > 0) {
				model.addAttribute("dclmsg", "신고가 정상적으로 접수되었습니다.");
			} 
			
		} else {
			model.addAttribute("dclmsg", "이미 신고한 게시물이거나 접수되지 않았습니다.");
		}

		return "declareResult";
	}
	
	
}
