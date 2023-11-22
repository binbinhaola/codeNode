INSERT INTO bbsusers VALUE('','test','123123','sdieso2123@gmail.com','女','2009-12-21 21:02:12'),
('','tom','123456','112231@sqee.com','男','2012-01-12 10:02:23'),
('','peter','123123','puniabo@chao.com','男','2013-08-12 12:23:21')

INSERT INTO bbstopics VALUE('','1','情人节怎么过的?','浪漫情人节怎么过?逛街？看电影？西餐？','2011-02-15 9:16:26'),
('','1','参数化SQL命令','提供安全性,避免SQL注入','2011-02-15 10:11:18'),
('','2','80后 VS 90后','80后装嫩,90后装成熟','2011-03-03 15:02:00')

INSERT INTO bbsreplys VALUE('','1','4','不知道随便了','2011-03-14 12:02:21')


SELECT * FROM bbsusers WHERE uname='accp'


SELECT * FROM bbstopics
LEFT JOIN bbsreplys
ON bbstopics.tid = bbsreplys.rtid
LEFT JOIN bbsusers
ON bbsusers.uid = bbsreplys.ruid


