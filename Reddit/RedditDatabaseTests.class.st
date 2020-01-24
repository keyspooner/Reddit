Class {
	#name : #RedditDatabaseTests,
	#superclass : #TestCase,
	#instVars : [
		'session'
	],
	#category : #Reddit
}

{ #category : #accessing }
RedditDatabaseTests >> session [
	^ session
]

{ #category : #accessing }
RedditDatabaseTests >> session: anObject [
	session := anObject
]

{ #category : #'initialize-release' }
RedditDatabaseTests >> setUp [ 
	session := RedditDatabaseResource session.
	session accessor
		logging: true;
		login
]

{ #category : #'initialize-release' }
RedditDatabaseTests >> tearDown [ 
	session accessor logout
]

{ #category : #'initialize-release' }
RedditDatabaseTests >> testCreate [ 
  | link url title id |
  url := 'http://www.seaside.st'.
  title := 'Seaside Unit Test'.
  link := RedditLink withURL: url title: title.
  session inUnitOfWorkDo: [ 
    session register: link ].
  id := link id.
  self assert: id notNil.
  session reset.
  link := session
            readOneOf: RedditLink 
            where: [ :each | each id = id ]. 
  link assertContractUsing: self.
  self assert: link url = url.
  self assert: link title = title.
  session delete: link
]

{ #category : #'initialize-release' }
RedditDatabaseTests >> testQuery [ 
	|links|
	links := session read: RedditLink where: true limit: 5.
	links do: [ :each |
		each assertContractUsing: self.
		self assert: (each isKindOf: RedditLink)]
]

{ #category : #'initialize-release' }
RedditDatabaseTests >> testUpdate [
  | link url title id |
  url := 'http://www.seaside.st'.
  title := 'Seaside Unit Test'.
  link := RedditLink withURL: url title: title.
  session inUnitOfWorkDo: [
    session register: link ].
  id := link id.
  session inUnitOfWorkDo: [
    session register: link.
    link voteUp ].
  session reset.
  link := session 
            readOneOf: RedditLink 
            where: [ :each | each id = id ]. 
  self assert: link points = 1.
  session delete: link
]
