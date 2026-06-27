# Feature: Configuración de preferencias de alertas
# Relacionado con: HU-08 — Configurar preferencias de alertas
# Épica: EP-03 — Gestión de alertas tempranas

Feature: Configuración de preferencias de alertas
  Como usuario autenticado en StressTrack
  Quiero configurar el horario y la frecuencia en que recibo alertas de bienestar
  Para evitar interrupciones durante reuniones o momentos de alta concentración en mi jornada

  Background:
    Given el usuario autenticado accede a la sección "Configuración de alertas" desde el menú de ajustes de la aplicación

  Scenario: Configuración de alertas guardada exitosamente
    Given el usuario define una franja horaria de silencio con hora de inicio y hora de fin válidas
    And el usuario selecciona la frecuencia de alertas deseada entre las opciones: tiempo real, cada 2 horas, o solo alertas críticas
    When el usuario selecciona "Guardar configuración"
    Then el sistema persiste las preferencias de alerta del usuario en su perfil
    And las aplica de forma inmediata a las siguientes alertas generadas por el motor de monitoreo
    And muestra el resumen de configuración activa con la franja de silencio y la frecuencia seleccionada

  Scenario: Activación del modo No molestar desde pantalla principal
    Given el usuario autenticado se encuentra en la pantalla principal de la aplicación StressTrack
    And el usuario necesita suspender todas las alertas no críticas de forma inmediata
    When el usuario activa el interruptor "No molestar" visible en la pantalla principal
    Then el sistema suspende de forma inmediata el envío de todas las notificaciones push de nivel moderado y elevado
    And muestra en la pantalla principal el ícono de "No molestar" activo con la etiqueta "Alertas pausadas"
