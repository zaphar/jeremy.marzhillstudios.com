+++
title = "MetaData and Database design"
date = 2005-09-27T00:36:36
in_search_index = true
[taxonomies]
tags = [
	"Data",
	"Software-Development",
]
+++
Recognizing the difference between your Data and your Metadata can go a long way toward keeping your data formats extensible. Theoretically keeping your data generic and using metadata to describe it can allow for much greater flexibility in your application's design. Planning for, and accounting for, the ability to add more metadata on the fly can allow you a much greater capacity for growth in the types of data your application can handle. I'm experiencing this in a current project in fact. The company in question is growing and is faced with a need to change their current application to allow for that growth. A massive refactoring of the application is going to be needed. They will have to be able to add new "products" (otherwise known as data) to the application and present more ways for customers to get access to said product. A metadata based design in their data format will give them that kind of flexibility.
