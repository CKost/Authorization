# Authorization
Authorization For XV6 OS Project

Team Members:
Curtis 'The Kosher' Koster :)
John 'Wiglz'
Daniel Wrecker
Benjamin 'String Bean' Matthews


LOG:
4/6/15 19:41 - CK: Method Stubs & fs.h added permission bit/UID to Inode Struct
4/6/15 19:41 - BRM: Git Setup
4/7/15 21:31 - Daniel working with Curtis.
4/8/15 20:39 - CK: Working on Access user program yay
4/9/15 18:45 - BRM: working on quit call
4/9/15 19:21 - BRM: added quit call
4/9/15 20:04 - ALL: Team Working at Wiglz
4/10/15 00:26 - BRM: Checked out new branch to clean up code
4/10/15 00:41 - BRM: Committed aesthetic changes and merged branch to master
4/10/15 01:27 - BRM: Test commit to ensure proper SSH setup
4/10/15 13:24 - BRM&CK: Fixing access syscall
4/12/15 22:58 - BRM: Cleanup


TODO:
1) Add owning UID to inode data -- CK & DR
2) Permission bits in inode structures -- CK & DR

4) New Syscall: chmod -- STUBBED BY CK & DR
	a. need to send data to sys_chmod()
	
5) New Syscall: access -- STUBBEED BY CK
6) Modify open() to perform access checks

