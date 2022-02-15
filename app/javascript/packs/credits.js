document.addEventListener('DOMContentLoaded', () => {
  const logo = document.querySelector("#logo")
  logo.addEventListener('click', (e) => {
    if (e.altKey) {
      alert('Criado por Alex Ramos')
    } else {
      window.location.href = "/";
    }
  })
})