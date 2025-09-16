from .models import Exam
from .ocr_utils import extract_text_from_image

def create_exam_with_ocr(image_file, save_path=None) -> Exam:
    """
    Guarda el objeto Exam y ejecuta OCR para completar result_text.
    """
    exam = Exam.objects.create(image=image_file) # Insert en Postgres y guarda el archivo físico en MEDIA_ROOT.
    text = extract_text_from_image(exam.image.path) # Usamos el OCR para extraer texto desde la imagen.
    exam.result_text = text # Guardamos el resultado del OCR en el campo "result_text" del objeto exam.
    exam.save() # Update en Postgres
    return exam