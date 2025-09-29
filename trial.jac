"""Simple Maths Assignment Generator for Grade 10 Students """

import from byllm.llm { Model }

glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

def make_grade10_maths_questions(level: str, count: int) -> list[str] by llm();

# Defining a node type to represent a student
node Student {
    has name: str;
    has score: float;            
    has level: str = "";
    has questions: list[str] = [];
}

with entry {
    # Creating node instances by calling the node type (NOT `spawn`)
    john  = Student(name="John", score=82);
    mary  = Student(name="Mary", score=48);
    peter = Student(name="Peter", score=65);

    # (optional) attaching to root so they appear in the graph
    root ++> john;
    root ++> mary;
    root ++> peter;

    # iterating over the concrete instances
    students = [john, mary, peter];

    for s in students {
        if s.score >= 75 { lvl = "Exceeding Expectations"; count = 5; }
        elif s.score >= 55 { lvl = "Meeting Expectations"; count = 4; }
        elif s.score >= 40 { lvl = "Approaching Expectations"; count = 3; }
        elif s.score >= 25 { lvl = "Developing"; count = 2; }
        else { lvl = "Beginning"; count = 2; }

        s.level = lvl;
        s.questions = make_grade10_maths_questions(lvl, count);
    }

    # Printing results
    for s in students {
        print("Student:", s.name, "(", s.score, "%)");
        print("Level:", s.level);
        print("Assignment (" + str(len(s.questions)) + " questions):");
        for q in s.questions {
            print("•", q);
        }
        print("");
    }
}
