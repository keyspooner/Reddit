"
Built by following the tutorial on https://medium.com/concerning-pharo/reddit-st-in-10-cool-pharo-classes-1b5327ca0740
"
Class {
	#name : #RedditWebApp,
	#superclass : #WAComponent,
	#instVars : [
		'linkEditor'
	],
	#category : #Reddit
}

{ #category : #'class initialization' }
RedditWebApp class >> durationString: duration [
  ^ String streamContents: [ :stream | 
      | needSpace printer |
      needSpace := false.
      printer := [ :value :word | 
        value isZero
          ifFalse: [ 
            needSpace ifTrue: [ stream space ].
            stream nextPutAll: (value pluralize: word).
            needSpace := true ] ].
      printer value: duration days value: 'day'.
      printer value: duration hours value: 'hour'.
      printer value: duration minutes value: 'minute'.
      duration < 60 seconds 
        ifTrue: [ printer value: duration seconds value: 'second' ].
      duration < 1 second 
        ifTrue: [ stream nextPutAll: 'less than a second' ] ]
]

{ #category : #'class initialization' }
RedditWebApp class >> initialize [
	"RedditWebApp initialize"
  (WAAdmin register: self asApplicationAt: 'simplereddit')
    preferenceAt: #sessionClass put: RedditSession
]

{ #category : #rendering }
RedditWebApp >> children [ 
	^ self linkEditor notNil
		ifTrue: [ Array with: self linkEditor ]
		ifFalse: [ super children ]
		
	
]

{ #category : #rendering }
RedditWebApp >> durationString: duration [
  ^ String streamContents: [ :stream | 
      | needSpace printer |
      needSpace := false.
      printer := [ :value :word | 
        value isZero
          ifFalse: [ 
            needSpace ifTrue: [ stream space ].
            stream nextPutAll: (value pluralize: word).
            needSpace := true ] ].
      printer value: duration days value: 'day'.
      printer value: duration hours value: 'hour'.
      printer value: duration minutes value: 'minute'.
      duration < 60 seconds 
        ifTrue: [ printer value: duration seconds value: 'second' ].
      duration < 1 second 
        ifTrue: [ stream nextPutAll: 'less than a second' ] ]
]

{ #category : #rendering }
RedditWebApp >> highestRankingLinks [
  | query |
  query := (Query read: RedditLink) 
             orderBy: [ :each | each points descending ]; 
             limit: 20;
             yourself.
  ^ self session glorpSession execute: query
]

{ #category : #rendering }
RedditWebApp >> latestLinks [
  | query |
  query := (Query read: RedditLink) 
             orderBy: [ :each | each created descending]; 
             limit: 20;
             yourself.
  ^ self session glorpSession execute: query
]

{ #category : #accessing }
RedditWebApp >> linkEditor [
	^ linkEditor
]

{ #category : #accessing }
RedditWebApp >> linkEditor: anObject [
	linkEditor := anObject
]

{ #category : #rendering }
RedditWebApp >> renderActionsOn: html [
  html paragraph: [
    html anchor 
      callback: [ ]; 
      with: 'Refresh'.
    self linkEditor 
		ifNil: [ 
			html anchor
				callback: [ self showNewLinkEditor ];
				with: 'New Link' ]]
]

{ #category : #rendering }
RedditWebApp >> renderContentOn: html [
  html heading: 'SimpleReddit.st'.
  self renderActionsOn: html.
  self linkEditor ifNotNil: [ html render: self linkEditor].
  self renderHighestRankingLinksOn: html.
  self renderLatestLinksOn: html
]

{ #category : #rendering }
RedditWebApp >> renderHighestRankingLinksOn: html [
  html heading 
    level2; 
    with: 'Highest Ranking Links'.
  html orderedList: [
    self highestRankingLinks do: [ :each | 
      self renderLink: each on: html ] ]
]

{ #category : #rendering }
RedditWebApp >> renderLatestLinksOn: html [
  html heading 
    level2; 
    with: 'Latest Links'.
 html orderedList: [
   self latestLinks do: [ :each | 
     self renderLink: each on: html ] ]
]

{ #category : #rendering }
RedditWebApp >> renderLink: link on: html [
  html listItem: [
    html anchor 
      url: link url; 
      title: link url; 
      with: link title.
    html text: ' Posted ', 
               (self class durationString: link age), 
               ' ago. '.
    html text: link points asString, ' points. '.
    html anchor 
      callback: [ self voteUp: link ]; 
      title: 'Vote this link up'; 
      with: 'Up'.
    html space.
    html anchor 
      callback: [ self voteDown: link ]; 
      title: 'Vote this link down'; 
      with: 'Down' ]
]

{ #category : #rendering }
RedditWebApp >> showNewLinkEditor [
	self linkEditor: RedditLinkEditor new.
	self linkEditor 
		onAnswer: [ :answer |
			answer
				ifTrue: [ 
					self session glorpSession
						inUnitOfWorkDo: [ :session |
							session register: self linkEditor createLink ] ].
			self linkEditor: nil ]
]

{ #category : #rendering }
RedditWebApp >> updateRoot: anHtmlRoot [
  super updateRoot: anHtmlRoot.
  anHtmlRoot title: 'Reddit.st'.
anHtmlRoot stylesheet url: (RedditFileLibrary urlOf: #mainCss)
]

{ #category : #rendering }
RedditWebApp >> voteDown: link [
  self session glorpSession 
    inUnitOfWorkDo: [ :session |
      session register: link.
      link voteDown ]
]

{ #category : #rendering }
RedditWebApp >> voteUp: link [
  self session glorpSession 
    inUnitOfWorkDo: [ :session |
      session register: link.
      link voteUp ]
]
