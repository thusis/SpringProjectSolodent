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
			/**** ????????? / ???????????? / ????????? / ???????????? *****/ 
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
				/***********???????????? ????????? ??? ???*************/
				ArrayList<Moim> topBoard = getTopBoard();
				model.addAttribute("topBoard", topBoard);
			}
			return "moimhome";
		} else {
			model.addAttribute("msg", "?????????????????? ????????????!");
			return "moimhome";
		}
	}
	
	@RequestMapping("write.moim")
	public String writeMoim() {
		return "moimwrite";
	}
	
	/**?????? ????????? ??????
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
		Date start = Date.valueOf(moimdate.split(" ?????? ")[0]);
		Date end = Date.valueOf(moimdate.split(" ?????? ")[1]);
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
			throw new BoardException("??????????????? ?????? ??????");
		}
	}
	
	/** Attachment ?????? */
	private String[] saveFile(MultipartFile attachment, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources"); // WEBAPP > resources?????? ??????
		String savePath = root + "\\uploadFiles"; //DB??? ????????? ???
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		int ranNum = (int) (Math.random() * 100000);
		String rawname = attachment.getOriginalFilename();
		String rename = sdf.format(new Date(System.currentTimeMillis())) + ranNum + rawname.substring(rawname.lastIndexOf("."));
		String fileRoute = folder + "\\" + rename; //fileRoute??? ????????? ???????????? ???, savePath??? DB?????????

		try {
			attachment.transferTo(new File(fileRoute));
		} catch (Exception e) {
			System.out.println("?????? ?????? ?????? : " + e.getMessage());
		}

		String[] returnArr = new String[2];
		returnArr[0] = savePath;
		returnArr[1] = rename;

		return returnArr;
	}
	
	/**??????????????? ??????detail ??????**/
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
		 * moim : ?????? ????????? ??????
		 * list : ???????????? ?????????
		 * replyList : ?????? ?????????
		 * replyLikeCount  : replyList ?????? ?????????(???) ???
		 * isReplyLikeCountList : replyList ?????? ?????????(??????) ????????? ???????????? ??????
		 * isLike : ????????? ????????????
		 * isScrap : ????????? ?????????
		 */
		ArrayList<Attachment> list = mService.selectAttmList((Integer) boardId);
		ArrayList<Reply> replyList = mService.getBoardReplyList(boardId);

		ArrayList<Integer> replyLikeCount = null;
		if(replyList.size()>0) {
			replyLikeCount = mService.getBoardReplyLikeCount(replyList);
		}
		int boardScrapCount = mService.getBoardScrapCount(boardId);
		int boardLikeCount = mService.getBoardLikeCount(boardId);
		
		// ???????????? 1?????? 0??? ???????????? ????????? ??????
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
			throw new BoardException("?????? ????????? ???????????? ??????");
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
		if(isLike(likevo)==0) { // ??? ??? ??? ?????? ??????
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
		if(isScrap(scrapvo)==0) { // ??? ??? ??? ?????? ??????
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
	 * ??????????????? ?????? ????????????
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

	/** ?????? 
	 */
	@RequestMapping("delete.moim")
	public String deleteBoard(@RequestParam("bId") int boardId) {
		int result = mService.deleteBoard(boardId);
		System.out.println(result);
		if (result > 0) {
			return "redirect:list.moim";
		} else {
			throw new BoardException("????????? ?????? ??????");
		}
	}
	
	//****************************??????********************************//
	/** ?????? ??????**/
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
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd"); // ?????? ?????? ???
		Gson gson = gb2.create(); // gson?????????
		try {
			gson.toJson(paramap, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	/** ?????? ?????? **/
	@RequestMapping("deleteReply.moim")
	@ResponseBody
	public int deleteReply(@RequestParam("replyId") int replyId,
			HttpServletResponse response) {
		return mService.deleteReply(replyId);
	}
	
	private int isReplyLike(ReplyLike rLikevo) {
		return mService.isReplyLike(rLikevo);
	}
	
	/** ?????? ????????? **/
	@RequestMapping(value = "setReplyLike.moim")
	@ResponseBody
	public String setReplyLike(@ModelAttribute ReplyLike rLikevo, 
			HttpServletResponse response,
			Model model) {
		int result = 0;
		if(isReplyLike(rLikevo)==0) { // ??? ??? ??? ?????? ??????
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
	}//?????? ??????????????? =========================

	/** ????????? + ????????? + ????????? ?????? ????????? ?????? ??????
	 */
	public ArrayList<Moim> getTopBoard(){
		return mService.getTopBoard();
	}
	
	/************ ?????? ***************/
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
		System.out.println(moimStatus); on?????? null
		System.out.println(moimCate); ????????? ?????? ?????????,???????????? ?????? null
		System.out.println(sido); ?????? ?????? ??????????????? ?????? ????????? ???/??? ??????
		System.out.println(gugun); ?????? ?????? ??? ?????? ??? ???
		System.out.println(selectOption); title??? ??????
		System.out.println(searchContent); ?????? ?????? ??? ???
		*/
		ArrayList<String> pageMsg = new ArrayList<>();
		HashMap<String,Object> paramap = new HashMap<>();
		
		if(moimStatus!=null) {
			paramap.put("moimStatus", "Y");
			pageMsg.add("?????????");
		}
		if(moimCate !=null) {
			String[] categories = moimCate.trim().split(",");
//			ArrayList<String> cates = new ArrayList<>();
//			for(String cate : categories){
//				cates.add(cate);
//			}
			paramap.put("cates", categories); // ?????? ???????????? LIST??? ????????? ???
			pageMsg.add("?????? ????????? "+moimCate);
		} 
		System.out.println(paramap.get("cates"));
		
		if(!(sido.trim().equals("???/??? ??????") || sido.trim().equals("??????"))){
			if(gugun.trim().equals("??????")){
				paramap.put("local", "%"+sido.trim()+"%");
				pageMsg.add("????????? "+paramap.get("local"));
			} else {
				paramap.put("local", sido.trim()+" "+gugun.trim());
				pageMsg.add("????????? "+paramap.get("local"));
			}
		} else {
			paramap.put("local", "%");
		}

		if(!searchContent.trim().equals("")) {
			switch(selectOption) {
				case "title": paramap.put("title", "%"+searchContent.trim()+"%"); 
							  pageMsg.add("????????? \""+searchContent.trim()+"\"??? ????????????");break;
				case "content": paramap.put("content", "%"+searchContent.trim()+"%"); 
								pageMsg.add("????????? \""+searchContent.trim()+"\"??? ????????????");break;
				case "nickname": paramap.put("nickname", "%"+searchContent.trim()+"%");
								pageMsg.add("???????????? \""+searchContent.trim()+"\"??? ????????????");break;
			}
		}
		ArrayList<Moim> searchList = mService.searchMoim(paramap);
		
		/*** ?????? ????????? ***/
		String str = "";
		for(String s : pageMsg) {
			str += " ???" + s;
		}
		
		if(searchList != null && searchList.size()>0  ) {
			ArrayList<Attachment> attmlist = mService.selectMoimAttm(searchList);
			
			/**** ????????? / ???????????? / ????????? / ???????????? *****/ 
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
			model.addAttribute("msg", "???????????? ?????? ??? ?????????!");
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
			model.addAttribute("dclmsg","?????? ????????? ??????????????????.");
			return "declared-popup";
		} else {
			int result = mService.declareBoard(dcl);
			if (result > 0) {
				model.addAttribute("dclmsg", "????????? ??????????????????.");
				return "declared-popup";
			} else {
				model.addAttribute("dclmsg", "????????? ??? ????????????.");
				return "declared-popup";
			}
		}
	}
	
	/**
	 * ??????????????? ???????????? ?????? ??????????????? ???????????? **********************************
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
		Date start = Date.valueOf(moimdate.split(" ?????? ")[0]);
		Date end = Date.valueOf(moimdate.split(" ?????? ")[1]);
		moim.setMoimStart(start);
		moim.setMoimEnd(end);
		
		/*local*/
		String local = null;
		if(!sido.trim().equals("")) {
			local = sido + " " + gugun;
		}
		moim.setLocal(local);
		
		for(String s: deleteAttm) { // ????????? ?????? ????????? ??? ????????? ?????? =>
			s = s.trim();
		}
		
		/************attachment= list(=attach) ==> ?????? ????????? ?????????******/
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
		
		/***************????????? ?????????*********************/
		ArrayList<String> delRename = new ArrayList<>();
		ArrayList<String> isThum = new ArrayList<>(); //???????????????
		
		for(String rename : deleteAttm) {  //name="deleteAttm"?????? ????????? ????????? value 2022113019315270991814.JPG/N
			if(!rename.equals("")) {
				String[] split = rename.split("/");
				delRename.add(split[0]);
				isThum.add(split[1]);
			}
		}
		
		int deleteAttmResult = 0;
		boolean existBeforeAttm = true;
		
		if(!delRename.isEmpty()) {
			deleteAttmResult = mService.deleteAttm(delRename); // DB?????? ??????
			if(deleteAttmResult>0) {
				for(String rename:delRename) {
					deleteFile(rename, request); //?????????????????? ??????
				}
			}
			if(delRename.size()==deleteAttm.length) { //??????????????? ?????? ?????????????????? ??? ??????
				existBeforeAttm = false;
				if(list.isEmpty()) { // ?????? ????????? ?????? ????????????, ?????? ????????? ??????????????? ??????????????? ????????? ??????
				}
			} else { // ?????? ????????? ???????????????
				for(String th : isThum) {
					if(th.equals("Y") ) {
						mService.updateAttmLevel(moim.getBoardId());
						break;
					}
				}
			}
		}
		
		for (int i=0; i<list.size();i++) { // ?????? ????????? ???????????? ???????????? ????????? ?????? ??????
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
		} // =======??????????????? ?????? ???=============
		
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
