# DiffyTables

DiffyTables is a practical and efficient way to use tables in WatchKit apps.

Instead of manipulating the table directly from an interface controller, you can now simply generate a representation of the table. DiffyTables then uses a diffing algorithm to compare new table row data with what's currently on screen and intelligently sends only the truly necessary updates to the watch.

(Yep, kind of like React.)

### How do I use this

1. Read my article: [Practical and efficient WatchKit tables with view model diffing](http://radex.io/watch/diffing/). It explains how to structure your application so you can use DiffyTables. Seriously, go read it, I can wait.
2. Check out the demo project in the `Demo/` folder
3. Copy `Diffing.swift`, `WatchKitUpdatable.swift`, and `DiffyTables.swift` to your project.
4. Now you can create your view models (conforming to `TableRowModel`) and make your row controllers conform to `UpdatableRowController`
5. Boom, you can now use `table.updateViewModels()` to do all the updating for you 😊
6. **Bonus:** You can make your app even faster by adopting lazy loading. Read [Lazy WatchKit tables](http://radex.io/watch/lazy/) for more info

### [Cathage](https://github.com/Carthage/Carthage)

Add this to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

    github "radex/DiffyTables"

and follow the [usual steps for watchOS frameworks](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)

### But… native apps?

> Since I published this post, Apple has announced a native SDK for the Watch to be released in the fall. You might conclude that this makes this post obsolete and there’s no reason to implement the view model-based architecture in your app. I believe this conclusion to be false.
>
> First of all, even though the native SDK is available for us to play with, your users will still have to use the WatchKit 1 app until the fall. This is a pretty long time to live with a frustratingly slow app. You can improve their experience with limited effort by using the techniques presented above.
>
> Second of all, I believe that the architectural benefits of this approach still apply on watchOS 2. Decoupling your business logic from interface logic makes your code cleaner and easier to reason about. So does treating the UI as a function of application state.
>
> Some of the optimizations, like the `update(...)` helpers won’t be needed anymore. But the diffing algorithm is actually still useful. Although conceived as a performance trick, it has a side effect of nicely animating row insertions and deletions without you having to do anything.

### Contributing

If you have comments, complaints or ideas for improvements, feel free to open an issue or a pull request.

### Author and license

Radek Pietruszewski

* [github.com/radex](http://github.com/radex)
* [twitter.com/radexp](http://twitter.com/radexp)
* [radex.io](http://radex.io)
* this.is@radex.io

DiffyTables is available under the MIT license. See the LICENSE file for more info.
