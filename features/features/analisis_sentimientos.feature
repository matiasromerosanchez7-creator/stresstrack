# Feature: Análisis de sentimientos del diario emocional
# Relacionado con: HU-05 — Consultar análisis de sentimientos del diario emocional
# Épica: EP-02 — Gestión de monitoreo del estrés

Feature: Análisis de sentimientos del diario emocional
  Como trabajador autenticado en StressTrack
  Quiero consultar el análisis de sentimientos de mis entradas del diario
  Para detectar patrones de estrés antes de que alcancen un nivel crítico

  Background:
    Given el usuario se encuentra autenticado en la aplicación StressTrack

  Scenario: Análisis de sentimientos disponible con entrada registrada
    Given el usuario tiene al menos una entrada de texto de mínimo 20 caracteres registrada en el diario emocional del día actual
    When el usuario accede a la sección "Monitoreo" del panel principal
    Then el sistema muestra la categoría emocional predominante de la entrada
    And muestra las palabras clave detectadas en el texto
    And muestra el nivel de estrés inferido según la categoría emocional detectada

  Scenario: Sin entradas en el diario emocional del día
    Given el usuario no ha registrado ninguna entrada en el diario emocional durante el día actual
    When el usuario accede a la sección "Monitoreo" del panel principal
    Then el sistema muestra el mensaje "Aún no hay entradas del diario para analizar hoy."
    And muestra el botón "Escribir en mi diario" que redirige a la sección de registro de entradas emocionales

  Scenario: Generación de alerta automática por entradas negativas consecutivas
    Given el usuario ha registrado 3 entradas consecutivas en el diario emocional
    And las 3 entradas han sido clasificadas con categoría emocional negativa
    When el sistema procesa el análisis de la tercera entrada negativa consecutiva
    Then el sistema genera automáticamente una alerta de estrés elevado
    And envía una notificación push al dispositivo del usuario indicando el patrón detectado
