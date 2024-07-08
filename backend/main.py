from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials, firestore
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder

app = Flask(__name__)

# Initialize Firebase
cred = credentials.Certificate("firebase-credentials.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# Load and prepare your data
data = pd.read_csv("nutrition_data.csv")
le = LabelEncoder()
X = data[['age', 'gender', 'weight', 'height', 'activity_level', 'dietary_preference', 'health_goal']]
X['gender'] = le.fit_transform(X['gender'])
X['activity_level'] = le.fit_transform(X['activity_level'])
X['dietary_preference'] = le.fit_transform(X['dietary_preference'])
X['health_goal'] = le.fit_transform(X['health_goal'])
y = data['recommended_diet']

# Train a random forest model
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X, y)

@app.route('/get_recommendation', methods=['POST'])
def get_recommendation():
    user_data = request.json
    user_profile = [
        user_data['age'],
        le.transform([user_data['gender']])[0],
        user_data['weight'],
        user_data['height'],
        le.transform([user_data['activity_level']])[0],
        le.transform([user_data['dietary_preference']])[0],
        le.transform([user_data['health_goal']])[0]
    ]

    recommendation = model.predict([user_profile])[0]

    return jsonify({'recommendation': recommendation})

@app.route('/log_meal', methods=['POST'])
def log_meal():
    meal_data = request.json
    user_id = meal_data['user_id']

    # Log meal to Firestore
    db.collection('users').document(user_id).collection('meals').add(meal_data)

    return jsonify({'status': 'success'})

if __name__ == '__main__':
    app.run(debug=True)
