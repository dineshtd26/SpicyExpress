// Toggle Navbar Menu for Small Screens
document.addEventListener('DOMContentLoaded', function () {
    const menuToggle = document.querySelector('.menu-toggle');
    const navbarMenu = document.querySelector('.navbar-menu');

    if (menuToggle) {
        menuToggle.addEventListener('click', function () {
            navbarMenu.classList.toggle('show');
        });
    }
});
