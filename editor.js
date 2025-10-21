(() => {
  const state = {
    data: null,
    selected: null,
    search: ''
  };

  const navTree = document.getElementById('navigation-tree');
  const categoryList = document.getElementById('category-list');
  const articleList = document.getElementById('article-list');
  const articleSearch = document.getElementById('article-search');
  const editorForm = document.getElementById('editor-form');
  const emptyState = document.getElementById('empty-state');
  const downloadBtn = document.getElementById('download-json');
  const copyBtn = document.getElementById('copy-json');
  const addMenuBtn = document.getElementById('add-menu');
  const addCategoryBtn = document.getElementById('add-category');
  const addArticleBtn = document.getElementById('add-article');

  init();

  async function init() {
    try {
      const res = await fetch('data.json');
      if (!res.ok) throw new Error('Failed to load data.json');
      state.data = await res.json();
    } catch (err) {
      console.warn('[Editor] fallback dataset', err);
      state.data = { navigation: [], support: { categories: [], articles: {} } };
    }

    bindEvents();
    renderAll();
  }

  function bindEvents() {
    navTree.addEventListener('click', onNavTreeClick);
    categoryList.addEventListener('click', onCategoryClick);
    articleList.addEventListener('click', onArticleClick);

    addMenuBtn.addEventListener('click', createMenuGroup);
    addCategoryBtn.addEventListener('click', createCategory);
    addArticleBtn.addEventListener('click', createArticle);

    articleSearch.addEventListener('input', event => {
      state.search = event.target.value.toLowerCase();
      renderArticles();
    });

    downloadBtn.addEventListener('click', downloadJson);
    copyBtn.addEventListener('click', copyJsonToClipboard);
  }

  function renderAll() {
    renderNavigation();
    renderCategories();
    renderArticles();
    renderEditorPanel();
  }

  /* ---------- navigation ---------- */
  function renderNavigation() {
    const groups = state.data.navigation || [];
    if (!groups.length) {
      navTree.innerHTML = '<li class="text-xs text-gray-500 px-3 py-2">No menus yet.</li>';
      return;
    }

    navTree.innerHTML = groups
      .map((group, groupIndex) => {
        const path = `navigation.${groupIndex}`;
        const isSelected = state.selected?.type === 'navigation' && state.selected.path === path;
        return `
          <li class="space-y-1">
            <button type="button" data-path="${path}" class="nav-node ${isSelected ? 'is-active' : ''}">
              <span class="font-medium">${escapeHtml(group.title || group.id || 'Menu Group')}</span>
              <span class="badge">Group</span>
            </button>
            ${Array.isArray(group.items) && group.items.length ? `
              <ul class="ml-4 space-y-1">
                ${group.items
                  .map((item, itemIndex) => {
                    const itemPath = `${path}.items.${itemIndex}`;
                    const active = state.selected?.type === 'navigation' && state.selected.path === itemPath;
                    return `
                      <li>
                        <button type="button" data-path="${itemPath}" class="nav-node ${active ? 'is-active' : ''}">
                          <span>${escapeHtml(item.title || 'Untitled')}</span>
                          ${item.slug ? `<span class="text-xs text-gray-400 truncate ml-2">${escapeHtml(item.slug)}</span>` : ''}
                        </button>
                      </li>
                    `;
                  })
                  .join('')}
              </ul>
            ` : ''}
          </li>
        `;
      })
      .join('');
  }

  function onNavTreeClick(event) {
    const button = event.target.closest('[data-path]');
    if (!button) return;
    event.preventDefault();
    state.selected = { type: 'navigation', path: button.dataset.path };
    renderAll();
  }

  function createMenuGroup() {
    const group = { id: slugify('menu-group'), title: 'New Menu Group', items: [] };
    state.data.navigation = state.data.navigation || [];
    state.data.navigation.push(group);
    state.selected = { type: 'navigation', path: `navigation.${state.data.navigation.length - 1}` };
    renderAll();
  }

  function addSubMenu(path, node) {
    node.items = node.items || [];
    node.items.push({ title: 'New Item', slug: '', icon: '' });
    state.selected = { type: 'navigation', path: `${path}.items.${node.items.length - 1}` };
    renderAll();
  }

  /* ---------- categories ---------- */
  function renderCategories() {
    const categories = state.data.support?.categories || [];
    if (!categories.length) {
      categoryList.innerHTML = '<li class="text-xs text-gray-500 px-3 py-2">No categories yet.</li>';
      return;
    }

    categoryList.innerHTML = categories
      .map((category, index) => {
        const path = `support.categories.${index}`;
        const isSelected = state.selected?.type === 'category' && state.selected.path === path;
        return `
          <li class="space-y-1">
            <button type="button" data-path="${path}" class="category-node ${isSelected ? 'is-active' : ''}">
              ${escapeHtml(category.title || 'Category')}
            </button>
            ${Array.isArray(category.items) && category.items.length ? `
              <ul class="ml-4 space-y-1 text-xs text-gray-500">
                ${category.items
                  .map(item => `<li>${escapeHtml(item.title || item.id || '')}</li>`)
                  .join('')}
              </ul>
            ` : ''}
          </li>
        `;
      })
      .join('');
  }

  function onCategoryClick(event) {
    const button = event.target.closest('[data-path]');
    if (!button) return;
    event.preventDefault();
    state.selected = { type: 'category', path: button.dataset.path };
    renderAll();
  }

  function createCategory() {
    const categories = state.data.support?.categories || (state.data.support = { categories: [], articles: {} }).categories;
    const category = { title: 'New Category', items: [] };
    categories.push(category);
    state.selected = { type: 'category', path: `support.categories.${categories.length - 1}` };
    renderAll();
  }

  /* ---------- articles ---------- */
  function renderArticles() {
    const articles = state.data.support?.articles || {};
    const entries = Object.entries(articles)
      .map(([id, article]) => ({ id, title: article.title || id, updatedAt: article.updatedAt || '' }))
      .filter(entry => {
        if (!state.search) return true;
        return entry.id.toLowerCase().includes(state.search) || entry.title.toLowerCase().includes(state.search);
      })
      .sort((a, b) => a.title.localeCompare(b.title));

    if (!entries.length) {
      articleList.innerHTML = '<li class="text-xs text-gray-500 px-3 py-2">No articles.</li>';
      return;
    }

    articleList.innerHTML = entries
      .map(entry => {
        const isSelected = state.selected?.type === 'article' && state.selected.articleId === entry.id;
        return `
          <li>
            <button type="button" data-article-id="${entry.id}" class="article-node ${isSelected ? 'is-active' : ''}">
              <div class="flex items-center justify-between">
                <span class="truncate">${escapeHtml(entry.title)}</span>
                ${entry.updatedAt ? `<span class="text-[10px] uppercase tracking-wide text-gray-400 ml-2">${escapeHtml(entry.updatedAt)}</span>` : ''}
              </div>
              <div class="text-xs text-gray-400 truncate">${escapeHtml(entry.id)}</div>
            </button>
          </li>
        `;
      })
      .join('');
  }

  function onArticleClick(event) {
    const button = event.target.closest('[data-article-id]');
    if (!button) return;
    event.preventDefault();
    const id = button.dataset.articleId;
    state.selected = { type: 'article', articleId: id };
    renderAll();
  }

  function createArticle() {
    const support = state.data.support || (state.data.support = { categories: [], articles: {} });
    const id = ensureUniqueKey('new-article', support.articles);
    support.articles[id] = {
      id,
      title: 'New Article',
      format: 'md',
      updatedAt: new Date().toISOString().slice(0, 10),
      tags: [],
      body: '# Heading\n\nStart writing markdown...'
    };
    state.selected = { type: 'article', articleId: id };
    renderAll();
  }

  /* ---------- editor panel ---------- */
  function renderEditorPanel() {
    if (!state.selected) {
      editorForm.classList.add('hidden');
      emptyState.classList.remove('hidden');
      editorForm.innerHTML = '';
      return;
    }

    emptyState.classList.add('hidden');
    editorForm.classList.remove('hidden');

    if (state.selected.type === 'navigation') {
      renderNavigationForm();
    } else if (state.selected.type === 'category') {
      renderCategoryForm();
    } else if (state.selected.type === 'article') {
      renderArticleForm();
    }
  }

  function renderNavigationForm() {
    const node = getByPath(state.selected.path);
    if (!node) return;
    const isGroup = Array.isArray(node.items);

    editorForm.innerHTML = `
      <header class="editor-header">
        <div>
          <h2>${isGroup ? 'Menu Group' : 'Menu Item'}</h2>
          <p class="path">Path: ${escapeHtml(state.selected.path)}</p>
        </div>
        <div class="actions">
          <button type="button" data-action="duplicate" class="link">Duplicate</button>
          <button type="button" data-action="delete" class="link danger">Delete</button>
        </div>
      </header>
      <p class="form-status hidden"></p>
      <div class="grid md:grid-cols-2 gap-4">
        ${isGroup ? `
          <label class="field">
            <span>ID</span>
            <input name="id" value="${escapeAttr(node.id || '')}" />
          </label>
        ` : ''}
        <label class="field ${isGroup ? '' : 'md:col-span-2'}">
          <span>Title</span>
          <input name="title" value="${escapeAttr(node.title || '')}" required />
        </label>
        ${!isGroup ? `
          <label class="field">
            <span>Slug</span>
            <input name="slug" value="${escapeAttr(node.slug || '')}" placeholder="platform/dashboard" />
          </label>
          <label class="field">
            <span>Icon</span>
            <input name="icon" value="${escapeAttr(node.icon || '')}" placeholder="Home" />
          </label>
        ` : ''}
      </div>
      <div class="mt-6 flex items-center space-x-3">
        <button type="submit" class="btn-primary">Save changes</button>
        ${isGroup ? '<button type="button" data-action="add-child" class="btn-secondary">+ Add sub-item</button>' : ''}
      </div>
      ${isGroup && node.items && node.items.length ? `
        <div class="mt-8">
          <h3 class="section-title">Sub-items (${node.items.length})</h3>
          <ul class="space-y-2">
            ${node.items
              .map((child, index) => `
                <li>
                  <button type="button" data-path="${state.selected.path}.items.${index}" class="sub-node">
                    <span>${escapeHtml(child.title || 'Untitled')}</span>
                    ${child.slug ? `<span class="muted">${escapeHtml(child.slug)}</span>` : ''}
                  </button>
                </li>
              `)
              .join('')}
          </ul>
        </div>
      ` : ''}
    `;

    editorForm.onsubmit = event => {
      event.preventDefault();
      const formData = new FormData(editorForm);
      const title = formData.get('title').trim();
      if (!title) return showStatus('Title is required.', 'error');
      node.title = title;

      if (isGroup) {
        node.id = formData.get('id').trim() || slugify(title);
      } else {
        node.slug = formData.get('slug').trim() || slugify(title);
        node.icon = formData.get('icon').trim();
      }

      renderNavigation();
      showStatus('Saved menu changes.', 'success');
    };

    editorForm.querySelector('[data-action="delete"]').addEventListener('click', () => {
      if (!confirm('Delete this menu entry?')) return;
      deleteByPath(state.selected.path);
      state.selected = null;
      renderAll();
    });

    editorForm.querySelector('[data-action="duplicate"]').addEventListener('click', () => {
      const parentInfo = getParent(state.selected.path);
      if (!parentInfo) return;
      const clone = deepClone(node);
      clone.title = `${clone.title || 'Copy'} (copy)`;
      if (!Array.isArray(clone.items)) {
        clone.slug = ensureUniqueSlug(clone.slug || slugify(clone.title));
      } else {
        clone.id = ensureUniqueId(clone.id || slugify(clone.title || 'group'));
      }
      parentInfo.container.splice(parentInfo.key + 1, 0, clone);
      const newPath = `${parentInfo.base}.${parentInfo.key + 1}`;
      state.selected = { type: 'navigation', path: newPath };
      renderAll();
    });

    const addChildBtn = editorForm.querySelector('[data-action="add-child"]');
    addChildBtn?.addEventListener('click', () => addSubMenu(state.selected.path, node));

    editorForm.querySelectorAll('.sub-node').forEach(btn => {
      btn.addEventListener('click', () => {
        state.selected = { type: 'navigation', path: btn.dataset.path };
        renderAll();
      });
    });
  }

  function renderCategoryForm() {
    const category = getByPath(state.selected.path);
    if (!category) return;
    category.items = category.items || [];

    editorForm.innerHTML = `
      <header class="editor-header">
        <div>
          <h2>Support Category</h2>
          <p class="path">Path: ${escapeHtml(state.selected.path)}</p>
        </div>
        <div class="actions">
          <button type="button" data-action="delete" class="link danger">Delete</button>
        </div>
      </header>
      <p class="form-status hidden"></p>
      <div class="space-y-4">
        <label class="field">
          <span>Title</span>
          <input name="title" value="${escapeAttr(category.title || '')}" required />
        </label>
      </div>
      <div class="mt-6">
        <div class="flex items-center justify-between">
          <h3 class="section-title">Category Items</h3>
          <button type="button" data-action="add-item" class="btn-secondary">+ Add item</button>
        </div>
        <div class="space-y-3 mt-3" id="category-items">
          ${category.items
            .map((item, index) => `
              <div class="category-item" data-index="${index}">
                <label class="field">
                  <span>Item ID</span>
                  <input name="item-${index}-id" value="${escapeAttr(item.id || '')}" required />
                </label>
                <label class="field">
                  <span>Item title</span>
                  <input name="item-${index}-title" value="${escapeAttr(item.title || '')}" required />
                </label>
                <button type="button" data-action="remove" data-index="${index}" class="link danger">Remove</button>
              </div>
            `)
            .join('')}
        </div>
      </div>
      <div class="mt-6">
        <button type="submit" class="btn-primary">Save changes</button>
      </div>
    `;

    editorForm.onsubmit = event => {
      event.preventDefault();
      const formData = new FormData(editorForm);
      category.title = formData.get('title').trim() || 'Untitled Category';
      const itemsContainer = editorForm.querySelector('#category-items');
      const newItems = [];
      itemsContainer.querySelectorAll('.category-item').forEach(row => {
        const idx = row.dataset.index;
        const id = formData.get(`item-${idx}-id`).trim();
        const title = formData.get(`item-${idx}-title`).trim();
        if (id && title) newItems.push({ id, title });
      });
      category.items = newItems;
      renderCategories();
      showStatus('Category saved.', 'success');
    };

    editorForm.querySelector('[data-action="delete"]').addEventListener('click', () => {
      if (!confirm('Delete this category?')) return;
      deleteByPath(state.selected.path);
      state.selected = null;
      renderAll();
    });

    editorForm.querySelector('[data-action="add-item"]').addEventListener('click', () => {
      category.items.push({ id: ensureUniqueId('new-item'), title: 'New Item' });
      renderEditorPanel();
    });

    editorForm.querySelectorAll('[data-action="remove"]').forEach(btn => {
      btn.addEventListener('click', () => {
        const index = Number(btn.dataset.index);
        category.items.splice(index, 1);
        renderEditorPanel();
      });
    });
  }

  function renderArticleForm() {
    const article = state.data.support?.articles?.[state.selected.articleId];
    if (!article) return;

    editorForm.innerHTML = `
      <header class="editor-header">
        <div>
          <h2>Article</h2>
          <p class="path">ID: ${escapeHtml(article.id)}</p>
        </div>
        <div class="actions">
          <button type="button" data-action="delete" class="link danger">Delete</button>
        </div>
      </header>
      <p class="form-status hidden"></p>
      <div class="grid md:grid-cols-2 gap-4">
        <label class="field">
          <span>Title</span>
          <input name="title" value="${escapeAttr(article.title || '')}" required />
        </label>
        <label class="field">
          <span>Updated at</span>
          <input name="updatedAt" value="${escapeAttr(article.updatedAt || '')}" placeholder="2025-10-20" />
        </label>
        <label class="field">
          <span>Tags (comma separated)</span>
          <input name="tags" value="${escapeAttr((article.tags || []).join(', '))}" />
        </label>
        <label class="field">
          <span>Format</span>
          <select name="format">
            <option value="md" ${article.format === 'md' ? 'selected' : ''}>Markdown</option>
            <option value="html" ${article.format === 'html' ? 'selected' : ''}>HTML</option>
          </select>
        </label>
      </div>
      <label class="field mt-4">
        <span>Body (Markdown)</span>
        <textarea name="body" rows="18" class="textarea">${escapeHtml(article.body || '')}</textarea>
      </label>
      <div class="mt-6 flex items-center space-x-3">
        <button type="submit" class="btn-primary">Save article</button>
      </div>
    `;

    editorForm.onsubmit = event => {
      event.preventDefault();
      const formData = new FormData(editorForm);
      article.title = formData.get('title').trim() || article.id;
      article.updatedAt = formData.get('updatedAt').trim();
      article.tags = formData.get('tags').split(',').map(tag => tag.trim()).filter(Boolean);
      article.format = formData.get('format');
      article.body = formData.get('body');
      renderArticles();
      showStatus('Article saved.', 'success');
    };

    editorForm.querySelector('[data-action="delete"]').addEventListener('click', () => {
      if (!confirm('Delete this article?')) return;
      delete state.data.support.articles[article.id];
      state.selected = null;
      renderAll();
    });
  }

  /* ---------- helpers ---------- */
  function renderEditorAgainIfMatches(path) {
    if (state.selected?.path === path) renderEditorPanel();
  }

  function getByPath(path) {
    return path.split('.').reduce((acc, key) => {
      if (acc === undefined || acc === null) return undefined;
      if (key === '') return acc;
      if (Array.isArray(acc)) return acc[Number(key)];
      return acc[key];
    }, state.data);
  }

  function deleteByPath(path) {
    const parent = getParent(path);
    if (!parent) return;
    parent.container.splice(parent.key, 1);
  }

  function getParent(path) {
    const parts = path.split('.');
    const key = parts.pop();
    const base = parts.join('.');
    const container = base ? getByPath(base) : state.data;
    if (!Array.isArray(container)) return null;
    return { container, key: Number(key), base };
  }

  function ensureUniqueKey(prefix, object) {
    let counter = 1;
    let candidate = prefix;
    while (object[candidate]) {
      counter += 1;
      candidate = `${prefix}-${counter}`;
    }
    return candidate;
  }

  function ensureUniqueSlug(slug) {
    const existing = new Set();
    (state.data.navigation || []).forEach(group => {
      (group.items || []).forEach(item => {
        if (item.slug) existing.add(item.slug);
      });
    });

    let candidate = slug;
    let i = 1;
    while (existing.has(candidate)) {
      candidate = `${slug}-${i++}`;
    }
    return candidate;
  }

  function ensureUniqueId(base) {
    const existing = new Set();
    (state.data.support?.categories || []).forEach(category => {
      (category.items || []).forEach(item => existing.add(item.id));
    });

    let candidate = base;
    let i = 1;
    while (existing.has(candidate)) {
      candidate = `${base}-${i++}`;
    }
    return candidate;
  }

  function slugify(value) {
    return value
      .toLowerCase()
      .trim()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/(^-|-$)/g, '')
      || 'item';
  }

  function showStatus(message, type) {
    const status = editorForm.querySelector('.form-status');
    if (!status) return;
    status.textContent = message;
    status.classList.remove('hidden', 'text-red-600', 'text-green-600');
    status.classList.add(type === 'error' ? 'text-red-600' : 'text-green-600');
    setTimeout(() => status.classList.add('hidden'), 2500);
  }

  function deepClone(value) {
    return JSON.parse(JSON.stringify(value));
  }

  function escapeHtml(value) {
    return (value || '')
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  function escapeAttr(value) {
    return escapeHtml(value).replace(/"/g, '&quot;');
  }

  function downloadJson() {
    const blob = new Blob([JSON.stringify(state.data, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = 'data.json';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  }

  async function copyJsonToClipboard() {
    try {
      await navigator.clipboard.writeText(JSON.stringify(state.data, null, 2));
      alert('JSON copied to clipboard.');
    } catch (err) {
      alert('Clipboard unavailable: ' + err.message);
    }
  }
})();
