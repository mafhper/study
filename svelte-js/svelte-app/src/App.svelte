<script>
  export let name;
</script>

<main>
  <h1>Hell {name}!</h1>
  <p>
    Visit the <a href="https://svelte.dev/tutorial">Svelte tutorial</a> to learn
    how to build Svelte apps.
  </p>
</main>

<style>
  main {
    text-align: center;
    padding: 1em;
    max-width: 240px;
    margin: 0 auto;
  }

  h1 {
    background: -webkit-linear-gradient(rgb(149, 0, 194), rgb(14, 202, 29));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-transform: uppercase;
    font-size: 10em;
    font-weight: 800;
	text-shadow: #CCC 5em 0 5em
  }

  @media (min-width: 640px) {
    main {
      max-width: none;
    }
  }
</style>
