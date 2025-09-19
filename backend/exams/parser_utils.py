def parse_exam(text: str) -> list[dict]:
    """
    Parser de informes de laboratorio.
    Extrae valores de tests específicos (ej: Glucosa, Colesterol Total).
    """
    # Quitamos lineas vacias 
    lines = []
    for l in text.splitlines():
        l = l.strip()
        if l:
            lines.append(l)
    
    # Index de datos por encabezado
    try:
        idx_result = lines.index("Resultado")
        idx_unit = lines.index("Unidad")
        idx_ref = lines.index("V. Referencia")
        idx_method = lines.index("Método")
    except ValueError:
        # Vacio sino
        return []

    # Bloques de datos
    test_names = lines[:idx_result]  # todo lo que aparece antes de "Resultado"
    results = lines[idx_result + 1 : idx_unit]
    units = lines[idx_unit + 1 : idx_ref]
    references = lines[idx_ref + 1 :idx_method]
    methods = lines[idx_method + 1 :]

    parsed_test = []
    for i, name in enumerate(test_names):
        if i < len(results) and i < len(units) and i < len(references):
            test = {
                "test_name": name,
                "result": safe_float(results[i]),
                "unit": units[i].replace(".", ""),
                "reference_range": references[i],
                "method": methods[i],
            }
            parsed_test.append(test)

    filtered = []
    for t in parsed_test:
        if t["test_name"].lower() in ["nitrógeno ureico"]:
            filtered.append(t)
    return filtered

def safe_float(s: str) -> float | None:
    """Convierte a float si puede, si no devuelve None."""
    try:
        return float(s.replace(",", "."))
    except ValueError:
        return None