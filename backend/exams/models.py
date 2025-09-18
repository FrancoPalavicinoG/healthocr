from django.db import models

class Exam(models.Model):
    """
    Modelo que representa una imagen de examen subida y el texto OCR resultante.
    Cada atributo se mapea a una columna en la tabla 'exams_exam' en Postgres.
    """
    image = models.ImageField(upload_to="exams/")   # Se guarda en media/exams/
    result_text = models.TextField(blank=True, null=True)  
    created_at = models.DateTimeField(auto_now_add=True)  

    class Meta:
        ordering = ["-created_at"] 

    def __str__(self) -> str:
        return f"Exam {self.id} - {self.created_at.isoformat()}"
    
class ExamResult(models.Model):
    """
    Cada fila de esta tabla representa un valor individual de un examen.
    Ejemplo: Glucosa 90 mg/dL
    """
    exam = models.ForeignKey(
        Exam,
        on_delete=models.CASCADE, 
        related_name="results"      # Permite acceder con exam.results.all()
    )
    test_name = models.CharField(max_length=255) 
    value = models.FloatField(null=True, blank=True)
    unit = models.CharField(max_length=50, null=True, blank=True)
    reference_range = models.CharField(max_length=100, null=True, blank=True)
    method = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.test_name}: {self.value} {self.unit}"