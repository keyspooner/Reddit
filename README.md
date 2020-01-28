# Reddit

Load project by running the below in Pharo's playground:

```smalltalk
Metacello new
   baseline: 'Reddit';
   repository: 'github://keyspooner/Reddit';
   onWarning: [ :ex | ];
   onConflict: [ :ex | ex useIncoming ];
   onUpgrade: [ :ex |  ex useIncoming ];
   onDowngrade: [ :ex |   ex useLoaded ];
   onLock:[ :ex |    ];
   load.
   ```
