package com.kh.solodent.board.controller;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.solodent.board.common.Pagination;
import com.kh.solodent.board.model.exception.BoardException;
import com.kh.solodent.board.model.service.MoimService;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.member.model.vo.Member;

@Controller
public class MoimController {
	

	@Autowired
	private MoimService mService;

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
		System.out.println("모임 listcount :" + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 6);
		System.out.println("pi:"+pi);
		ArrayList<Moim> list = mService.selectMoimList(pi);
		System.out.println(list);
		ArrayList<Attachment> attmlist = mService.selectMoimAttm(list);
		System.out.println(attmlist);
		
		if(list !=null) {
			model.addAttribute("pi",pi);
			model.addAttribute("list",list);
			model.addAttribute("attmlist", attmlist);
			
			return "moimhome";
		} else {
			throw new BoardException("모임게시글 조회 실패");
		}
	}
	
	@RequestMapping("write.moim")
	public String writeMoim() {
		return "moimwrite";
	}
	
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
		System.out.println("insertBoard.moim에서 지역명: " + moim.getLocal());
		
		/*attachment*/
		
		System.out.println(attachments);
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
		
		System.out.println("insertBoard.moim에서 모임: " + moim);
		
		int result = mService.insertMoim(moim,list);
		if(result>0) {
			return "redirect:list.moim";
		} else {
			throw new BoardException("모임게시글 작성 실패");
		}
	}
	
	/**
	 * 이하 saveFile 스프링 수업 시간 내용과 아예 동일
	 * @param file
	 * @param request
	 * @return
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
		
		System.out.println("original"+rawname);
		System.out.println("rename"+rename);
		System.out.println("fileRoute"+fileRoute);

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
		
		System.out.println(moim);
		System.out.println(list);
		
		if(moim!=null) {
			mv.addObject("moim",moim).addObject("page",page).addObject("list",list).setViewName("moimdetail");
		} else {
			throw new BoardException("모임 게시글 상세보기 실패");
		}
		
		return mv;
	}
	
	@RequestMapping("updateMoim.moim")
	public String updateMoim(@RequestParam("boardId") int bId, 
			@RequestParam("page") int page,
			Model model	) {
		Moim moim = mService.selectMoim(bId, false);
		model.addAttribute("moim",moim);
		model.addAttribute("page",page);
		return "edit";
	}

	
}
