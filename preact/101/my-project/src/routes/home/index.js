import { h } from 'preact';
import style from './style.css';

const Home = () => (
	<div class={style.home}>
		<h1>Home</h1>
		<p>This is the Home component.</p>
		<p class="linecut">•	Gestão de bancos de dados com conhecimento amplo de Excel/PowerBI. 
•	Planejamentos de relatórios técnicos, rotas operacionais e modelos de gestão de equipes.
•	Competência técnica e prática em suporte de computadores e redes de comunicação.
•	Desenvolvimento de sistema para Web (HTML5/CSS/JS). Elaboração de layouts (UI) aplicando métricas de uso (UX) e gerenciadores de conteúdo (CMS).
•	Habilidades em desenvolvimento de circuitos eletrônicos e programação. 
</p>
<button class="clickon">Hello World</button>
	</div>
);

export default Home;
