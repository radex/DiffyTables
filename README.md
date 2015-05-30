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

### Contributing

If you have comments, complaints or ideas for improvements, feel free to open an issue or a pull request.

### Author and license

Radek Pietruszewski

* [github.com/radex](http://github.com/radex)
* [twitter.com/radexp](http://twitter.com/radexp)
* [radex.io](http://radex.io)
* this.is@radex.io

DiffyTables is available under the MIT license. See the LICENSE file for more info.
