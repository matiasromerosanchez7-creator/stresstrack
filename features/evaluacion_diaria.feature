# Feature: Registro de evaluación diaria de estrés
# Relacionado con: HU-04 — Registrar evaluación diaria de estrés
# Épica: EP-02 — Gestión de monitoreo del estrés

Feature: Registro de evaluación diaria de estrés
  Como trabajador autenticado en StressTrack
  Quiero registrar mi evaluación diaria de estrés
  Para mantener un historial continuo de mi bienestar emocional

  Background:
    Given el trabajador se encuentra autenticado en la aplicación StressTrack

  Scenario: Evaluación diaria registrada correctamente
    Given el trabajador no ha completado ninguna evaluación el día actual
    When el trabajador responde las 5 preguntas de escala de bienestar del 1 al 5
    And selecciona el botón "Confirmar evaluación"
    Then el sistema calcula el índice de estrés como promedio ponderado de 0 a 100
    And almacena la evaluación con marca de tiempo en la tabla daily_evaluations
    And muestra el resultado con indicador visual de color según el nivel de estrés calculado

  Scenario: Intento de registrar segunda evaluación en el mismo día
    Given el trabajador ya completó su evaluación diaria el día actual
    When el trabajador intenta acceder a la pantalla de evaluación diaria
    Then el sistema muestra el mensaje "Ya registraste tu evaluación de hoy. Vuelve mañana."
    And muestra el resultado de la evaluación previamente completada con su indicador de nivel y hora de registro

  Scenario Outline: Cálculo correcto del nivel de estrés según respuestas
    Given el trabajador responde las preguntas con los valores indicados
    When el sistema calcula el índice de estrés promedio
    Then el nivel mostrado debe corresponder al rango calculado

    Examples:
      | Energía | Concentración | Irritabilidad | Tensión | Estado_animo | Indice_esperado | Nivel_esperado |
      | 1       | 1             | 5             | 5       | 2            | 86              | Elevado        |
      | 3       | 3             | 3             | 3       | 3            | 60              | Moderado       |
      | 5       | 5             | 1             | 1       | 5            | 14              | Bajo           |
