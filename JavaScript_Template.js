// =========================
// STRICT MODE
// =========================

"use strict";

// =========================
// VARIABLES
// =========================

let name = "John";
const age = 30;
var oldVar = "avoid this";

// =========================
// DATA STRUCTURES
// =========================

const person = {
    name: "Alice",
    age: 25,
    greet() {
        console.log(`Hello, my name is ${this.name}`);
    }
};

const numbers = [1, 2, 3, 4];

// =========================
// FUNCTIONS
// =========================

function add(a, b) {
    return a + b;
}

const multiply = (a, b) => a * b;

// =========================
// CONTROL FLOW
// =========================

if (age > 18) {
    console.log("Adult");
} else {
    console.log("Minor");
}

for (let i = 0; i < numbers.length; i++) {
    console.log(numbers[i]);
}

// =========================
// ARRAY METHODS
// =========================

numbers.forEach(n => console.log(n));

const doubled = numbers.map(n => n * 2);
const filtered = numbers.filter(n => n > 2);

// =========================
// DESTRUCTURING
// =========================

const { name: personName } = person;
const [first] = numbers;

// =========================
// SPREAD / REST
// =========================

const newNumbers = [...numbers, 5, 6];

function sum(...args) {
    return args.reduce((a, b) => a + b, 0);
}

// =========================
// DOM MANIPULATION
// =========================

const el = document.querySelector(".my-element");

if (el) {
    el.textContent = "Hello World";
}

// =========================
// EVENTS
// =========================

if (el) {
    el.addEventListener("click", () => {
        console.log("Clicked!");
    });
}

// =========================
// PROMISES
// =========================

const fetchData = () => {
    return new Promise((resolve) => {
        setTimeout(() => resolve("Data loaded"), 1000);
    });
};

// =========================
// ASYNC / AWAIT
// =========================

async function loadData() {
    try {
        const data = await fetchData();
        console.log(data);
    } catch (err) {
        console.error(err);
    }
}

loadData();

// =========================
// FETCH API
// =========================

async function getUsers() {
    try {
        const res = await fetch("https://jsonplaceholder.typicode.com/users");
        const data = await res.json();
        console.log(data);
    } catch (err) {
        console.error(err);
    }
}

// =========================
// CLASSES
// =========================

class Animal {
    constructor(name) {
        this.name = name;
    }

    speak() {
        console.log(`${this.name} makes a noise.`);
    }
}

class Dog extends Animal {
    speak() {
        console.log(`${this.name} barks.`);
    }
}

const dog = new Dog("Rex");
dog.speak();

// =========================
// MODULE PATTERN (IIFE)
// =========================

const App = (function () {
    const privateVar = "secret";

    function init() {
        console.log("App initialized");
    }

    return {
        init
    };
})();

App.init();

// =========================
// ERROR HANDLING
// =========================

try {
    throw new Error("Something went wrong");
} catch (e) {
    console.error(e.message);
}

// =========================
// TIMERS
// =========================

setTimeout(() => console.log("Delayed"), 1000);

const interval = setInterval(() => console.log("Repeating"), 2000);

clearInterval(interval);

// =========================
// LOCAL STORAGE
// =========================

localStorage.setItem("key", "value");
const value = localStorage.getItem("key");

// =========================
// UTILITIES
// =========================

const isArray = Array.isArray(numbers);
const now = new Date();

console.log(isArray, now);
