from django.db import models

class Exam(models.Model):
    """
    Modelo que representa una imagen de examen subida y el texto OCR resultante.
    Cada atributo se mapea a una columna en la tabla 'exams_exam' en Postgres.
    """
    image = models.ImageField(upload_to="exams/")   #se guarda en media/exams/
    result_text = models.TextField(blank=True, null=True)  
    created_at = models.DateTimeField(auto_now_add=True)  

    class Meta:
        ordering = ["-created_at"] 

    def __str__(self) -> str:
        return f"Exam {self.id} - {self.created_at.isoformat()}"