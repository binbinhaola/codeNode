SELECT users.NickName,users.sex,bloodinfo.BloodType
FROM users
JOIN bloodinfo ON users.bloodTypeID=bloodinfo.id
WHERE bloodinfo.bloodType='O型';


SELECT users.NickName,users.sex,bloodinfo.BloodType,testscore.Star
FROM users
JOIN bloodinfo ON users.bloodTypeID=bloodinfo.Id
JOIN testscore ON users.StarID=testscore.Id
WHERE bloodinfo.bloodType='A型' AND testscore.Star='白羊座';

UPDATE users 
SET nickName = '天外飞仙'
WHERE nickName='.NET';

SELECT users.NickName,users.sex,bloodinfo.BloodType,testscore.Star
FROM users
JOIN bloodinfo ON users.bloodTypeID=bloodinfo.Id
JOIN testscore ON users.StarID=testscore.Id;

SELECT NickName,sex
FROM users
WHERE LoginPWD IN ('A');
