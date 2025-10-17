-- Script pour ajouter des spécialistes de test dans la base de données

-- Insertion d'utilisateurs spécialistes
INSERT INTO users (nom, prenom, email, mot_de_passe, role, telephone, adresse, active) VALUES
('BENALI', 'Sara', 'sara.benali@teleexpertise.ma', '$2a$10$YourHashedPassword', 'SPECIALISTE', '0612345678', '123 Rue Mohammed V, Casablanca', true),
('ALAMI', 'Karim', 'karim.alami@teleexpertise.ma', '$2a$10$YourHashedPassword', 'SPECIALISTE', '0623456789', '45 Avenue Hassan II, Rabat', true),
('TAHIRI', 'Fatima', 'fatima.tahiri@teleexpertise.ma', '$2a$10$YourHashedPassword', 'SPECIALISTE', '0634567890', '78 Boulevard Zerktouni, Marrakech', true),
('CHRAIBI', 'Ahmed', 'ahmed.chraibi@teleexpertise.ma', '$2a$10$YourHashedPassword', 'SPECIALISTE', '0645678901', '12 Rue de Fès, Tanger', true),
('LAMRANI', 'Nadia', 'nadia.lamrani@teleexpertise.ma', '$2a$10$YourHashedPassword', 'SPECIALISTE', '0656789012', '90 Avenue des FAR, Agadir', true),
('BENCHEKROUN', 'Omar', 'omar.benchekroun@teleexpertise.ma', '$2a$10$YourHashedPassword', 'SPECIALISTE', '0667890123', '33 Rue Imam Malik, Fès', true),
('IDRISSI', 'Amina', 'amina.idrissi@teleexpertise.ma', '$2a$10$YourHashedPassword', 'SPECIALISTE', '0678901234', '56 Boulevard Moulay Youssef, Meknès', true),
('BERRADA', 'Youssef', 'youssef.berrada@teleexpertise.ma', '$2a$10$YourHashedPassword', 'SPECIALISTE', '0689012345', '21 Avenue Mohammed VI, Oujda', true)
ON CONFLICT (email) DO NOTHING;

-- Insertion des médecins spécialistes
-- Récupérer les IDs des utilisateurs créés
INSERT INTO medecins (user_id, specialite, tarif_consultation, duree_consultation, diplomes, experience, numero_ordre, is_disponible)
SELECT
    u.id,
    'CARDIOLOGIE',
    500.00,
    45,
    'Doctorat en Cardiologie - Université Mohammed V',
    '15 ans d''expérience',
    'ORD-CARD-001',
    true
FROM users u WHERE u.email = 'sara.benali@teleexpertise.ma'
ON CONFLICT DO NOTHING;

INSERT INTO medecins (user_id, specialite, tarif_consultation, duree_consultation, diplomes, experience, numero_ordre, is_disponible)
SELECT
    u.id,
    'DERMATOLOGIE',
    400.00,
    30,
    'Doctorat en Dermatologie - Université Hassan II',
    '10 ans d''expérience',
    'ORD-DERM-002',
    true
FROM users u WHERE u.email = 'karim.alami@teleexpertise.ma'
ON CONFLICT DO NOTHING;

INSERT INTO medecins (user_id, specialite, tarif_consultation, duree_consultation, diplomes, experience, numero_ordre, is_disponible)
SELECT
    u.id,
    'PNEUMOLOGIE',
    450.00,
    40,
    'Doctorat en Pneumologie - Université Cadi Ayyad',
    '12 ans d''expérience',
    'ORD-PNEU-003',
    true
FROM users u WHERE u.email = 'fatima.tahiri@teleexpertise.ma'
ON CONFLICT DO NOTHING;

INSERT INTO medecins (user_id, specialite, tarif_consultation, duree_consultation, diplomes, experience, numero_ordre, is_disponible)
SELECT
    u.id,
    'NEUROLOGIE',
    550.00,
    50,
    'Doctorat en Neurologie - Université Mohammed VI',
    '18 ans d''expérience',
    'ORD-NEUR-004',
    true
FROM users u WHERE u.email = 'ahmed.chraibi@teleexpertise.ma'
ON CONFLICT DO NOTHING;

INSERT INTO medecins (user_id, specialite, tarif_consultation, duree_consultation, diplomes, experience, numero_ordre, is_disponible)
SELECT
    u.id,
    'PEDIATRIE',
    350.00,
    35,
    'Doctorat en Pédiatrie - Université Ibn Zohr',
    '8 ans d''expérience',
    'ORD-PEDI-005',
    true
FROM users u WHERE u.email = 'nadia.lamrani@teleexpertise.ma'
ON CONFLICT DO NOTHING;

INSERT INTO medecins (user_id, specialite, tarif_consultation, duree_consultation, diplomes, experience, numero_ordre, is_disponible)
SELECT
    u.id,
    'CARDIOLOGIE',
    480.00,
    45,
    'Doctorat en Cardiologie - Université Sidi Mohammed Ben Abdellah',
    '13 ans d''expérience',
    'ORD-CARD-006',
    true
FROM users u WHERE u.email = 'omar.benchekroun@teleexpertise.ma'
ON CONFLICT DO NOTHING;

INSERT INTO medecins (user_id, specialite, tarif_consultation, duree_consultation, diplomes, experience, numero_ordre, is_disponible)
SELECT
    u.id,
    'DERMATOLOGIE',
    420.00,
    35,
    'Doctorat en Dermatologie - Université Moulay Ismail',
    '11 ans d''expérience',
    'ORD-DERM-007',
    true
FROM users u WHERE u.email = 'amina.idrissi@teleexpertise.ma'
ON CONFLICT DO NOTHING;

INSERT INTO medecins (user_id, specialite, tarif_consultation, duree_consultation, diplomes, experience, numero_ordre, is_disponible)
SELECT
    u.id,
    'NEUROLOGIE',
    520.00,
    45,
    'Doctorat en Neurologie - Université Mohammed Premier',
    '16 ans d''expérience',
    'ORD-NEUR-008',
    true
FROM users u WHERE u.email = 'youssef.berrada@teleexpertise.ma'
ON CONFLICT DO NOTHING;

-- Vérification
SELECT
    u.nom,
    u.prenom,
    u.email,
    u.role,
    m.specialite,
    m.tarif_consultation,
    m.is_disponible
FROM users u
LEFT JOIN medecins m ON u.id = m.user_id
WHERE u.role = 'SPECIALISTE'
ORDER BY m.specialite, m.tarif_consultation;

