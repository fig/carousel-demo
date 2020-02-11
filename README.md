# Bare-bones Rails 6 app to demonstrate integration of 'Flickity' library with Webpacker and vanilla JS.

## Flickity

Touch, responsive, flickable carousels. [https://flickity.metafizzy.co/](https://flickity.metafizzy.co/)

## Inplement with Ruby on Rails and Webpacker

Clone the repo or replicate it yourself as below.

## Steps to replicate


1. Install Rails at the command prompt if you haven't yet:

        $ gem install rails -v '~> 6.0.0'

2. At the command prompt, create a new Rails application:

        $ rails new myapp

    where "myapp" is the application name.

3. Change directory to `myapp`.

        $ cd myapp

4. Install the Flickity library:

        $ yarn add flickity

5. Create a controller with `index` action and views:

        $ rails generate controller home index

6. Replace contents of `app/views/home/index.html.erb` with:

    ```html
    <h1>Flickity - autoPlay</h1>

    <!-- Flickity HTML init -->
    <div class="carousel" data-flickity='{ "autoPlay": true }'>
    <div class="carousel-cell"><div class="content"></div></div>
    <div class="carousel-cell"><div class="content"></div></div>
    <div class="carousel-cell"><div class="content"></div></div>
    <div class="carousel-cell"><div class="content"></div></div>
    <div class="carousel-cell"><div class="content"></div></div>
    </div>
    ```

7. Create a file at `app/javascript/carousel/index.js` with:

    ```js
    // Import the Flickity library
    import Flickity from "flickity";

    // Wait for content load
    window.addEventListener("load", function() {

    // Initialise Flickity
    var flkty = new Flickity(".carousel", {
            //Flickity options
    });

    // Due to the implementation of Flickity, a resize is required.
    // This can be accomplished by manually resizing the browser viewport
    // or do it here with JS see: https://github.com/metafizzy/flickity/issues/205
    flkty.resize();
    });
    ```

8. Create a file at `app/javascript/stylesheets/carousel.css` with:

    ```css
    /* external css: flickity.css */

    * {
    box-sizing: border-box;
    }

    body {
    font-family: sans-serif;
    }

    .content {

    min-height: 200px;
    }

    .carousel {
    background: #EEE;
    }

    .carousel-cell {
    width: 66%;
    height: 200px;
    margin-right: 10px;
    background: #8C8;
    border-radius: 5px;
    counter-increment: gallery-cell;
    }

    /* cell number */
    .carousel-cell:before {
    display: block;
    text-align: center;
    content: counter(gallery-cell);
    line-height: 200px;
    font-size: 80px;
    color: white;
    }
    ```

9. Add the following lines to `app/javascript/packs/application.js` to load our javascript and css:

    ```js
    // require our custom JS. The Flickity library will be loaded
    // from there.
    // Webpack will automatically load an `index.js' file from the given
    // directory: 'app/javascript/carousel/index.js'
    require("carousel");

    // import Flickity styles
    import "flickity/dist/flickity.min.css";

    // import our custom styles from 'app/javascript/stylsheets/carousel.css
    import "stylesheets/carousel.css";
    ```

10. Start the web server:

        $ bin/rails server

11. Go to `http://localhost:3000/home/index.html` and marvel at a wonderfull carousel flicking away merrily!
