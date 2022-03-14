# MarvelApp
Marvel App in Swift using MVVM Architecture

# About

The app processes the Marvel API to display descriptions and images of the characters in the Marvel universe. This project has been implemented in Swift.

# Features

 Characters list: displays a list of characters and their thumbnails.
 Character detail: displays a picture of a character and its description.

# Technical details
This app has been developed using an MVVM architectural pattern, which is a combination of the Model-View-ViewModel architecture. In this implementation, the binding between the Views and the ViewModels is done via protocol-delegation. The app has major Folders:

The View Group, which contains the views. The ViewModel group, which contains the business logic. The APIService group which contains the networking. The Common group, which contains common functionality.
