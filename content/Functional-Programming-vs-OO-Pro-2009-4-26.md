+++
title = "Functional Programming vs OO Programming"
date = 2009-04-26T20:52:39Z
in_search_index = true
[taxonomies]
tags = [
	"Site-News",
	"comparison",
	"erlang",
	"functional-programming",
	"insanity",
	"OO",
]
+++
I've been thinking lately about the differences between <abbr title="Object Oriented">OO</abbr> and <abbr title="Functional programming">FP</abbr>. FP languages don't really support the OO model because of a difference in design. Some try but the "true" functional languages make no such effort and for good reason. One of the primary principles of OO programming is the black box. An object is meant to represent some entity in the system. All the state and valid actions for that entity are encapsulated in the Object and the only visibility you have into them is the interface the object provides to the outside world. Programs tend to be defined as a set of interactions between objects. FP takes a different approach. In FP data is not modifiable only transformable by functions. In FP the functions expect certain input and give back certain output for that input. They certainly don't maintain any state on their own. You can't have an object if you can't have modifiable internal state. In OO you are encouraged to group together state and activity on that state. In OO you don't think so much about state as you do about entities. Person, Car, ATM machine. All of these are commonly referenced objects in an OO tutorial or textbook. Consumers of your object are encouraged not to think about the state of a person or a car or an ATM machine. Instead they think in terms of allowable interactions with that object: Talk, Drive, Withdraw Money. Within OO code there are a huge number of possible orders of various interactions possible. So large they are just about impossible to completely test or even visualize. For example say I'm programming a person object. I've given the person object a handshake method. However, depending on the internal state of the person object that method may or may not work the same way or be supposed to be called. Maybe the person object is in a bad mood, in which case the handshake method is non-functional. How do we handle that? Hrmm, so first before calling handshake on the person object we should call the offer hand method. No wait, before we call the offer hand method, perhaps we should look at their face first to gauge their mood. This could get complicated pretty quickly. Furthermore there is nothing in the OO language that allows us to specify that the offer hand method should happen first. We obviously need to know quite a bit about the state of that person object in order to properly interact with it. Contrast that with an FP approach. This gets a little bit simpler for some people to visualize suddenly. Rather than an object, they see state and a set of possible transformations of that state. the state may be something like this. person1 mood, person2 mood. and there is an interact function. If the person1 and person2 mood is good then the interact function offers hand for handshake and the two shake hands then interact returns the new person1 mood and person2 mood. Or if the mood of one of them is bad then do some other action then return new person1 mood and person 2 mood. By placing the emphasis on the state involved the coder has reduced the problem to a set of possible transformations based on that state. In OO, an object's methods define the interface. but passing the same input to an object will not always result in the same output. Most of the time methods modify internal state and the return depends on the internal state. At any time in your code the internal state of an object must be treated as an unknown. This means the return of your objects method must also be treated as an unknown. Every object has to treat every other object like it has some sort of mental disease and could have a psychotic break any moment. It could do just about anything and if you didn't define the proper response to what they do then who knows what might happen. In FP you are encouraged to think in terms of state transformations. You are forced to consider what the state you are dealing with is and then transform that state appropriately. Since the state is of primary importance after a while FP feels more natural than OO to certain mindsets. I'm discovering that I rather like the FP mindset and miss OO less and less these days. <hr /> Glossary = "<dl> <dt>FP</dt> <dd>Functional Programming</dd> <dt>OO</dt> <dd>Object Oriented</dd> </dl>"