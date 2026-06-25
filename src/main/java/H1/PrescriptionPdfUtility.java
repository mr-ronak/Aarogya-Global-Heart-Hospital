package H1;

import java.io.ByteArrayOutputStream;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

public class PrescriptionPdfUtility {

    public static byte[] generatePrescriptionPdf(

            int prescriptionId,
            String patientName,
            String doctorName,
            String symptoms,
            String diagnosis,
            String medicines,
            String advice,
            String date

    ) {

        try {

            ByteArrayOutputStream baos =
                    new ByteArrayOutputStream();

            Document document =
                    new Document(PageSize.A4);

            PdfWriter.getInstance(
                    document,
                    baos);

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
                            12
                    );

            document.add(
                    new Paragraph(
                            "Aarogya Global Hospital",
                            titleFont
                    )
            );

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Prescription"));
            document.add(new Paragraph(" "));

            document.add(
                    new Paragraph(
                            "Prescription ID : " +
                            prescriptionId,
                            normalFont
                    )
            );

            document.add(
                    new Paragraph(
                            "Date : " +
                            date,
                            normalFont
                    )
            );

            document.add(
                    new Paragraph(
                            "Patient : " +
                            patientName,
                            normalFont
                    )
            );

            document.add(
                    new Paragraph(
                            "Doctor : " +
                            doctorName,
                            normalFont
                    )
            );

            document.add(new Paragraph(" "));

            PdfPTable table =
                    new PdfPTable(2);

            table.setWidthPercentage(100);

            table.addCell("Symptoms");
            table.addCell(symptoms);

            table.addCell("Diagnosis");
            table.addCell(diagnosis);

            table.addCell("Medicines");
            table.addCell(medicines);

            table.addCell("Advice");
            table.addCell(advice);

            document.add(table);

            document.add(new Paragraph(" "));
            document.add(new Paragraph(" "));
            document.add(
                    new Paragraph(
                            "Doctor Signature __________________"
                    )
            );

            document.close();

            return baos.toByteArray();

        } catch (Exception e) {

            e.printStackTrace();

            return null;
        }
    }
}