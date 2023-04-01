# state_management_week2

-Learned about MVVM architecture which suggests separating the data presentation logic(Views or UI) from the core business logic part of the application. 
it has 3 layers
The separate code layers of MVVM are:

Model: This layer is responsible for the abstraction of the data sources. Model and ViewModel work together to get and save the data.
View: The purpose of this layer is to inform the ViewModel about the user’s action. This layer observes the ViewModel and does not contain any kind of application logic.
ViewModel: It exposes those data streams which are relevant to the View. Moreover, it serves as a link between the Model and the View. 

--------------------------------------------------------Provider-----------------------------------------------------------------------------

Learned about state management(Provider) and implemented it with dummy shopping cart App
4 Basic and important parts of changenotifier(provider)

1) ChangeNotifier:
Your class should extend ChangeNotifier, if you want to use Provider package in your app.
 In our class, we created a class named DataClass, and this class extends ChangeNotifier.

2)Consumer
You need to wrap your widget, using Consumer. It helps you to show the changed data in the UI or View.

3) Provider.of<>()
Provider.of<>() can access the data that's inside DataClass( this class extends ChangeNotifier). It's job is to read the data from DataClass. 
we can also use context<>.read instead of it.

4)ChangeNotifierProvider

This is used in the entry point of your app. Instead of wrapping your app using MaterialApp, you need to wrap your app using ChangeNotifierProvider
we wrap it at the root level so that the state is accessible to each widget.


-----------------------------------------------API integration------------------------------------------------------------

Flutter provides http package to consume HTTP resources. http is a Future-based library and uses await and async features.
It provides many high level methods and simplifies the development of REST based mobile applications.

Basic Concepts
http package provides a high level class and http to do web requests.

http class provides functionality to perform all types of HTTP requests.

http methods accept a url, and additional information through Dart Map (post data, additional headers, etc.,). It requests the server and collects the response back in async/await pattern.
 For example, the below code reads the data from the specified url and print it in the console.
print(await http.read('https://flutter.dev/'));

Some of the core methods are as follows −

read − Request the specified url through GET method and return back the response as Future<String>

get − Request the specified url through GET method and return back the response as Future<Response>. Response is a class holding the response information.

post − Request the specified url through POST method by posting the supplied data and return back the response as Future<Response>

put − Request the specified url through PUT method and return back the response as Future <Response>

head − Request the specified url through HEAD method and return back the response as Future<Response>

delete − Request the specified url through DELETE method and return back the response as Future<Response>
