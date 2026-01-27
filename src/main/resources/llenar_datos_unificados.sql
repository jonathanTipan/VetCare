-- Script actualizado para la entidad unificada Consulta
-- Ejecutar en una base de datos limpia despues de que Hibernate cree las tablas

-- 1. USUARIOS
-- ADMINISTRADORES
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado, departamento)
VALUES ('Administrador', '1700000001', 'Juan', 'Admin', 'admin1', '1234', 'ACTIVO', 'Sistemas');
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado, departamento)
VALUES ('Administrador', '1700000002', 'Maria', 'Admin', 'admin2', '1234', 'ACTIVO', 'RRHH');
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado, departamento)
VALUES ('Administrador', '1700000003', 'Carlos', 'Admin', 'admin3', '1234', 'ACTIVO', 'Gerencia');

-- CLIENTES
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado)
VALUES ('Cliente', '1800000001', 'Pedro', 'Cliente', 'cliente1', '1234', 'ACTIVO');
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado)
VALUES ('Cliente', '1800000002', 'Lucia', 'Cliente', 'cliente2', '1234', 'ACTIVO');
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado)
VALUES ('Cliente', '1800000003', 'Miguel', 'Cliente', 'cliente3', '1234', 'ACTIVO');

-- VETERINARIOS
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado, especialidad, numeroLicencia, telefono)
VALUES ('Veterinario', '1900000001', 'Dra. Ana', 'Lopez', 'vet1', '1234', 'ACTIVO', 'Cirugia', 'LIC-001', '0990000001');
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado, especialidad, numeroLicencia, telefono)
VALUES ('Veterinario', '1900000002', 'Dr. Luis', 'Torres', 'vet2', '1234', 'ACTIVO', 'Medicina General', 'LIC-002', '0990000002');
INSERT INTO usuarios (DTYPE, cedula, nombre, apellido, usuario, clave, estado, especialidad, numeroLicencia, telefono)
VALUES ('Veterinario', '1900000003', 'Dra. Sofia', 'Ruiz', 'vet3', '1234', 'ACTIVO', 'Dermatologia', 'LIC-003', '0990000003');

-- 2. MASCOTAS
-- Cliente 1
INSERT INTO mascotas (cliente_cedula, nombre, especie, raza, fechaNacimiento, sexo, peso)
VALUES ('1800000001', 'Firulais', 'Perro', 'Mestizo', '2020-01-01', 'Macho', 10.5);
INSERT INTO mascotas (cliente_cedula, nombre, especie, raza, fechaNacimiento, sexo, peso)
VALUES ('1800000001', 'Pelusa', 'Gato', 'Persa', '2019-06-15', 'Hembra', 4.2);

-- Cliente 2
INSERT INTO mascotas (cliente_cedula, nombre, especie, raza, fechaNacimiento, sexo, peso)
VALUES ('1800000002', 'Michi', 'Gato', 'Siames', '2021-05-15', 'Hembra', 4.0);
INSERT INTO mascotas (cliente_cedula, nombre, especie, raza, fechaNacimiento, sexo, peso)
VALUES ('1800000002', 'Rex', 'Perro', 'Labrador', '2018-03-10', 'Macho', 25.0);

-- Cliente 3
INSERT INTO mascotas (cliente_cedula, nombre, especie, raza, fechaNacimiento, sexo, peso)
VALUES ('1800000003', 'Max', 'Perro', 'Pastor Aleman', '2022-02-20', 'Macho', 15.0);
INSERT INTO mascotas (cliente_cedula, nombre, especie, raza, fechaNacimiento, sexo, peso)
VALUES ('1800000003', 'Lola', 'Conejo', 'Angora', '2023-01-05', 'Hembra', 2.1);

-- 3. CONSULTAS UNIFICADAS
-- Nota: La tabla ahora es 'consultas' y contiene todos los datos.
-- Los IDs son generados, asumimos serial (1, 2, 3...) para las relaciones con recetas.

-- Consulta 1: Vet 1, Mascota 1 (Firulais) - ATENDIDA
INSERT INTO consultas (veterinario_cedula, mascota_id, fecha, hora, motivo, estado, sintomas, diagnostico, tratamiento, observaciones)
VALUES ('1900000001', 1, '2023-11-01', '10:00:00', 'Esterilizacion', 'ATENDIDA', 'Ninguno', 'Saludable', 'Cirugia exitosa', 'Reposo 3 dias');

-- Consulta 2: Vet 1, Mascota 4 (Rex) - ATENDIDA
INSERT INTO consultas (veterinario_cedula, mascota_id, fecha, hora, motivo, estado, sintomas, diagnostico, tratamiento, observaciones)
VALUES ('1900000001', 4, '2023-11-01', '14:30:00', 'Cirugia de pata', 'ATENDIDA', 'Cojera', 'Fractura leve', 'Vendaje y reposo', 'Revision en 2 semanas');

-- Consulta 3: Vet 2, Mascota 2 (Pelusa) - ATENDIDA
INSERT INTO consultas (veterinario_cedula, mascota_id, fecha, hora, motivo, estado, sintomas, diagnostico, tratamiento, observaciones)
VALUES ('1900000002', 2, '2023-11-02', '09:00:00', 'Control Anual', 'ATENDIDA', 'Vomitos', 'Indigestion', 'Dieta blanda', 'Agua constante');

-- Consulta 4: Vet 2, Mascota 3 (Michi) - ATENDIDA
INSERT INTO consultas (veterinario_cedula, mascota_id, fecha, hora, motivo, estado, sintomas, diagnostico, tratamiento, observaciones)
VALUES ('1900000002', 3, '2023-11-02', '11:00:00', 'Vacunacion', 'ATENDIDA', 'Ninguno', 'Sano', 'Vacuna Triple Felina', 'Proxima dosis 1 año');

-- Consulta 5: Vet 3, Mascota 5 (Max) - ATENDIDA
INSERT INTO consultas (veterinario_cedula, mascota_id, fecha, hora, motivo, estado, sintomas, diagnostico, tratamiento, observaciones)
VALUES ('1900000003', 5, '2023-11-03', '10:00:00', 'Alergia en piel', 'ATENDIDA', 'Picazon severa', 'Dermatitis atopica', 'Corticoides', 'Cambio de alimento');

-- Consulta 6: Vet 3, Mascota 6 (Lola) - ATENDIDA
INSERT INTO consultas (veterinario_cedula, mascota_id, fecha, hora, motivo, estado, sintomas, diagnostico, tratamiento, observaciones)
VALUES ('1900000003', 6, '2023-11-03', '12:00:00', 'Caida de pelo', 'ATENDIDA', 'Alopecia zonal', 'Hongos', 'Crema antifungica', 'Aislar de otros animales');

-- Consulta 7: Vet 1, Mascota 1 (Firulais) - AGENDADA (Futura)
INSERT INTO consultas (veterinario_cedula, mascota_id, fecha, hora, motivo, estado)
VALUES ('1900000001', 1, '2025-12-01', '09:00:00', 'Revision post-operatoria', 'AGENDADA');


-- 4. RECETAS
-- Recetas para Consulta 1
INSERT INTO recetas (consulta_id, medicamento, dosis, frecuencia, duracion)
VALUES (1, 'Analgesico', '10mg', 'Cada 12 horas', '3 dias');
INSERT INTO recetas (consulta_id, medicamento, dosis, frecuencia, duracion)
VALUES (1, 'Antibiotico', '1 tab', 'Cada 24 horas', '5 dias');

-- Recetas para Consulta 2
INSERT INTO recetas (consulta_id, medicamento, dosis, frecuencia, duracion)
VALUES (2, 'Antiinflamatorio', '20mg', 'Cada 24 horas', '5 dias');

-- Recetas para Consulta 5
INSERT INTO recetas (consulta_id, medicamento, dosis, frecuencia, duracion)
VALUES (5, 'Corticoides Orales', '5mg', 'Cada 12 horas', '7 dias');
INSERT INTO recetas (consulta_id, medicamento, dosis, frecuencia, duracion)
VALUES (5, 'Shampoo Hipoalergenico', 'N/A', 'Cada 3 dias', '2 semanas');

-- Recetas para Consulta 6
INSERT INTO recetas (consulta_id, medicamento, dosis, frecuencia, duracion)
VALUES (6, 'Crema Ketoconazol', 'Capa fina', 'Cada 12 horas', '10 dias');
