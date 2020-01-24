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
			self seaside: spec.
			spec  package: 'Reddit' with: [spec requires: #('Seaside3')]]
]

{ #category : #baselines }
BaselineOfReddit >> seaside: spec [
	spec 
		baseline: 'Seaside3'
		with: [ spec 
						loads: #('Stable');
						repository: 'github://SeasideSt/Seaside:master/repository' ]
		
]
