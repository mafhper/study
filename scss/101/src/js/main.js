/* Mudança de Tema */

const switcher = document.querySelector('#theme-switcher');
const doc = document.firstElementChild;

switcher.addEventListener('input', (e) => setTheme(e.target.value));

const setTheme = (theme) => doc.setAttribute('color-scheme', theme);

console.log('hello from main.js');
/* Captura da cor selecionada e Modificação de Componentes */

/* const colorInput = document.querySelector('input[type=color]')
const colorVariable = '--brand-color'

colorInput.addEventListener('change', e =>{
  console.log(e.target.value)
  document.documentElement.style.setProperty(colorVariable, e.target.value)
})
 */
