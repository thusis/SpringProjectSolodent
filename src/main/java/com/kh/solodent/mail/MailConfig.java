package com.kh.solodent.mail;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {
	
		@Bean
		public JavaMailSender JavaMailService() {
			JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
			
			javaMailSender.setHost("smtp.naver.com");// 도매인
			javaMailSender.setUsername("rlwo5454");//네이버 아이디
			javaMailSender.setPassword("Junegemini11.");//네이버 비밀번호
			
			javaMailSender.setPort(465); // 서버 포트
			
			javaMailSender.setJavaMailProperties(getMailProperties());
			
			return javaMailSender;
		}
		private Properties getMailProperties() {
			Properties properties = new Properties();
			properties.setProperty("mail.transport.protocol", "smtp");//프로트콜설정
			properties.setProperty("mail.smpt.auth", "true");//smtp인증
			properties.setProperty("mail.smtp.starttls.enable", "true");//
			properties.setProperty("mail.debug", "true");//디버그사용
			properties.setProperty("mail.smtp.ssl.trust","smtp.naver.com");//ssl인증
			properties.setProperty("mail.smtp.ssl.enable","true");//ssl사용
			return properties;
		}

}
