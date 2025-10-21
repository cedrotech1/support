<?php
/* ---------- AJAX & DOWNLOAD HANDLER ---------- */
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    header('Content-Type: application/json; charset=utf-8');
    $pdo = new PDO('mysql:host=localhost;dbname=innovate_rwanda;charset=utf8mb4', 'root', '');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $action = $_POST['action'] ?? '';

    function err($msg) { echo json_encode(['success' => false, 'error' => $msg]); exit; }

    if ($action === 'get_categories') {
        $stmt = $pdo->query("SELECT id,title,position FROM support_categories ORDER BY position");
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll(PDO::FETCH_ASSOC)]);
    } elseif ($action === 'get_items') {
        $cat = $_POST['category_id'] ?? 0;
        $stmt = $pdo->prepare("SELECT id,title,article_id FROM support_category_items WHERE category_id=? ORDER BY id");
        $stmt->execute([$cat]);
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll(PDO::FETCH_ASSOC)]);
    } elseif ($action === 'add_category') {
        $title = trim($_POST['title'] ?? '');
        empty($title) && err('Title required');
        $pos = $pdo->query("SELECT COALESCE(MAX(position),0)+1 FROM support_categories")->fetchColumn();
        $pdo->prepare("INSERT INTO support_categories (title,position) VALUES (?,?)")->execute([$title, $pos]);
        echo json_encode(['success' => true]);
    } elseif ($action === 'edit_category') {
        $id = $_POST['id'] ?? 0;
        $title = trim($_POST['title'] ?? '');
        empty($id) || empty($title) && err('ID & title required');
        $pdo->prepare("UPDATE support_categories SET title=? WHERE id=?")->execute([$title, $id]);
        echo json_encode(['success' => true]);
    } elseif ($action === 'delete_category') {
        $id = $_POST['id'] ?? 0;
        empty($id) && err('ID required');
        $pdo->beginTransaction();
        $pdo->prepare("DELETE FROM support_category_items WHERE category_id=?")->execute([$id]);
        $pdo->prepare("DELETE FROM support_categories WHERE id=?")->execute([$id]);
        $pdo->commit();
        echo json_encode(['success' => true]);
    } elseif ($action === 'add_item') {
        $cat = $_POST['category_id'] ?? 0;
        $title = trim($_POST['title'] ?? '');
        empty($cat) || empty($title) && err('All fields required');
        $aid = preg_replace('/[^a-z0-9]+/', '-', strtolower($title));
        $aid = trim($aid, '-');
        $base = $aid;
        $i = 1;
        while ($pdo->query("SELECT 1 FROM support_articles WHERE id='$aid'")->fetch()) $aid = $base . '-' . $i++;
        $pdo->beginTransaction();
        $pdo->prepare("INSERT INTO support_articles (id,title,format,updated_at,body) VALUES (?,?,'md',CURDATE(),'')")->execute([$aid, $title]);
        $pdo->prepare("INSERT INTO support_category_items (category_id,title,article_id) VALUES (?,?,?)")->execute([$cat, $title, $aid]);
        $pdo->commit();
        echo json_encode(['success' => true]);
    } elseif ($action === 'edit_item') {
        $id = $_POST['item_id'] ?? 0;
        $title = trim($_POST['title'] ?? '');
        empty($id) || empty($title) && err('All fields required');
        $stmt = $pdo->prepare("SELECT article_id FROM support_category_items WHERE id=?");
        $stmt->execute([$id]);
        $aid = $stmt->fetchColumn();
        $pdo->beginTransaction();
        $pdo->prepare("UPDATE support_category_items SET title=? WHERE id=?")->execute([$title, $id]);
        $pdo->prepare("UPDATE support_articles SET title=? WHERE id=?")->execute([$title, $aid]);
        $pdo->commit();
        echo json_encode(['success' => true]);
    } elseif ($action === 'delete_item') {
        $id = $_POST['id'] ?? 0;
        empty($id) && err('ID required');
        $stmt = $pdo->prepare("SELECT article_id FROM support_category_items WHERE id=?");
        $stmt->execute([$id]);
        $aid = $stmt->fetchColumn();
        $pdo->beginTransaction();
        $pdo->prepare("DELETE FROM support_category_items WHERE id=?")->execute([$id]);
        $pdo->prepare("DELETE FROM support_articles WHERE id=?")->execute([$aid]);
        $pdo->commit();
        echo json_encode(['success' => true]);
    } elseif ($action === 'reorder_categories') {
        $order = $_POST['order'] ?? [];
        $pdo->beginTransaction();
        $stmt = $pdo->prepare("UPDATE support_categories SET position=? WHERE id=?");
        foreach ($order as $pos => $id) {
            $stmt->execute([$pos + 1, $id]);
        }
        $pdo->commit();
        echo json_encode(['success' => true]);
    } elseif ($action === 'get_article') {
        $id = $_POST['id'] ?? '';
        empty($id) && err('ID required');
        $stmt = $pdo->prepare("SELECT id,title,body FROM support_articles WHERE id=?");
        $stmt->execute([$id]);
        $art = $stmt->fetch(PDO::FETCH_ASSOC);
        $art ?: err('Not found');
        echo json_encode(['success' => true, 'data' => $art]);
    } elseif ($action === 'save_article_body') {
        $id = $_POST['article_id'] ?? '';
        $body = $_POST['body'] ?? '';
        empty($id) && err('ID required');
        $pdo->prepare("UPDATE support_articles SET body=?,updated_at=CURDATE() WHERE id=?")->execute([$body, $id]);
        echo json_encode(['success' => true]);
    } elseif ($action === 'truncate_all') {
        $pdo->beginTransaction();
        $pdo->exec("SET FOREIGN_KEY_CHECKS=0");
        foreach (['json_files','search_entries','article_tags','support_category_items','support_articles','support_categories','navigation','theme','meta'] as $t) {
            $pdo->exec("TRUNCATE TABLE $t");
        }
        $pdo->exec("SET FOREIGN_KEY_CHECKS=1");
        $pdo->commit();
        echo json_encode(['success' => true]);
    } elseif ($action === 'list_json_files') {
        $stmt = $pdo->query("SELECT id,name,created_at FROM json_files ORDER BY created_at DESC");
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll(PDO::FETCH_ASSOC)]);
    } elseif ($action === 'delete_json_file') {
        $id = $_POST['id'] ?? 0;
        empty($id) && err('ID required');
        $pdo->prepare("DELETE FROM json_files WHERE id=?")->execute([$id]);
        echo json_encode(['success' => true]);
    } elseif ($action === 'upload_data') {
        if (!isset($_FILES['file']) || $_FILES['file']['error'] !== UPLOAD_ERR_OK) {
            err('Upload file or upload failed');
        }

        $json = file_get_contents($_FILES['file']['tmp_name']);
        $data = json_decode($json, true);
        if (!$data || !isset($data['meta'], $data['theme'], $data['navigation'], $data['support'])) {
            err('Invalid JSON structure');
        }

        $name = $_FILES['file']['name'];
        $stmt = $pdo->prepare("INSERT INTO json_files (name,content) VALUES (?,?)");
        try {
            $stmt->execute([$name, $json]);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                $name = pathinfo($name, PATHINFO_FILENAME) . '_' . time() . '.json';
                $stmt->execute([$name, $json]);
            } else {
                throw $e;
            }
        }

        $pdo->beginTransaction();

        $pdo->exec("SET FOREIGN_KEY_CHECKS=0");
        foreach (['search_entries','article_tags','support_category_items','support_articles','support_categories','navigation','theme','meta'] as $t) {
            $pdo->exec("TRUNCATE TABLE $t");
        }
        $pdo->exec("SET FOREIGN_KEY_CHECKS=1");

        // META
        $m = $data['meta'];
        $pdo->prepare("INSERT INTO meta (schema_version,version,generated_at,locale,product,default_page) VALUES (?,?,?,?,?,?)")
            ->execute([
                $m['schemaVersion'] ?? '1.0',
                $m['version'] ?? 'v1.0.0',
                $m['generatedAt'] ?? date('c'),
                $m['locale'] ?? 'en',
                $m['product'] ?? 'Innovate Rwanda Admin',
                $m['defaultPage'] ?? 'support:index'
            ]);

        // THEME
        if (!empty($data['theme']['tokens'])) {
            $stmt = $pdo->prepare("INSERT INTO theme (css,token_key,token_value) VALUES (?,?,?)");
            foreach ($data['theme']['tokens'] as $k => $v) {
                $css = ($k === '--brand-bg' && !empty($data['theme']['css'])) ? $data['theme']['css'] : null;
                $stmt->execute([$css, $k, $v]);
            }
        }

        // NAVIGATION
        $navMap = [];
        $pending = [];
        $stmt = $pdo->prepare("INSERT INTO navigation (id,parent_id,title,slug,icon) VALUES (NULL,?,?,?,?)");
        function insertNav($items, $parent, &$map, &$pending, $stmt, $pdo) {
            foreach ($items as $it) {
                $jsonId = $it['id'] ?? null;
                $pId = $it['parent_id'] ?? null;
                if ($pId && !isset($map[$pId])) {
                    $pending[] = ['it' => $it, 'parent' => $parent];
                    continue;
                }
                $stmt->execute([
                    $pId ? ($map[$pId] ?? null) : $parent,
                    $it['title'] ?? '',
                    $it['slug'] ?? null,
                    $it['icon'] ?? null
                ]);
                $dbId = $pdo->lastInsertId();
                if ($jsonId !== null) $map[$jsonId] = $dbId;
                if (!empty($it['items'])) insertNav($it['items'], $dbId, $map, $pending, $stmt, $pdo);
            }
        }
        insertNav($data['navigation'], null, $navMap, $pending, $stmt, $pdo);
        while (!empty($pending)) {
            $new = [];
            foreach ($pending as $p) {
                $it = $p['it'];
                $par = $p['parent'];
                $pid = $it['parent_id'] ?? null;
                if ($pid && !isset($navMap[$pid])) {
                    $new[] = $p;
                    continue;
                }
                $stmt->execute([
                    $pid ? ($navMap[$pid] ?? null) : $par,
                    $it['title'] ?? '',
                    $it['slug'] ?? null,
                    $it['icon'] ?? null
                ]);
                $navMap[$it['id'] ?? null] = $pdo->lastInsertId();
                if (!empty($it['items'])) insertNav($it['items'], $navMap[$it['id'] ?? null], $navMap, $new, $stmt, $pdo);
            }
            $pending = $new;
        }

        // SUPPORT CATEGORIES & ITEMS
        $catStmt = $pdo->prepare("INSERT INTO support_categories (title,position) VALUES (?,?)");
        $itemStmt = $pdo->prepare("INSERT INTO support_category_items (category_id,title,article_id) VALUES (?,?,?)");
        foreach ($data['support']['categories'] as $pos => $cat) {
            $catStmt->execute([$cat['title'] ?? 'Untitled', $pos + 1]);
            $catId = $pdo->lastInsertId();
            foreach ($cat['items'] as $it) {
                $itemStmt->execute([
                    $catId,
                    $it['title'] ?? 'Untitled',
                    $it['id'] ?? $it['article_id'] ?? 'unknown-' . uniqid()
                ]);
            }
        }

        // ARTICLES
        $artStmt = $pdo->prepare("INSERT INTO support_articles (id,title,format,updated_at,body) VALUES (?,?,?,?,?)");
        $tagStmt = $pdo->prepare("INSERT INTO article_tags (article_id,tag) VALUES (?,?)");
        foreach ($data['support']['articles'] as $aid => $art) {
            $artStmt->execute([
                $art['id'] ?? $aid,
                $art['title'] ?? 'Unknown',
                $art['format'] ?? 'md',
                $art['updatedAt'] ?? date('Y-m-d'),
                $art['body'] ?? ''
            ]);
            if (!empty($art['tags'])) {
                foreach ($art['tags'] as $t) {
                    $tagStmt->execute([$art['id'] ?? $aid, $t]);
                }
            }
        }

        // SEARCH ENTRIES
        $searchStmt = $pdo->prepare("INSERT INTO search_entries (article_id,term,weight) VALUES (?,?,?)");
        if (!empty($data['support']['search']['entries'])) {
            foreach ($data['support']['search']['entries'] as $aid => $list) {
                foreach ($list as $e) {
                    $searchStmt->execute([$aid, $e[0] ?? '', $e[1] ?? 1]);
                }
            }
        }

        $pdo->commit();
        echo json_encode(['success' => true, 'message' => 'Upload completed successfully']);
    } else {
        err('Invalid action');
    }
    exit;
}

/* ---------- DOWNLOAD ALL DATA ---------- */
if (isset($_GET['action']) && $_GET['action'] === 'download_data') {
    $pdo = new PDO('mysql:host=localhost;dbname=innovate_rwanda;charset=utf8mb4', 'root', '');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $out = [
        'meta' => [],
        'theme' => ['css' => '', 'tokens' => []],
        'navigation' => [],
        'support' => [
            'hero' => ['title' => 'How can we help you?', 'subtitle' => 'Search for an answer or browse our topics'],
            'categories' => [],
            'articles' => [],
            'search' => ['strategy' => 'precomputed', 'entries' => [], 'stopWords' => ['the','a','an','and','or','to','of','for','in']]
        ]
    ];

    $stmt = $pdo->query("SELECT schema_version AS schemaVersion,version,generated_at AS generatedAt,locale,product,default_page AS defaultPage FROM meta LIMIT 1");
    $out['meta'] = $stmt->fetch(PDO::FETCH_ASSOC) ?: $out['meta'];

    $stmt = $pdo->query("SELECT css,token_key,token_value FROM theme");
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $r) {
        if ($r['css']) $out['theme']['css'] = $r['css'];
        $out['theme']['tokens'][$r['token_key']] = $r['token_value'];
    }

    $stmt = $pdo->query("SELECT id,parent_id,title,slug,icon FROM navigation");
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $map = [];
    foreach ($rows as $r) $map[$r['id']] = ['id' => $r['id'], 'title' => $r['title'], 'slug' => $r['slug'], 'icon' => $r['icon'], 'items' => []];
    foreach ($rows as $r) if ($r['parent_id']) $map[$r['parent_id']]['items'][] =& $map[$r['id']];
    $out['navigation'] = array_values(array_filter($map, fn($i) => !($i['parent_id'] ?? false)));

    $stmt = $pdo->query("SELECT id,title FROM support_categories ORDER BY position");
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $c) {
        $stmt2 = $pdo->prepare("SELECT title,article_id AS id FROM support_category_items WHERE category_id=?");
        $stmt2->execute([$c['id']]);
        $c['items'] = $stmt2->fetchAll(PDO::FETCH_ASSOC);
        unset($c['id']);
        $out['support']['categories'][] = $c;
    }

    $stmt = $pdo->query("SELECT id,title,format,updated_at AS updatedAt,body FROM support_articles");
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $a) {
        $stmt2 = $pdo->prepare("SELECT tag FROM article_tags WHERE article_id=?");
        $stmt2->execute([$a['id']]);
        $a['tags'] = array_column($stmt2->fetchAll(PDO::FETCH_ASSOC), 'tag');
        $out['support']['articles'][$a['id']] = $a;
    }

    $stmt = $pdo->query("SELECT article_id,term,weight FROM search_entries");
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $s) {
        $out['support']['search']['entries'][$s['article_id']][] = [$s['term'], $s['weight']];
    }

    $json = json_encode($out, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
    $file = 'backup_' . date('Y-m-d_His') . '.json';
    $pdo->prepare("INSERT INTO json_files (name,content) VALUES (?,?)")->execute([$file, $json]);

    header('Content-Type: application/json');
    header('Content-Disposition: attachment; filename="' . $file . '"');
    echo $json;
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Support Menu Manager</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    <script src="https://unpkg.com/marked@4.0.12/lib/marked.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simplemde@1.11.2/dist/simplemde.min.css">
    <style>
        .spinner{display:none;border:3px solid #f3f3f3;border-top:3px solid #3498db;border-radius:50%;width:18px;height:18px;animation:s 1s linear infinite;margin-left:8px}
        @keyframes s{to{transform:rotate(360deg)}}
        .CodeMirror,.editor-preview{height:340px}
        .editor-preview img{max-width:100%;height:auto;border-radius:6px;margin:8px 0}
        .editor-preview{padding:12px;background:#fafafa;border:1px solid #ddd}
    </style>
</head>
<body class="bg-gray-50">
<div class="container mx-auto p-6 max-w-7xl">

<h1 class="text-4xl font-bold text-center text-indigo-700 mb-8">Support  Manager</h1> back to <a href="index.html">view updated json page</a>

<div class="grid md:grid-cols-3 gap-6 mb-8">
  <div class="bg-white p-5 rounded shadow">
    <h3 class="font-semibold mb-3">Data Controls</h3>
    <button id="truncateBtn" class="w-full bg-red-600 text-white py-2 rounded flex items-center justify-center">Truncate All <span class="spinner"></span></button>
    <a href="?action=download_data" class="block mt-3 w-full bg-green-600 text-white text-center py-2 rounded">Download All Data</a>
  </div>
  <div class="bg-white p-5 rounded shadow">
    <h3 class="font-semibold mb-3">Upload JSON</h3>
    <form id="uploadForm" enctype="multipart/form-data">
      <input type="file" name="file" accept=".json" required class="block w-full text-sm file:mr-4 file:py-2 file:px-4 file:rounded file:border-0 file:bg-indigo-600 file:text-white">
      <button type="submit" class="mt-3 w-full bg-indigo-600 text-white py-2 rounded flex items-center justify-center">Upload <span class="spinner"></span></button>
    </form>
  </div>
  <div class="bg-white p-5 rounded shadow">
    <h3 class="font-semibold mb-3">Stored Files</h3>
    <div id="jsonFilesList" class="text-sm"></div>
  </div>
</div>

<div class="bg-white p-5 rounded shadow mb-6">
  <form id="addCatForm" class="flex gap-3">
    <input type="text" name="title" placeholder="e.g. 1. Getting Started" required class="flex-1 p-3 border rounded">
    <button type="submit" class="bg-indigo-600 text-white px-6 py-3 rounded flex items-center">Add Category <span class="spinner"></span></button>
  </form>
</div>

<div id="catList" class="grid gap-6 md:grid-cols-2 lg:grid-cols-3"></div>

<div id="mdModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
  <div class="bg-white rounded w-full max-w-4xl mx-4 shadow-xl">
    <div class="p-6">
      <h2 class="text-2xl font-bold mb-4">Edit Article</h2>
      <form id="mdForm">
        <input type="hidden" name="article_id">
        <div class="mb-4"><label class="block font-medium mb-1">Title</label>
          <input type="text" name="title" readonly class="w-full p-3 border rounded bg-gray-50">
        </div>
        <div class="mb-4"><label class="block font-medium mb-1">Body (Markdown)</label>
          <textarea id="mdEditor"></textarea>
        </div>
        <div class="flex gap-3 justify-end">
          <button type="submit" class="bg-indigo-600 text-white px-5 py-2 rounded flex items-center">Save <span class="spinner"></span></button>
          <button type="button" id="dlArtBtn" class="bg-green-600 text-white px-5 py-2 rounded">Download .md</button>
          <button type="button" id="cancelMd" class="bg-gray-300 px-5 py-2 rounded">Cancel</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div id="editItemModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
  <div class="bg-white rounded w-full max-w-sm mx-4 shadow-xl">
    <div class="p-6">
      <h2 class="text-xl font-bold mb-4">Edit Item</h2>
      <form id="editItemForm">
        <input type="hidden" name="item_id">
        <div class="mb-4">
          <label class="block font-medium mb-1">Title</label>
          <input type="text" name="title" required class="w-full p-3 border rounded">
        </div>
        <div class="flex gap-3 justify-end">
          <button type="submit" class="bg-indigo-600 text-white px-4 py-2 rounded flex items-center">
            Save <span class="spinner"></span>
          </button>
          <button type="button" id="cancelEditItem" class="bg-gray-300 px-4 py-2 rounded">Cancel</button>
        </div>
      </form>
    </div>
  </div>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/simplemde@1.11.2/dist/simplemde.min.js"></script>

<script>
let smde = null;

function spin($b, on) {
    $b.find('.spinner').toggle(on);
    $b.prop('disabled', on);
}

function loadCats() {
    $.post('', {action: 'get_categories'}, r => {
        if (!r.success) return alert(r.error);
        const $l = $('#catList').empty();
        r.data.forEach(c => {
            const $c = $(`<div class="bg-white p-5 rounded-lg shadow-lg category-card" data-id="${c.id}">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-lg font-semibold cursor-pointer toggle-cat" data-id="${c.id}">${c.title} <span class="toggle-icon">▼</span></h3>
                    <div class="flex gap-2">
                        <button class="edit-cat-btn text-indigo-600 hover:text-indigo-700">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232a3.75 3.75 0 11-5.31 5.31m0 0a3.75 3.75 0 11-5.31-5.31m5.31 5.31v-.708m0 0a3.75 3.75 0 11-5.31 5.31m5.31-5.31L9.94 3.56a3.75 3.75 0 11-5.31 5.31m5.31 5.31L21.75 11.25"></path>
                            </svg>
                        </button>
                        <button class="del-cat-btn text-red-600 hover:text-red-700">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                            </svg>
                        </button>
                    </div>
                </div>
                <form class="edit-cat-form hidden flex gap-3 mb-4 p-3 bg-gray-50 rounded">
                    <input type="text" name="title" value="${c.title}" required class="flex-1 p-2 border rounded">
                    <button type="submit" class="bg-indigo-600 text-white px-4 py-2 rounded">Save</button>
                    <button type="button" class="cancel-edit bg-gray-400 text-white px-4 py-2 rounded">Cancel</button>
                </form>
                <form class="add-item-form flex gap-3 mb-4 p-3 bg-blue-50 rounded">
                    <input type="hidden" name="category_id" value="${c.id}">
                    <input type="text" name="title" placeholder="New Item Title" required class="flex-1 p-2 border rounded">
                    <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded">Add Item</button>
                </form>
                <ul class="item-list space-y-3"></ul>
            </div>`);
            $l.append($c);
            loadItems(c.id, $c.find('.item-list'));
        });
        new Sortable($l[0], {
            animation: 150,
            handle: '.category-card',
            onEnd: () => {
                const ord = [...$l.find('.category-card')].map(e => $(e).data('id'));
                $.post('', {action: 'reorder_categories', order: ord});
            }
        });
    }, 'json');
}

function loadItems(cat, $ul) {
    $.post('', {action: 'get_items', category_id: cat}, r => {
        if (!r.success) return;
        $ul.empty();
        r.data.forEach(i => $ul.append(`
            <li class="flex justify-between items-center p-4 bg-white rounded-lg shadow-sm border">
                <span class="flex-1 font-medium text-indigo-600 hover:text-indigo-700 cursor-pointer edit-body" data-id="${i.article_id}">${i.title}</span>
                <div class="flex gap-2">
                    <button class="edit-item-btn text-indigo-600 hover:text-indigo-700 p-2 rounded-full hover:bg-indigo-50" data-id="${i.id}" data-title="${i.title}" title="Edit Item">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                        </svg>
                    </button>
                    <button class="del-item-btn text-red-600 hover:text-red-700 p-2 rounded-full hover:bg-red-50" data-id="${i.id}" title="Delete Item">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                        </svg>
                    </button>
                </div>
            </li>
        `));
    }, 'json');
}

function loadFiles() {
    $.post('', {action: 'list_json_files'}, r => {
        const $l = $('#jsonFilesList').empty();
        if (!r.data.length) return $l.append('<p class="text-gray-500">No files</p>');
        r.data.forEach(f => $l.append(`
            <div class="flex justify-between items-center py-2 px-4 bg-white rounded-lg shadow-sm border">
                <span class="text-sm font-mono">${f.name}</span>
                <div class="flex gap-2">
                    <a href="?download_json=${f.id}" class="text-indigo-600 hover:text-indigo-700">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                        </svg>
                    </a>
                    <button class="del-json-btn text-red-600 hover:text-red-700 p-1 rounded" data-id="${f.id}" title="Delete">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
            </div>
        `));
    }, 'json');
}

function initEditor() {
    if (smde) return;
    smde = new SimpleMDE({
        element: document.getElementById('mdEditor'),
        spellChecker: false,
        toolbar: ["bold","italic","heading","|","quote","unordered-list","ordered-list","|","link","image","|","preview","side-by-side","fullscreen","|","guide"],
        previewRender: function(text) {
            return marked.parse(text, { gfm: true, breaks: true });
        }
    });
}

$(function() {
    loadCats();
    loadFiles();

    $(document).on('click', '.toggle-cat', function() {
        const $card = $(this).closest('.category-card');
        $card.toggleClass('category-collapsed category-expanded');
        $(this).find('.toggle-icon').text($card.hasClass('category-expanded') ? '▲' : '▼');
    });

    $(document).on('click', '.edit-body', function() {
        const id = $(this).data('id');
        $.post('', {action: 'get_article', id: id}, function(r) {
            if (!r.success) return alert(r.error);
            $('#mdModal').removeClass('hidden');
            $('#mdForm [name=article_id]').val(r.data.id);
            $('#mdForm [name=title]').val(r.data.title);
            initEditor();
            smde.value(r.data.body);
        }, 'json');
    });

    $('#mdForm').submit(function(e) {
        e.preventDefault();
        if (!smde) return alert('Editor not ready');
        const $b = $(this).find('button[type=submit]');
        spin($b, true);
        $.post('', {
            action: 'save_article_body',
            article_id: $('#mdForm [name=article_id]').val(),
            body: smde.value()
        }, function(r) {
            spin($b, false);
            if (r.success) {
                alert('Article saved!');
                $('#mdModal').addClass('hidden');
            }
        });
    });

    $('#dlArtBtn').click(function() {
        if (!smde) return;
        const blob = new Blob([smde.value()], {type: 'text/markdown'});
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = $('#mdForm [name=title]').val().replace(/[^a-z0-9]/gi,'_').toLowerCase() + '.md';
        a.click();
        URL.revokeObjectURL(url);
    });

    $('#cancelMd').click(() => $('#mdModal').addClass('hidden'));

    $('#addCatForm').submit(function(e) {
        e.preventDefault();
        const $b = $(this).find('button');
        spin($b, true);
        $.post('', {action: 'add_category', title: $('[name=title]', this).val()}, function(r) {
            spin($b, false);
            if (r.success) loadCats();
        });
    });

    $(document).on('click', '.edit-cat-btn', function() {
        $(this).closest('.category-card').find('.edit-cat-form').toggleClass('hidden');
    });

    $(document).on('submit', '.edit-cat-form', function(e) {
        e.preventDefault();
        const $f = $(this);
        const $b = $f.find('button[type=submit]');
        const id = $f.closest('.category-card').data('id');
        spin($b, true);
        $.post('', {action: 'edit_category', id: id, title: $f.find('input').val()}, function(r) {
            spin($b, false);
            if (r.success) loadCats();
        });
    });

    $(document).on('click', '.del-cat-btn', function() {
        if (!confirm('Delete category and all items?')) return;
        const id = $(this).closest('.category-card').data('id');
        $.post('', {action: 'delete_category', id: id}, function(r) {
            if (r.success) loadCats();
        });
    });

    $(document).on('submit', '.add-item-form', function(e) {
        e.preventDefault();
        const $f = $(this);
        const $b = $f.find('button[type=submit]');
        const fd = new FormData(this);
        fd.append('action', 'add_item');
        spin($b, true);
        $.ajax({
            url: '',
            type: 'POST',
            data: fd,
            processData: false,
            contentType: false,
            success: function(r) {
                spin($b, false);
                if (r.success) {
                    const catId = $f.find('[name=category_id]').val();
                    loadItems(catId, $f.closest('.category-card').find('.item-list'));
                    $f.find('[name=title]').val('');
                }
            }
        });
    });

    $(document).on('click', '.edit-item-btn', function() {
        const id = $(this).data('id');
        const title = $(this).data('title');
        $('#editItemModal').removeClass('hidden');
        $('#editItemForm [name=item_id]').val(id);
        $('#editItemForm [name=title]').val(title);
    });

    $('#editItemForm').submit(function(e) {
        e.preventDefault();
        const $b = $(this).find('button[type=submit]');
        spin($b, true);
        $.post('', {
            action: 'edit_item',
            item_id: $('#editItemForm [name=item_id]').val(),
            title: $('#editItemForm [name=title]').val()
        }, function(r) {
            spin($b, false);
            if (r.success) {
                alert('Item updated!');
                $('#editItemModal').addClass('hidden');
                const catId = $('.edit-item-btn[data-id="' + $('#editItemForm [name=item_id]').val() + '"]').closest('.category-card').data('id');
                loadItems(catId, $('.category-card[data-id="' + catId + '"] .item-list'));
            }
        });
    });

    $('#cancelEditItem').click(() => $('#editItemModal').addClass('hidden'));

    $(document).on('click', '.del-item-btn', function() {
        if (!confirm('Delete item?')) return;
        const id = $(this).data('id');
        const catId = $(this).closest('.category-card').data('id');
        $.post('', {action: 'delete_item', id: id}, function(r) {
            if (r.success) loadItems(catId, $('.category-card[data-id="' + catId + '"] .item-list'));
        });
    });

    $('#truncateBtn').click(() => {
        if (!confirm('Delete EVERYTHING?')) return;
        const $b = $(this);
        spin($b, true);
        $.post('', {action: 'truncate_all'}, function(r) {
            spin($b, false);
            if (r.success) {
                alert('All data cleared!');
                loadCats();
                loadFiles();
            }
        });
    });

    $('#uploadForm').submit(function(e) {
        e.preventDefault();
        const $form = $(this);
        const $btn = $form.find('button[type=submit]');
        const fd = new FormData(this);
        fd.append('action', 'upload_data');

        spin($btn, true);

        $.ajax({
            url: '',
            type: 'POST',
            data: fd,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function(r) {
                spin($btn, false);
                if (r.success) {
                    alert('Upload successful! Data reloaded.');
                    loadCats();
                    loadFiles();
                } else {
                    alert('Error: ' + (r.error || 'Unknown error'));
                }
            },
            error: function(xhr) {
                spin($btn, false);
                console.error('Upload failed:', xhr.responseText);
                alert('Upload failed. Check console.');
            }
        });
    });

    $(document).on('click', '.del-json-btn', function() {
        if (!confirm('Delete file?')) return;
        const id = $(this).data('id');
        $.post('', {action: 'delete_json_file', id: id}, function(r) {
            if (r.success) loadFiles();
        });
    });
});
</script>
</body>
</html>