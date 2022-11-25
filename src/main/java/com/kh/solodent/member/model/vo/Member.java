package com.kh.solodent.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Member {
		private String id;
		private String name;
		private String pwd;
		private String nickName;
		private String email;
		private String phone;
		private String address;
		private String gender;
		private String birthDate;
		private String status;
		private String isManager;
		private Date enrollDate;
		private String rate;
}
