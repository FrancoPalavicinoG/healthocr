# backend/exams/ocr_utils.py

def extract_text_from_image(image_path: str) -> str:
    """
    Función dummy para OCR.
    Por ahora solo retorna un texto fijo, luego puedes reemplazarlo con pytesseract o similar.
    """
    return "Texto OCR simulado desde: " + image_path