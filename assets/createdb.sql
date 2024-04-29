CREATE TABLE addictiveApp(
	packageName TEXT PRIMARY KEY
);

CREATE TABLE dailyGoal(
	id INTEGER PRIMARY KEY,
	createdAt DATETIME,
    title TEXT NOT NULL,
    rating INTEGER
);
CREATE TABLE appUse(
	id INTEGER PRIMARY KEY,
    packageName TEXT NOT NULL,
    openedAt DATETIME,
    reason TEXT NOT NULL
);
CREATE TABLE note(
	id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    createdAt DATETIME,
    updatedAt DATETIME
);