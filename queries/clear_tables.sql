TRUNCATE TABLE 68_personal.spent;

ALTER TABLE 68_personal.spent DROP FOREIGN KEY spent_ibfk_1;
ALTER TABLE 68_personal.spent DROP FOREIGN KEY spent_ibfk_2;

TRUNCATE TABLE 68_personal.spentcategory;
TRUNCATE TABLE 68_personal.spentstatus;

ALTER TABLE `Spent` ADD FOREIGN KEY (`IdSpentCategory`) REFERENCES `SpentCategory` (`IdSpentCategory`);
ALTER TABLE `Spent` ADD FOREIGN KEY (`IdSpentStatus`) REFERENCES `SpentStatus` (`IdSpentStatus`);

SELECT * FROM 68_personal.spent;
SELECT * FROM 68_personal.spentcategory;
SELECT * FROM 68_personal.spentstatus;