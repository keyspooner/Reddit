Class {
	#name : #BaselineOfReddit,
	#superclass : #BaselineOf,
	#category : #BaselineOfReddit
}

{ #category : #baselines }
BaselineOfReddit >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			
			
			"Packages"
			spec
				"package: 'RedditClone' with: [ spec requires: #('Glorp' 'Seaside3') ]"
				package: 'Reddit'
		]
]
