To Run this project simply open xcode, select the an iPhone simulator and click run or CMD + R

This application Using no third party libraries.

I isolated the main profile from the userLists, although they hit the exact same api in my opinion if you were making a full socail media application it makes the most sense to keep these two pieces seperate from one another.

Looking back on it, profileView and UserDetailView are basically identical, and they can totally be used interchangably, for just being a view that takes a viewModel with a given user, granted I didn't want the userDetailView to be refreshable like the profileView is. 

