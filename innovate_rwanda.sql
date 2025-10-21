-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2025 at 12:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `innovate_rwanda`
--

-- --------------------------------------------------------

--
-- Table structure for table `article_tags`
--

CREATE TABLE `article_tags` (
  `id` int(11) NOT NULL,
  `article_id` varchar(100) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `article_tags`
--

INSERT INTO `article_tags` (`id`, `article_id`, `tag`) VALUES
(1, 'user-onboarding', 'onboarding'),
(2, 'user-onboarding', 'accounts'),
(3, 'user-onboarding', 'welcome'),
(4, 'profile-setup', 'profile'),
(5, 'profile-setup', 'settings'),
(6, 'user-registration', 'accounts'),
(7, 'user-registration', 'signup'),
(8, 'setting-preferences', 'preferences'),
(9, 'setting-preferences', 'notifications'),
(10, 'setting-preferences', 'locale'),
(11, 'company-registration', 'companies'),
(12, 'company-registration', 'registration'),
(13, 'password-reset', 'security'),
(14, 'password-reset', 'password'),
(15, 'enable-2fa', 'security'),
(16, 'enable-2fa', '2fa'),
(17, 'enable-2fa', 'mfa'),
(18, 'login-activity', 'security'),
(19, 'login-activity', 'audit'),
(20, 'session-timeout', 'security'),
(21, 'session-timeout', 'session'),
(22, 'login-devices', 'security'),
(23, 'login-devices', 'devices'),
(24, 'export-reports', 'reports'),
(25, 'export-reports', 'export'),
(26, 'bulk-import', 'import'),
(27, 'bulk-import', 'csv'),
(28, 'sharing-reports', 'reports'),
(29, 'sharing-reports', 'sharing'),
(30, 'archiving-data', 'lifecycle'),
(31, 'archiving-data', 'archive'),
(32, 'report-schedules', 'automation'),
(33, 'report-schedules', 'reports'),
(34, 'add-team-members', 'collaboration'),
(35, 'add-team-members', 'users'),
(36, 'role-permissions', 'rbac'),
(37, 'role-permissions', 'permissions'),
(38, 'real-time-commenting', 'comments'),
(39, 'real-time-commenting', 'collaboration'),
(40, 'notifications', 'notifications'),
(41, 'slack-teams', 'integrations'),
(42, 'slack-teams', 'slack'),
(43, 'slack-teams', 'teams'),
(44, 'system-status', 'status'),
(45, 'system-status', 'uptime'),
(46, 'emergency-contacts', 'support'),
(47, 'emergency-contacts', 'contact'),
(48, 'keyboard-shortcuts', 'productivity'),
(49, 'keyboard-shortcuts', 'shortcuts'),
(50, 'api-access', 'api'),
(51, 'api-access', 'developers'),
(52, 'custom-templates', 'templates'),
(53, 'bulk-import-tools', 'import'),
(54, 'bulk-import-tools', 'tools'),
(55, 'system-backup', 'backup'),
(56, 'system-backup', 'disaster-recovery'),
(57, 'companies-insights', 'companies'),
(58, 'companies-insights', 'insights'),
(59, 'companies-insights', 'metrics'),
(60, 'investors-directory', 'investors'),
(61, 'investors-directory', 'directory'),
(62, 'enablers-assessment', 'enablers'),
(63, 'enablers-assessment', 'eso'),
(64, 'enablers-assessment', 'assessment'),
(65, 'opportunities-tenders', 'opportunities'),
(66, 'opportunities-tenders', 'tenders'),
(67, 'opportunities-tenders', 'rfp'),
(68, 'content-studio-basics', 'cms'),
(69, 'content-studio-basics', 'content-studio');

-- --------------------------------------------------------

--
-- Table structure for table `json_files`
--

CREATE TABLE `json_files` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `json_files`
--

INSERT INTO `json_files` (`id`, `name`, `content`, `created_at`) VALUES
(1, 'docs.en.json', '{\r\n    \"meta\": {\r\n        \"schemaVersion\": \"1.0\",\r\n        \"version\": \"v1.0.0\",\r\n        \"generatedAt\": \"2025-09-23T12:00:00Z\",\r\n        \"locale\": \"en\",\r\n        \"product\": \"Innovate Rwanda Admin\",\r\n        \"defaultPage\": \"support:index\"\r\n    },\r\n    \"theme\": {\r\n        \"css\": \"/* optional: add typography, callouts, code blocks */\",\r\n        \"tokens\": {\r\n            \"--brand-bg\": \"#0B5FFF\",\r\n            \"--brand-fg\": \"#FFFFFF\",\r\n            \"--ink\": \"#0F172A\",\r\n            \"--muted\": \"#64748B\"\r\n        }\r\n    },\r\n    \"navigation\": [\r\n        {\r\n            \"id\": \"platform\",\r\n            \"title\": \"Platform\",\r\n            \"items\": [\r\n                { \"title\": \"Dashboard\", \"slug\": \"platform/dashboard\", \"icon\": \"Home\" },\r\n                {\r\n                    \"title\": \"Companies\",\r\n                    \"slug\": \"platform/companies\",\r\n                    \"icon\": \"Briefcase\",\r\n                    \"items\": [\r\n                        {\r\n                            \"title\": \"Insights\",\r\n                            \"slug\": \"platform/companies/insights\",\r\n                            \"icon\": \"LineChart\"\r\n                        },\r\n                        {\r\n                            \"title\": \"Directory\",\r\n                            \"slug\": \"platform/companies/directory\",\r\n                            \"icon\": \"Building2\"\r\n                        }\r\n                    ]\r\n                },\r\n                {\r\n                    \"title\": \"Investors\",\r\n                    \"slug\": \"platform/investors\",\r\n                    \"icon\": \"Landmark\",\r\n                    \"items\": [\r\n                        {\r\n                            \"title\": \"Insights\",\r\n                            \"slug\": \"platform/investors/insights\",\r\n                            \"icon\": \"LineChart\"\r\n                        },\r\n                        {\r\n                            \"title\": \"Directory\",\r\n                            \"slug\": \"platform/investors/directory\",\r\n                            \"icon\": \"Landmark\"\r\n                        }\r\n                    ]\r\n                },\r\n                {\r\n                    \"title\": \"Enablers\",\r\n                    \"slug\": \"platform/enablers\",\r\n                    \"icon\": \"Handshake\",\r\n                    \"items\": [\r\n                        {\r\n                            \"title\": \"Assessment\",\r\n                            \"slug\": \"platform/enablers/assessment\",\r\n                            \"icon\": \"LineChart\"\r\n                        },\r\n                        { \"title\": \"Hubs\", \"slug\": \"platform/enablers/hubs\", \"icon\": \"Building2\" },\r\n                        {\r\n                            \"title\": \"Incubators/Accelerators\",\r\n                            \"slug\": \"platform/enablers/incubators\",\r\n                            \"icon\": \"Rocket\"\r\n                        }\r\n                    ]\r\n                },\r\n                { \"title\": \"Users\", \"slug\": \"platform/users\", \"icon\": \"Users\" },\r\n                { \"title\": \"Events\", \"slug\": \"platform/events\", \"icon\": \"CalendarRange\" },\r\n                {\r\n                    \"title\": \"Opportunities\",\r\n                    \"slug\": \"platform/opportunities\",\r\n                    \"icon\": \"Sparkles\",\r\n                    \"items\": [\r\n                        {\r\n                            \"title\": \"Open calls\",\r\n                            \"slug\": \"platform/opportunities/open-calls\",\r\n                            \"icon\": \"ListIcon\"\r\n                        },\r\n                        {\r\n                            \"title\": \"Tenders\",\r\n                            \"slug\": \"platform/opportunities/tenders\",\r\n                            \"icon\": \"FileSignature\"\r\n                        },\r\n                        {\r\n                            \"title\": \"Programs\",\r\n                            \"slug\": \"platform/opportunities/programs\",\r\n                            \"icon\": \"Rocket\"\r\n                        }\r\n                    ]\r\n                },\r\n                {\r\n                    \"title\": \"Newsroom\",\r\n                    \"slug\": \"platform/newsroom\",\r\n                    \"icon\": \"Newspaper\",\r\n                    \"items\": [\r\n                        { \"title\": \"News\", \"slug\": \"platform/newsroom/news\", \"icon\": \"Newspaper\" },\r\n                        {\r\n                            \"title\": \"Updates\",\r\n                            \"slug\": \"platform/newsroom/updates\",\r\n                            \"icon\": \"ChartPie\"\r\n                        }\r\n                    ]\r\n                },\r\n                { \"title\": \"Content Studio\", \"slug\": \"platform/content-studio\", \"icon\": \"FileCog\" },\r\n                { \"title\": \"Support\", \"slug\": \"support:index\", \"icon\": \"GalleryVerticalEnd\" },\r\n                { \"title\": \"Settings\", \"slug\": \"platform/settings\", \"icon\": \"Settings\" }\r\n            ]\r\n        }\r\n    ],\r\n    \"support\": {\r\n        \"hero\": {\r\n            \"title\": \"How can we help you?\",\r\n            \"subtitle\": \"Search for an answer or browse our topics\"\r\n        },\r\n        \"categories\": [\r\n            {\r\n                \"title\": \"1. Getting Started\",\r\n                \"items\": [\r\n                    { \"id\": \"user-onboarding\", \"title\": \"User onboarding\" },\r\n                    { \"id\": \"profile-setup\", \"title\": \"Profile setup\" },\r\n                    { \"id\": \"user-registration\", \"title\": \"User registration\" },\r\n                    { \"id\": \"setting-preferences\", \"title\": \"Setting preferences\" },\r\n                    { \"id\": \"company-registration\", \"title\": \"Company registration steps\" }\r\n                ]\r\n            },\r\n            {\r\n                \"title\": \"2. Security\",\r\n                \"items\": [\r\n                    { \"id\": \"password-reset\", \"title\": \"Password reset guide\" },\r\n                    { \"id\": \"enable-2fa\", \"title\": \"Enable 2FA\" },\r\n                    { \"id\": \"login-activity\", \"title\": \"Check login activity\" },\r\n                    { \"id\": \"session-timeout\", \"title\": \"Session timeout settings\" },\r\n                    { \"id\": \"login-devices\", \"title\": \"Managing login devices\" }\r\n                ]\r\n            },\r\n            {\r\n                \"title\": \"3. Data & Reports\",\r\n                \"items\": [\r\n                    { \"id\": \"export-reports\", \"title\": \"Export reports\" },\r\n                    { \"id\": \"bulk-import\", \"title\": \"Bulk import data\" },\r\n                    { \"id\": \"sharing-reports\", \"title\": \"Sharing reports externally\" },\r\n                    { \"id\": \"archiving-data\", \"title\": \"Archiving old data\" },\r\n                    { \"id\": \"report-schedules\", \"title\": \"Automating report schedules\" }\r\n                ]\r\n            },\r\n            {\r\n                \"title\": \"4. Collaboration\",\r\n                \"items\": [\r\n                    { \"id\": \"add-team-members\", \"title\": \"Add team members\" },\r\n                    { \"id\": \"role-permissions\", \"title\": \"Role-based permissions\" },\r\n                    { \"id\": \"real-time-commenting\", \"title\": \"Real-time commenting\" },\r\n                    { \"id\": \"notifications\", \"title\": \"Notification settings\" },\r\n                    { \"id\": \"slack-teams\", \"title\": \"Integrating Slack/Teams\" }\r\n                ]\r\n            },\r\n            {\r\n                \"title\": \"5. Troubleshooting\",\r\n                \"items\": [\r\n                    { \"id\": \"system-status\", \"title\": \"Check system status\" },\r\n                    { \"id\": \"emergency-contacts\", \"title\": \"Emergency contacts\" },\r\n                    { \"id\": \"ask-question-1\", \"title\": \"Ask a question or describe a (1)\" },\r\n                    { \"id\": \"ask-question-2\", \"title\": \"Ask a question or describe a (2)\" },\r\n                    { \"id\": \"ask-question-3\", \"title\": \"Ask a question or describe a (3)\" }\r\n                ]\r\n            },\r\n            {\r\n                \"title\": \"6. Advanced Features\",\r\n                \"items\": [\r\n                    { \"id\": \"keyboard-shortcuts\", \"title\": \"Keyboard shortcuts\" },\r\n                    { \"id\": \"api-access\", \"title\": \"API access\" },\r\n                    { \"id\": \"custom-templates\", \"title\": \"Custom templates\" },\r\n                    { \"id\": \"bulk-import-tools\", \"title\": \"Bulk import tools\" },\r\n                    { \"id\": \"system-backup\", \"title\": \"System backup options\" }\r\n                ]\r\n            },\r\n            {\r\n                \"title\": \"7. Platform Modules\",\r\n                \"items\": [\r\n                    { \"id\": \"companies-insights\", \"title\": \"Companies → Insights\" },\r\n                    { \"id\": \"investors-directory\", \"title\": \"Investors → Directory\" },\r\n                    { \"id\": \"enablers-assessment\", \"title\": \"Enablers → Assessment\" },\r\n                    { \"id\": \"opportunities-tenders\", \"title\": \"Opportunities → Tenders\" },\r\n                    { \"id\": \"content-studio-basics\", \"title\": \"Content Studio → Basics\" }\r\n                ]\r\n            }\r\n        ],\r\n        \"articles\": {\r\n            \"user-onboarding\": {\r\n                \"id\": \"user-onboarding\",\r\n                \"title\": \"User onboarding\",\r\n                \"format\": \"md\",\r\n                \"updatedAt\": \"2025-09-18\",\r\n                \"tags\": [\"onboarding\", \"accounts\", \"welcome\"],\r\n                \"body\": \"## Overview\\nWelcome to Innovate Rwanda Admin. This guide helps new users get productive quickly.\\n\\n### Steps\\n1. **Invitation/Registration** – Create an account with a work email.\\n2. **Email verification** – Click the verification link.\\n3. **Profile setup** – Complete name, role, and organization.\\n4. **Pick a workspace** – Choose your ecosystem/team (if applicable).\\n5. **Quick tour** – Dashboard, Companies, Investors, Enablers, Opportunities.\\n\\n> Tip: Admins can pre-assign roles to fast-track access.\\n\"\r\n            },\r\n            \"profile-setup\": {\r\n                \"id\": \"profile-setup\",\r\n                \"title\": \"Profile setup\",\r\n                \"format\": \"md\",\r\n                \"updatedAt\": \"2025-09-19\",\r\n                \"tags\": [\"profile\", \"settings\"],\r\n                \"body\": \"## Profile setup\\nGo to **Settings → Profile**. Update your display name, avatar, job title, and bio. Set your notification preferences and time zone.\\n\\n### Recommendations\\n- Use a clear headshot (≥ 400×400).\\n- Add a short, descriptive bio.\\n- Set a backup email for critical alerts.\\n\"\r\n            },\r\n            \"user-registration\": {\r\n                \"id\": \"user-registration\",\r\n                \"title\": \"User registration\",\r\n                \"format\": \"md\",\r\n                \"updatedAt\": \"2025-09-20\",\r\n                \"tags\": [\"accounts\", \"signup\"],\r\n                \"body\": \"## Registration\\nYou can register via **Invite** from admins or **Self-signup** (if enabled).\\n\\n### Self-signup options\\n- Email + password\\n- Social sign-in (if configured)\\n\\n### Verification\\nAll new accounts require email verification before first login.\\n\"\r\n            },\r\n            \"setting-preferences\": {\r\n                \"id\": \"setting-preferences\",\r\n                \"title\": \"Setting preferences\",\r\n                \"format\": \"md\",\r\n                \"updatedAt\": \"2025-09-20\",\r\n                \"tags\": [\"preferences\", \"notifications\", \"locale\"],\r\n                \"body\": \"## Preferences\\nVisit **Settings → Preferences** to configure language, time zone, notification frequency, and data display density.\\n\"\r\n            },\r\n            \"company-registration\": {\r\n                \"id\": \"company-registration\",\r\n                \"title\": \"Company registration steps\",\r\n                \"format\": \"md\",\r\n                \"updatedAt\": \"2025-09-21\",\r\n                \"tags\": [\"companies\", \"registration\"],\r\n                \"body\": \"## Company registration\\n1. Go to **Companies → Directory → Add company**.\\n2. Provide legal name, sector, location, and contacts.\\n3. Optionally attach pitch deck and logo.\\n4. Submit for admin review (if moderation is enabled).\\n\"\r\n            },\r\n            \"password-reset\": {\r\n                \"id\": \"password-reset\",\r\n                \"title\": \"Password reset guide\",\r\n                \"format\": \"md\",\r\n                \"updatedAt\": \"2025-09-19\",\r\n                \"tags\": [\"security\", \"password\"],\r\n                \"body\": \"## Reset your password\\n1. Click **Forgot password** on the login screen.\\n2. Enter your email and follow the link.\\n3. Set a strong password (≥ 12 chars, mixed types).\\n\\n> Admins can force a reset in **Users**.\\n\"\r\n            },\r\n            \"enable-2fa\": {\r\n                \"id\": \"enable-2fa\",\r\n                \"title\": \"Enable 2FA\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"security\", \"2fa\", \"mfa\"],\r\n                \"updatedAt\": \"2025-09-19\",\r\n                \"body\": \"## Two-factor authentication\\nEnable 2FA in **Settings → Security**. Supported: TOTP apps (Authy, Google Authenticator). Recovery codes are shown once—store securely.\\n\"\r\n            },\r\n            \"login-activity\": {\r\n                \"id\": \"login-activity\",\r\n                \"title\": \"Check login activity\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"security\", \"audit\"],\r\n                \"body\": \"## Login activity\\nReview recent sign-ins, IP addresses, and device info in **Settings → Security → Activity**. Click **Sign out of other devices** if needed.\\n\"\r\n            },\r\n            \"session-timeout\": {\r\n                \"id\": \"session-timeout\",\r\n                \"title\": \"Session timeout settings\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"security\", \"session\"],\r\n                \"body\": \"## Session timeout\\nDefault idle timeout is 30 minutes. Admins can configure per workspace in **Settings → Platform**.\\n\"\r\n            },\r\n            \"login-devices\": {\r\n                \"id\": \"login-devices\",\r\n                \"title\": \"Managing login devices\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"security\", \"devices\"],\r\n                \"body\": \"## Devices\\nView and revoke remembered devices. Enable **device approval** for high-security organizations.\\n\"\r\n            },\r\n            \"export-reports\": {\r\n                \"id\": \"export-reports\",\r\n                \"title\": \"Export reports\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"reports\", \"export\"],\r\n                \"body\": \"## Export\\nFrom any analytics page, click **Export** to download CSV/XLSX or schedule emailed PDFs.\\n\"\r\n            },\r\n            \"bulk-import\": {\r\n                \"id\": \"bulk-import\",\r\n                \"title\": \"Bulk import data\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"import\", \"csv\"],\r\n                \"body\": \"## Bulk import\\nUse the **Bulk Import** tool for Companies, Investors, Events. Upload CSV, map columns, preview, then commit.\\n\"\r\n            },\r\n            \"sharing-reports\": {\r\n                \"id\": \"sharing-reports\",\r\n                \"title\": \"Sharing reports externally\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"reports\", \"sharing\"],\r\n                \"body\": \"## Share securely\\nGenerate one-time links or time-bound shares. Optional password and watermarking for PDFs.\\n\"\r\n            },\r\n            \"archiving-data\": {\r\n                \"id\": \"archiving-data\",\r\n                \"title\": \"Archiving old data\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"lifecycle\", \"archive\"],\r\n                \"body\": \"## Archive policy\\nArchive stale companies/investors/events to improve performance. Restore anytime.\\n\"\r\n            },\r\n            \"report-schedules\": {\r\n                \"id\": \"report-schedules\",\r\n                \"title\": \"Automating report schedules\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"automation\", \"reports\"],\r\n                \"body\": \"## Scheduled reports\\nSet weekly/monthly email reports to leadership with KPIs and trends.\\n\"\r\n            },\r\n            \"add-team-members\": {\r\n                \"id\": \"add-team-members\",\r\n                \"title\": \"Add team members\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"collaboration\", \"users\"],\r\n                \"body\": \"## Invite teammates\\nGo to **Users → Invite**. Assign roles (Viewer, Editor, Admin, Superadmin) based on responsibilities.\\n\"\r\n            },\r\n            \"role-permissions\": {\r\n                \"id\": \"role-permissions\",\r\n                \"title\": \"Role-based permissions\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"rbac\", \"permissions\"],\r\n                \"body\": \"## Roles\\n- **User**: read, limited write\\n- **Admin**: manage content & people\\n- **Superadmin**: platform-wide settings\\n\"\r\n            },\r\n            \"real-time-commenting\": {\r\n                \"id\": \"real-time-commenting\",\r\n                \"title\": \"Real-time commenting\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"comments\", \"collaboration\"],\r\n                \"body\": \"## Comments\\nMention teammates with **@name** in company/investor profiles and program pages. Threaded, live updates.\\n\"\r\n            },\r\n            \"notifications\": {\r\n                \"id\": \"notifications\",\r\n                \"title\": \"Notification settings\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"notifications\"],\r\n                \"body\": \"## Notifications\\nEmail, in-app, and (optional) Slack notifications. Customize per module.\\n\"\r\n            },\r\n            \"slack-teams\": {\r\n                \"id\": \"slack-teams\",\r\n                \"title\": \"Integrating Slack/Teams\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"integrations\", \"slack\", \"teams\"],\r\n                \"body\": \"## Integrations\\nConnect Slack/Teams to push activity summaries and alerts to a channel.\\n\"\r\n            },\r\n            \"system-status\": {\r\n                \"id\": \"system-status\",\r\n                \"title\": \"Check system status\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"status\", \"uptime\"],\r\n                \"body\": \"## Status\\nVisit **Support → System Status** for realtime uptime and incident history.\\n\"\r\n            },\r\n            \"emergency-contacts\": {\r\n                \"id\": \"emergency-contacts\",\r\n                \"title\": \"Emergency contacts\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"support\", \"contact\"],\r\n                \"body\": \"## Emergency contacts\\nEmail: support@example.org\\nPhone: +250 700 000 000\\nSLA: P1 in 2h, P2 in 8h, P3 next business day.\\n\"\r\n            },\r\n            \"ask-question-1\": {\r\n                \"id\": \"ask-question-1\",\r\n                \"title\": \"Ask a question or describe a (1)\",\r\n                \"format\": \"md\",\r\n                \"body\": \"## Ask support\\nTell us what you’re trying to do and what you expected vs. what happened.\\n\"\r\n            },\r\n            \"ask-question-2\": {\r\n                \"id\": \"ask-question-2\",\r\n                \"title\": \"Ask a question or describe a (2)\",\r\n                \"format\": \"md\",\r\n                \"body\": \"## Ask support v2\\nInclude screenshots and the URL.\\n\"\r\n            },\r\n            \"ask-question-3\": {\r\n                \"id\": \"ask-question-3\",\r\n                \"title\": \"Ask a question or describe a (3)\",\r\n                \"format\": \"md\",\r\n                \"body\": \"## Ask support v3\\nWe’ll follow up by email.\\n\"\r\n            },\r\n            \"keyboard-shortcuts\": {\r\n                \"id\": \"keyboard-shortcuts\",\r\n                \"title\": \"Keyboard shortcuts\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"productivity\", \"shortcuts\"],\r\n                \"body\": \"## Shortcuts\\n- `/` focus search\\n- `g c` go to Companies\\n- `g i` go to Investors\\n- `?` open help\\n\"\r\n            },\r\n            \"api-access\": {\r\n                \"id\": \"api-access\",\r\n                \"title\": \"API access\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"api\", \"developers\"],\r\n                \"body\": \"## API\\nRequest an API key from **Settings → Developers**. Rate limits and scopes apply.\\n\"\r\n            },\r\n            \"custom-templates\": {\r\n                \"id\": \"custom-templates\",\r\n                \"title\": \"Custom templates\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"templates\"],\r\n                \"body\": \"## Templates\\nCreate reusable templates for reports, opportunities, and messages in **Content Studio**.\\n\"\r\n            },\r\n            \"bulk-import-tools\": {\r\n                \"id\": \"bulk-import-tools\",\r\n                \"title\": \"Bulk import tools\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"import\", \"tools\"],\r\n                \"body\": \"## Tools\\nDownload sample CSVs, validate locally, then upload via **Bulk Import**.\\n\"\r\n            },\r\n            \"system-backup\": {\r\n                \"id\": \"system-backup\",\r\n                \"title\": \"System backup options\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"backup\", \"disaster-recovery\"],\r\n                \"body\": \"## Backups\\nDaily snapshots retained for 30 days. Contact support for data export.\\n\"\r\n            },\r\n            \"companies-insights\": {\r\n                \"id\": \"companies-insights\",\r\n                \"title\": \"Companies → Insights\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"companies\", \"insights\", \"metrics\"],\r\n                \"body\": \"## Company Insights\\nFunding rounds, traction growth, hiring trends, and sector distribution.\\nAdmins see advanced filters and cohort comparisons.\\n\"\r\n            },\r\n            \"investors-directory\": {\r\n                \"id\": \"investors-directory\",\r\n                \"title\": \"Investors → Directory\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"investors\", \"directory\"],\r\n                \"body\": \"## Investor Directory\\nBrowse funds, angels, and DFIs. Track theses, ticket sizes, and geo focus.\\n\"\r\n            },\r\n            \"enablers-assessment\": {\r\n                \"id\": \"enablers-assessment\",\r\n                \"title\": \"Enablers → Assessment\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"enablers\", \"eso\", \"assessment\"],\r\n                \"body\": \"## ESO Assessment\\nScorecards for hubs, incubators, universities. KPIs: programs, jobs, cohorts, follow-on capital.\\n\"\r\n            },\r\n            \"opportunities-tenders\": {\r\n                \"id\": \"opportunities-tenders\",\r\n                \"title\": \"Opportunities → Tenders\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"opportunities\", \"tenders\", \"rfp\"],\r\n                \"body\": \"## Tenders\\nPublish and manage RFPs/RFQs. Vendors submit bids; admins shortlist and award.\\n\"\r\n            },\r\n            \"content-studio-basics\": {\r\n                \"id\": \"content-studio-basics\",\r\n                \"title\": \"Content Studio → Basics\",\r\n                \"format\": \"md\",\r\n                \"tags\": [\"cms\", \"content-studio\"],\r\n                \"body\": \"## Content Studio\\nManage site copy, resources, feeds, message templates, presets, and analysis narratives.\\n\"\r\n            }\r\n        },\r\n        \"search\": {\r\n            \"strategy\": \"precomputed\",\r\n            \"entries\": {\r\n                \"user-onboarding\": [\r\n                    [\"onboarding\", 6],\r\n                    [\"verify\", 2],\r\n                    [\"profile\", 1]\r\n                ],\r\n                \"profile-setup\": [\r\n                    [\"profile\", 5],\r\n                    [\"avatar\", 1],\r\n                    [\"timezone\", 1]\r\n                ],\r\n                \"user-registration\": [\r\n                    [\"signup\", 4],\r\n                    [\"verification\", 3]\r\n                ],\r\n                \"setting-preferences\": [\r\n                    [\"preferences\", 4],\r\n                    [\"language\", 2],\r\n                    [\"timezone\", 2]\r\n                ],\r\n                \"company-registration\": [\r\n                    [\"company\", 4],\r\n                    [\"registration\", 4],\r\n                    [\"directory\", 1]\r\n                ],\r\n                \"password-reset\": [\r\n                    [\"password\", 6],\r\n                    [\"reset\", 5]\r\n                ],\r\n                \"enable-2fa\": [\r\n                    [\"2fa\", 6],\r\n                    [\"totp\", 3],\r\n                    [\"security\", 2]\r\n                ],\r\n                \"login-activity\": [\r\n                    [\"login\", 4],\r\n                    [\"activity\", 3],\r\n                    [\"audit\", 2]\r\n                ],\r\n                \"session-timeout\": [\r\n                    [\"session\", 4],\r\n                    [\"timeout\", 3]\r\n                ],\r\n                \"login-devices\": [\r\n                    [\"devices\", 4],\r\n                    [\"security\", 2]\r\n                ],\r\n                \"export-reports\": [\r\n                    [\"export\", 5],\r\n                    [\"reports\", 4],\r\n                    [\"csv\", 2]\r\n                ],\r\n                \"bulk-import\": [\r\n                    [\"import\", 5],\r\n                    [\"csv\", 4]\r\n                ],\r\n                \"sharing-reports\": [\r\n                    [\"sharing\", 4],\r\n                    [\"reports\", 3],\r\n                    [\"links\", 2]\r\n                ],\r\n                \"archiving-data\": [\r\n                    [\"archive\", 4],\r\n                    [\"lifecycle\", 2]\r\n                ],\r\n                \"report-schedules\": [\r\n                    [\"scheduled\", 4],\r\n                    [\"reports\", 3],\r\n                    [\"email\", 2]\r\n                ],\r\n                \"add-team-members\": [\r\n                    [\"invite\", 4],\r\n                    [\"users\", 3]\r\n                ],\r\n                \"role-permissions\": [\r\n                    [\"roles\", 5],\r\n                    [\"permissions\", 4],\r\n                    [\"rbac\", 3]\r\n                ],\r\n                \"real-time-commenting\": [\r\n                    [\"comments\", 5],\r\n                    [\"realtime\", 3]\r\n                ],\r\n                \"notifications\": [\r\n                    [\"notifications\", 5],\r\n                    [\"email\", 2]\r\n                ],\r\n                \"slack-teams\": [\r\n                    [\"slack\", 4],\r\n                    [\"teams\", 4],\r\n                    [\"integrations\", 3]\r\n                ],\r\n                \"system-status\": [\r\n                    [\"status\", 4],\r\n                    [\"uptime\", 3]\r\n                ],\r\n                \"emergency-contacts\": [\r\n                    [\"emergency\", 4],\r\n                    [\"contacts\", 3]\r\n                ],\r\n                \"ask-question-1\": [\r\n                    [\"support\", 3],\r\n                    [\"question\", 2]\r\n                ],\r\n                \"ask-question-2\": [\r\n                    [\"support\", 3],\r\n                    [\"screenshots\", 2]\r\n                ],\r\n                \"ask-question-3\": [\r\n                    [\"support\", 3],\r\n                    [\"email\", 2]\r\n                ],\r\n                \"keyboard-shortcuts\": [\r\n                    [\"shortcuts\", 5],\r\n                    [\"keyboard\", 4]\r\n                ],\r\n                \"api-access\": [\r\n                    [\"api\", 6],\r\n                    [\"developers\", 3],\r\n                    [\"key\", 2]\r\n                ],\r\n                \"custom-templates\": [\r\n                    [\"templates\", 4],\r\n                    [\"content\", 2]\r\n                ],\r\n                \"bulk-import-tools\": [\r\n                    [\"import\", 5],\r\n                    [\"tools\", 3]\r\n                ],\r\n                \"system-backup\": [\r\n                    [\"backup\", 5],\r\n                    [\"recovery\", 3]\r\n                ],\r\n                \"companies-insights\": [\r\n                    [\"companies\", 5],\r\n                    [\"insights\", 5],\r\n                    [\"metrics\", 3]\r\n                ],\r\n                \"investors-directory\": [\r\n                    [\"investors\", 5],\r\n                    [\"directory\", 4]\r\n                ],\r\n                \"enablers-assessment\": [\r\n                    [\"enablers\", 5],\r\n                    [\"assessment\", 4],\r\n                    [\"eso\", 3]\r\n                ],\r\n                \"opportunities-tenders\": [\r\n                    [\"opportunities\", 5],\r\n                    [\"tenders\", 5],\r\n                    [\"rfp\", 3]\r\n                ],\r\n                \"content-studio-basics\": [\r\n                    [\"content\", 4],\r\n                    [\"studio\", 4],\r\n                    [\"cms\", 3]\r\n                ]\r\n            },\r\n            \"stopWords\": [\"the\", \"a\", \"an\", \"and\", \"or\", \"to\", \"of\", \"for\", \"in\"]\r\n        }\r\n    }\r\n}\r\n', '2025-10-21 12:23:39');
INSERT INTO `json_files` (`id`, `name`, `content`, `created_at`) VALUES
(2, 'backup_2025-10-21_122932.json', '{\n    \"meta\": {\n        \"schemaVersion\": \"1.0\",\n        \"version\": \"v1.0.0\",\n        \"generatedAt\": \"2025-09-23 12:00:00\",\n        \"locale\": \"en\",\n        \"product\": \"Innovate Rwanda Admin\",\n        \"defaultPage\": \"support:index\"\n    },\n    \"theme\": {\n        \"css\": \"/* optional: add typography, callouts, code blocks */\",\n        \"tokens\": {\n            \"--brand-bg\": \"#0B5FFF\",\n            \"--brand-fg\": \"#FFFFFF\",\n            \"--ink\": \"#0F172A\",\n            \"--muted\": \"#64748B\"\n        }\n    },\n    \"navigation\": [\n        {\n            \"id\": 1,\n            \"title\": \"Platform\",\n            \"slug\": null,\n            \"icon\": null,\n            \"items\": [\n                {\n                    \"id\": 2,\n                    \"title\": \"Dashboard\",\n                    \"slug\": \"platform/dashboard\",\n                    \"icon\": \"Home\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 3,\n                    \"title\": \"Companies\",\n                    \"slug\": \"platform/companies\",\n                    \"icon\": \"Briefcase\",\n                    \"items\": [\n                        {\n                            \"id\": 4,\n                            \"title\": \"Insights\",\n                            \"slug\": \"platform/companies/insights\",\n                            \"icon\": \"LineChart\",\n                            \"items\": []\n                        },\n                        {\n                            \"id\": 5,\n                            \"title\": \"Directory\",\n                            \"slug\": \"platform/companies/directory\",\n                            \"icon\": \"Building2\",\n                            \"items\": []\n                        }\n                    ]\n                },\n                {\n                    \"id\": 6,\n                    \"title\": \"Investors\",\n                    \"slug\": \"platform/investors\",\n                    \"icon\": \"Landmark\",\n                    \"items\": [\n                        {\n                            \"id\": 7,\n                            \"title\": \"Insights\",\n                            \"slug\": \"platform/investors/insights\",\n                            \"icon\": \"LineChart\",\n                            \"items\": []\n                        },\n                        {\n                            \"id\": 8,\n                            \"title\": \"Directory\",\n                            \"slug\": \"platform/investors/directory\",\n                            \"icon\": \"Landmark\",\n                            \"items\": []\n                        }\n                    ]\n                },\n                {\n                    \"id\": 9,\n                    \"title\": \"Enablers\",\n                    \"slug\": \"platform/enablers\",\n                    \"icon\": \"Handshake\",\n                    \"items\": [\n                        {\n                            \"id\": 10,\n                            \"title\": \"Assessment\",\n                            \"slug\": \"platform/enablers/assessment\",\n                            \"icon\": \"LineChart\",\n                            \"items\": []\n                        },\n                        {\n                            \"id\": 11,\n                            \"title\": \"Hubs\",\n                            \"slug\": \"platform/enablers/hubs\",\n                            \"icon\": \"Building2\",\n                            \"items\": []\n                        },\n                        {\n                            \"id\": 12,\n                            \"title\": \"Incubators/Accelerators\",\n                            \"slug\": \"platform/enablers/incubators\",\n                            \"icon\": \"Rocket\",\n                            \"items\": []\n                        }\n                    ]\n                },\n                {\n                    \"id\": 13,\n                    \"title\": \"Users\",\n                    \"slug\": \"platform/users\",\n                    \"icon\": \"Users\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 14,\n                    \"title\": \"Events\",\n                    \"slug\": \"platform/events\",\n                    \"icon\": \"CalendarRange\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 15,\n                    \"title\": \"Opportunities\",\n                    \"slug\": \"platform/opportunities\",\n                    \"icon\": \"Sparkles\",\n                    \"items\": [\n                        {\n                            \"id\": 16,\n                            \"title\": \"Open calls\",\n                            \"slug\": \"platform/opportunities/open-calls\",\n                            \"icon\": \"ListIcon\",\n                            \"items\": []\n                        },\n                        {\n                            \"id\": 17,\n                            \"title\": \"Tenders\",\n                            \"slug\": \"platform/opportunities/tenders\",\n                            \"icon\": \"FileSignature\",\n                            \"items\": []\n                        },\n                        {\n                            \"id\": 18,\n                            \"title\": \"Programs\",\n                            \"slug\": \"platform/opportunities/programs\",\n                            \"icon\": \"Rocket\",\n                            \"items\": []\n                        }\n                    ]\n                },\n                {\n                    \"id\": 19,\n                    \"title\": \"Newsroom\",\n                    \"slug\": \"platform/newsroom\",\n                    \"icon\": \"Newspaper\",\n                    \"items\": [\n                        {\n                            \"id\": 20,\n                            \"title\": \"News\",\n                            \"slug\": \"platform/newsroom/news\",\n                            \"icon\": \"Newspaper\",\n                            \"items\": []\n                        },\n                        {\n                            \"id\": 21,\n                            \"title\": \"Updates\",\n                            \"slug\": \"platform/newsroom/updates\",\n                            \"icon\": \"ChartPie\",\n                            \"items\": []\n                        }\n                    ]\n                },\n                {\n                    \"id\": 22,\n                    \"title\": \"Content Studio\",\n                    \"slug\": \"platform/content-studio\",\n                    \"icon\": \"FileCog\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 23,\n                    \"title\": \"Support\",\n                    \"slug\": \"support:index\",\n                    \"icon\": \"GalleryVerticalEnd\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 24,\n                    \"title\": \"Settings\",\n                    \"slug\": \"platform/settings\",\n                    \"icon\": \"Settings\",\n                    \"items\": []\n                }\n            ]\n        },\n        {\n            \"id\": 2,\n            \"title\": \"Dashboard\",\n            \"slug\": \"platform/dashboard\",\n            \"icon\": \"Home\",\n            \"items\": []\n        },\n        {\n            \"id\": 3,\n            \"title\": \"Companies\",\n            \"slug\": \"platform/companies\",\n            \"icon\": \"Briefcase\",\n            \"items\": [\n                {\n                    \"id\": 4,\n                    \"title\": \"Insights\",\n                    \"slug\": \"platform/companies/insights\",\n                    \"icon\": \"LineChart\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 5,\n                    \"title\": \"Directory\",\n                    \"slug\": \"platform/companies/directory\",\n                    \"icon\": \"Building2\",\n                    \"items\": []\n                }\n            ]\n        },\n        {\n            \"id\": 4,\n            \"title\": \"Insights\",\n            \"slug\": \"platform/companies/insights\",\n            \"icon\": \"LineChart\",\n            \"items\": []\n        },\n        {\n            \"id\": 5,\n            \"title\": \"Directory\",\n            \"slug\": \"platform/companies/directory\",\n            \"icon\": \"Building2\",\n            \"items\": []\n        },\n        {\n            \"id\": 6,\n            \"title\": \"Investors\",\n            \"slug\": \"platform/investors\",\n            \"icon\": \"Landmark\",\n            \"items\": [\n                {\n                    \"id\": 7,\n                    \"title\": \"Insights\",\n                    \"slug\": \"platform/investors/insights\",\n                    \"icon\": \"LineChart\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 8,\n                    \"title\": \"Directory\",\n                    \"slug\": \"platform/investors/directory\",\n                    \"icon\": \"Landmark\",\n                    \"items\": []\n                }\n            ]\n        },\n        {\n            \"id\": 7,\n            \"title\": \"Insights\",\n            \"slug\": \"platform/investors/insights\",\n            \"icon\": \"LineChart\",\n            \"items\": []\n        },\n        {\n            \"id\": 8,\n            \"title\": \"Directory\",\n            \"slug\": \"platform/investors/directory\",\n            \"icon\": \"Landmark\",\n            \"items\": []\n        },\n        {\n            \"id\": 9,\n            \"title\": \"Enablers\",\n            \"slug\": \"platform/enablers\",\n            \"icon\": \"Handshake\",\n            \"items\": [\n                {\n                    \"id\": 10,\n                    \"title\": \"Assessment\",\n                    \"slug\": \"platform/enablers/assessment\",\n                    \"icon\": \"LineChart\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 11,\n                    \"title\": \"Hubs\",\n                    \"slug\": \"platform/enablers/hubs\",\n                    \"icon\": \"Building2\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 12,\n                    \"title\": \"Incubators/Accelerators\",\n                    \"slug\": \"platform/enablers/incubators\",\n                    \"icon\": \"Rocket\",\n                    \"items\": []\n                }\n            ]\n        },\n        {\n            \"id\": 10,\n            \"title\": \"Assessment\",\n            \"slug\": \"platform/enablers/assessment\",\n            \"icon\": \"LineChart\",\n            \"items\": []\n        },\n        {\n            \"id\": 11,\n            \"title\": \"Hubs\",\n            \"slug\": \"platform/enablers/hubs\",\n            \"icon\": \"Building2\",\n            \"items\": []\n        },\n        {\n            \"id\": 12,\n            \"title\": \"Incubators/Accelerators\",\n            \"slug\": \"platform/enablers/incubators\",\n            \"icon\": \"Rocket\",\n            \"items\": []\n        },\n        {\n            \"id\": 13,\n            \"title\": \"Users\",\n            \"slug\": \"platform/users\",\n            \"icon\": \"Users\",\n            \"items\": []\n        },\n        {\n            \"id\": 14,\n            \"title\": \"Events\",\n            \"slug\": \"platform/events\",\n            \"icon\": \"CalendarRange\",\n            \"items\": []\n        },\n        {\n            \"id\": 15,\n            \"title\": \"Opportunities\",\n            \"slug\": \"platform/opportunities\",\n            \"icon\": \"Sparkles\",\n            \"items\": [\n                {\n                    \"id\": 16,\n                    \"title\": \"Open calls\",\n                    \"slug\": \"platform/opportunities/open-calls\",\n                    \"icon\": \"ListIcon\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 17,\n                    \"title\": \"Tenders\",\n                    \"slug\": \"platform/opportunities/tenders\",\n                    \"icon\": \"FileSignature\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 18,\n                    \"title\": \"Programs\",\n                    \"slug\": \"platform/opportunities/programs\",\n                    \"icon\": \"Rocket\",\n                    \"items\": []\n                }\n            ]\n        },\n        {\n            \"id\": 16,\n            \"title\": \"Open calls\",\n            \"slug\": \"platform/opportunities/open-calls\",\n            \"icon\": \"ListIcon\",\n            \"items\": []\n        },\n        {\n            \"id\": 17,\n            \"title\": \"Tenders\",\n            \"slug\": \"platform/opportunities/tenders\",\n            \"icon\": \"FileSignature\",\n            \"items\": []\n        },\n        {\n            \"id\": 18,\n            \"title\": \"Programs\",\n            \"slug\": \"platform/opportunities/programs\",\n            \"icon\": \"Rocket\",\n            \"items\": []\n        },\n        {\n            \"id\": 19,\n            \"title\": \"Newsroom\",\n            \"slug\": \"platform/newsroom\",\n            \"icon\": \"Newspaper\",\n            \"items\": [\n                {\n                    \"id\": 20,\n                    \"title\": \"News\",\n                    \"slug\": \"platform/newsroom/news\",\n                    \"icon\": \"Newspaper\",\n                    \"items\": []\n                },\n                {\n                    \"id\": 21,\n                    \"title\": \"Updates\",\n                    \"slug\": \"platform/newsroom/updates\",\n                    \"icon\": \"ChartPie\",\n                    \"items\": []\n                }\n            ]\n        },\n        {\n            \"id\": 20,\n            \"title\": \"News\",\n            \"slug\": \"platform/newsroom/news\",\n            \"icon\": \"Newspaper\",\n            \"items\": []\n        },\n        {\n            \"id\": 21,\n            \"title\": \"Updates\",\n            \"slug\": \"platform/newsroom/updates\",\n            \"icon\": \"ChartPie\",\n            \"items\": []\n        },\n        {\n            \"id\": 22,\n            \"title\": \"Content Studio\",\n            \"slug\": \"platform/content-studio\",\n            \"icon\": \"FileCog\",\n            \"items\": []\n        },\n        {\n            \"id\": 23,\n            \"title\": \"Support\",\n            \"slug\": \"support:index\",\n            \"icon\": \"GalleryVerticalEnd\",\n            \"items\": []\n        },\n        {\n            \"id\": 24,\n            \"title\": \"Settings\",\n            \"slug\": \"platform/settings\",\n            \"icon\": \"Settings\",\n            \"items\": []\n        }\n    ],\n    \"support\": {\n        \"hero\": {\n            \"title\": \"How can we help you?\",\n            \"subtitle\": \"Search for an answer or browse our topics\"\n        },\n        \"categories\": [\n            {\n                \"title\": \"1. Getting Started\",\n                \"items\": [\n                    {\n                        \"title\": \"User onboarding\",\n                        \"id\": \"user-onboarding\"\n                    },\n                    {\n                        \"title\": \"Profile setup\",\n                        \"id\": \"profile-setup\"\n                    },\n                    {\n                        \"title\": \"User registration\",\n                        \"id\": \"user-registration\"\n                    },\n                    {\n                        \"title\": \"Setting preferences\",\n                        \"id\": \"setting-preferences\"\n                    },\n                    {\n                        \"title\": \"Company registration steps\",\n                        \"id\": \"company-registration\"\n                    }\n                ]\n            },\n            {\n                \"title\": \"2. Security\",\n                \"items\": [\n                    {\n                        \"title\": \"Password reset guide\",\n                        \"id\": \"password-reset\"\n                    },\n                    {\n                        \"title\": \"Enable 2FA\",\n                        \"id\": \"enable-2fa\"\n                    },\n                    {\n                        \"title\": \"Check login activity\",\n                        \"id\": \"login-activity\"\n                    },\n                    {\n                        \"title\": \"Session timeout settings\",\n                        \"id\": \"session-timeout\"\n                    },\n                    {\n                        \"title\": \"Managing login devices\",\n                        \"id\": \"login-devices\"\n                    }\n                ]\n            },\n            {\n                \"title\": \"3. Data & Reports\",\n                \"items\": [\n                    {\n                        \"title\": \"Export reports\",\n                        \"id\": \"export-reports\"\n                    },\n                    {\n                        \"title\": \"Bulk import data\",\n                        \"id\": \"bulk-import\"\n                    },\n                    {\n                        \"title\": \"Sharing reports externally\",\n                        \"id\": \"sharing-reports\"\n                    },\n                    {\n                        \"title\": \"Archiving old data\",\n                        \"id\": \"archiving-data\"\n                    },\n                    {\n                        \"title\": \"Automating report schedules\",\n                        \"id\": \"report-schedules\"\n                    }\n                ]\n            },\n            {\n                \"title\": \"4. Collaboration\",\n                \"items\": [\n                    {\n                        \"title\": \"Add team members\",\n                        \"id\": \"add-team-members\"\n                    },\n                    {\n                        \"title\": \"Role-based permissions\",\n                        \"id\": \"role-permissions\"\n                    },\n                    {\n                        \"title\": \"Real-time commenting\",\n                        \"id\": \"real-time-commenting\"\n                    },\n                    {\n                        \"title\": \"Notification settings\",\n                        \"id\": \"notifications\"\n                    },\n                    {\n                        \"title\": \"Integrating Slack/Teams\",\n                        \"id\": \"slack-teams\"\n                    }\n                ]\n            },\n            {\n                \"title\": \"5. Troubleshooting\",\n                \"items\": [\n                    {\n                        \"title\": \"Check system status1\",\n                        \"id\": \"system-status\"\n                    },\n                    {\n                        \"title\": \"Emergency contacts\",\n                        \"id\": \"emergency-contacts\"\n                    },\n                    {\n                        \"title\": \"Ask a question or describe a (1)\",\n                        \"id\": \"ask-question-1\"\n                    },\n                    {\n                        \"title\": \"Ask a question or describe a (2)\",\n                        \"id\": \"ask-question-2\"\n                    },\n                    {\n                        \"title\": \"Ask a question or describe a (3)\",\n                        \"id\": \"ask-question-3\"\n                    }\n                ]\n            },\n            {\n                \"title\": \"6. Advanced Features\",\n                \"items\": [\n                    {\n                        \"title\": \"Keyboard shortcuts\",\n                        \"id\": \"keyboard-shortcuts\"\n                    },\n                    {\n                        \"title\": \"API access\",\n                        \"id\": \"api-access\"\n                    },\n                    {\n                        \"title\": \"Custom templates\",\n                        \"id\": \"custom-templates\"\n                    },\n                    {\n                        \"title\": \"Bulk import tools\",\n                        \"id\": \"bulk-import-tools\"\n                    },\n                    {\n                        \"title\": \"System backup options\",\n                        \"id\": \"system-backup\"\n                    }\n                ]\n            },\n            {\n                \"title\": \"7. Platform Modules\",\n                \"items\": [\n                    {\n                        \"title\": \"Companies \\u2192 Insights\",\n                        \"id\": \"companies-insights\"\n                    },\n                    {\n                        \"title\": \"Investors \\u2192 Directory\",\n                        \"id\": \"investors-directory\"\n                    },\n                    {\n                        \"title\": \"Enablers \\u2192 Assessment\",\n                        \"id\": \"enablers-assessment\"\n                    },\n                    {\n                        \"title\": \"Opportunities \\u2192 Tenders\",\n                        \"id\": \"opportunities-tenders\"\n                    },\n                    {\n                        \"title\": \"Content Studio \\u2192 Basics1\",\n                        \"id\": \"content-studio-basics\"\n                    }\n                ]\n            }\n        ],\n        \"articles\": {\n            \"add-team-members\": {\n                \"id\": \"add-team-members\",\n                \"title\": \"Add team members\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Invite teammates\\nGo to **Users \\u2192 Invite**. Assign roles (Viewer, Editor, Admin, Superadmin) based on responsibilities.\\n\",\n                \"tags\": [\n                    \"collaboration\",\n                    \"users\"\n                ]\n            },\n            \"api-access\": {\n                \"id\": \"api-access\",\n                \"title\": \"API access\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## API\\nRequest an API key from **Settings \\u2192 Developers**. Rate limits and scopes apply.\\n\",\n                \"tags\": [\n                    \"api\",\n                    \"developers\"\n                ]\n            },\n            \"archiving-data\": {\n                \"id\": \"archiving-data\",\n                \"title\": \"Archiving old data\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Archive policy\\nArchive stale companies/investors/events to improve performance. Restore anytime.\\n\",\n                \"tags\": [\n                    \"lifecycle\",\n                    \"archive\"\n                ]\n            },\n            \"ask-question-1\": {\n                \"id\": \"ask-question-1\",\n                \"title\": \"Ask a question or describe a (1)\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Ask support\\nTell us what you\\u2019re trying to do and what you expected vs. what happened.\\n\",\n                \"tags\": []\n            },\n            \"ask-question-2\": {\n                \"id\": \"ask-question-2\",\n                \"title\": \"Ask a question or describe a (2)\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Ask support v2\\nInclude screenshots and the URL.\\n\",\n                \"tags\": []\n            },\n            \"ask-question-3\": {\n                \"id\": \"ask-question-3\",\n                \"title\": \"Ask a question or describe a (3)\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Ask support v3\\nWe\\u2019ll follow up by email.\\n\",\n                \"tags\": []\n            },\n            \"bulk-import\": {\n                \"id\": \"bulk-import\",\n                \"title\": \"Bulk import data\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Bulk import\\nUse the **Bulk Import** tool for Companies, Investors, Events. Upload CSV, map columns, preview, then commit.\\n\",\n                \"tags\": [\n                    \"import\",\n                    \"csv\"\n                ]\n            },\n            \"bulk-import-tools\": {\n                \"id\": \"bulk-import-tools\",\n                \"title\": \"Bulk import tools\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Tools\\nDownload sample CSVs, validate locally, then upload via **Bulk Import**.\\n\",\n                \"tags\": [\n                    \"import\",\n                    \"tools\"\n                ]\n            },\n            \"companies-insights\": {\n                \"id\": \"companies-insights\",\n                \"title\": \"Companies \\u2192 Insights\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Company Insights\\nFunding rounds, traction growth, hiring trends, and sector distribution.\\nAdmins see advanced filters and cohort comparisons.\\n\",\n                \"tags\": [\n                    \"companies\",\n                    \"insights\",\n                    \"metrics\"\n                ]\n            },\n            \"company-registration\": {\n                \"id\": \"company-registration\",\n                \"title\": \"Company registration steps\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-09-21\",\n                \"body\": \"## Company registration\\n1. Go to **Companies \\u2192 Directory \\u2192 Add company**.\\n2. Provide legal name, sector, location, and contacts.\\n3. Optionally attach pitch deck and logo.\\n4. Submit for admin review (if moderation is enabled).\\n\",\n                \"tags\": [\n                    \"companies\",\n                    \"registration\"\n                ]\n            },\n            \"content-studio-basics\": {\n                \"id\": \"content-studio-basics\",\n                \"title\": \"Content Studio \\u2192 Basics1\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Content Studio\\nManage site copy, resources, feeds, message templates, presets, and analysis narratives.\\n\",\n                \"tags\": [\n                    \"cms\",\n                    \"content-studio\"\n                ]\n            },\n            \"custom-templates\": {\n                \"id\": \"custom-templates\",\n                \"title\": \"Custom templates\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Templates\\nCreate reusable templates for reports, opportunities, and messages in **Content Studio**.\\n\",\n                \"tags\": [\n                    \"templates\"\n                ]\n            },\n            \"emergency-contacts\": {\n                \"id\": \"emergency-contacts\",\n                \"title\": \"Emergency contacts\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Emergency contacts\\nEmail: support@example.org\\nPhone: +250 700 000 000\\nSLA: P1 in 2h, P2 in 8h, P3 next business day.\\n\",\n                \"tags\": [\n                    \"support\",\n                    \"contact\"\n                ]\n            },\n            \"enable-2fa\": {\n                \"id\": \"enable-2fa\",\n                \"title\": \"Enable 2FA\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-09-19\",\n                \"body\": \"## Two-factor authentication\\nEnable 2FA in **Settings \\u2192 Security**. Supported: TOTP apps (Authy, Google Authenticator). Recovery codes are shown once\\u2014store securely.\\n\",\n                \"tags\": [\n                    \"security\",\n                    \"2fa\",\n                    \"mfa\"\n                ]\n            },\n            \"enablers-assessment\": {\n                \"id\": \"enablers-assessment\",\n                \"title\": \"Enablers \\u2192 Assessment\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## ESO Assessment\\nScorecards for hubs, incubators, universities. KPIs: programs, jobs, cohorts, follow-on capital.\\n\",\n                \"tags\": [\n                    \"enablers\",\n                    \"eso\",\n                    \"assessment\"\n                ]\n            },\n            \"export-reports\": {\n                \"id\": \"export-reports\",\n                \"title\": \"Export reports\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Export\\nFrom any analytics page, click **Export** to download CSV/XLSX or schedule emailed PDFs.\\n\",\n                \"tags\": [\n                    \"reports\",\n                    \"export\"\n                ]\n            },\n            \"investors-directory\": {\n                \"id\": \"investors-directory\",\n                \"title\": \"Investors \\u2192 Directory\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Investor Directory\\nBrowse funds, angels, and DFIs. Track theses, ticket sizes, and geo focus.\\n\",\n                \"tags\": [\n                    \"investors\",\n                    \"directory\"\n                ]\n            },\n            \"keyboard-shortcuts\": {\n                \"id\": \"keyboard-shortcuts\",\n                \"title\": \"Keyboard shortcuts\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Shortcuts\\n- `/` focus search\\n- `g c` go to Companies\\n- `g i` go to Investors\\n- `?` open help\\n\",\n                \"tags\": [\n                    \"productivity\",\n                    \"shortcuts\"\n                ]\n            },\n            \"login-activity\": {\n                \"id\": \"login-activity\",\n                \"title\": \"Check login activity\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Login activity\\nReview recent sign-ins, IP addresses, and device info in **Settings \\u2192 Security \\u2192 Activity**. Click **Sign out of other devices** if needed.\\n\",\n                \"tags\": [\n                    \"security\",\n                    \"audit\"\n                ]\n            },\n            \"login-devices\": {\n                \"id\": \"login-devices\",\n                \"title\": \"Managing login devices\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Devices\\nView and revoke remembered devices. Enable **device approval** for high-security organizations.\\n\",\n                \"tags\": [\n                    \"security\",\n                    \"devices\"\n                ]\n            },\n            \"notifications\": {\n                \"id\": \"notifications\",\n                \"title\": \"Notification settings\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Notifications\\nEmail, in-app, and (optional) Slack notifications. Customize per module.\\n\",\n                \"tags\": [\n                    \"notifications\"\n                ]\n            },\n            \"opportunities-tenders\": {\n                \"id\": \"opportunities-tenders\",\n                \"title\": \"Opportunities \\u2192 Tenders\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Tenders\\nPublish and manage RFPs/RFQs. Vendors submit bids; admins shortlist and award.\\n\",\n                \"tags\": [\n                    \"opportunities\",\n                    \"tenders\",\n                    \"rfp\"\n                ]\n            },\n            \"password-reset\": {\n                \"id\": \"password-reset\",\n                \"title\": \"Password reset guide\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-09-19\",\n                \"body\": \"## Reset your password\\n1. Click **Forgot password** on the login screen.\\n2. Enter your email and follow the link.\\n3. Set a strong password (\\u2265 12 chars, mixed types).\\n\\n> Admins can force a reset in **Users**.\\n\",\n                \"tags\": [\n                    \"security\",\n                    \"password\"\n                ]\n            },\n            \"profile-setup\": {\n                \"id\": \"profile-setup\",\n                \"title\": \"Profile setup\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-09-19\",\n                \"body\": \"## Profile setup\\nGo to **Settings \\u2192 Profile**. Update your display name, avatar, job title, and bio. Set your notification preferences and time zone.\\n\\n### Recommendations\\n- Use a clear headshot (\\u2265 400\\u00d7400).\\n- Add a short, descriptive bio.\\n- Set a backup email for critical alerts.\\n\",\n                \"tags\": [\n                    \"profile\",\n                    \"settings\"\n                ]\n            },\n            \"real-time-commenting\": {\n                \"id\": \"real-time-commenting\",\n                \"title\": \"Real-time commenting\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Comments\\nMention teammates with **@name** in company/investor profiles and program pages. Threaded, live updates.\\n\",\n                \"tags\": [\n                    \"comments\",\n                    \"collaboration\"\n                ]\n            },\n            \"report-schedules\": {\n                \"id\": \"report-schedules\",\n                \"title\": \"Automating report schedules\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Scheduled reports\\nSet weekly/monthly email reports to leadership with KPIs and trends.\\n\",\n                \"tags\": [\n                    \"automation\",\n                    \"reports\"\n                ]\n            },\n            \"role-permissions\": {\n                \"id\": \"role-permissions\",\n                \"title\": \"Role-based permissions\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Roles\\n- **User**: read, limited write\\n- **Admin**: manage content & people\\n- **Superadmin**: platform-wide settings\\n\",\n                \"tags\": [\n                    \"rbac\",\n                    \"permissions\"\n                ]\n            },\n            \"session-timeout\": {\n                \"id\": \"session-timeout\",\n                \"title\": \"Session timeout settings\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Session timeout\\nDefault idle timeout is 30 minutes. Admins can configure per workspace in **Settings \\u2192 Platform**.\\n\",\n                \"tags\": [\n                    \"security\",\n                    \"session\"\n                ]\n            },\n            \"setting-preferences\": {\n                \"id\": \"setting-preferences\",\n                \"title\": \"Setting preferences\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-09-20\",\n                \"body\": \"## Preferences\\nVisit **Settings \\u2192 Preferences** to configure language, time zone, notification frequency, and data display density.\\n\",\n                \"tags\": [\n                    \"preferences\",\n                    \"notifications\",\n                    \"locale\"\n                ]\n            },\n            \"sharing-reports\": {\n                \"id\": \"sharing-reports\",\n                \"title\": \"Sharing reports externally\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Share securely\\nGenerate one-time links or time-bound shares. Optional password and watermarking for PDFs.\\n\",\n                \"tags\": [\n                    \"reports\",\n                    \"sharing\"\n                ]\n            },\n            \"slack-teams\": {\n                \"id\": \"slack-teams\",\n                \"title\": \"Integrating Slack/Teams\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Integrations\\nConnect Slack/Teams to push activity summaries and alerts to a channel.\\n\",\n                \"tags\": [\n                    \"integrations\",\n                    \"slack\",\n                    \"teams\"\n                ]\n            },\n            \"system-backup\": {\n                \"id\": \"system-backup\",\n                \"title\": \"System backup options\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Backups\\nDaily snapshots retained for 30 days. Contact support for data export.\\n\",\n                \"tags\": [\n                    \"backup\",\n                    \"disaster-recovery\"\n                ]\n            },\n            \"system-status\": {\n                \"id\": \"system-status\",\n                \"title\": \"Check system status1\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-10-21\",\n                \"body\": \"## Status\\nVisit **Support \\u2192 System Status** for realtime uptime and incident history.\\n\",\n                \"tags\": [\n                    \"status\",\n                    \"uptime\"\n                ]\n            },\n            \"user-onboarding\": {\n                \"id\": \"user-onboarding\",\n                \"title\": \"User onboarding\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-09-18\",\n                \"body\": \"## Overview\\nWelcome to Innovate Rwanda Admin. This guide helps new users get productive quickly.\\n\\n### Steps\\n1. **Invitation/Registration** \\u2013 Create an account with a work email.\\n2. **Email verification** \\u2013 Click the verification link.\\n3. **Profile setup** \\u2013 Complete name, role, and organization.\\n4. **Pick a workspace** \\u2013 Choose your ecosystem/team (if applicable).\\n5. **Quick tour** \\u2013 Dashboard, Companies, Investors, Enablers, Opportunities.\\n\\n> Tip: Admins can pre-assign roles to fast-track access.\\n\",\n                \"tags\": [\n                    \"onboarding\",\n                    \"accounts\",\n                    \"welcome\"\n                ]\n            },\n            \"user-registration\": {\n                \"id\": \"user-registration\",\n                \"title\": \"User registration\",\n                \"format\": \"md\",\n                \"updatedAt\": \"2025-09-20\",\n                \"body\": \"## Registration\\nYou can register via **Invite** from admins or **Self-signup** (if enabled).\\n\\n### Self-signup options\\n- Email + password\\n- Social sign-in (if configured)\\n\\n### Verification\\nAll new accounts require email verification before first login.\\n\",\n                \"tags\": [\n                    \"accounts\",\n                    \"signup\"\n                ]\n            }\n        },\n        \"search\": {\n            \"strategy\": \"precomputed\",\n            \"entries\": {\n                \"user-onboarding\": [\n                    [\n                        \"onboarding\",\n                        6\n                    ],\n                    [\n                        \"verify\",\n                        2\n                    ],\n                    [\n                        \"profile\",\n                        1\n                    ]\n                ],\n                \"profile-setup\": [\n                    [\n                        \"profile\",\n                        5\n                    ],\n                    [\n                        \"avatar\",\n                        1\n                    ],\n                    [\n                        \"timezone\",\n                        1\n                    ]\n                ],\n                \"user-registration\": [\n                    [\n                        \"signup\",\n                        4\n                    ],\n                    [\n                        \"verification\",\n                        3\n                    ]\n                ],\n                \"setting-preferences\": [\n                    [\n                        \"preferences\",\n                        4\n                    ],\n                    [\n                        \"language\",\n                        2\n                    ],\n                    [\n                        \"timezone\",\n                        2\n                    ]\n                ],\n                \"company-registration\": [\n                    [\n                        \"company\",\n                        4\n                    ],\n                    [\n                        \"registration\",\n                        4\n                    ],\n                    [\n                        \"directory\",\n                        1\n                    ]\n                ],\n                \"password-reset\": [\n                    [\n                        \"password\",\n                        6\n                    ],\n                    [\n                        \"reset\",\n                        5\n                    ]\n                ],\n                \"enable-2fa\": [\n                    [\n                        \"2fa\",\n                        6\n                    ],\n                    [\n                        \"totp\",\n                        3\n                    ],\n                    [\n                        \"security\",\n                        2\n                    ]\n                ],\n                \"login-activity\": [\n                    [\n                        \"login\",\n                        4\n                    ],\n                    [\n                        \"activity\",\n                        3\n                    ],\n                    [\n                        \"audit\",\n                        2\n                    ]\n                ],\n                \"session-timeout\": [\n                    [\n                        \"session\",\n                        4\n                    ],\n                    [\n                        \"timeout\",\n                        3\n                    ]\n                ],\n                \"login-devices\": [\n                    [\n                        \"devices\",\n                        4\n                    ],\n                    [\n                        \"security\",\n                        2\n                    ]\n                ],\n                \"export-reports\": [\n                    [\n                        \"export\",\n                        5\n                    ],\n                    [\n                        \"reports\",\n                        4\n                    ],\n                    [\n                        \"csv\",\n                        2\n                    ]\n                ],\n                \"bulk-import\": [\n                    [\n                        \"import\",\n                        5\n                    ],\n                    [\n                        \"csv\",\n                        4\n                    ]\n                ],\n                \"sharing-reports\": [\n                    [\n                        \"sharing\",\n                        4\n                    ],\n                    [\n                        \"reports\",\n                        3\n                    ],\n                    [\n                        \"links\",\n                        2\n                    ]\n                ],\n                \"archiving-data\": [\n                    [\n                        \"archive\",\n                        4\n                    ],\n                    [\n                        \"lifecycle\",\n                        2\n                    ]\n                ],\n                \"report-schedules\": [\n                    [\n                        \"scheduled\",\n                        4\n                    ],\n                    [\n                        \"reports\",\n                        3\n                    ],\n                    [\n                        \"email\",\n                        2\n                    ]\n                ],\n                \"add-team-members\": [\n                    [\n                        \"invite\",\n                        4\n                    ],\n                    [\n                        \"users\",\n                        3\n                    ]\n                ],\n                \"role-permissions\": [\n                    [\n                        \"roles\",\n                        5\n                    ],\n                    [\n                        \"permissions\",\n                        4\n                    ],\n                    [\n                        \"rbac\",\n                        3\n                    ]\n                ],\n                \"real-time-commenting\": [\n                    [\n                        \"comments\",\n                        5\n                    ],\n                    [\n                        \"realtime\",\n                        3\n                    ]\n                ],\n                \"notifications\": [\n                    [\n                        \"notifications\",\n                        5\n                    ],\n                    [\n                        \"email\",\n                        2\n                    ]\n                ],\n                \"slack-teams\": [\n                    [\n                        \"slack\",\n                        4\n                    ],\n                    [\n                        \"teams\",\n                        4\n                    ],\n                    [\n                        \"integrations\",\n                        3\n                    ]\n                ],\n                \"system-status\": [\n                    [\n                        \"status\",\n                        4\n                    ],\n                    [\n                        \"uptime\",\n                        3\n                    ]\n                ],\n                \"emergency-contacts\": [\n                    [\n                        \"emergency\",\n                        4\n                    ],\n                    [\n                        \"contacts\",\n                        3\n                    ]\n                ],\n                \"ask-question-1\": [\n                    [\n                        \"support\",\n                        3\n                    ],\n                    [\n                        \"question\",\n                        2\n                    ]\n                ],\n                \"ask-question-2\": [\n                    [\n                        \"support\",\n                        3\n                    ],\n                    [\n                        \"screenshots\",\n                        2\n                    ]\n                ],\n                \"ask-question-3\": [\n                    [\n                        \"support\",\n                        3\n                    ],\n                    [\n                        \"email\",\n                        2\n                    ]\n                ],\n                \"keyboard-shortcuts\": [\n                    [\n                        \"shortcuts\",\n                        5\n                    ],\n                    [\n                        \"keyboard\",\n                        4\n                    ]\n                ],\n                \"api-access\": [\n                    [\n                        \"api\",\n                        6\n                    ],\n                    [\n                        \"developers\",\n                        3\n                    ],\n                    [\n                        \"key\",\n                        2\n                    ]\n                ],\n                \"custom-templates\": [\n                    [\n                        \"templates\",\n                        4\n                    ],\n                    [\n                        \"content\",\n                        2\n                    ]\n                ],\n                \"bulk-import-tools\": [\n                    [\n                        \"import\",\n                        5\n                    ],\n                    [\n                        \"tools\",\n                        3\n                    ]\n                ],\n                \"system-backup\": [\n                    [\n                        \"backup\",\n                        5\n                    ],\n                    [\n                        \"recovery\",\n                        3\n                    ]\n                ],\n                \"companies-insights\": [\n                    [\n                        \"companies\",\n                        5\n                    ],\n                    [\n                        \"insights\",\n                        5\n                    ],\n                    [\n                        \"metrics\",\n                        3\n                    ]\n                ],\n                \"investors-directory\": [\n                    [\n                        \"investors\",\n                        5\n                    ],\n                    [\n                        \"directory\",\n                        4\n                    ]\n                ],\n                \"enablers-assessment\": [\n                    [\n                        \"enablers\",\n                        5\n                    ],\n                    [\n                        \"assessment\",\n                        4\n                    ],\n                    [\n                        \"eso\",\n                        3\n                    ]\n                ],\n                \"opportunities-tenders\": [\n                    [\n                        \"opportunities\",\n                        5\n                    ],\n                    [\n                        \"tenders\",\n                        5\n                    ],\n                    [\n                        \"rfp\",\n                        3\n                    ]\n                ],\n                \"content-studio-basics\": [\n                    [\n                        \"content\",\n                        4\n                    ],\n                    [\n                        \"studio\",\n                        4\n                    ],\n                    [\n                        \"cms\",\n                        3\n                    ]\n                ]\n            },\n            \"stopWords\": [\n                \"the\",\n                \"a\",\n                \"an\",\n                \"and\",\n                \"or\",\n                \"to\",\n                \"of\",\n                \"for\",\n                \"in\"\n            ]\n        }\n    }\n}', '2025-10-21 12:29:32');

-- --------------------------------------------------------

--
-- Table structure for table `meta`
--

CREATE TABLE `meta` (
  `id` int(11) NOT NULL,
  `schema_version` varchar(10) DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  `generated_at` datetime DEFAULT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `product` varchar(100) DEFAULT NULL,
  `default_page` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meta`
--

INSERT INTO `meta` (`id`, `schema_version`, `version`, `generated_at`, `locale`, `product`, `default_page`) VALUES
(1, '1.0', 'v1.0.0', '2025-09-23 12:00:00', 'en', 'Innovate Rwanda Admin', 'support:index');

-- --------------------------------------------------------

--
-- Table structure for table `navigation`
--

CREATE TABLE `navigation` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `navigation`
--

INSERT INTO `navigation` (`id`, `parent_id`, `title`, `slug`, `icon`) VALUES
(1, NULL, 'Platform', NULL, NULL),
(2, 1, 'Dashboard', 'platform/dashboard', 'Home'),
(3, 1, 'Companies', 'platform/companies', 'Briefcase'),
(4, 3, 'Insights', 'platform/companies/insights', 'LineChart'),
(5, 3, 'Directory', 'platform/companies/directory', 'Building2'),
(6, 1, 'Investors', 'platform/investors', 'Landmark'),
(7, 6, 'Insights', 'platform/investors/insights', 'LineChart'),
(8, 6, 'Directory', 'platform/investors/directory', 'Landmark'),
(9, 1, 'Enablers', 'platform/enablers', 'Handshake'),
(10, 9, 'Assessment', 'platform/enablers/assessment', 'LineChart'),
(11, 9, 'Hubs', 'platform/enablers/hubs', 'Building2'),
(12, 9, 'Incubators/Accelerators', 'platform/enablers/incubators', 'Rocket'),
(13, 1, 'Users', 'platform/users', 'Users'),
(14, 1, 'Events', 'platform/events', 'CalendarRange'),
(15, 1, 'Opportunities', 'platform/opportunities', 'Sparkles'),
(16, 15, 'Open calls', 'platform/opportunities/open-calls', 'ListIcon'),
(17, 15, 'Tenders', 'platform/opportunities/tenders', 'FileSignature'),
(18, 15, 'Programs', 'platform/opportunities/programs', 'Rocket'),
(19, 1, 'Newsroom', 'platform/newsroom', 'Newspaper'),
(20, 19, 'News', 'platform/newsroom/news', 'Newspaper'),
(21, 19, 'Updates', 'platform/newsroom/updates', 'ChartPie'),
(22, 1, 'Content Studio', 'platform/content-studio', 'FileCog'),
(23, 1, 'Support', 'support:index', 'GalleryVerticalEnd'),
(24, 1, 'Settings', 'platform/settings', 'Settings');

-- --------------------------------------------------------

--
-- Table structure for table `search_entries`
--

CREATE TABLE `search_entries` (
  `id` int(11) NOT NULL,
  `article_id` varchar(100) DEFAULT NULL,
  `term` varchar(100) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `search_entries`
--

INSERT INTO `search_entries` (`id`, `article_id`, `term`, `weight`) VALUES
(1, 'user-onboarding', 'onboarding', 6),
(2, 'user-onboarding', 'verify', 2),
(3, 'user-onboarding', 'profile', 1),
(4, 'profile-setup', 'profile', 5),
(5, 'profile-setup', 'avatar', 1),
(6, 'profile-setup', 'timezone', 1),
(7, 'user-registration', 'signup', 4),
(8, 'user-registration', 'verification', 3),
(9, 'setting-preferences', 'preferences', 4),
(10, 'setting-preferences', 'language', 2),
(11, 'setting-preferences', 'timezone', 2),
(12, 'company-registration', 'company', 4),
(13, 'company-registration', 'registration', 4),
(14, 'company-registration', 'directory', 1),
(15, 'password-reset', 'password', 6),
(16, 'password-reset', 'reset', 5),
(17, 'enable-2fa', '2fa', 6),
(18, 'enable-2fa', 'totp', 3),
(19, 'enable-2fa', 'security', 2),
(20, 'login-activity', 'login', 4),
(21, 'login-activity', 'activity', 3),
(22, 'login-activity', 'audit', 2),
(23, 'session-timeout', 'session', 4),
(24, 'session-timeout', 'timeout', 3),
(25, 'login-devices', 'devices', 4),
(26, 'login-devices', 'security', 2),
(27, 'export-reports', 'export', 5),
(28, 'export-reports', 'reports', 4),
(29, 'export-reports', 'csv', 2),
(30, 'bulk-import', 'import', 5),
(31, 'bulk-import', 'csv', 4),
(32, 'sharing-reports', 'sharing', 4),
(33, 'sharing-reports', 'reports', 3),
(34, 'sharing-reports', 'links', 2),
(35, 'archiving-data', 'archive', 4),
(36, 'archiving-data', 'lifecycle', 2),
(37, 'report-schedules', 'scheduled', 4),
(38, 'report-schedules', 'reports', 3),
(39, 'report-schedules', 'email', 2),
(40, 'add-team-members', 'invite', 4),
(41, 'add-team-members', 'users', 3),
(42, 'role-permissions', 'roles', 5),
(43, 'role-permissions', 'permissions', 4),
(44, 'role-permissions', 'rbac', 3),
(45, 'real-time-commenting', 'comments', 5),
(46, 'real-time-commenting', 'realtime', 3),
(47, 'notifications', 'notifications', 5),
(48, 'notifications', 'email', 2),
(49, 'slack-teams', 'slack', 4),
(50, 'slack-teams', 'teams', 4),
(51, 'slack-teams', 'integrations', 3),
(52, 'system-status', 'status', 4),
(53, 'system-status', 'uptime', 3),
(54, 'emergency-contacts', 'emergency', 4),
(55, 'emergency-contacts', 'contacts', 3),
(56, 'ask-question-1', 'support', 3),
(57, 'ask-question-1', 'question', 2),
(58, 'ask-question-2', 'support', 3),
(59, 'ask-question-2', 'screenshots', 2),
(60, 'ask-question-3', 'support', 3),
(61, 'ask-question-3', 'email', 2),
(62, 'keyboard-shortcuts', 'shortcuts', 5),
(63, 'keyboard-shortcuts', 'keyboard', 4),
(64, 'api-access', 'api', 6),
(65, 'api-access', 'developers', 3),
(66, 'api-access', 'key', 2),
(67, 'custom-templates', 'templates', 4),
(68, 'custom-templates', 'content', 2),
(69, 'bulk-import-tools', 'import', 5),
(70, 'bulk-import-tools', 'tools', 3),
(71, 'system-backup', 'backup', 5),
(72, 'system-backup', 'recovery', 3),
(73, 'companies-insights', 'companies', 5),
(74, 'companies-insights', 'insights', 5),
(75, 'companies-insights', 'metrics', 3),
(76, 'investors-directory', 'investors', 5),
(77, 'investors-directory', 'directory', 4),
(78, 'enablers-assessment', 'enablers', 5),
(79, 'enablers-assessment', 'assessment', 4),
(80, 'enablers-assessment', 'eso', 3),
(81, 'opportunities-tenders', 'opportunities', 5),
(82, 'opportunities-tenders', 'tenders', 5),
(83, 'opportunities-tenders', 'rfp', 3),
(84, 'content-studio-basics', 'content', 4),
(85, 'content-studio-basics', 'studio', 4),
(86, 'content-studio-basics', 'cms', 3);

-- --------------------------------------------------------

--
-- Table structure for table `support_articles`
--

CREATE TABLE `support_articles` (
  `id` varchar(100) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `format` varchar(10) DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `body` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_articles`
--

INSERT INTO `support_articles` (`id`, `title`, `format`, `updated_at`, `body`) VALUES
('add-team-members', 'Add team members', 'md', '2025-10-21', '## Invite teammates\nGo to **Users → Invite**. Assign roles (Viewer, Editor, Admin, Superadmin) based on responsibilities.\n'),
('api-access', 'API access', 'md', '2025-10-21', '## API\nRequest an API key from **Settings → Developers**. Rate limits and scopes apply.\n'),
('archiving-data', 'Archiving old data', 'md', '2025-10-21', '## Archive policy\nArchive stale companies/investors/events to improve performance. Restore anytime.\n'),
('ask-question-1', 'Ask a question or describe a (1)', 'md', '2025-10-21', '## Ask support\nTell us what you’re trying to do and what you expected vs. what happened.\n'),
('ask-question-2', 'Ask a question or describe a (2)', 'md', '2025-10-21', '## Ask support v2\nInclude screenshots and the URL.\n'),
('ask-question-3', 'Ask a question or describe a (3)', 'md', '2025-10-21', '## Ask support v3\nWe’ll follow up by email.\n'),
('bulk-import', 'Bulk import data', 'md', '2025-10-21', '## Bulk import\nUse the **Bulk Import** tool for Companies, Investors, Events. Upload CSV, map columns, preview, then commit.\n'),
('bulk-import-tools', 'Bulk import tools', 'md', '2025-10-21', '## Tools\nDownload sample CSVs, validate locally, then upload via **Bulk Import**.\n'),
('companies-insights', 'Companies → Insights', 'md', '2025-10-21', '## Company Insights\nFunding rounds, traction growth, hiring trends, and sector distribution.\nAdmins see advanced filters and cohort comparisons.\n'),
('company-registration', 'Company registration steps', 'md', '2025-09-21', '## Company registration\n1. Go to **Companies → Directory → Add company**.\n2. Provide legal name, sector, location, and contacts.\n3. Optionally attach pitch deck and logo.\n4. Submit for admin review (if moderation is enabled).\n'),
('content-studio-basics', 'Content Studio → Basics1', 'md', '2025-10-21', '## Content Studio\nManage site copy, resources, feeds, message templates, presets, and analysis narratives.\n'),
('custom-templates', 'Custom templates', 'md', '2025-10-21', '## Templates\nCreate reusable templates for reports, opportunities, and messages in **Content Studio**.\n'),
('emergency-contacts', 'Emergency contacts', 'md', '2025-10-21', '## Emergency contacts\nEmail: support@example.org\nPhone: +250 700 000 000\nSLA: P1 in 2h, P2 in 8h, P3 next business day.\n'),
('enable-2fa', 'Enable 2FA', 'md', '2025-09-19', '## Two-factor authentication\nEnable 2FA in **Settings → Security**. Supported: TOTP apps (Authy, Google Authenticator). Recovery codes are shown once—store securely.\n'),
('enablers-assessment', 'Enablers → Assessment', 'md', '2025-10-21', '## ESO Assessment\nScorecards for hubs, incubators, universities. KPIs: programs, jobs, cohorts, follow-on capital.\n'),
('export-reports', 'Export reports', 'md', '2025-10-21', '## Export\nFrom any analytics page, click **Export** to download CSV/XLSX or schedule emailed PDFs.\n'),
('investors-directory', 'Investors → Directory', 'md', '2025-10-21', '## Investor Directory\nBrowse funds, angels, and DFIs. Track theses, ticket sizes, and geo focus.\n'),
('keyboard-shortcuts', 'Keyboard shortcuts', 'md', '2025-10-21', '## Shortcuts\n- `/` focus search\n- `g c` go to Companies\n- `g i` go to Investors\n- `?` open help\n'),
('login-activity', 'Check login activity', 'md', '2025-10-21', '## Login activity\nReview recent sign-ins, IP addresses, and device info in **Settings → Security → Activity**. Click **Sign out of other devices** if needed.\n'),
('login-devices', 'Managing login devices', 'md', '2025-10-21', '## Devices\nView and revoke remembered devices. Enable **device approval** for high-security organizations.\n'),
('notifications', 'Notification settings', 'md', '2025-10-21', '## Notifications\nEmail, in-app, and (optional) Slack notifications. Customize per module.\n'),
('opportunities-tenders', 'Opportunities → Tenders', 'md', '2025-10-21', '## Tenders\nPublish and manage RFPs/RFQs. Vendors submit bids; admins shortlist and award.\n'),
('password-reset', 'Password reset guide', 'md', '2025-09-19', '## Reset your password\n1. Click **Forgot password** on the login screen.\n2. Enter your email and follow the link.\n3. Set a strong password (≥ 12 chars, mixed types).\n\n> Admins can force a reset in **Users**.\n'),
('profile-setup', 'Profile setup', 'md', '2025-09-19', '## Profile setup\nGo to **Settings → Profile**. Update your display name, avatar, job title, and bio. Set your notification preferences and time zone.\n\n### Recommendations\n- Use a clear headshot (≥ 400×400).\n- Add a short, descriptive bio.\n- Set a backup email for critical alerts.\n'),
('real-time-commenting', 'Real-time commenting', 'md', '2025-10-21', '## Comments\nMention teammates with **@name** in company/investor profiles and program pages. Threaded, live updates.\n'),
('report-schedules', 'Automating report schedules', 'md', '2025-10-21', '## Scheduled reports\nSet weekly/monthly email reports to leadership with KPIs and trends.\n'),
('role-permissions', 'Role-based permissions', 'md', '2025-10-21', '## Roles\n- **User**: read, limited write\n- **Admin**: manage content & people\n- **Superadmin**: platform-wide settings\n'),
('session-timeout', 'Session timeout settings', 'md', '2025-10-21', '## Session timeout\nDefault idle timeout is 30 minutes. Admins can configure per workspace in **Settings → Platform**.\n'),
('setting-preferences', 'Setting preferences', 'md', '2025-09-20', '## Preferences\nVisit **Settings → Preferences** to configure language, time zone, notification frequency, and data display density.\n'),
('sharing-reports', 'Sharing reports externally', 'md', '2025-10-21', '## Share securely\nGenerate one-time links or time-bound shares. Optional password and watermarking for PDFs.\n'),
('slack-teams', 'Integrating Slack/Teams', 'md', '2025-10-21', '## Integrations\nConnect Slack/Teams to push activity summaries and alerts to a channel.\n'),
('system-backup', 'System backup options', 'md', '2025-10-21', '## Backups\nDaily snapshots retained for 30 days. Contact support for data export.\n'),
('system-status', 'Check system status1', 'md', '2025-10-21', '## Status\nVisit **Support → System Status** for realtime uptime and incident history.\n'),
('user-onboarding', 'User onboarding', 'md', '2025-09-18', '## Overview\nWelcome to Innovate Rwanda Admin. This guide helps new users get productive quickly.\n\n### Steps\n1. **Invitation/Registration** – Create an account with a work email.\n2. **Email verification** – Click the verification link.\n3. **Profile setup** – Complete name, role, and organization.\n4. **Pick a workspace** – Choose your ecosystem/team (if applicable).\n5. **Quick tour** – Dashboard, Companies, Investors, Enablers, Opportunities.\n\n> Tip: Admins can pre-assign roles to fast-track access.\n'),
('user-registration', 'User registration', 'md', '2025-09-20', '## Registration\nYou can register via **Invite** from admins or **Self-signup** (if enabled).\n\n### Self-signup options\n- Email + password\n- Social sign-in (if configured)\n\n### Verification\nAll new accounts require email verification before first login.\n');

-- --------------------------------------------------------

--
-- Table structure for table `support_categories`
--

CREATE TABLE `support_categories` (
  `id` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `position` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_categories`
--

INSERT INTO `support_categories` (`id`, `title`, `position`) VALUES
(1, '1. Getting Started', 1),
(2, '2. Security', 2),
(3, '3. Data & Reports', 3),
(4, '4. Collaboration', 4),
(5, '5. Troubleshooting', 5),
(6, '6. Advanced Features', 6),
(7, '7. Platform Modules', 7);

-- --------------------------------------------------------

--
-- Table structure for table `support_category_items`
--

CREATE TABLE `support_category_items` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `article_id` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_category_items`
--

INSERT INTO `support_category_items` (`id`, `category_id`, `title`, `article_id`) VALUES
(1, 1, 'User onboarding', 'user-onboarding'),
(2, 1, 'Profile setup', 'profile-setup'),
(3, 1, 'User registration', 'user-registration'),
(4, 1, 'Setting preferences', 'setting-preferences'),
(5, 1, 'Company registration steps', 'company-registration'),
(6, 2, 'Password reset guide', 'password-reset'),
(7, 2, 'Enable 2FA', 'enable-2fa'),
(8, 2, 'Check login activity', 'login-activity'),
(9, 2, 'Session timeout settings', 'session-timeout'),
(10, 2, 'Managing login devices', 'login-devices'),
(11, 3, 'Export reports', 'export-reports'),
(12, 3, 'Bulk import data', 'bulk-import'),
(13, 3, 'Sharing reports externally', 'sharing-reports'),
(14, 3, 'Archiving old data', 'archiving-data'),
(15, 3, 'Automating report schedules', 'report-schedules'),
(16, 4, 'Add team members', 'add-team-members'),
(17, 4, 'Role-based permissions', 'role-permissions'),
(18, 4, 'Real-time commenting', 'real-time-commenting'),
(19, 4, 'Notification settings', 'notifications'),
(20, 4, 'Integrating Slack/Teams', 'slack-teams'),
(21, 5, 'Check system status1', 'system-status'),
(22, 5, 'Emergency contacts', 'emergency-contacts'),
(23, 5, 'Ask a question or describe a (1)', 'ask-question-1'),
(24, 5, 'Ask a question or describe a (2)', 'ask-question-2'),
(25, 5, 'Ask a question or describe a (3)', 'ask-question-3'),
(26, 6, 'Keyboard shortcuts', 'keyboard-shortcuts'),
(27, 6, 'API access', 'api-access'),
(28, 6, 'Custom templates', 'custom-templates'),
(29, 6, 'Bulk import tools', 'bulk-import-tools'),
(30, 6, 'System backup options', 'system-backup'),
(31, 7, 'Companies → Insights', 'companies-insights'),
(32, 7, 'Investors → Directory', 'investors-directory'),
(33, 7, 'Enablers → Assessment', 'enablers-assessment'),
(34, 7, 'Opportunities → Tenders', 'opportunities-tenders'),
(35, 7, 'Content Studio → Basics1', 'content-studio-basics');

-- --------------------------------------------------------

--
-- Table structure for table `theme`
--

CREATE TABLE `theme` (
  `id` int(11) NOT NULL,
  `css` text DEFAULT NULL,
  `token_key` varchar(50) DEFAULT NULL,
  `token_value` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `theme`
--

INSERT INTO `theme` (`id`, `css`, `token_key`, `token_value`) VALUES
(1, '/* optional: add typography, callouts, code blocks */', '--brand-bg', '#0B5FFF'),
(2, NULL, '--brand-fg', '#FFFFFF'),
(3, NULL, '--ink', '#0F172A'),
(4, NULL, '--muted', '#64748B');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article_tags`
--
ALTER TABLE `article_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_id` (`article_id`);

--
-- Indexes for table `json_files`
--
ALTER TABLE `json_files`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `meta`
--
ALTER TABLE `meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `navigation`
--
ALTER TABLE `navigation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `search_entries`
--
ALTER TABLE `search_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_id` (`article_id`);

--
-- Indexes for table `support_articles`
--
ALTER TABLE `support_articles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_categories`
--
ALTER TABLE `support_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_category_items`
--
ALTER TABLE `support_category_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `theme`
--
ALTER TABLE `theme`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article_tags`
--
ALTER TABLE `article_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `json_files`
--
ALTER TABLE `json_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `meta`
--
ALTER TABLE `meta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `navigation`
--
ALTER TABLE `navigation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `search_entries`
--
ALTER TABLE `search_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT for table `support_categories`
--
ALTER TABLE `support_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `support_category_items`
--
ALTER TABLE `support_category_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `theme`
--
ALTER TABLE `theme`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `article_tags`
--
ALTER TABLE `article_tags`
  ADD CONSTRAINT `article_tags_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `support_articles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `navigation`
--
ALTER TABLE `navigation`
  ADD CONSTRAINT `navigation_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `navigation` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `search_entries`
--
ALTER TABLE `search_entries`
  ADD CONSTRAINT `search_entries_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `support_articles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `support_category_items`
--
ALTER TABLE `support_category_items`
  ADD CONSTRAINT `support_category_items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `support_categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
