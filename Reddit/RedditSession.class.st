Class {
	#name : #RedditSession,
	#superclass : #WASession,
	#instVars : [
		'glorpSession'
	],
	#category : #Reddit
}

{ #category : #accessing }
RedditSession >> glorpSession [
	glorpSession ifNil: [ glorpSession := self newGlorpSession ].
	glorpSession accessor isLoggedIn
		ifFalse: [ glorpSession accessor login ].
	^ glorpSession
	
	
]

{ #category : #accessing }
RedditSession >> newGlorpSession [
	|session|
	session := RedditDatabaseResource session.
	session accessor logging: true.
	^ session
]

{ #category : #accessing }
RedditSession >> tearDownGlorpSession [
	self glorpSession logout
	
	
]

{ #category : #accessing }
RedditSession >> unregistered [
	super unregistered.
	self tearDownGlorpSession
	
	
]
