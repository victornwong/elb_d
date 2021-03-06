import java.io.*;
import java.util.*;
import java.text.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import groovy.sql.Sql;
import org.zkoss.zk.ui.*;

/*
Title: Email shortcut functions based on javax.mail
Written by : Victor Wong
Date : 4/8/2010

Design notes:
*/

// Simple email sendout func - no attachments
// return 0 = sent, else not
int simpleSendEmail(String ismtpserver, String ifrom, String ito, String isubj, String imessage)
{
	retval = 0;

	Properties props = new Properties();
	props.put("mail.smtp.host", ismtpserver);
	props.put("mail.from", ifrom);
	javax.mail.Session mailsession = javax.mail.Session.getInstance(props, null);

	try
	{
        MimeMessage msg = new MimeMessage(mailsession);
        msg.setFrom();
        msg.setRecipients(Message.RecipientType.TO,ito);
		msg.setSubject(isubj);
		msg.setSentDate(new Date());

		// create and fill the first message part
		MimeBodyPart mbp1 = new MimeBodyPart();
		mbp1.setText(imessage);

		// create the Multipart and add its parts to it - check in purchasereq_driller.zul, can attach file too!!
		Multipart mp = new MimeMultipart();
		mp.addBodyPart(mbp1);

		// add the Multipart to the message
		msg.setContent(mp);

		Transport.send(msg);

	} catch (MessagingException mex)
	{
		retval = 1;
		//System.out.println("send failed, exception: " + mex);
	}
	
	return retval;
}
