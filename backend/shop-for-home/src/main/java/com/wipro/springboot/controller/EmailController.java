package com.wipro.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.wipro.springboot.entity.Email;
import com.wipro.springboot.service.impl.EmailServiceImpl;

@RestController
public class EmailController {

	@Autowired
	private EmailServiceImpl emailService;

	@PostMapping("/sendMail")
	public String sendMail(@RequestBody Email email) {
		String status = emailService.sendSimpleMail(email);

		return status;
	}

	@PostMapping("/sendMailWithAttachment")
	public String sendMailWithAttachment(@RequestBody Email email) {
		String status = emailService.sendMailWithAttachment(email);
		return status;
	}

}
