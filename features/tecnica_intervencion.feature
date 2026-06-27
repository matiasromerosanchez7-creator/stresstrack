# Feature: Activación de técnica de intervención desde la alerta
# Relacionado con: HU-09 — Activar técnica de intervención desde la alerta
# Épica: EP-03 — Gestión de alertas tempranas

Feature: Activación de técnica de intervención desde la alerta
  Como trabajador que ha recibido una alerta de estrés en StressTrack
  Quiero activar una técnica de intervención inmediata de 2 minutos directamente desde la notificación
  Para reducir mi estrés elevado sin necesidad de abrir la aplicación completa

  Scenario: Técnica de respiración iniciada desde la notificación
    Given el trabajador ha recibido una notificación push de alerta de estrés en su smartphone
    And la notificación sigue activa y visible en el panel de notificaciones del dispositivo
    When el trabajador selecciona el botón de acción rápida "Iniciar técnica de respiración" desde la notificación
    Then el sistema abre el módulo de respiración guiada de 2 minutos en modo pantalla completa sin necesidad de autenticación adicional
    And el sistema registra automáticamente el inicio de la intervención en el historial de bienestar del usuario con marca de tiempo

  Scenario: Técnica completada y evaluación del resultado
    Given el trabajador ha ejecutado el módulo de respiración guiada de 2 minutos en la aplicación
    And el temporizador del módulo de intervención ha llegado a cero indicando el fin del ejercicio
    When el módulo finaliza y muestra la pantalla de cierre
    Then el sistema presenta al trabajador la pregunta "¿Cómo te sientes ahora?" con las opciones "Mejor", "Igual" o "Peor"
    And el sistema registra la respuesta seleccionada junto al evento de intervención en el historial de bienestar del usuario para análisis futuros

  Scenario: Módulo de respiración ejecutado con las fases correctas
    Given el trabajador inicia el módulo de respiración guiada desde la notificación push
    When el módulo comienza su ejecución
    Then el sistema muestra la animación de expansión y contracción con las fases de respiración
    And la fase de inhalación dura 4 segundos
    And la fase de mantenimiento dura 4 segundos
    And la fase de exhalación dura 6 segundos
    And el temporizador visual de 120 segundos se sincroniza con las fases mostradas
