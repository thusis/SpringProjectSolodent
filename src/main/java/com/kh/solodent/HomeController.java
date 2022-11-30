package com.kh.solodent;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.solodent.board.model.service.BoardService;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.Used;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * 
	 */
	
	@Autowired
	private BoardService bService;
	
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		ArrayList<Board> AllBoardList = bService.selectUsedList(2);
		ArrayList<Board> LatestUsedBoardList = new ArrayList<Board>();
		ArrayList<Used> usedList = new ArrayList<>();
		for(int i=0 ; i < 4 ; i++) {
			LatestUsedBoardList.add(AllBoardList.get(i));
			usedList.add(bService.selectUsed(LatestUsedBoardList.get(i).getBoardId()));
		}
		
		AllBoardList.clear();
		
		ArrayList<Attachment> usedAttmList = new ArrayList<Attachment>();
		for(int i=0 ; i<LatestUsedBoardList.size() ; i++) {
			usedAttmList.add(bService.mainPageUsedList(LatestUsedBoardList.get(i).getBoardId()));
		}
		
		model.addAttribute("LatestUsedBoardList", LatestUsedBoardList);
		model.addAttribute("usedList", usedList);
		model.addAttribute("usedAttmList", usedAttmList);
		
		
		return "home/home";
	}
	
}
