# Feature: Cifrado y seguridad de datos del usuario
# Relacionado con: NF-02 — Requisito no funcional de seguridad
# Épica: EP-04 — Gestión del diario emocional

Feature: Cifrado y seguridad de datos del usuario
  Como usuario de StressTrack
  Quiero que mis datos personales y entradas del diario estén protegidos con cifrado
  Para garantizar la privacidad e integridad de mi información emocional sensible

  Background:
    Given el usuario se encuentra autenticado en la aplicación StressTrack

  Scenario: Entrada del diario almacenada con cifrado AES-256
    Given el usuario ha escrito al menos 20 caracteres en el editor del diario emocional
    When el usuario selecciona el botón "Guardar entrada"
    Then el sistema cifra el contenido del texto con AES-256 antes de almacenarlo en la base de datos
    And registra el ID del usuario, fecha, hora local y contenido cifrado en la tabla diary_entries
    And ningún otro usuario puede acceder al contenido de la entrada cifrada

  Scenario: Descifrado seguro de entradas solo para el propietario
    Given el usuario propietario accede a la sección "Diario emocional"
    When el usuario solicita visualizar una entrada guardada previamente
    Then el sistema descifra el contenido únicamente para el usuario propietario autenticado
    And muestra el texto original sin exponer los datos cifrados en la interfaz

  Scenario: Acceso denegado a entradas de otro usuario
    Given existe un usuario autenticado con sesión activa en la aplicación
    When el usuario intenta acceder a una entrada del diario que pertenece a otro usuario
    Then el sistema retorna un error de autorización sin exponer ningún dato de la entrada ajena
    And registra el intento de acceso no autorizado en el log de seguridad del sistema

  Scenario: Contraseña almacenada con hash seguro al registrarse
    Given un trabajador completa el formulario de registro con sus datos personales
    When el sistema procesa la solicitud de registro
    Then el sistema hashea la contraseña con bcrypt antes de almacenarla en la base de datos
    And nunca almacena la contraseña en texto plano en ningún componente del sistema
