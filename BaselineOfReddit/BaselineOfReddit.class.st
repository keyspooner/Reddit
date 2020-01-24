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
			self postgresAndGlorp: spec.
			spec  package: 'Reddit' with: [spec requires: #('Seaside3' 'P3')]]
]

{ #category : #baselines }
BaselineOfReddit >> postgresAndGlorp: spec [
	spec 
		baseline: 'P3'
		with: [ 
			spec
			loads: #('glorp');
			repository: 'github://svenvc/P3' ]
		
]

{ #category : #baselines }
BaselineOfReddit >> seaside: spec [
	spec 
		baseline: 'Seaside3'
		with: [ spec 
						repository: 'github://SeasideSt/Seaside:master/repository' ]
		
]
