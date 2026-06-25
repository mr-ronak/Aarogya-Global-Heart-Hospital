package H1;

import java.io.File;
import java.io.FileOutputStream;

import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class PdfEmailUtility {

// ==========================
// LAB REPORT PDF
// ==========================

public static String generateLabReportPdf(

        String projectPath,

        int patientId,
        String patientName,

        double hemoglobin,
        double rbc,
        double wbc,
        double platelets,

        double bloodSugar,
        double cholesterol,
        double heartRate,

        String bp

) {

    String filePath = null;

    try {

        String folderPath =
                projectPath + File.separator +
                "generated_reports";

        File folder =
                new File(folderPath);

        if (!folder.exists()) {

            folder.mkdirs();
        }

        filePath =
                folderPath +
                File.separator +
                "LabReport_" +
                patientId +
                ".pdf";

        Document document =
                new Document(PageSize.A4);

        PdfWriter.getInstance(
                document,
                new FileOutputStream(filePath)
        );

        document.open();

        Font titleFont =
                new Font(
                        Font.FontFamily.HELVETICA,
                        20,
                        Font.BOLD
                );

        Font normalFont =
                new Font(
                        Font.FontFamily.HELVETICA,
                        12,
                        Font.NORMAL
                );

        document.add(
                new Paragraph(
                        "Aarogya Global Hospital",
                        titleFont
                )
        );

        document.add(new Paragraph(" "));
        document.add(
                new Paragraph(
                        "Laboratory Report",
                        titleFont
                )
        );

        document.add(new Paragraph(" "));
        document.add(
                new Paragraph(
                        "Patient ID : " + patientId,
                        normalFont
                )
        );

        document.add(
                new Paragraph(
                        "Patient Name : " + patientName,
                        normalFont
                )
        );

        document.add(new Paragraph(" "));

        PdfPTable table =
                new PdfPTable(3);

        table.setWidthPercentage(100);

        table.addCell("Test");
        table.addCell("Result");
        table.addCell("Normal Range");

        table.addCell("Hemoglobin");
        table.addCell(String.valueOf(hemoglobin));
        table.addCell("13 - 17");

        table.addCell("RBC");
        table.addCell(String.valueOf(rbc));
        table.addCell("4.5 - 5.9");

        table.addCell("WBC");
        table.addCell(String.valueOf(wbc));
        table.addCell("4000 - 11000");

        table.addCell("Platelets");
        table.addCell(String.valueOf(platelets));
        table.addCell("150000 - 450000");

        table.addCell("Blood Sugar");
        table.addCell(String.valueOf(bloodSugar));
        table.addCell("70 - 100");

        table.addCell("Cholesterol");
        table.addCell(String.valueOf(cholesterol));
        table.addCell("Less than 200");

        table.addCell("Heart Rate");
        table.addCell(String.valueOf(heartRate));
        table.addCell("60 - 100");

        table.addCell("Blood Pressure");
        table.addCell(bp);
        table.addCell("120/80");

        document.add(table);

        document.add(new Paragraph(" "));
        document.add(
                new Paragraph(
                        "Doctor Signature ___________________"
                )
        );

        document.close();

        return filePath;

    } catch (Exception e) {

        e.printStackTrace();
        return null;
    }
}

// ==========================
// BILL PDF
// ==========================

public static String generateBillPdf(

        String projectPath,

        int billId,

        String patientName,

        String doctorName,

        double baseAmount,

        double gstAmount,

        double totalAmount

) {

    String filePath = null;

    try {

        String folderPath =
                projectPath +
                File.separator +
                "generated_bills";

        File folder =
                new File(folderPath);

        if (!folder.exists()) {

            folder.mkdirs();
        }

        filePath =
                folderPath +
                File.separator +
                "Bill_" +
                billId +
                ".pdf";

        Document document =
                new Document(PageSize.A4);

        PdfWriter.getInstance(
                document,
                new FileOutputStream(filePath)
        );

        document.open();

        Font titleFont =
                new Font(
                        Font.FontFamily.HELVETICA,
                        20,
                        Font.BOLD
                );

        Font normalFont =
                new Font(
                        Font.FontFamily.HELVETICA,
                        12,
                        Font.NORMAL
                );

        document.add(
                new Paragraph(
                        "Aarogya Global Hospital",
                        titleFont
                )
        );

        document.add(new Paragraph(" "));
        document.add(
                new Paragraph(
                        "Hospital Bill",
                        titleFont
                )
        );

        document.add(new Paragraph(" "));
        document.add(
                new Paragraph(
                        "Bill ID : " + billId,
                        normalFont
                )
        );

        document.add(
                new Paragraph(
                        "Patient : " + patientName,
                        normalFont
                )
        );

        document.add(
                new Paragraph(
                        "Doctor : " + doctorName,
                        normalFont
                )
        );

        document.add(new Paragraph(" "));

        PdfPTable table =
                new PdfPTable(2);

        table.setWidthPercentage(100);

        table.addCell("Description");
        table.addCell("Amount");

        table.addCell("Consultation Fees");
        table.addCell("₹ " + baseAmount);

        table.addCell("GST");
        table.addCell("₹ " + gstAmount);

        table.addCell("Total Amount");
        table.addCell("₹ " + totalAmount);

        document.add(table);

        document.add(new Paragraph(" "));

        document.add(
                new Paragraph(
                        "Thank you for choosing Aarogya Global Hospital."
                )
        );

        document.close();

        return filePath;

    } catch (Exception e) {

        e.printStackTrace();
        return null;
    }
}


}
