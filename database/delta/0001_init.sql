-- Table os 
CREATE TABLE os (
    id int(11) unsigned NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    version varchar(255) DEFAULT NULL,
    PRIMARY KEY (id)
) ENGINE=myISAM;

-- Table hardware
CREATE TABLE hardware (
    id int(11) unsigned NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	PRIMARY KEY (id)
) ENGINE=myISAM;

-- Table engine
CREATE TABLE  engine(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	locale char(5) NOT NULL, -- need for speed
	version char(10) DEFAULT NULL,
	name varchar(255) NOT NULL,
	PRIMARY KEY (id)
) ENGINE=myISAM;

-- Table browser
CREATE TABLE browser (
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	version char(10) DEFAULT NULL,
	PRIMARY KEY (id)
) ENGINE=myISAM;

-- Table testset
CREATE TABLE testset (
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	browser_id int(11) unsigned NOT NULL, -- foreign key to browser.id
	engine_id int(11) unsigned NOT NULL, -- foreign key to engine.id
	hardware_id int(11) unsigned NOT NULL, -- foreign key to hardware.id
	os_id int(11) unsigned NOT NULL,  -- foreign key to os.id
	testsetid int(11) unsigned NOT NULL, -- unique
	specifier_id int(11) unsigned DEFAULT NULL, -- optional
	`timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UNIQUE KEY testsetid (testsetid),
	PRIMARY KEY (id)
) ENGINE=myISAM;

-- Table testresult
CREATE TABLE testresult (
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	testset_id int(11) unsigned NOT NULL, -- foreign key to testset.id
	testid int(11) unsigned NOT NULL, -- unique
	spec_id int(11) unsigned DEFAULT NULL, -- optional  -- foreign key to spec.id
	tags varchar(255) DEFAULT NULL, -- stored like: ",css,dom,whatever," (leading and tailing ',')
	name varchar(100) DEFAULT NULL,
	`timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UNIQUE KEY testid (testid),
	PRIMARY KEY (id)
) ENGINE=myISAM;

-- Table specifier
CREATE TABLE specifier (
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	organization varchar(50) NOT NULL,
	subset varchar(50) NOT NULL,
	category varchar(50) NOT NULL,
	UNIQUE KEY specifier (organization, subset, category),	
	PRIMARY KEY (id)
) ENGINE=myISAM;

-- Table spec
CREATE TABLE spec (
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	specifier_id int(11) unsigned NOT NULL,  -- foreign key to specifier.id
	version char(10) DEFAULT NULL,
	url varchar(255) NOT NULL, -- would prefer a normalised url
	status varchar(20) DEFAULT NULL,
	UNIQUE KEY url (url),
	PRIMARY KEY (id)
) ENGINE=myISAM;

-- Table testresult2spec
-- note: binding table of testresult
CREATE TABLE testresult2spec (
	testresult_id int(11) unsigned NOT NULL,
	spec_id int(11) unsigned NOT NULL,
	PRIMARY KEY (testresult_id, spec_id)
) ENGINE=myISAM;