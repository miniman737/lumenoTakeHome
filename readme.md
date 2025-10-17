
To Run this project simply open xcode, select the an iPhone simulator and click run or CMD + R

This application Using no third party libraries.

I isolated the main profile from the userLists, although they hit the exact same api in my opinion if you were making a full socail media application it makes the most sense to keep these two pieces seperate from one another.

Looking back on it, profileView and UserDetailView are basically identical, and they can totally be used interchangably, for just being a view that takes a viewModel with a given user, granted I didn't want the userDetailView to be refreshable like the profileView is. 

![Uploading Simulator Screenshot - iPhone 17 Pro - 2025-10-17 at 04.12.05.png…]()
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-17 at 04 12 10" src="https://github.com/user-attachments/assets/4f5fa875-7309-460c-819e-67e0d92dfaec" />
