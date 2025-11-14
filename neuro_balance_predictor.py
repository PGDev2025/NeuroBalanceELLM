import joblib
import pandas as pd

model = joblib.load("neuro_balance_model.pkl")
scaler = joblib.load("neuro_balance_scaler.pkl")

def predict_mfi(sentiment_score, activity_score, rest_balance):
    input_df = pd.DataFrame({
        "sentiment_score": [sentiment_score],
        "activity_score": [activity_score],
        "rest_balance": [rest_balance]
    })
    input_scaled = scaler.transform(input_df)
    prediction = model.predict(input_scaled)[0]

    return float(prediction)
