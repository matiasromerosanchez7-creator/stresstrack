# Feature: Disponibilidad de la plataforma StressTrack
# Relacionado con: NF-03 — Requisito no funcional de disponibilidad
# Épica: EP-02 — Gestión de monitoreo del estrés

Feature: Disponibilidad de la plataforma StressTrack
  Como usuario de StressTrack
  Quiero que la plataforma esté disponible de forma continua durante mi jornada laboral
  Para poder registrar mis evaluaciones y acceder al monitoreo de estrés en cualquier momento

  Background:
    Given el usuario tiene la aplicación StressTrack instalada en su dispositivo móvil

  Scenario: Acceso exitoso a la aplicación durante horario laboral estándar
    Given el usuario se encuentra dentro de su horario laboral configurado en el perfil
    When el usuario abre la aplicación StressTrack en su smartphone
    Then el sistema carga el panel principal en menos de 5 segundos
    And todas las funcionalidades de monitoreo se encuentran disponibles para el usuario

  Scenario: Recuperación de datos al restaurar conexión a internet
    Given el usuario tenía conexión a internet activa y la perdió temporalmente
    And el usuario intentó registrar una evaluación diaria durante la desconexión
    When la conexión a internet del usuario se restaura
    Then el sistema sincroniza los datos pendientes con el servidor de forma automática
    And muestra una confirmación de sincronización exitosa al usuario

  Scenario: Mensaje informativo ante falla temporal del servicio
    Given el servidor de StressTrack experimenta una interrupción temporal del servicio
    When el usuario intenta acceder a cualquier funcionalidad de la aplicación
    Then el sistema muestra el mensaje informativo "El servicio no está disponible en este momento. Intenta nuevamente en unos minutos."
    And conserva los datos locales del usuario sin pérdida de información

  Scenario: Funcionamiento del módulo de respiración sin conexión
    Given el usuario no tiene conexión a internet activa en su dispositivo
    When el usuario accede al módulo de respiración guiada desde la aplicación
    Then el sistema ejecuta el módulo de respiración de 2 minutos sin requerir conexión a internet
    And almacena el registro de la intervención localmente para sincronizarlo cuando se restaure la conexión
