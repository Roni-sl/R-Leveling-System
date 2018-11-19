-- THAT CONFIG WORKS ONLY WHEN YOU NOT ON DARKRP
-- IF YOU ON DARKRP THEN LEVEL SYSTEM USING DARKRP MYSQL CONFIG

MySQLite.initialize({
	EnableMySQL = false,
	Host = "127.0.0.1",
	Username = "root",
	Password = "",
	Database_name = "r_level_system",
	Database_port = 3306
})
