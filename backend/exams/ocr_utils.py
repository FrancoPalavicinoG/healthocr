import pytesseract
from PIL import Image

def extract_text_from_image(image_path: str) -> str:
    """
    Procesa la imagen con Tesseract OCR y devuelve el texto extraído.
    """
    try:
        text = pytesseract.image_to_string(Image.open(image_path), lang="spa")
        return text.strip()
    except Exception as e:
        return f"OCR error: {e}"