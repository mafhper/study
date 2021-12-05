const switcher = document.querySelector('#theme-switcher')
const doc = document.firstElementChild

switcher.addEventListener('input', e =>
    setTheme(e.target.value))

const setTheme = theme =>
    doc.setAttribute('color-scheme', theme)


// const colorPicker = document.querySelector('#input-color');
// const elems = document.querySelectorAll('.title');
// var root = document.querySelector('*');

// colorPicker.addEventListener('change', function () {
//     root.style.setProperty('--brand-color', this.value);
//     Array.from(elems).forEach(v => v.style.color = this.value);

//     console.log('Color Picker: ' + this.value);

// });