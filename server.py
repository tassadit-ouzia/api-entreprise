from flask import Flask, render_template, request, redirect, flash, url_for
from flask_login import LoginManager, UserMixin, login_user, login_required, current_user, logout_user
import psycopg2
import bcrypt
import os  # Import pour utiliser les variables d'environnement

app = Flask(__name__)
app.secret_key = "supersecretkey"  # Nécessaire pour utiliser `flash`

# Initialisation de Flask-Login
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "login"  # Page de connexion si non authentifié

# Fonction pour se connecter à la base de données PostgreSQL
def get_db_connection():
    try:
        # Récupérer les informations de connexion depuis les variables d'environnement ou directement à partir de l'URL PostgreSQL de Render
        db_url = os.getenv("DATABASE_URL", "postgresql://stage_db_62gn_user:1KyqqNY8KhgjGC7ukZpzZaNEhtrD8KZv@dpg-cvdveffnoe9s73ej7qhg-a.oregon-postgres.render.com/stage_db_62gn")
        
        # Connexion à PostgreSQL
        conn = psycopg2.connect(db_url)
        return conn
    except psycopg2.Error as err:
        print(f"❌ Erreur de connexion à la base de données : {err}")
        return None

# User class pour Flask-Login
class User(UserMixin):
    def __init__(self, id, username):
        self.id = id
        self.username = username

# Fonction pour charger un utilisateur
@login_manager.user_loader
def load_user(user_id):
    db = get_db_connection()
    cursor = db.cursor()
    cursor.execute('SELECT * FROM users WHERE id = %s', (user_id,))
    user_data = cursor.fetchone()
    cursor.close()
    db.close()
    
    if user_data:
        return User(user_data[0], user_data[1])  # Renvoie un objet User avec id et username
    return None

# Route pour afficher la page d'accueil (entreprises)
@app.route('/')
@login_required  # Seule la personne connectée peut accéder à cette page
def index():
    db = get_db_connection()
    if not db:
        flash("Erreur de connexion à la base de données", "danger")
        return redirect('/')

    cursor = db.cursor()
    cursor.execute('SELECT * FROM entreprises')  # Sélectionner toutes les entreprises
    entreprises = cursor.fetchall()  # Récupérer toutes les lignes
    cursor.close()
    db.close()
    
    return render_template('index.html', entreprises=entreprises)

# Route pour la page de connexion
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        
        # Connexion à la base de données
        db = get_db_connection()
        cursor = db.cursor()
        cursor.execute('SELECT * FROM users WHERE username = %s', (username,))
        user_data = cursor.fetchone()
        cursor.close()
        db.close()

        # Si l'utilisateur existe et que le mot de passe est correct
        if user_data and bcrypt.checkpw(password.encode(), user_data[2].encode()):
            user = User(user_data[0], user_data[1])  # Créer l'objet utilisateur
            login_user(user)  # Connexion de l'utilisateur
            flash("Connexion réussie", "success")
            return redirect('/')  # Redirection vers la page d'accueil après une connexion réussie
        
        flash("Nom d'utilisateur ou mot de passe incorrect", "danger")
        return redirect('/login')  # Redirection en cas d'échec

    return render_template('login.html')  # Afficher le formulaire de connexion en GET

# Route pour la déconnexion
@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Déconnexion réussie", "info")
    return redirect('/')

# Route pour ajouter une entreprise
@app.route('/ajouter', methods=['GET', 'POST'])
@login_required  # Cette route est protégée par login
def ajouter_entreprise():
    if request.method == 'POST':
        # Récupérer les données du formulaire
        raison_sociale = request.form['raison_sociale'].strip()
        nom_dirigeant = request.form['nom_dirigeant'].strip()
        service = request.form['service'].strip()
        if service == 'autre':
            service = request.form.get('autre_service', '').strip()  # Si 'Autre' est sélectionné, récupérer la valeur
        email = request.form['email'].strip()
        telephone = request.form['telephone'].strip()
        description = request.form['description'].strip()
        numero_rue = request.form['numero_rue'].strip()  # Ajout du champ numéro et rue
        code_postal = request.form['code_postal'].strip()
        ville = request.form['ville'].strip()
        pays = request.form['pays'].strip()

        # Vérification des champs obligatoires
        if not (raison_sociale and nom_dirigeant and service and email and telephone and description and numero_rue and code_postal and ville and pays):
            flash("Tous les champs obligatoires doivent être remplis", "danger")
            return redirect('/ajouter')  # Rediriger l'utilisateur vers la page d'ajout

        db = get_db_connection()
        if not db:
            flash("Erreur de connexion à la base de données", "danger")
            return redirect('/ajouter')

        cursor = db.cursor()
        query = """INSERT INTO entreprises (raison_sociale, nom_dirigeant, service, email, telephone, description, numero_rue, code_postal, ville, pays)
                   VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
        cursor.execute(query, (raison_sociale, nom_dirigeant, service, email, telephone, description, numero_rue, code_postal, ville, pays))
        db.commit()
        cursor.close()
        db.close()

        flash("Entreprise ajoutée avec succès", "success")
        return redirect('/')  # Rediriger vers la page d'accueil après ajout

    return render_template('ajouter.html')  # Afficher le formulaire d'ajout en GET

# Route pour supprimer une entreprise
@app.route('/supprimer/<int:id>', methods=['POST'])
@login_required  # Cette route est protégée par login
def supprimer_entreprise(id):
    db = get_db_connection()
    if not db:
        flash("Erreur de connexion à la base de données", "danger")
        return redirect('/')

    cursor = db.cursor()
    cursor.execute('DELETE FROM entreprises WHERE id = %s', (id,))
    db.commit()
    cursor.close()
    db.close()

    flash("Entreprise supprimée avec succès", "success")
    return redirect('/')

# Route pour modifier une entreprise
@app.route('/modifier/<int:id>', methods=['GET', 'POST'])
@login_required  # Cette route est protégée par login
def modifier_entreprise(id):
    db = get_db_connection()
    cursor = db.cursor()
    cursor.execute('SELECT * FROM entreprises WHERE id = %s', (id,))
    entreprise = cursor.fetchone()
    cursor.close()

    if not entreprise:
        flash("Entreprise introuvable", "danger")
        return redirect('/')  # Si l'entreprise n'existe pas, rediriger vers la page d'accueil

    if request.method == 'POST':
        raison_sociale = request.form['raison_sociale'].strip()
        nom_dirigeant = request.form['nom_dirigeant'].strip()
        service = request.form['service'].strip()
        if service == 'autre':
            service = request.form.get('autre_service', '').strip()  # Si 'Autre' est sélectionné, récupérer la valeur
        email = request.form['email'].strip()
        telephone = request.form['telephone'].strip()
        description = request.form['description'].strip()
        numero_rue = request.form['numero_rue'].strip()  # Ajout du champ numéro et rue
        code_postal = request.form['code_postal'].strip()
        ville = request.form['ville'].strip()
        pays = request.form['pays'].strip()

        # Vérification des champs obligatoires
        if not (raison_sociale and nom_dirigeant and service and email and telephone and description and numero_rue and code_postal and ville and pays):
            flash("Tous les champs obligatoires doivent être remplis", "danger")
            return redirect(f'/modifier/{id}')  # Rediriger en cas d'erreur

        db = get_db_connection()
        cursor = db.cursor()
        cursor.execute("""UPDATE entreprises SET raison_sociale = %s, nom_dirigeant = %s, service = %s, email = %s, 
                        telephone = %s, description = %s, numero_rue = %s, code_postal = %s, ville = %s, pays = %s WHERE id = %s""", 
                        (raison_sociale, nom_dirigeant, service, email, telephone, description, numero_rue, code_postal, ville, pays, id))
        db.commit()
        cursor.close()
        db.close()

        flash("Entreprise modifiée avec succès", "success")
        return redirect('/')

    return render_template('modifier.html', entreprise=entreprise)  # Afficher le formulaire de modification en GET

if __name__ == '__main__':
    app.run(debug=True)