import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
import joblib

# Example data - replace with your real dataset CSV
data = {
    'text': ["This is real news", "Fake news here", "Another real example", "More fake news"],
    'label': [2, 1, 2, 1]
}
df = pd.DataFrame(data)

# Split data
X_train, X_test, y_train, y_test = train_test_split(df["text"], df["label"], test_size=0.2, random_state=42)

# Vectorize text data
vectorizer = TfidfVectorizer()
X_train_vec = vectorizer.fit_transform(X_train)

# Train a simple logistic regression model
model = LogisticRegression()
model.fit(X_train_vec, y_train)

# Save model and vectorizer
import os
os.makedirs("models", exist_ok=True)
joblib.dump(model, "models/model.pkl")
joblib.dump(vectorizer, "models/vectorizer.pkl")

print("Model and vectorizer saved successfully!")
