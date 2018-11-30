const socket = io();

// DOM elements
let command = document.getElementById('command');
let btn = document.getElementById('send');
let output = document.getElementById('output');
let error = document.getElementById('error');
let modal = document.getElementById('myModal');
let menu = document.getElementById('menu_item');

const action = (value) => {
  socket.emit('prolog:command', {
    command: value,
  });
  modal.style.display = "block";
}

btn.addEventListener('click', function() {
    if( command.value === '') {
        error.className = '';
        error.innerHTML = 'Empty Command';
    } else {
        action(command.value);
        command.value = '';
    }
});

socket.on('prolog:command', function(data) {
    modal.style.display = "none";
    menu.style.display = "none";
    error.classList.add('d-none');
    output.innerHTML += 
    `<p>
        ${data}
    </p>`

    output.scrollTo(0, output.scrollHeight);
});

socket.on('prolog:error', function(err) {
  modal.style.display = "none";
  error.className = '';
  error.innerHTML = err;
})

const open_menu_door = (place) => {
  menu.style.display = "block";
  menu.innerHTML = `<button onclick="action('goto(${place})')">Enter</button><br>
                    <button href="#" onclick="action('use_key(${place})')">Use key</button><br>
                    <button href="#" onclick="action('open_door(${place})')">Open</button><br>
                    <button href="#" onclick="action('close_door(${place})')">Close</button>`
  
}

const view_object = (object) => {
  action(`view_object(${object})`);
}

const view_object_inside = (item, object) => {
  action(`view_object_inside(${item}, ${object})`);
}

const open_menu = (object) => {
  menu.style.display = "block";
  menu.innerHTML = `<button onclick="action('eat(${object})')">Eat</button><br>
                    <button href="#" onclick="action('drink(${object})')">Drink</button><br>
                    <button href="#" onclick="action('drop(${object})')">Drop</button><br>`
}

const take = (object) => {
  action(`take(${object})`);
}

const take_inside = (item, object) => {
  action(`take(${item},${object})`);
}