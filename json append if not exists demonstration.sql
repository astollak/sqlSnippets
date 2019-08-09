start TRANSACTION; 
-- initial array of strings
SELECT  requiredContext INTO @s1 FROM rule WHERE eventName='Namespace:Event';
-- append a new string, verify
update rule set requiredContext = JSON_ARRAY_APPEND(requiredContext,'$',"newEnvironmentData") 
	WHERE eventName='Namespace:Event' 
	AND NOT JSON_CONTAINS(requiredContext, '"newEnvironmentData"');
  
SELECT requiredContext INTO @s2 FROM rule WHERE eventName='Namespace:Event';

-- reappend a new string and fail, verify
update rule set requiredContext = JSON_ARRAY_APPEND(requiredContext,'$',"newEnvironmentData") 
	WHERE eventName='Namespace:Event' 
	AND NOT JSON_CONTAINS(requiredContext, '"newEnvironmentData"');
SELECT requiredContext INTO @s3 FROM rule WHERE eventName='Namespace:Event';

-- view in one tab
SELECT 1 AS i, @s1 AS txt UNION SELECT 2 AS i, @s2 AS txt UNION SELECT 3 AS i, @s3 AS txt;
ROLLBACK;
