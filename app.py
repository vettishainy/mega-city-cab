from flask import Flask, render_template, request
import random

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def dashboard():
    prediction = None
    if request.method == "POST":
        text = request.form["text"]
        prediction = random.choice(["Fake", "Real"])  # Replace with ML model output

    # Stats data
    stats = {
        "accuracy": 92.5,
        "fake_count": 500,
        "real_count": 600
    }

    return render_template(
        "dashboard.html",
        prediction=prediction,
        stats=stats
    )

if __name__ == "__main__":
    app.run(debug=True)
