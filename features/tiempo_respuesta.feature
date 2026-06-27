# Feature: Tiempo de respuesta del sistema
# Relacionado con: NF-01 — Requisito no funcional de rendimiento
# Épica: EP-02 — Gestión de monitoreo del estrés

Feature: Tiempo de respuesta del sistema
  Como usuario autenticado en StressTrack
  Quiero que las operaciones principales del sistema respondan en tiempos aceptables
  Para no interrumpir mi jornada laboral mientras uso la aplicación

  Background:
    Given el usuario se encuentra autenticado en la aplicación StressTrack
    And el sistema se encuentra en condiciones normales de carga

  Scenario: Tiempo de respuesta al confirmar evaluación diaria
    Given el trabajador ha completado las 5 preguntas de la evaluación diaria
    When el trabajador selecciona "Confirmar evaluación"
    Then el sistema calcula y muestra el resultado del índice de estrés en menos de 3 segundos
    And el indicador visual de color aparece en pantalla sin demoras perceptibles

  Scenario: Tiempo de respuesta al acceder al análisis de sentimientos
    Given el usuario tiene al menos una entrada registrada en el diario emocional del día actual
    When el usuario accede a la sección "Monitoreo" del panel principal
    Then el sistema muestra los resultados del análisis de sentimientos en menos de 5 segundos
    And las palabras clave detectadas se renderizan correctamente en la interfaz

  Scenario: Tiempo de respuesta al guardar una entrada del diario emocional
    Given el usuario ha escrito al menos 20 caracteres en el editor del diario emocional
    When el usuario selecciona el botón "Guardar entrada"
    Then el sistema almacena la entrada cifrada y confirma el guardado en menos de 3 segundos
    And dispara el procesamiento asíncrono del análisis de sentimientos sin bloquear la interfaz

  Scenario: Tiempo de envío de notificación push de alerta
    Given el motor de alertas detecta que el índice de estrés del trabajador ha superado el umbral configurado
    When el motor procesa los datos de monitoreo en tiempo real
    Then la notificación push llega al dispositivo del trabajador en menos de 10 segundos desde la detección
