/**
 * Manga Recommender - Main JS File
 */

// Setup search suggestions dropdown for any search input
function setupSearchSuggestions(inputId, suggestionsContainerId, formId) {
    const searchInput = document.getElementById(inputId);
    const suggestionsContainer = document.getElementById(suggestionsContainerId);
    let debounceTimer;
    
    if (!searchInput || !suggestionsContainer) {
        console.error(`Elements not found: input=${inputId}, suggestions=${suggestionsContainerId}`);
        return;
    }
    
    // Event listener for input in search box
    searchInput.addEventListener('input', function() {
        const query = this.value.trim();
        console.log(`Search input (${inputId}):`, query);
        
        // Clear existing timer
        clearTimeout(debounceTimer);
        
        // Hide suggestions if query is too short
        if (query.length < 2) {
            suggestionsContainer.style.display = 'none';
            return;
        }
        
        // Show loading indicator if available
        const loadingIndicator = document.querySelector('.htmx-indicator');
        if (loadingIndicator) {
            loadingIndicator.style.display = 'flex';
        }
        
        // Debounce the API call
        debounceTimer = setTimeout(() => {
            const url = `/api/search_suggestions?q=${encodeURIComponent(query)}`;
            console.log(`Fetching suggestions for (${inputId}):`, url);
            
            fetch(url)
                .then(response => {
                    console.log(`Response status for (${inputId}):`, response.status);
                    return response.json();
                })
                .then(data => {
                    console.log(`Suggestions data for (${inputId}):`, data);
                    
                    // Hide loading indicator if available
                    if (loadingIndicator) {
                        loadingIndicator.style.display = 'none';
                    }
                    
                    // Clear previous suggestions
                    suggestionsContainer.innerHTML = '';
                    
                    if (data.length > 0) {
                        // Add new suggestions
                        data.forEach(manga => {
                            const item = document.createElement('div');
                            item.className = 'suggestion-item';
                            
                            const englishTitle = manga.english_title ? 
                                `<div class="suggestion-english">${manga.english_title}</div>` : '';
                            
                            item.innerHTML = `
                                <img src="${manga.image_url}" alt="${manga.title}" class="suggestion-img" 
                                     onerror="this.onerror=null; this.src='/static/img/no-cover.jpg'">
                                <div class="suggestion-info">
                                    <div class="suggestion-title">${manga.title}</div>
                                    ${englishTitle}
                                    <small class="badge bg-primary">${manga.score || 'N/A'}</small>
                                </div>
                            `;
                            
                            // When clicked, fill the search box and submit the form
                            item.addEventListener('click', function() {
                                searchInput.value = manga.title;
                                suggestionsContainer.style.display = 'none';
                                document.getElementById(formId).submit();
                            });
                            
                            suggestionsContainer.appendChild(item);
                        });
                        
                        // Show suggestions
                        suggestionsContainer.style.display = 'block';
                    } else {
                        suggestionsContainer.style.display = 'none';
                    }
                })
                .catch(error => {
                    console.error(`Error fetching suggestions for (${inputId}):`, error);
                    // Hide loading indicator on error
                    if (loadingIndicator) {
                        loadingIndicator.style.display = 'none';
                    }
                });
        }, 300); // 300ms debounce
    });
    
    // Hide suggestions when clicking outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest(`#${suggestionsContainerId}`) && event.target !== searchInput) {
            suggestionsContainer.style.display = 'none';
        }
    });
    
    // Show suggestions when focusing on input if it has content
    searchInput.addEventListener('focus', function() {
        if (this.value.trim().length >= 2) {
            // Trigger the input event to load suggestions
            searchInput.dispatchEvent(new Event('input'));
        }
    });
}

// Initialize all search dropdowns when document is ready
document.addEventListener('DOMContentLoaded', function() {
    // Set up the navbar search suggestions
    setupSearchSuggestions('searchInput', 'searchSuggestions', 'searchForm');
    
    // Initialize other site-wide functionality here
}); 