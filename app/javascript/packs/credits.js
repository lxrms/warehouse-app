document.addEventListener('DOMContentLoaded', () => {
  const logo = document.querySelector("#logo")
  logo.addEventListener('click', (e) => {
    if (e.altKey) {
      alert('App criado com Rails 6 e Bulma durante o treinamento do QSD7 da Campus Code :)')
    } else {
      window.location.href = "/";
    }
  })
})