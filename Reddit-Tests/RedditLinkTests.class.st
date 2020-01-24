Class {
	#name : #RedditLinkTests,
	#superclass : #TestCase,
	#category : #'Reddit-Tests'
}

{ #category : #tests }
RedditLinkTests >> testCreate [ 
	|link url title|
	url := 'http://www.seaside.st'.
	title := 'Seaside'.
	link := RedditLink withURL: url title: title.
	link assertContractUsing: self.
	self assert: link points isZero.
	self assert: link url  equals: url.
	self assert: link title equals: title. 
]

{ #category : #tests }
RedditLinkTests >> testInitialState [
	|link|
	link := RedditLink new.
	link assertContractUsing: self.
	self assert: link points isZero.
]

{ #category : #tests }
RedditLinkTests >> testVoting [
	|link|
	link := RedditLink new.
	link assertContractUsing: self.
	self assert: link points isZero.
	link voteUp.
	self assert: link points equals: 1.
	link voteDown.
	self assert: link points isZero.
	link voteDown.
	self assert: link points isZero.
]
