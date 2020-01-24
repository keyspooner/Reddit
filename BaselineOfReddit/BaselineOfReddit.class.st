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
			
			spec postLoadDoIt: #'postload:package:'.
			self seaside: spec.
			self postgresAndGlorp: spec.
			spec  package: 'Reddit' with: [spec requires: #('Seaside3' 'P3' 'P3-Glorp')]]
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
BaselineOfReddit >> postload: loader package: packageSpec [
	PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver.
	Transcript show: 'PharoDatabaseAccessor default driver set to P3DatabaseDriver'
]

{ #category : #baselines }
BaselineOfReddit >> seaside: spec [
	spec 
		baseline: 'Seaside3'
		with: [ spec 
						repository: 'github://SeasideSt/Seaside:master/repository' ]
		
]
