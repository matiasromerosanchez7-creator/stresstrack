# Feature: Notificación de alerta de estrés al usuario
# Relacionado con: HU-07 — Recibir notificación de alerta de estrés
# Épica: EP-03 — Gestión de alertas tempranas

Feature: Notificación de alerta de estrés al usuario
  Como trabajador con alertas activadas en StressTrack
  Quiero recibir una notificación cuando mi nivel de estrés supere el umbral configurado
  Para tomar acciones preventivas antes de alcanzar un estado de estrés severo

  Background:
    Given el trabajador tiene las notificaciones push de StressTrack activadas en su smartphone
    And el umbral de alerta configurado en su perfil es índice mayor o igual a 60 por defecto

  Scenario: Alerta enviada correctamente fuera de franja de silencio
    Given el sistema detecta que el índice de estrés del trabajador ha alcanzado 72 puntos
    And el trabajador no se encuentra dentro de ninguna franja horaria de silencio configurada
    When el motor de alertas procesa los datos de monitoreo en tiempo real
    Then el sistema envía una notificación push al dispositivo con el mensaje "Tu nivel de estrés es elevado. Te sugerimos tomar un descanso."
    And la notificación incluye el botón de acción rápida "Iniciar técnica de respiración"

  Scenario: Alerta retenida por franja de silencio activa con nivel moderado
    Given el sistema detecta que el índice de estrés del trabajador ha alcanzado 65 puntos
    And el trabajador se encuentra dentro de la franja horaria de silencio configurada entre las 09:00 y las 11:00
    When el motor de alertas procesa los datos de monitoreo en tiempo real
    Then el sistema retiene la notificación y la encola para enviarla al finalizar la franja de silencio configurada

  Scenario: Alerta urgente enviada inmediatamente aunque haya franja de silencio activa
    Given el sistema detecta que el índice de estrés del trabajador ha alcanzado 88 puntos
    And el trabajador se encuentra dentro de una franja horaria de silencio configurada
    When el motor de alertas procesa los datos de monitoreo en tiempo real
    Then el sistema ignora la franja de silencio y envía la notificación de forma inmediata
    And la notificación incluye la etiqueta "Urgente" indicando la criticidad del nivel detectado
