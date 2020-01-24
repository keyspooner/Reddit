Class {
	#name : #RedditDatabaseResource,
	#superclass : #Object,
	#classVars : [
		'DefaultLogin'
	],
	#category : #Reddit
}

{ #category : #'private protocol' }
RedditDatabaseResource class >> DefaultLogin [
	^ DefaultLogin
]

{ #category : #'private protocol' }
RedditDatabaseResource class >> DefaultLogin: aLogin [
	DefaultLogin := aLogin
]

{ #category : #'private protocol' }
RedditDatabaseResource class >> createLogin [
	^ Login new 
		database: PostgreSQLPlatform new;
		username: 'postgres';
		password: 'lims';
		connectString: 'localhost:5432_reddit_links';
		encodingStrategy: #utf8;
		yourself
]

{ #category : #'private protocol' }
RedditDatabaseResource class >> createTables [ 
	"self createTables"
	"this has to be done only once, be sure to set #login"
	|session|
	session := self session.
	session accessor login; logging: true.
	session inTransactionDo: [ session createTables ].
	session accessor logout
]

{ #category : #'private protocol' }
RedditDatabaseResource class >> login [ 
	^ DefaultLogin ifNil: [ DefaultLogin := self createLogin ]
]

{ #category : #'private protocol' }
RedditDatabaseResource class >> login: aLogin [
	DefaultLogin := aLogin
]

{ #category : #'private protocol' }
RedditDatabaseResource class >> session [ 
	^ RedditSchema sessionForLogin: self login
]
