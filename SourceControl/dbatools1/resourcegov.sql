ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = NULL);
GO

ALTER RESOURCE GOVERNOR WITH (MAX_OUTSTANDING_IO_PER_VOLUME = DEFAULT);
GO

ALTER RESOURCE GOVERNOR RECONFIGURE;
GO

