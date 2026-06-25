package H1;

import java.io.File;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtility {

	private static final String FROM_EMAIL =
	        System.getenv("MAIL_USERNAME");

	private static final String APP_PASSWORD =
	        System.getenv("MAIL_PASSWORD"); // Apna Gmail App Password

    private static Session getMailSession() {

        Properties props = new Properties();

        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        return Session.getInstance(
                props,
                new Authenticator() {

                    protected PasswordAuthentication
                    getPasswordAuthentication() {

                        return new PasswordAuthentication(
                                FROM_EMAIL,
                                APP_PASSWORD
                        );
                    }
                });
    }

    // ==========================
    // OTP EMAIL
    // ==========================

    public static boolean sendOTP(
            String toEmail,
            String otp) {

        try {

            Session session =
                    getMailSession();

            Message message =
                    new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(FROM_EMAIL));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject(
                    "Aarogya Global Hospital - Email Verification OTP");

            String html =

                    "<div style='font-family:Arial;padding:20px'>" +

                    "<h2 style='color:#0d6efd'>Aarogya Global Hospital</h2>" +

                    "<p>Your OTP is:</p>" +

                    "<h1 style='color:green'>" +
                    otp +
                    "</h1>" +

                    "<p>This OTP expires in 5 minutes.</p>" +

                    "</div>";

            message.setContent(
                    html,
                    "text/html");

            Transport.send(message);

            return true;

        } catch (Exception e) {

            System.out.println("========== EMAIL ERROR ==========");

            e.printStackTrace();

            System.out.println(e.getMessage());

            return false;
        
        }
    }

    // ==========================
    // SIMPLE NOTIFICATION EMAIL
    // ==========================

    public static boolean sendNotificationEmail(
            String toEmail,
            String subject,
            String body) {

        try {

            Session session =
                    getMailSession();

            Message message =
                    new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(FROM_EMAIL));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject(subject);

            String html =

                    "<div style='font-family:Arial;padding:20px'>" +

                    "<h2 style='color:#0d6efd'>Aarogya Global Hospital</h2>" +

                    "<p>" +
                    body +
                    "</p>" +

                    "<hr>" +

                    "<small>This is an automated email.</small>" +

                    "</div>";

            message.setContent(
                    html,
                    "text/html");

            Transport.send(message);

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    // ==========================
    // APPOINTMENT EMAIL
    // ==========================

    public static boolean sendAppointmentEmail(
            String email,
            String patientName,
            String status) {

        String subject =
                "Appointment " + status;

        String body =

                "Dear " + patientName +

                ",<br><br>Your appointment has been <b>" +

                status +

                "</b> successfully.";

        return sendNotificationEmail(
                email,
                subject,
                body);
    }

    // ==========================
    // BILL EMAIL
    // ==========================

    public static boolean sendBillEmail(
            String email,
            String patientName,
            double amount) {

        String subject =
                "Hospital Bill Generated";

        String body =

                "Dear " +
                patientName +

                ",<br><br>Your bill has been generated." +

                "<br><br><b>Total Amount : ₹" +
                amount +
                "</b>";

        return sendNotificationEmail(
                email,
                subject,
                body);
    }

    // ==========================
    // LAB REPORT EMAIL
    // ==========================

    public static boolean sendLabReportEmail(
            String email,
            String patientName) {

        String subject =
                "Lab Report Ready";

        String body =

                "Dear " +
                patientName +

                ",<br><br>Your lab report is ready." +

                "<br>Please login and view your report.";

        return sendNotificationEmail(
                email,
                subject,
                body);
    }

    // ==========================
    // PDF ATTACHMENT EMAIL
    // ==========================

    public static boolean sendPdfEmail(

            String toEmail,
            String patientName,

            String subject,

            String messageText,

            String pdfPath

    ) {

        try {

            Session session =
                    getMailSession();

            MimeMessage message =
                    new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(FROM_EMAIL));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject(subject);

            // BODY PART

            MimeBodyPart textPart =
                    new MimeBodyPart();

            textPart.setContent(

                    "<h3>Hello " +
                    patientName +
                    "</h3>" +

                    "<p>" +
                    messageText +
                    "</p>",

                    "text/html"

            );

            // PDF PART

            MimeBodyPart pdfPart =
                    new MimeBodyPart();

            File file =
                    new File(pdfPath);

            FileDataSource source =
                    new FileDataSource(file);

            pdfPart.setDataHandler(
                    new DataHandler(source));

            pdfPart.setFileName(
                    file.getName());

            Multipart multipart =
                    new MimeMultipart();

            multipart.addBodyPart(textPart);
            multipart.addBodyPart(pdfPart);

            message.setContent(multipart);

            Transport.send(message);

            return true;

        }
        catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}