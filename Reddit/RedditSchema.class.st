Class {
	#name : #RedditSchema,
	#superclass : #DescriptorSystem,
	#category : #Reddit
}

{ #category : #accessing }
RedditSchema >> allTableNames [ 
	^ #('REDDIT_LINKS')
	
]

{ #category : #initialization }
RedditSchema >> classModelForRedditLink: aClassModel [
	#(id url title created points) do: [ :each | aClassModel newAttributeNamed: each ]
]

{ #category : #initialization }
RedditSchema >> constructAllClasses [ 
	^ super constructAllClasses
		add: RedditLink;
		yourself
]

{ #category : #'as yet unclassified' }
RedditSchema >> descriptorForRedditLink: aDescriptor [
	|table|
	table := self tableNamed: 'REDDIT_LINKS'.
	aDescriptor table: table.
	#(id url title created points) do: [ :each | 
		(aDescriptor newMapping: DirectMapping) from: each to: (table fieldNamed: each) ]
	
]

{ #category : #accessing }
RedditSchema >> tableForREDDIT_LINKS: aTable [
	(aTable createFieldNamed: 'id' type: platform serial) bePrimaryKey.
	aTable createFieldNamed: 'url' type: (platform varchar: 64).
	aTable createFieldNamed: 'title' type: (platform varchar: 64).
	aTable createFieldNamed: 'created' type: (platform timestamp).
	aTable createFieldNamed: 'points' type: (platform integer)
]
