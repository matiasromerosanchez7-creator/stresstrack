# Feature: Compatibilidad con dispositivos y sistemas operativos
# Relacionado con: NF-04 — Requisito no funcional de compatibilidad
# Épica: EP-01 — Gestión de registro y perfil de usuario

Feature: Compatibilidad con dispositivos y sistemas operativos
  Como trabajador mayor de 18 años
  Quiero que la aplicación StressTrack funcione correctamente en mi dispositivo móvil
  Para acceder al monitoreo de estrés independientemente del sistema operativo que use

  Scenario: Registro exitoso desde dispositivo Android
    Given el trabajador utiliza un smartphone con sistema operativo Android
    When el trabajador accede al formulario de registro de cuenta en la aplicación
    Then el sistema muestra correctamente todos los campos del formulario adaptados al tamaño de pantalla Android
    And el proceso de registro se completa exitosamente sin errores de compatibilidad

  Scenario: Registro exitoso desde dispositivo iOS
    Given el trabajador utiliza un smartphone con sistema operativo iOS
    When el trabajador accede al formulario de registro de cuenta en la aplicación
    Then el sistema muestra correctamente todos los campos del formulario adaptados al tamaño de pantalla iOS
    And el proceso de registro se completa exitosamente sin errores de compatibilidad

  Scenario: Sincronización de datos de sueño desde Apple Health en iOS
    Given el usuario tiene un dispositivo iOS con Apple Health configurado
    And el usuario autoriza el acceso de lectura a los datos de sueño desde la configuración de StressTrack
    When el usuario accede a la sección "Correlación sueño-estrés"
    Then el sistema extrae correctamente los datos de horas de sueño de los últimos 7 días desde HealthKit
    And los datos se muestran correctamente en la gráfica de correlación

  Scenario: Sincronización de datos de sueño desde Google Fit en Android
    Given el usuario tiene un dispositivo Android con Google Fit configurado
    And el usuario autoriza el acceso de lectura a los datos de sueño desde la configuración de StressTrack
    When el usuario accede a la sección "Correlación sueño-estrés"
    Then el sistema extrae correctamente los datos de horas de sueño de los últimos 7 días desde Google Fit
    And los datos se muestran correctamente en la gráfica de correlación

  Scenario: Notificaciones push recibidas correctamente en Android mediante Firebase Cloud Messaging
    Given el usuario tiene un dispositivo Android con StressTrack instalado
    And el sistema detecta un índice de estrés elevado para el usuario
    When el motor de alertas envía la notificación push a través de Firebase Cloud Messaging
    Then la notificación aparece en el panel de notificaciones del dispositivo Android
    And el botón de acción rápida "Iniciar técnica de respiración" es visible y funcional

  Scenario: Notificaciones push recibidas correctamente en iOS mediante APNs
    Given el usuario tiene un dispositivo iOS con StressTrack instalado
    And el sistema detecta un índice de estrés elevado para el usuario
    When el motor de alertas envía la notificación push a través de APNs
    Then la notificación aparece en el panel de notificaciones del dispositivo iOS
    And el botón de acción rápida "Iniciar técnica de respiración" es visible y funcional
