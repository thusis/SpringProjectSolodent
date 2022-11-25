package com.kh.solodent.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.border.Border;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.kh.solodent.board.model.exception.BoardException;
import com.kh.solodent.board.model.service.BoardService;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.Used;
import com.kh.solodent.member.model.vo.Member;

@SessionAttributes("loginUser")
@Controller
public class BoardController {
	@Autowired
	private BoardService bService;
	
	
	@RequestMapping("board1.bo")
	public String loginView() {
		
		return "boardUsedList";
	}
	
	
	
	
	
	
	public String[] saveFile(MultipartFile file, HttpServletRequest req) {
		String savePath = req.getSession().getServletContext().getRealPath("resources") + "\\uploadFiles";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		int ranNum = (int)(Math.random()*100000);
		String oName = file.getOriginalFilename();
		String smallExt = oName.substring(oName.lastIndexOf(".")).toLowerCase();
		
		String rName = sdf.format(new Date(System.currentTimeMillis())) + ranNum + smallExt;
		
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
		
		System.out.println(bList);
		System.out.println(aList);
		System.out.println(uList);
		
		
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
		System.out.println("나는: " + ((Member)req.getSession().getAttribute("loginUser")));
		String nickName = ((Member)req.getSession().getAttribute("loginUser")).getNickName();
		b.setUserId(nickName);
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
		String loginUser = m.getNickName();
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
		
		if(b !=null) {
			model.addAttribute("b", b);
			model.addAttribute("aList", aList);
			model.addAttribute("u", u);
			model.addAttribute("isLike", isLike);
			model.addAttribute("likeCount", likeCount);
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
	
	@RequestMapping("tipList.bo")
	public String tipList() {
		return "boardTipList";
	}
}
