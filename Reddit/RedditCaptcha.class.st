Class {
	#name : #RedditCaptcha,
	#superclass : #WAComponent,
	#instVars : [
		'x',
		'y',
		'sum'
	],
	#category : #Reddit
}

{ #category : #rendering }
RedditCaptcha >> initialize [
  super initialize.
  self x: 0; y: 0; sum: 0
]

{ #category : #rendering }
RedditCaptcha >> isSolved [
  ^ self sum asInteger = (self x + self y)
]

{ #category : #rendering }
RedditCaptcha >> renderContentOn: html [
  self x: 10 atRandom.
  self y: 10 atRandom.
  html paragraph:
    ('CAPTCHA: How much is {1} plus {2} ?'
     format: { self x asWords. self y asWords }).
  html textInput
    title: 'Type the answer using digits';
    on: #sum of: self
]

{ #category : #accessing }
RedditCaptcha >> sum [
	^ sum
]

{ #category : #accessing }
RedditCaptcha >> sum: anObject [
	sum := anObject
]

{ #category : #accessing }
RedditCaptcha >> x [
	^ x
]

{ #category : #accessing }
RedditCaptcha >> x: anObject [
	x := anObject
]

{ #category : #accessing }
RedditCaptcha >> y [
	^ y
]

{ #category : #accessing }
RedditCaptcha >> y: anObject [
	y := anObject
]
