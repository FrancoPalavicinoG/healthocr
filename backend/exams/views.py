from rest_framework import generics, status
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from .serializers import ExamSerializer
from .services import create_exam_with_ocr
from .models import Exam

# Esta vista maneja la creación de nuevos Exámenes (Exam) desde un endpoint REST.
class ExamCreateView(generics.CreateAPIView):
    queryset = Exam.objects.all() # Conjunto base de objetos sobre los que opera la vista
    serializer_class = ExamSerializer # Validar y formatear la entrada/salida
    parser_classes = [MultiPartParser, FormParser] # Archivos binarios y formularios 

    def perform_create(self, serializer):
        image = self.request.FILES.get("image")
        exam = create_exam_with_ocr(image)
        serializer = ExamSerializer(exam, context={"request": self.request})
        self._response = Response(serializer.data, status=status.HTTP_201_CREATED)

    def create(self, request, *args, **kwargs):
        super().create(request, *args, **kwargs)
        return self._response
    
class ExamDetailView(generics.RetrieveAPIView):
    queryset = Exam.objects.all()
    serializer_class = ExamSerializer