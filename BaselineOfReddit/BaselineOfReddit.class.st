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
			
			"dependencies"
			self seaside: spec.
			
			"Packages"
			spec
				"package: 'RedditClone' with: [ spec requires: #('Glorp' 'Seaside3') ]"
				package: 'Reddit' with: [ spec requires: #('Seaside3') ]]
]

{ #category : #baselines }
BaselineOfReddit >> seaside: spec [
	spec 
		baseline: 'Seaside3';
		with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ]
]
