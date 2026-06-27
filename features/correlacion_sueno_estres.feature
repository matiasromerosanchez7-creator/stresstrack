# Feature: Visualización de correlación entre sueño y estrés
# Relacionado con: HU-06 — Visualizar correlación entre sueño y estrés
# Épica: EP-02 — Gestión de monitoreo del estrés

Feature: Visualización de correlación entre sueño y estrés
  Como usuario autenticado en StressTrack
  Quiero visualizar la correlación entre mis hábitos de sueño y niveles de estrés
  Para identificar cómo el descanso impacta en mi bienestar emocional diario

  Background:
    Given el usuario se encuentra autenticado en la aplicación StressTrack

  Scenario: Gráfica de correlación disponible con datos sincronizados
    Given el usuario tiene datos de horas de sueño sincronizados desde Apple Health o Google Fit
    And los datos de sueño cubren al menos los últimos 7 días consecutivos
    When el usuario accede a la sección "Correlación sueño-estrés" en el módulo de reportes
    Then el sistema genera una gráfica de línea doble con horas de sueño y nivel de estrés por día
    And resalta con marcador rojo los días donde las horas de sueño fueron menores a 6 y el índice de estrés fue mayor o igual a 60

  Scenario: Sin fuente de datos de sueño vinculada al perfil
    Given el usuario no ha autorizado el acceso a Apple Health ni a Google Fit
    And no tiene ningún wearable sincronizado en su perfil de StressTrack
    When el usuario accede a la sección "Correlación sueño-estrés"
    Then el sistema muestra el mensaje "No hay datos de sueño disponibles. Conecta tu app de salud para ver este análisis."
    And muestra el botón "Conectar dispositivo" que redirige a la configuración de integración con wearables

  Scenario Outline: Marcado correcto de días críticos según datos de sueño y estrés
    Given el usuario tiene los siguientes datos registrados
    When el sistema genera la gráfica de correlación
    Then el día debe marcarse como crítico o no según la condición

    Examples:
      | Dia        | Horas_sueno | Indice_estres | Marcado_critico |
      | Lunes      | 5           | 75            | Si              |
      | Martes     | 7           | 45            | No              |
      | Miercoles  | 4           | 85            | Si              |
      | Jueves     | 8           | 30            | No              |
      | Viernes    | 6           | 65            | No              |
