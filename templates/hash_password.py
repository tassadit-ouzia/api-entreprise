import bcrypt

# Remplace ce mot de passe par le mot de passe que tu souhaites hacher
password = "motdepasse123"  # Exemple de mot de passe

# Générer un "salt" pour le hachage
salt = bcrypt.gensalt()

# Hacher le mot de passe avec le salt
hashed_password = bcrypt.hashpw(password.encode(), salt)

# Afficher le mot de passe haché (copie ce hash dans ta base de données)
print(hashed_password.decode())