<?php
// Database connection settings
$host = 'localhost';
$dbname = 'innovate_rwanda';
$username = 'root'; // Replace with your MySQL username
$password = ''; // Replace with your MySQL password

try {
    // Connect to MySQL using PDO
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Initialize the JSON structure
    $jsonData = [
        'meta' => [],
        'theme' => ['tokens' => []],
        'navigation' => [],
        'support' => [
            'hero' => [
                'title' => 'How can we help you?',
                'subtitle' => 'Search for an answer or browse our topics'
            ],
            'categories' => [],
            'articles' => []
        ],
        'search' => [
            'strategy' => 'precomputed',
            'entries' => [],
            'stopWords' => ['the', 'a', 'an', 'and', 'or', 'to', 'of', 'for', 'in']
        ]
    ];

    // Fetch meta data
    $stmt = $pdo->query("SELECT schema_version, version, generated_at, locale, product, default_page FROM meta LIMIT 1");
    $meta = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($meta) {
        $jsonData['meta'] = [
            'schemaVersion' => $meta['schema_version'],
            'version' => $meta['version'],
            'generatedAt' => $meta['generated_at'],
            'locale' => $meta['locale'],
            'product' => $meta['product'],
            'defaultPage' => $meta['default_page']
        ];
    }

    // Fetch theme data
    $stmt = $pdo->query("SELECT css, token_key, token_value FROM theme");
    $themes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $css = '';
    foreach ($themes as $theme) {
        if ($theme['css']) {
            $css = $theme['css'];
        }
        $jsonData['theme']['tokens'][$theme['token_key']] = $theme['token_value'];
    }
    $jsonData['theme']['css'] = $css;

    // Fetch navigation data (recursive function to build hierarchy)
    function buildNavigationTree($pdo, $parentId = null) {
        $navItems = [];
        $stmt = $pdo->prepare("SELECT id, title, slug, icon FROM navigation WHERE parent_id <=> ?");
        $stmt->execute([$parentId]);
        $items = $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($items as $item) {
            $navItem = [
                'id' => (string)$item['id'],
                'title' => $item['title'],
                'slug' => $item['slug'],
                'icon' => $item['icon']
            ];
            $children = buildNavigationTree($pdo, $item['id']);
            if (!empty($children)) {
                $navItem['items'] = $children;
            }
            $navItems[] = $navItem;
        }
        return $navItems;
    }

    $jsonData['navigation'] = buildNavigationTree($pdo);

    // Fetch support categories and items
    $stmt = $pdo->query("SELECT id, title, position FROM support_categories ORDER BY position");
    $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($categories as $category) {
        $cat = ['title' => $category['title'], 'items' => []];
        $stmtItems = $pdo->prepare("SELECT title, article_id FROM support_category_items WHERE category_id = ?");
        $stmtItems->execute([$category['id']]);
        $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);
        foreach ($items as $item) {
            $cat['items'][] = ['id' => $item['article_id'], 'title' => $item['title']];
        }
        $jsonData['support']['categories'][] = $cat;
    }

    // Fetch support articles
    $stmt = $pdo->query("SELECT id, title, format, updated_at, body FROM support_articles");
    $articles = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($articles as $article) {
        // Fetch tags for the article
        $stmtTags = $pdo->prepare("SELECT tag FROM article_tags WHERE article_id = ?");
        $stmtTags->execute([$article['id']]);
        $tags = $stmtTags->fetchAll(PDO::FETCH_COLUMN);

        $jsonData['support']['articles'][$article['id']] = [
            'id' => $article['id'],
            'title' => $article['title'],
            'format' => $article['format'],
            'updatedAt' => $article['updated_at'],
            'tags' => $tags,
            'body' => $article['body']
        ];
    }

    // Fetch search entries
    $stmt = $pdo->query("SELECT article_id, term, weight FROM search_entries");
    $searchEntries = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($searchEntries as $entry) {
        $jsonData['search']['entries'][$entry['article_id']][] = [$entry['term'], $entry['weight']];
    }

    // Set headers for file download
    header('Content-Type: application/json; charset=utf-8');
    header('Content-Disposition: attachment; filename="innovate_rwanda_data.json"');
    header('Cache-Control: no-cache, must-revalidate');
    header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');

    // Output JSON
    echo json_encode($jsonData, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {
    // Handle database errors
    http_response_code(500);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>