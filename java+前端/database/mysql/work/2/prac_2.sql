ALTER TABLE result
ADD PRIMARY KEY(subjectNo,examDate);

ALTER TABLE result 
ADD FOREIGN KEY(studentNo)
REFERENCES student(studentNo);
