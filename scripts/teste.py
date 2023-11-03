import yaml

data = {
    "questions": [
        {
            "question": "q1",
            "description": "teste",
            "feedback": "test",
            "answers": [
                {"answer": "bla"},
                {"answer": "bla"},
                {"answer": "bla"},
            ]
        },
        {
            "question": "q2",
            "description": "teste",
            "feedback": "test",
            "answers": [
                {"answer": "bla"},
                {"answer": "bla"},
                {"answer": "bla"},
            ]
        }
    ]
}

with open("questions.yaml", "w") as yaml_file:
    yaml.dump(data, yaml_file, default_flow_style=False)
