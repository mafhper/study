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
    /* color: #ff3e00; */
    text-transform: uppercase;
    font-size: 10rem;
    font-weight: 800;

    background: -webkit-linear-gradient(
      335deg,
      hsl(60deg 4% 87%) 0%,
      hsl(65deg 13% 83%) 13%,
      hsl(79deg 22% 80%) 19%,
      hsl(92deg 31% 77%) 23%,
      hsl(102deg 39% 74%) 27%,
      hsl(112deg 48% 70%) 31%,
      hsl(122deg 56% 67%) 34%,
      hsl(132deg 66% 64%) 38%,
      hsl(143deg 74% 60%) 41%,
      hsl(153deg 83% 57%) 44%,
      hsl(164deg 92% 53%) 47%,
      hsl(174deg 100% 50%) 50%,
      hsl(185deg 99% 50%) 53%,
      hsl(196deg 98% 50%) 56%,
      hsl(207deg 97% 50%) 59%,
      hsl(218deg 95% 50%) 62%,
      hsl(229deg 94% 49%) 66%,
      hsl(241deg 93% 49%) 69%,
      hsl(252deg 92% 49%) 73%,
      hsl(263deg 90% 49%) 77%,
      hsl(274deg 90% 49%) 81%,
      hsl(285deg 88% 49%) 87%,
      hsl(296deg 87% 49%) 100%
    );
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  @media (min-width: 640px) {
    main {
      max-width: none;
    }
  }
</style>
