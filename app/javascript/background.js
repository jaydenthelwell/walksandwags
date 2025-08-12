document.addEventListener('turbo:load', function () {
  // Prevent reload loop
  if (!sessionStorage.getItem('reloaded')) {
    sessionStorage.setItem('reloaded', 'true');
    console.log("Page loaded for the first time, flag set.");
  } else {
    sessionStorage.removeItem('reloaded');
    console.log("Page loaded after reload, flag removed.");
  }

  console.log("Turbo page load!");

  const navbar = document.querySelector('.navbar');
  const sections = document.querySelectorAll('section');
  const navbarText = document.querySelectorAll('.navbar-text-color');
  const logoImage = document.querySelector('#logo-image');
  const openBtn = document.querySelector('.openbtn');

  // Intersection Observer options
  const observerOptions = {
    root: null,
    rootMargin: '0px',
    threshold: 0.30
  };

  // Function to apply styles for each section
  function applyStylesForSection(section) {
    if (section.id === "section1" && section.classList.contains('image-bg')) {
      navbar.style.backgroundColor = 'transparent';
      navbar.style.boxShadow = "none";
    } else if (section.classList.contains('color-bg')) {
      navbar.style.backgroundColor = window.getComputedStyle(section).backgroundColor;
    }

    navbarText.forEach(link => {
      if (["section3", "section4", "section6"].includes(section.id)) {
        navbar.style.boxShadow = "none";
        link.style.setProperty('color', '#032B22', 'important');
        openBtn.style.color = "#032B22";
        link.style.setProperty('text-shadow', '', 'important');
        logoImage.src = logoImage.dataset.darkSrc;
      } else {
        openBtn.style.color = "#EFEDE7";
        link.style.setProperty('color', '', 'important');
        link.style.setProperty('text-shadow', '2px 2px 4px rgba(0, 0, 0, 0.5)', 'important');
      }
    });

    if (!["section3", "section4", "section6"].includes(section.id)) {
      logoImage.src = logoImage.dataset.defaultSrc;
    }
  }

  // Check the initial section on page load
  function checkInitialSection() {
    const currentSection = Array.from(sections).find(section => {
      const rect = section.getBoundingClientRect();
      return rect.top <= window.innerHeight * 0.7 && rect.bottom >= window.innerHeight * 0.7;
    });

    if (currentSection) {
      applyStylesForSection(currentSection);
    }
  }

  // Initial check
  checkInitialSection();

  // Set up IntersectionObserver
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        applyStylesForSection(entry.target);
      }
    });
  }, observerOptions);

  // Observe all sections
  sections.forEach(section => observer.observe(section));
});
