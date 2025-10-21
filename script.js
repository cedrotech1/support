// Global variables
const appData = window.appData || {};
let currentPath = '';
let breadcrumbs = [];

// DOM Elements
const mainNav = document.getElementById('main-nav');
const contentDiv = document.getElementById('content');
const articleContent = document.getElementById('article-content');
const welcomeMessage = document.getElementById('welcome-message');
const breadcrumbsEl = document.getElementById('breadcrumbs');

// Initialize the application
function initApp() {
    console.log('initApp called');
    console.log('appData:', window.appData);
    
    // Make sure DOM is ready
    if (document.readyState === 'loading') {
        console.log('Waiting for DOM to load...');
        document.addEventListener('DOMContentLoaded', () => {
            console.log('DOM fully loaded, initializing...');
            renderNavigation();
            handleInitialLoad();
        });
    } else {
        console.log('DOM already loaded, initializing directly');
        renderNavigation();
        handleInitialLoad();
    }
}

// Initialize the app when the script loads
initApp();

// Render support categories and articles with collapsible functionality
function renderSupportCategories() {
    if (!window.appData.support?.categories) return '';
    
    return window.appData.support.categories.map(category => {
        const categoryId = `category-${category.title.toLowerCase().replace(/\s+/g, '-')}`;
        const items = category.items.map(item => {
            const article = window.appData.support.articles[item.id];
            if (!article) return '';
            
            return `
                <li class="pl-2">
                    <a href="#support/${item.id}" 
                       class="flex items-center px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-100 rounded-md group"
                       data-path="support/${item.id}">
                        <i class="fas fa-file-alt w-4 mr-3 text-gray-400 group-hover:text-gray-500"></i>
                        <span>${article.title}</span>
                    </a>
                </li>
            `;
        }).join('');

        return `
            <li class="mt-2">
                <button type="button" 
                        class="flex items-center justify-between w-full px-4 py-2 text-sm font-medium text-left text-gray-900 bg-gray-50 rounded-md hover:bg-gray-100 focus:outline-none"
                        aria-expanded="false"
                        data-category="${categoryId}">
                    <span>${category.title}</span>
                    <svg class="w-5 h-5 text-gray-400 transform transition-transform duration-200" 
                         fill="none" 
                         viewBox="0 0 24 24" 
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                    </svg>
                </button>
                <ul id="${categoryId}" class="pl-2 mt-1 space-y-1 overflow-hidden max-h-0 transition-all duration-200 ease-in-out">
                    ${items}
                </ul>
            </li>
        `;
    }).join('');
}

// Render navigation menu
function renderNavigation() {
    console.log('renderNavigation called');
    console.log('appData:', window.appData);
    
    if (!window.appData) {
        console.error('No appData found');
        return;
    }

    let navHTML = '';
    
    // Only show Support Center in navigation
    if (window.appData.support?.categories) {
        navHTML = `
            <div class="mb-6">
                <h3 class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">
                    Support Center
                </h3>
                <ul class="space-y-1">
                    ${renderSupportCategories()}
                </ul>
            </div>
        `;
    }

    mainNav.innerHTML = navHTML;
    setupEventListeners();
}

// Recursively render menu items and submenus
function renderMenuItems(items, parentId = '') {
    return items.map(item => {
        const hasChildren = item.items && item.items.length > 0;
        const itemId = parentId ? `${parentId}-${item.slug.split('/').pop()}` : item.slug.split('/').pop();
        
        return `
            <li>
                <a href="#${item.slug}" 
                   class="flex items-center px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-100 rounded-md group"
                   data-path="${item.slug}">
                    ${item.icon ? `<i class="fas fa-${item.icon.toLowerCase()} w-5 mr-3 text-gray-400 group-hover:text-gray-500"></i>` : ''}
                    <span>${item.title}</span>
                    ${hasChildren ? '<i class="fas fa-chevron-down ml-auto text-xs text-gray-400"></i>' : ''}
                </a>
                ${hasChildren ? `
                    <ul class="pl-4 mt-1 hidden" id="submenu-${itemId}">
                        ${renderMenuItems(item.items, itemId)}
                    </ul>
                ` : ''}
            </li>
        `;
    }).join('');
}

// Setup event listeners for navigation and collapsible categories
function setupEventListeners() {
    // Handle menu item clicks
    document.querySelectorAll('[data-path]').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const path = link.getAttribute('data-path');
            navigateTo(path);
        });
    });

    // Handle category toggles
    document.querySelectorAll('[data-category]').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            const categoryId = button.getAttribute('data-category');
            const categoryContent = document.getElementById(categoryId);
            const isExpanded = button.getAttribute('aria-expanded') === 'true';
            
            // Toggle the category
            button.setAttribute('aria-expanded', !isExpanded);
            const icon = button.querySelector('svg');
            
            if (isExpanded) {
                categoryContent.style.maxHeight = '0';
                icon.classList.remove('rotate-180');
                button.classList.remove('bg-gray-100');
            } else {
                categoryContent.style.maxHeight = categoryContent.scrollHeight + 'px';
                icon.classList.add('rotate-180');
                button.classList.add('bg-gray-100');
            }
        });
    });
}

// Handle initial page load
function handleInitialLoad() {
    const hash = window.location.hash.substring(1);
    if (hash) {
        navigateTo(hash);
    } else if (appData.meta && appData.meta.defaultPage) {
        navigateTo(appData.meta.defaultPage.replace(':', '/'));
    }
}

// Navigate to a specific path
function navigateTo(path) {
    currentPath = path;
    window.location.hash = path;
    
    // Update active states
    document.querySelectorAll('[data-path]').forEach(el => {
        el.classList.remove('bg-blue-50', 'text-blue-700');
        if (el.getAttribute('data-path') === path) {
            el.classList.add('bg-blue-50', 'text-blue-700');
        }
    });
    
    // Update content
    loadContent(path);
    updateBreadcrumbs(path);
}

// Enhanced markdown to HTML conversion
function markdownToHtml(markdown) {
    if (!markdown) return '';
    
    // Process blockquotes first
    let html = markdown.replace(/^> (.*$)/gm, '<blockquote class="border-l-4 border-gray-300 pl-4 text-gray-600 my-4">$1</blockquote>');
    
    // Process headings
    html = html
        .replace(/^# (.*$)/gm, '<h1 class="text-2xl font-bold mb-4 mt-6">$1</h1>')
        .replace(/^## (.*$)/gm, '<h2 class="text-xl font-semibold mt-6 mb-3 pb-2 border-b border-gray-100">$1</h2>')
        .replace(/^### (.*$)/gm, '<h3 class="text-lg font-medium mt-5 mb-2">$1</h3>');

    // Process lists
    html = html
        .replace(/^\s*[-*+] (.*$)/gm, '<li class="ml-4 mb-1">$1</li>')  // Unordered lists
        .replace(/^\s*\d+\. (.*$)/gm, '<li class="ml-4 mb-1">$1</li>'); // Ordered lists

    // Process images
    html = html.replace(/(<li>.*<\/li>)/gs, function(match) {
        return match.includes('1. ') ? 
            '<ol class="list-decimal pl-6 my-2">' + match + '</ol>' :
            '<ul class="list-disc pl-6 my-2">' + match + '</ul>';
    });
    
    // Process inline formatting
    html = html
        .replace(/\*\*(.*?)\*\*/g, '<strong class="font-semibold">$1</strong>')  // Bold
        .replace(/\*(.*?)\*/g, '<em class="italic">$1</em>')  // Italic
        .replace(/~~(.*?)~~/g, '<s>$1</s>')  // Strikethrough
        .replace(/`([^`]+)`/g, '<code class="bg-gray-100 text-red-600 px-1.5 py-0.5 rounded text-sm font-mono">$1</code>');  // Inline code
    
    // Images
    html = html.replace(/!\[(.*?)\]\((.*?)\)/g, '<img src="$2" alt="$1" class="my-4 rounded-lg shadow" />');

    // Process paragraphs and line breaks
    html = html
        .replace(/\n\n/g, '</p><p class="my-4 leading-relaxed">')
        .replace(/\n/g, '<br>');
    
    // Wrap in paragraph if needed
    if (!html.startsWith('<h') && !html.startsWith('<ul') && !html.startsWith('<ol') && !html.startsWith('<blockquote')) {
        html = '<p class="my-4 leading-relaxed">' + html + '</p>';
    }
    
    return html;
}

// Load content based on path
function loadContent(path) {
    console.log('Loading content for path:', path);
    const [section, ...rest] = path.split('/');
    
    // Check if it's a support article
    if (section === 'support' && window.appData.support?.articles) {
        const articleId = rest[0];
        const article = window.appData.support.articles[articleId];
        
        if (article) {
            welcomeMessage.classList.add('hidden');
            articleContent.classList.remove('hidden');
            
            // Convert markdown to HTML with proper formatting
            const htmlContent = article.body
                // Headers
                .replace(/^# (.*$)/gm, '<h1 class="text-2xl font-bold my-4">$1</h1>')
                .replace(/^## (.*$)/gm, '<h2 class="text-xl font-semibold my-3">$1</h2>')
                .replace(/^### (.*$)/gm, '<h3 class="text-lg font-medium my-2">$1</h3>')
                // Bold and italic
                .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
                .replace(/\*(.*?)\*/g, '<em>$1</em>')
                // Lists
                .replace(/^(\d+)\.\s+(.*$)/gm, '<li class="mb-1">$2</li>')
                // Blockquotes
                .replace(/^>\s+(.*$)/gm, '<blockquote class="border-l-4 border-gray-300 pl-4 my-3 text-gray-600">$1</blockquote>')
                // Paragraphs and line breaks
                .replace(/!\[(.*?)\]\((.*?)\)/g, '<img src="$2" alt="$1" class="my-4 rounded-lg shadow" />')
                .replace(/\n\n/g, '</p><p class="my-3">')
                .replace(/\n/g, '<br>');
            
            // Handle lists
            const withLists = htmlContent.replace(/(<li>.*<\/li>)/gs, function(match) {
                return '<ol class="list-decimal pl-6 my-2">' + match + '</ol>';
            });
            
            articleContent.innerHTML = `
                <div class="mb-6">
                    <h1 class="text-2xl font-bold mb-2">${article.title}</h1>
                    ${article.updatedAt ? `<div class="text-sm text-gray-500 mb-4">Last updated: ${article.updatedAt}</div>` : ''}
                    <div class="prose max-w-none">${withLists}</div>
                </div>
            `;
            
            // Update browser title
            document.title = `${article.title} | ${window.appData.meta.product}`;
            
            return;
        }
    }
    
    // Default content if no specific content found
    if (welcomeMessage) welcomeMessage.classList.remove('hidden');
    if (articleContent) articleContent.classList.add('hidden');
    
    // Reset browser title
    document.title = window.appData.meta.product || 'Admin Panel';
}

// Update breadcrumbs based on current path
function updateBreadcrumbs(path) {
    console.log('Updating breadcrumbs for path:', path);
    if (!path || !breadcrumbsEl) {
        if (breadcrumbsEl) breadcrumbsEl.innerHTML = '';
        return;
    }
    
    const parts = path.split('/');
    let breadcrumbHTML = '';
    let currentPath = '';
    
    parts.forEach((part, index) => {
        currentPath += (index > 0 ? '/' : '') + part;
        const isLast = index === parts.length - 1;
        const displayName = part.charAt(0).toUpperCase() + part.slice(1).replace('-', ' ');
        
        breadcrumbHTML += isLast 
            ? `<span class="font-medium text-gray-900">${displayName}</span>`
            : `<a href="#${currentPath}" class="text-blue-600 hover:text-blue-800">${displayName}</a>`;
        
        if (!isLast) {
            breadcrumbHTML += '<span class="mx-2 text-gray-400">/</span>';
        }
    });
    
    breadcrumbsEl.innerHTML = breadcrumbHTML;
    
    // Add event listeners to breadcrumb links
    breadcrumbsEl.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const path = link.getAttribute('href').substring(1);
            navigateTo(path);
        });
    });
}

// Handle browser back/forward buttons
window.addEventListener('popstate', () => {
    const hash = window.location.hash.substring(1);
    if (hash) {
        navigateTo(hash);
    }
});
