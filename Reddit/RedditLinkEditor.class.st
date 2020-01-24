Class {
	#name : #RedditLinkEditor,
	#superclass : #WAComponent,
	#instVars : [
		'url',
		'title',
		'captcha',
		'password'
	],
	#category : #Reddit
}

{ #category : #rendering }
RedditLinkEditor >> cancel [
	self answer: false
]

{ #category : #accessing }
RedditLinkEditor >> captcha [
	^ captcha
]

{ #category : #accessing }
RedditLinkEditor >> captcha: anObject [
	captcha := anObject
]

{ #category : #rendering }
RedditLinkEditor >> children [ 
	^ Array with: self captcha
]

{ #category : #rendering }
RedditLinkEditor >> createLink [
  ^ RedditLink withURL: self url title: self title
]

{ #category : #rendering }
RedditLinkEditor >> initialize [ 
	super initialize.
	self 
		url: 'http://';
		captcha: RedditCaptcha new
]

{ #category : #rendering }
RedditLinkEditor >> isPasswordCorrect [
  ^ self password = 'topsecret'
]

{ #category : #rendering }
RedditLinkEditor >> isTitleMissing [ 
  ^ self title isNil or: [ 
      self title isEmpty or: [ self title = 'title' ] ]
]

{ #category : #rendering }
RedditLinkEditor >> isUrlMissing [
  ^ self url isNil or: [ 
      self url isEmpty or: [ self url = 'http://' ] ]
]

{ #category : #rendering }
RedditLinkEditor >> isUrlValid [
  ^ [ 
      ZnClient new
        get: self url;
        isSuccess ]
      on: Error
      do: [ false ]
]

{ #category : #accessing }
RedditLinkEditor >> password [
	^ password
]

{ #category : #accessing }
RedditLinkEditor >> password: anObject [
	password := anObject
]

{ #category : #rendering }
RedditLinkEditor >> renderContentOn: html [
	html form: [ 
		html paragraph: 'Enter a URL & title for the link to add:'.
		html textInput 
			size: 48;
			title: 'The URL of the new link';
			placeholder: 'URL';
			on: #url of: self.
		html textInput 
			size: 48;
			title: 'The title of the new link';
			placeholder: 'Title';
			on: #title of: self.
		html render: self captcha.
		html paragraph: 'Enter the admin password for new links:'.
		html heading level3 with: 'I don''t trust you, internet...'.
		html passwordInput 
			size: 48;
			on: #password of: self.
		html submitButton on: #cancel of: self.
		html submitButton on: #save of: self.
		 ]
]

{ #category : #rendering }
RedditLinkEditor >> save [
  self isUrlMissing
    ifTrue: [ 
      ^ self inform: 'Please enter an URL' ].
  self isTitleMissing
    ifTrue: [ 
      ^ self inform: 'Please enter a title' ].
  self captcha isSolved
    ifFalse: [ 
      ^ self inform: 'Please answer the correct sum using digits' ].
  self isUrlValid
    ifFalse: [ 
      ^ self inform: 'The URL you entered did not resolve' ].
  self isPasswordCorrect 
	 ifFalse: [ 
		 ^ self inform: 'The admin password is incorrect'].
  self answer: true
]

{ #category : #accessing }
RedditLinkEditor >> title [
	^ title
]

{ #category : #accessing }
RedditLinkEditor >> title: anObject [
	title := anObject
]

{ #category : #rendering }
RedditLinkEditor >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot title: 'Reddit.st-Submit a new link'
]

{ #category : #accessing }
RedditLinkEditor >> url [
	^ url
]

{ #category : #accessing }
RedditLinkEditor >> url: anObject [
	url := anObject
]
