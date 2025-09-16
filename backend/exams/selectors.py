from typing import Iterable
from .models import Exam

def list_exams(limit: int = 100) -> Iterable[Exam]:
    """Devuelve los últimos exámenes (ordenados por created_at)."""
    return Exam.objects.all()[:limit]

def get_exam_by_id(exam_id: int) -> Exam | None:
    """Devuelve un examen o None."""
    try:
        return Exam.objects.get(pk=exam_id)
    except Exam.DoesNotExist:
        return None