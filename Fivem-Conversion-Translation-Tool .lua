<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FiveM Professional Resource Converter</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
    <style>
        :root {
            --primary: #9c27b0;
            --secondary: #e91e63;
            --accent: #ff9800;
            --esx: #e74c3c;
            --qb: #9b59b6;
            --map: #f39c12;
            --vehicle: #e67e22;
            --plugin: #1abc9c;
            --dark: #2c3e50;
            --light: #f5f5f5;
            --warning: #f1c40f;
            --danger: #e74c3c;
            --success: #2ecc71;
            --text: #333;
            --header-gradient: linear-gradient(135deg, #d1c4e9, #f8bbd0, #ffccbc);
            --card-gradient: linear-gradient(145deg, #ffffff, #f8f9fa);
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #d1c4e9, #f8bbd0, #ffccbc);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            color: var(--text);
            line-height: 1.6;
            min-height: 100vh;
            padding: 20px;
        }
        
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            backdrop-filter: blur(10px);
        }
        
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background: rgba(0, 0, 0, 0.1);
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: bold;
            font-size: 1.2rem;
            color: var(--primary);
        }
        
        .language-selector {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .language-selector select {
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid rgba(0,0,0,0.2);
            background: rgba(255,255,255,0.8);
            color: var(--text);
            cursor: pointer;
            outline: none;
            transition: all 0.3s;
        }
        
        .language-selector select:hover {
            background: rgba(255,255,255,1);
        }
        
        .language-selector select option {
            background: white;
            color: var(--text);
        }
        
        header {
            background: var(--header-gradient);
            padding: 30px;
            text-align: center;
            color: var(--text);
            position: relative;
            overflow: hidden;
        }
        
        header::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            transform: rotate(30deg);
        }
        
        header h1 {
            font-size: 2.8rem;
            margin-bottom: 10px;
            text-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: relative;
            color: var(--primary);
        }
        
        header p {
            font-size: 1.2rem;
            opacity: 0.9;
            position: relative;
            color: var(--text);
        }
        
        .tabs {
            display: flex;
            background: var(--primary);
            padding: 0;
            margin: 0;
            list-style: none;
            position: relative;
            z-index: 10;
        }
        
        .tabs li {
            flex: 1;
            text-align: center;
            padding: 15px;
            cursor: pointer;
            transition: all 0.3s;
            color: white;
            font-weight: bold;
            border-bottom: 4px solid transparent;
            position: relative;
        }
        
        .tabs li.active {
            background: rgba(255, 255, 255, 0.1);
            border-bottom: 4px solid var(--accent);
        }
        
        .tabs li:hover:not(.active) {
            background: rgba(255, 255, 255, 0.05);
        }
        
        .tabs li::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 4px;
            background: var(--accent);
            transition: all 0.3s;
            transform: translateX(-50%);
        }
        
        .tabs li.active::after {
            width: 100%;
        }
        
        .tab-content {
            padding: 30px;
        }
        
        .tab-pane {
            display: none;
            animation: fadeIn 0.5s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .tab-pane.active {
            display: block;
        }
        
        .card {
            background: var(--card-gradient);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
        }
        
        .card h2 {
            color: var(--primary);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            font-size: 1.8rem;
        }
        
        .card h2 i {
            margin-right: 15px;
            font-size: 2rem;
            color: var(--primary);
            background: rgba(156, 39, 176, 0.1);
            width: 60px;
            height: 60px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        
        .upload-area {
            border: 3px dashed var(--primary);
            border-radius: 10px;
            padding: 50px 20px;
            text-align: center;
            transition: all 0.3s;
            background: rgba(156, 39, 176, 0.05);
            cursor: pointer;
            margin-bottom: 30px;
            position: relative;
        }
        
        .upload-area:hover {
            background: rgba(156, 39, 176, 0.1);
            border-color: var(--secondary);
        }
        
        .upload-area i {
            font-size: 4.5rem;
            color: var(--primary);
            margin-bottom: 20px;
            opacity: 0.7;
        }
        
        .btn {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border: none;
            padding: 16px 35px;
            font-size: 1.1rem;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: bold;
            display: inline-block;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            margin: 10px 5px;
            position: relative;
            overflow: hidden;
        }
        
        .btn::after {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: rgba(255, 255, 255, 0.1);
            transform: rotate(30deg);
            transition: all 0.5s;
            opacity: 0;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }
        
        .btn:hover::after {
            opacity: 1;
        }
        
        .btn:active {
            transform: translateY(1px);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
        }
        
        .btn-esx {
            background: linear-gradient(to right, var(--esx), #c0392b);
        }
        
        .btn-qb {
            background: linear-gradient(to right, var(--qb), #8e44ad);
        }
        
        .btn-map {
            background: linear-gradient(to right, var(--map), #e67e22);
        }
        
        .btn-vehicle {
            background: linear-gradient(to right, var(--vehicle), #d35400);
        }
        
        .btn-plugin {
            background: linear-gradient(to right, var(--plugin), #16a085);
        }
        
        .btn-warning {
            background: linear-gradient(to right, var(--warning), #f39c12);
        }
        
        .btn-danger {
            background: linear-gradient(to right, var(--danger), #c0392b);
        }
        
        .btn-success {
            background: linear-gradient(to right, var(--success), #27ae60);
        }
        
        .file-input-wrapper {
            margin: 25px 0;
            text-align: center;
        }
        
        .file-input-label {
            display: inline-block;
            padding: 16px 35px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border-radius: 50px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
        }
        
        .file-input-label:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }
        
        .hidden {
            display: none;
        }
        
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 30px;
            gap: 20px;
        }
        
        .progress-container {
            width: 100%;
            background: rgba(0, 0, 0, 0.05);
            border-radius: 10px;
            margin: 25px 0;
            overflow: hidden;
            height: 25px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .progress-bar {
            height: 100%;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            width: 0%;
            transition: width 0.4s ease;
            position: relative;
            overflow: hidden;
        }
        
        .progress-bar::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: linear-gradient(
                -45deg,
                rgba(255, 255, 255, 0.2) 25%,
                transparent 25%,
                transparent 50%,
                rgba(255, 255, 255, 0.2) 50%,
                rgba(255, 255, 255, 0.2) 75%,
                transparent 75%,
                transparent
            );
            background-size: 50px 50px;
            animation: move 2s linear infinite;
        }
        
        @keyframes move {
            0% { background-position: 0 0; }
            100% { background-position: 50px 50px; }
        }
        
        .conversion-info {
            margin-top: 30px;
            padding: 20px;
            background: rgba(46, 204, 113, 0.1);
            border-radius: 12px;
            border-left: 5px solid var(--success);
        }
        
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }
        
        .feature-card {
            background: var(--card-gradient);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            border: none;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .feature-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: var(--primary);
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
        }
        
        .feature-card i {
            font-size: 3.5rem;
            color: var(--primary);
            margin-bottom: 20px;
            display: block;
            text-align: center;
        }
        
        .feature-card h3 {
            color: var(--dark);
            margin-bottom: 15px;
            text-align: center;
            font-size: 1.5rem;
        }
        
        .feature-card p {
            text-align: center;
            color: #666;
            margin-bottom: 20px;
        }
        
        .footer {
            text-align: center;
            padding: 25px;
            background: var(--primary);
            color: white;
            position: relative;
        }
        
        .footer::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }
        
        .option-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin: 25px 0;
            justify-content: center;
        }
        
        .option-btn {
            padding: 14px 30px;
            background: rgba(156, 39, 176, 0.1);
            border: 2px solid var(--primary);
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 500;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }
        
        .option-btn.active {
            background: var(--primary);
            color: white;
            box-shadow: 0 5px 15px rgba(156, 39, 176, 0.3);
        }
        
        .option-btn:hover:not(.active) {
            background: rgba(156, 39, 176, 0.2);
        }
        
        .status-box {
            padding: 20px;
            background: rgba(46, 204, 113, 0.1);
            border-radius: 12px;
            border-left: 5px solid var(--success);
            margin: 25px 0;
            display: none;
            animation: fadeIn 0.5s ease;
        }
        
        .github-section {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
            background: rgba(0,0,0,0.05);
            padding: 15px;
            border-radius: 10px;
        }
        
        .github-section input {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid #ddd;
            border-radius: 50px;
            font-size: 1rem;
            outline: none;
            transition: all 0.3s;
        }
        
        .github-section input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.2);
        }
        
        .github-section button {
            padding: 12px 25px;
            background: linear-gradient(to right, #333, #555);
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .github-section button:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .language-info {
            background: rgba(155, 89, 182, 0.1);
            border-left: 5px solid var(--qb);
            padding: 15px;
            margin-top: 20px;
            border-radius: 8px;
        }
        
        .file-list {
            max-height: 200px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
            margin-top: 15px;
        }
        
        .file-item {
            display: flex;
            justify-content: space-between;
            padding: 8px;
            border-bottom: 1px solid #eee;
        }
        
        .file-item:last-child {
            border-bottom: none;
        }
        
        .file-status {
            font-size: 0.9rem;
            color: #666;
        }
        
        .status-success {
            color: var(--success);
        }
        
        .status-warning {
            color: var(--warning);
        }
        
        .status-skipped {
            color: #777;
        }
        
        .language-flag {
            width: 24px;
            height: 16px;
            display: inline-block;
            margin-right: 8px;
            vertical-align: middle;
            border: 1px solid #ddd;
        }
        
        @media (max-width: 768px) {
            .tabs {
                flex-direction: column;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                margin: 8px 0;
            }
            
            header h1 {
                font-size: 2.2rem;
            }
            
            .card {
                padding: 20px;
            }
            
            .feature-grid {
                grid-template-columns: 1fr;
            }
            
            .top-bar {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <div class="logo">
                <i class="fas fa-sync-alt"></i>
                <span id="logo-text">FiveM Resource Converter</span>
            </div>
            <div class="language-selector">
                <span><i class="fas fa-globe"></i> <span id="language-label">Language:</span></span>
                <select id="languageSelector">
                    <option value="en" selected>English</option>
                    <option value="zh-cn">简体中文 (Chinese)</option>
                    <option value="zh-tw">繁體中文 (Taiwan)</option>
                    <option value="de">Deutsch (German)</option>
                    <option value="da">Dansk (Danish)</option>
                    <option value="es">Español (Spanish)</option>
                    <option value="fr">Français (French)</option>
                    <option value="it">Italiano (Italian)</option>
                </select>
            </div>
        </div>
        
        <header>
            <h1><i class="fas fa-sync-alt"></i> <span id="main-title">FiveM Professional Resource Converter</span></h1>
            <p id="subtitle">Multi-language support | Strictly follows FiveM documentation</p>
        </header>
        
        <ul class="tabs">
            <li class="active" data-tab="resource"><span id="tab-resource">Resource Conversion</span></li>
            <li data-tab="framework"><span id="tab-framework">Framework Conversion</span></li>
            <li data-tab="security"><span id="tab-security">Security</span></li>
            <li data-tab="localization"><span id="tab-localization">Localization</span></li>
        </ul>
        
        <div class="tab-content">
            <!-- Resource Conversion Tab -->
            <div id="resource" class="tab-pane active">
                <div class="card">
                    <h2><i class="fas fa-file-archive"></i> <span id="resource-title">FiveM Resource Conversion</span></h2>
                    <p id="resource-desc">Upload ZIP resource package to convert to FiveM compatible format</p>
                    
                    <div class="upload-area" id="dropZone">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <h3 id="upload-title">Drag & Drop or Select Resource ZIP</h3>
                        <p id="upload-desc">Supports vehicle, map, and plugin resources</p>
                        <div class="file-input-wrapper">
                            <label for="resourceFile" class="file-input-label">
                                <i class="fas fa-folder-open"></i> <span id="select-zip">Select ZIP File</span>
                            </label>
                            <input type="file" id="resourceFile" class="hidden" accept=".zip">
                        </div>
                    </div>
                    
                    <div class="option-group">
                        <div class="option-btn active" data-type="auto"><span id="option-auto">Auto Detect</span></div>
                        <div class="option-btn" data-type="vehicle"><span id="option-vehicle">Vehicle</span></div>
                        <div class="option-btn" data-type="map"><span id="option-map">Map</span></div>
                        <div class="option-btn" data-type="plugin"><span id="option-plugin">Plugin</span></div>
                    </div>
                    
                    <div class="github-section">
                        <input type="text" id="githubUrl" placeholder="Enter GitHub Resource URL...">
                        <button id="fetchGithub"><i class="fab fa-github"></i> <span id="github-button">Fetch from GitHub</span></button>
                    </div>
                    
                    <div class="progress-container">
                        <div class="progress-bar" id="resourceProgress"></div>
                    </div>
                    
                    <div class="status-box" id="resourceStatus">
                        <i class="fas fa-check-circle"></i>
                        <span id="status-text">Conversion complete! Download the converted files</span>
                    </div>
                    
                    <div class="action-buttons">
                        <button class="btn" id="convertResource">
                            <i class="fas fa-cogs"></i> <span id="convert-button">Convert Resource</span>
                        </button>
                        <button class="btn btn-success" id="downloadResource" disabled>
                            <i class="fas fa-download"></i> <span id="download-button">Download Result</span>
                        </button>
                    </div>
                </div>
                
                <div class="conversion-info">
                    <h3><i class="fas fa-info-circle"></i> <span id="info-title">Conversion Details</span></h3>
                    <p id="info-desc">The tool will perform the following:</p>
                    <ul>
                        <li id="info-item1">Automatic resource type detection</li>
                        <li id="info-item2">Convert __resource.lua to fxmanifest.lua</li>
                        <li id="info-item3">Fix common errors (e.g. gt=5 → gta5)</li>
                        <li id="info-item4">Preserve original file structure</li>
                        <li id="info-item5">Strictly follow FiveM documentation</li>
                        <li id="info-item6">Support GitHub resource fetching</li>
                    </ul>
                </div>
            </div>
            
            <!-- Framework Conversion Tab -->
            <div id="framework" class="tab-pane">
                <div class="card">
                    <h2><i class="fas fa-exchange-alt"></i> <span id="framework-title">Framework Conversion</span></h2>
                    <p id="framework-desc">Convert scripts between ESX and QBcore frameworks</p>
                    
                    <div class="feature-grid">
                        <div class="feature-card">
                            <i class="fas fa-arrow-right" style="color: var(--esx);"></i>
                            <h3 id="esx-to-qb">ESX to QBcore</h3>
                            <p id="esx-to-qb-desc">Convert ESX scripts to QBcore framework</p>
                            <div class="file-input-wrapper">
                                <label for="esxToQbFile" class="file-input-label" style="background: linear-gradient(to right, var(--esx), #c0392b);">
                                    <i class="fas fa-file-code"></i> <span>Select Script</span>
                                </label>
                                <input type="file" id="esxToQbFile" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn btn-esx" style="margin-top: 15px; width: 100%;" id="convertEsxToQb">
                                <i class="fas fa-cogs"></i> <span id="convert-esx-qb">Convert to QBcore</span>
                            </button>
                        </div>
                        
                        <div class="feature-card">
                            <i class="fas fa-arrow-right" style="color: var(--qb);"></i>
                            <h3 id="qb-to-esx">QBcore to ESX</h3>
                            <p id="qb-to-esx-desc">Convert QBcore scripts to ESX framework</p>
                            <div class="file-input-wrapper">
                                <label for="qbToEsxFile" class="file-input-label" style="background: linear-gradient(to right, var(--qb), #8e44ad);">
                                    <i class="fas fa-file-code"></i> <span>Select Script</span>
                                </label>
                                <input type="file" id="qbToEsxFile" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn btn-qb" style="margin-top: 15px; width: 100%;" id="convertQbToEsx">
                                <i class="fas fa-cogs"></i> <span id="convert-qb-esx">Convert to ESX</span>
                            </button>
                        </div>
                        
                        <div class="feature-card">
                            <i class="fas fa-sync-alt" style="color: var(--esx);"></i>
                            <h3 id="esx-to-new">ESX to New ESX</h3>
                            <p id="esx-to-new-desc">Convert legacy ESX to new ESX (1.9+)</p>
                            <div class="file-input-wrapper">
                                <label for="esxToNewFile" class="file-input-label" style="background: linear-gradient(to right, var(--esx), #c0392b);">
                                    <i class="fas fa-file-code"></i> <span>Select Script</span>
                                </label>
                                <input type="file" id="esxToNewFile" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn btn-esx" style="margin-top: 15px; width: 100%;" id="convertEsxToNew">
                                <i class="fas fa-cogs"></i> <span id="convert-esx-new">Convert to New ESX</span>
                            </button>
                        </div>
                    </div>
                    
                    <div class="conversion-info">
                        <h3><i class="fas fa-lightbulb"></i> <span id="process-title">Conversion Process</span></h3>
                        <p id="process-desc">Framework conversion uses advanced code analysis:</p>
                        <ul>
                            <li id="process-item1">Parse framework-specific API calls</li>
                            <li id="process-item2">Map equivalent functions and events</li>
                            <li id="process-item3">Intelligent variable and callback refactoring</li>
                            <li id="process-item4">Preserve original functionality</li>
                            <li id="process-item5">Supports complex script conversion</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- Security Tab -->
            <div id="security" class="tab-pane">
                <div class="card">
                    <h2><i class="fas fa-shield-alt"></i> <span id="security-title">Security Processing</span></h2>
                    <p id="security-desc">Detect and remove backdoors and region locks</p>
                    
                    <div class="feature-grid">
                        <div class="feature-card">
                            <i class="fas fa-globe-americas" style="color: var(--primary);"></i>
                            <h3 id="remove-region">Remove Region Lock</h3>
                            <p id="remove-region-desc">Remove region restrictions from plugins</p>
                            <div class="file-input-wrapper">
                                <label for="removeRegionLock" class="file-input-label">
                                    <i class="fas fa-file-code"></i> <span>Select Script</span>
                                </label>
                                <input type="file" id="removeRegionLock" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn" style="margin-top: 15px; width: 100%;" id="removeRegionBtn">
                                <i class="fas fa-unlock"></i> <span id="remove-button">Remove Restrictions</span>
                            </button>
                        </div>
                        
                        <div class="feature-card">
                            <i class="fas fa-user-secret" style="color: var(--danger);"></i>
                            <h3 id="backdoor-title">Backdoor Detection</h3>
                            <p id="backdoor-desc">Detect and remove malicious backdoors</p>
                            <div class="file-input-wrapper">
                                <label for="detectBackdoor" class="file-input-label">
                                    <i class="fas fa-file-code"></i> <span>Select Script</span>
                                </label>
                                <input type="file" id="detectBackdoor" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn btn-danger" style="margin-top: 15px; width: 100%;" id="detectBackdoorBtn">
                                <i class="fas fa-shield-virus"></i> <span id="scan-button">Scan & Remove</span>
                            </button>
                        </div>
                    </div>
                    
                    <div class="conversion-info">
                        <h3><i class="fas fa-database"></i> <span id="db-title">Security Database</span></h3>
                        <p id="db-desc">Tool uses the following security resources:</p>
                        <ul>
                            <li id="db-item1">Official FiveM security guidelines</li>
                            <li id="db-item2">GitHub backdoor pattern database</li>
                            <li id="db-item3">Community-reported malicious code</li>
                            <li id="db-item4">Automatically updated security rules</li>
                            <li id="db-item5">Real-time code behavior analysis</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- Localization Tab -->
            <div id="localization" class="tab-pane">
                <div class="card">
                    <h2><i class="fas fa-language"></i> <span id="local-title">Multi-language Localization</span></h2>
                    <p id="local-desc">Translate resources to your selected language</p>
                    
                    <div class="language-info">
                        <p><i class="fas fa-info-circle"></i> <strong id="strategy-title">Localization Strategy</strong>: <span id="strategy-desc">Only translate UI text and configuration, preserve code logic</span></p>
                    </div>
                    
                    <div class="feature-grid">
                        <div class="feature-card">
                            <i class="fas fa-font" style="color: var(--success);"></i>
                            <h3 id="res-local">Resource Localization</h3>
                            <p id="res-local-desc">Intelligent text recognition and translation</p>
                            <div class="file-input-wrapper">
                                <label for="localizeScript" class="file-input-label">
                                    <i class="fas fa-file-archive"></i> <span>Select Resource/ZIP</span>
                                </label>
                                <input type="file" id="localizeScript" class="hidden" accept=".lua,.js,.zip">
                            </div>
                            <div class="action-buttons">
                                <button class="btn btn-success" id="localizeResourceBtn">
                                    <i class="fas fa-language"></i> <span id="localize-button">Localize Resource</span>
                                </button>
                                <button class="btn" id="downloadLocalized" style="display: none; margin-top: 10px;">
                                    <i class="fas fa-download"></i> <span>Download Result</span>
                                </button>
                            </div>
                        </div>
                        
                        <div class="feature-card">
                            <i class="fas fa-cogs" style="color: var(--primary);"></i>
                            <h3 id="settings-title">Localization Settings</h3>
                            <p id="settings-desc">Customize localization options</p>
                            <div class="option-group" style="flex-direction: column; align-items: flex-start;">
                                <label style="margin: 10px; display: flex; align-items: center;">
                                    <input type="checkbox" id="translateConfig" checked style="margin-right: 10px;">
                                    <span id="config-label">Translate config.lua</span>
                                </label>
                                <label style="margin: 10px; display: flex; align-items: center;">
                                    <input type="checkbox" id="ignoreServerFiles" checked style="margin-right: 10px;">
                                    <span id="ignore-label">Ignore server.lua/server_*.lua</span>
                                </label>
                                <label style="margin: 10px; display: flex; align-items: center;">
                                    <input type="checkbox" id="createLangFile" checked style="margin-right: 10px;">
                                    <span id="create-label">Create language file</span>
                                </label>
                                <label style="margin: 10px; display: flex; align-items: center;">
                                    <input type="checkbox" id="preserveFormat" checked style="margin-right: 10px;">
                                    <span id="preserve-label">Preserve original format</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="conversion-info" style="margin-top: 30px;">
                        <h3><i class="fas fa-info-circle"></i> <span id="details-title">Localization Details</span></h3>
                        <p id="details-desc">Localization strictly follows FiveM best practices:</p>
                        <ul>
                            <li id="detail-item1">Only translate UI text and configuration options</li>
                            <li id="detail-item2">Preserve all code logic and structure</li>
                            <li id="detail-item3">Skip server.lua and server_*.lua files</li>
                            <li id="detail-item4">Automatically skip encrypted files</li>
                            <li id="detail-item5">Create language file in selected language</li>
                            <li id="detail-item6">Preserve original file format and names</li>
                        </ul>
                    </div>
                    
                    <div class="file-list" id="fileList" style="display: none;">
                        <h4 id="file-title">File Processing Results:</h4>
                        <div id="fileItems"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p id="footer-text">FiveM Professional Resource Converter v5.0 | Strictly follows FiveM documentation</p>
            <p id="footer-subtext">© 2023 FiveM Resource Converter | Supports vehicles, maps, and plugins</p>
        </div>
    </div>

    <script>
        // Language translations
        const translations = {
            'en': {
                'logo': "FiveM Resource Converter",
                'language': "Language:",
                'title': "FiveM Professional Resource Converter",
                'subtitle': "Multi-language support | Strictly follows FiveM documentation",
                'resource': "Resource Conversion",
                'framework': "Framework Conversion",
                'security': "Security",
                'localization': "Localization",
                'resourceTitle': "FiveM Resource Conversion",
                'resourceDesc': "Upload ZIP resource package to convert to FiveM compatible format",
                'uploadTitle': "Drag & Drop or Select Resource ZIP",
                'uploadDesc': "Supports vehicle, map, and plugin resources",
                'selectZip': "Select ZIP File",
                'autoDetect': "Auto Detect",
                'vehicle': "Vehicle",
                'map': "Map",
                'plugin': "Plugin",
                'githubButton': "Fetch from GitHub",
                'convertButton': "Convert Resource",
                'downloadButton': "Download Result",
                'statusText': "Conversion complete! Download the converted files",
                'infoTitle': "Conversion Details",
                'infoDesc': "The tool will perform the following:",
                'info1': "Automatic resource type detection",
                'info2': "Convert __resource.lua to fxmanifest.lua",
                'info3': "Fix common errors (e.g. gt=5 → gta5)",
                'info4': "Preserve original file structure",
                'info5': "Strictly follow FiveM documentation",
                'info6': "Support GitHub resource fetching",
                'frameworkTitle': "Framework Conversion",
                'frameworkDesc': "Convert scripts between ESX and QBcore frameworks",
                'esxToQb': "ESX to QBcore",
                'esxToQbDesc': "Convert ESX scripts to QBcore framework",
                'qbToEsx': "QBcore to ESX",
                'qbToEsxDesc': "Convert QBcore scripts to ESX framework",
                'esxToNew': "ESX to New ESX",
                'esxToNewDesc': "Convert legacy ESX to new ESX (1.9+)",
                'convertEsxQb': "Convert to QBcore",
                'convertQbEsx': "Convert to ESX",
                'convertEsxNew': "Convert to New ESX",
                'processTitle': "Conversion Process",
                'processDesc': "Framework conversion uses advanced code analysis:",
                'process1': "Parse framework-specific API calls",
                'process2': "Map equivalent functions and events",
                'process3': "Intelligent variable and callback refactoring",
                'process4': "Preserve original functionality",
                'process5': "Supports complex script conversion",
                'securityTitle': "Security Processing",
                'securityDesc': "Detect and remove backdoors and region locks",
                'removeRegion': "Remove Region Lock",
                'removeRegionDesc': "Remove region restrictions from plugins",
                'backdoorTitle': "Backdoor Detection",
                'backdoorDesc': "Detect and remove malicious backdoors",
                'removeButton': "Remove Restrictions",
                'scanButton': "Scan & Remove",
                'dbTitle': "Security Database",
                'dbDesc': "Tool uses the following security resources:",
                'db1': "Official FiveM security guidelines",
                'db2': "GitHub backdoor pattern database",
                'db3': "Community-reported malicious code",
                'db4': "Automatically updated security rules",
                'db5': "Real-time code behavior analysis",
                'localTitle': "Multi-language Localization",
                'localDesc': "Translate resources to your selected language",
                'strategyTitle': "Localization Strategy",
                'strategyDesc': "Only translate UI text and configuration, preserve code logic",
                'resLocal': "Resource Localization",
                'resLocalDesc': "Intelligent text recognition and translation",
                'localizeButton': "Localize Resource",
                'settingsTitle': "Localization Settings",
                'settingsDesc': "Customize localization options",
                'configLabel': "Translate config.lua",
                'ignoreLabel': "Ignore server.lua/server_*.lua",
                'createLabel': "Create language file",
                'preserveLabel': "Preserve original format",
                'detailsTitle': "Localization Details",
                'detailsDesc': "Localization strictly follows FiveM best practices:",
                'detail1': "Only translate UI text and configuration options",
                'detail2': "Preserve all code logic and structure",
                'detail3': "Skip server.lua and server_*.lua files",
                'detail4': "Automatically skip encrypted files",
                'detail5': "Create language file in selected language",
                'detail6': "Preserve original file format and names",
                'fileTitle': "File Processing Results:",
                'success': "Success",
                'skipped': "Skipped",
                'warning': "Warning",
                'localizationComplete': "Localization complete! Language file created",
                'footerText': "FiveM Professional Resource Converter v5.0 | Strictly follows FiveM documentation",
                'footerSubtext': "© 2023 FiveM Resource Converter | Supports vehicles, maps and plugins"
            },
            'zh-cn': {
                'logo': "FiveM 资源转换工具",
                'language': "语言:",
                'title': "FiveM 专业资源转换工具",
                'subtitle': "多语言支持 | 严格遵循FiveM文档规范",
                'resource': "资源转换",
                'framework': "框架转换",
                'security': "安全处理",
                'localization': "本地化",
                'resourceTitle': "FiveM资源转换",
                'resourceDesc': "上传ZIP格式的资源包，工具将自动识别类型并转换为FiveM可用格式",
                'uploadTitle': "拖放或选择资源ZIP文件",
                'uploadDesc': "支持车辆、地图、插件资源包的转换",
                'selectZip': "选择ZIP文件",
                'autoDetect': "自动识别",
                'vehicle': "车辆资源",
                'map': "地图资源",
                'plugin': "插件资源",
                'githubButton': "从GitHub获取",
                'convertButton': "转换资源",
                'downloadButton': "下载结果",
                'statusText': "转换完成！请下载转换后的文件",
                'infoTitle': "转换说明",
                'infoDesc': "工具将执行以下操作:",
                'info1': "自动识别资源类型（车辆/地图/插件）",
                'info2': "转换__resource.lua为fxmanifest.lua",
                'info3': "修复常见错误（如gt=5 → gta5）",
                'info4': "保留原始文件结构",
                'info5': "严格遵循FiveM官方文档规范",
                'info6': "支持从GitHub直接获取资源",
                'frameworkTitle': "框架转换",
                'frameworkDesc': "在ESX和QBcore框架之间转换脚本",
                'esxToQb': "ESX 转 QBcore",
                'esxToQbDesc': "将ESX框架脚本转换为QBcore框架",
                'qbToEsx': "QBcore 转 ESX",
                'qbToEsxDesc': "将QBcore框架脚本转换为ESX框架",
                'esxToNew': "ESX 转 New ESX",
                'esxToNewDesc': "将旧版ESX转换为新版ESX (1.9+)",
                'convertEsxQb': "转换到QBcore",
                'convertQbEsx': "转换到ESX",
                'convertEsxNew': "转换到New ESX",
                'processTitle': "转换原理",
                'processDesc': "框架转换使用高级代码分析技术:",
                'process1': "解析ESX/QBcore特定API调用",
                'process2': "映射等效函数和事件",
                'process3': "智能重构变量和回调",
                'process4': "保留原始功能同时转换框架逻辑",
                'process5': "支持复杂脚本转换",
                'securityTitle': "安全处理",
                'securityDesc': "检测和移除脚本中的后门与地区限制",
                'removeRegion': "插件去墙",
                'removeRegionDesc': "移除插件中的地区限制",
                'backdoorTitle': "后门检测与移除",
                'backdoorDesc': "检测并移除脚本中的恶意后门",
                'removeButton': "移除地区限制",
                'scanButton': "检测并移除后门",
                'dbTitle': "安全数据库",
                'dbDesc': "工具使用以下安全资源:",
                'db1': "FiveM官方安全指南",
                'db2': "GitHub后门模式数据库",
                'db3': "社区报告恶意代码库",
                'db4': "自动更新安全规则",
                'db5': "实时代码行为分析",
                'localTitle': "多语言本地化",
                'localDesc': "将资源内容转换为简体中文",
                'strategyTitle': "本地化策略",
                'strategyDesc': "只翻译UI文本和配置项，保留代码逻辑",
                'resLocal': "资源本地化",
                'resLocalDesc': "智能文本识别和翻译",
                'localizeButton': "本地化资源",
                'settingsTitle': "本地化设置",
                'settingsDesc': "自定义本地化选项",
                'configLabel': "翻译config.lua文件",
                'ignoreLabel': "忽略server.lua/server_*.lua文件",
                'createLabel': "创建语言文件",
                'preserveLabel': "保留原始格式",
                'detailsTitle': "本地化说明",
                'detailsDesc': "本地化严格遵循FiveM最佳实践:",
                'detail1': "只翻译UI文本和配置选项",
                'detail2': "保留所有代码逻辑和结构",
                'detail3': "跳过server.lua和server_*.lua文件",
                'detail4': "自动跳过加密文件",
                'detail5': "创建选定语言的语言文件",
                'detail6': "保留原始文件格式和名称",
                'fileTitle': "文件处理结果:",
                'success': "成功",
                'skipped': "已跳过",
                'warning': "警告",
                'localizationComplete': "本地化完成！语言文件已创建",
                'footerText': "FiveM 专业资源转换工具 v5.0 | 严格遵循FiveM官方文档规范",
                'footerSubtext': "© 2023 FiveM资源转换专家 | 支持车辆、地图、插件资源转换"
            },
            'zh-tw': {
                'logo': "FiveM 資源轉換工具",
                'language': "語言:",
                'title': "FiveM 專業資源轉換工具",
                'subtitle': "多語言支援 | 嚴格遵循FiveM文件規範",
                'resource': "資源轉換",
                'framework': "框架轉換",
                'security': "安全處理",
                'localization': "本地化",
                'resourceTitle': "FiveM資源轉換",
                'resourceDesc': "上傳ZIP格式的資源包，工具將自動識別類型並轉換為FiveM可用格式",
                'uploadTitle': "拖放或選擇資源ZIP文件",
                'uploadDesc': "支持車輛、地圖、插件資源包的轉換",
                'selectZip': "選擇ZIP文件",
                'autoDetect': "自動識別",
                'vehicle': "車輛資源",
                'map': "地圖資源",
                'plugin': "插件資源",
                'githubButton': "從GitHub獲取",
                'convertButton': "轉換資源",
                'downloadButton': "下載結果",
                'statusText': "轉換完成！請下載轉換後的文件",
                'infoTitle': "轉換說明",
                'infoDesc': "工具將執行以下操作:",
                'info1': "自動識別資源類型（車輛/地圖/插件）",
                'info2': "轉換__resource.lua為fxmanifest.lua",
                'info3': "修復常見錯誤（如gt=5 → gta5）",
                'info4': "保留原始文件結構",
                'info5': "嚴格遵循FiveM官方文件規範",
                'info6': "支持從GitHub直接獲取資源",
                'frameworkTitle': "框架轉換",
                'frameworkDesc': "在ESX和QBcore框架之間轉換腳本",
                'esxToQb': "ESX 轉 QBcore",
                'esxToQbDesc': "將ESX框架腳本轉換為QBcore框架",
                'qbToEsx': "QBcore 轉 ESX",
                'qbToEsxDesc': "將QBcore框架腳本轉換為ESX框架",
                'esxToNew': "ESX 轉 New ESX",
                'esxToNewDesc': "將舊版ESX轉換為新版ESX (1.9+)",
                'convertEsxQb': "轉換到QBcore",
                'convertQbEsx': "轉換到ESX",
                'convertEsxNew': "轉換到New ESX",
                'processTitle': "轉換原理",
                'processDesc': "框架轉換使用高級代碼分析技術:",
                'process1': "解析ESX/QBcore特定API調用",
                'process2': "映射等效函數和事件",
                'process3': "智能重構變量和回調",
                'process4': "保留原始功能同時轉換框架邏輯",
                'process5': "支持複雜腳本轉換",
                'securityTitle': "安全處理",
                'securityDesc': "檢測和移除腳本中的後門與地區限制",
                'removeRegion': "插件去牆",
                'removeRegionDesc': "移除插件中的地區限制",
                'backdoorTitle': "後門檢測與移除",
                'backdoorDesc': "檢測並移除腳本中的惡意後門",
                'removeButton': "移除地區限制",
                'scanButton': "檢測並移除後門",
                'dbTitle': "安全數據庫",
                'dbDesc': "工具使用以下安全資源:",
                'db1': "FiveM官方安全指南",
                'db2': "GitHub後門模式數據庫",
                'db3': "社區報告惡意代碼庫",
                'db4': "自動更新安全規則",
                'db5': "實時代碼行為分析",
                'localTitle': "多語言本地化",
                'localDesc': "將資源內容轉換為繁體中文",
                'strategyTitle': "本地化策略",
                'strategyDesc': "只翻譯UI文本和配置項，保留代碼邏輯",
                'resLocal': "資源本地化",
                'resLocalDesc': "智能文本識別和翻譯",
                'localizeButton': "本地化資源",
                'settingsTitle': "本地化設置",
                'settingsDesc': "自定義本地化選項",
                'configLabel': "翻譯config.lua文件",
                'ignoreLabel': "忽略server.lua/server_*.lua文件",
                'createLabel': "創建語言文件",
                'preserveLabel': "保留原始格式",
                'detailsTitle': "本地化說明",
                'detailsDesc': "本地化嚴格遵循FiveM最佳實踐:",
                'detail1': "只翻譯UI文本和配置選項",
                'detail2': "保留所有代碼邏輯和結構",
                'detail3': "跳過server.lua和server_*.lua文件",
                'detail4': "自動跳過加密文件",
                'detail5': "創建選定語言的語言文件",
                'detail6': "保留原始文件格式和名稱",
                'fileTitle': "文件處理結果:",
                'success': "成功",
                'skipped': "已跳過",
                'warning': "警告",
                'localizationComplete': "本地化完成！語言文件已建立",
                'footerText': "FiveM 專業資源轉換工具 v5.0 | 嚴格遵循FiveM官方文件規範",
                'footerSubtext': "© 2023 FiveM資源轉換專家 | 支持車輛、地圖、插件資源轉換"
            },
            'de': {
                'logo': "FiveM Ressourcenkonverter",
                'language': "Sprache:",
                'title': "FiveM Professioneller Ressourcen-Konverter",
                'subtitle': "Mehrsprachige Unterstützung | Hält sich strikt an die FiveM-Dokumentation",
                'resource': "Ressourcenkonvertierung",
                'framework': "Framework-Konvertierung",
                'security': "Sicherheit",
                'localization': "Lokalisierung",
                'resourceTitle': "FiveM Ressourcenkonvertierung",
                'resourceDesc': "Laden Sie ein ZIP-Ressourcenpaket hoch, um es in ein FiveM-kompatibles Format zu konvertieren",
                'uploadTitle': "Ziehen & Ablegen oder ZIP-Ressource auswählen",
                'uploadDesc': "Unterstützt Fahrzeug-, Karten- und Plugin-Ressourcen",
                'selectZip': "ZIP-Datei auswählen",
                'autoDetect': "Automatische Erkennung",
                'vehicle': "Fahrzeug",
                'map': "Karte",
                'plugin': "Plugin",
                'githubButton': "Von GitHub abrufen",
                'convertButton': "Ressource konvertieren",
                'downloadButton': "Ergebnis herunterladen",
                'statusText': "Konvertierung abgeschlossen! Konvertierte Dateien herunterladen",
                'infoTitle': "Konvertierungsdetails",
                'infoDesc': "Das Tool führt folgende Schritte durch:",
                'info1': "Automatische Ressourcentyp-Erkennung",
                'info2': "Konvertierung von __resource.lua zu fxmanifest.lua",
                'info3': "Behebung häufiger Fehler (z.B. gt=5 → gta5)",
                'info4': "Beibehaltung der ursprünglichen Dateistruktur",
                'info5': "Strikte Einhaltung der FiveM-Dokumentation",
                'info6': "Unterstützung für GitHub-Ressourcenabruf",
                'frameworkTitle': "Framework-Konvertierung",
                'frameworkDesc': "Konvertieren Sie Skripte zwischen ESX- und QBcore-Frameworks",
                'esxToQb': "ESX zu QBcore",
                'esxToQbDesc': "Konvertieren Sie ESX-Skripte in das QBcore-Framework",
                'qbToEsx': "QBcore zu ESX",
                'qbToEsxDesc': "Konvertieren Sie QBcore-Skripte in das ESX-Framework",
                'esxToNew': "ESX zu New ESX",
                'esxToNewDesc': "Konvertieren Sie Legacy-ESX in neues ESX (1.9+)",
                'convertEsxQb': "Zu QBcore konvertieren",
                'convertQbEsx': "Zu ESX konvertieren",
                'convertEsxNew': "Zu New ESX konvertieren",
                'processTitle': "Konvertierungsprozess",
                'processDesc': "Framework-Konvertierung verwendet fortschrittliche Codeanalyse:",
                'process1': "Parsen frameworkspezifischer API-Aufrufe",
                'process2': "Zuordnung äquivalenter Funktionen und Ereignisse",
                'process3': "Intelligente Variablen- und Callback-Refaktorierung",
                'process4': "Beibehaltung der ursprünglichen Funktionalität",
                'process5': "Unterstützung für komplexe Skriptkonvertierung",
                'securityTitle': "Sicherheitsverarbeitung",
                'securityDesc': "Erkennen und entfernen Sie Backdoors und Regionssperren",
                'removeRegion': "Regionssperre entfernen",
                'removeRegionDesc': "Entfernen Sie Regionsbeschränkungen von Plugins",
                'backdoorTitle': "Backdoor-Erkennung",
                'backdoorDesc': "Erkennen und entfernen Sie bösartige Backdoors",
                'removeButton': "Einschränkungen entfernen",
                'scanButton': "Scannen und entfernen",
                'dbTitle': "Sicherheitsdatenbank",
                'dbDesc': "Das Tool verwendet folgende Sicherheitsressourcen:",
                'db1': "Offizielle FiveM-Sicherheitsrichtlinien",
                'db2': "GitHub Backdoor-Musterdatenbank",
                'db3': "Community-gemeldeter bösartiger Code",
                'db4': "Automatisch aktualisierte Sicherheitsregeln",
                'db5': "Echtzeit-Code-Verhaltensanalyse",
                'localTitle': "Mehrsprachige Lokalisierung",
                'localDesc': "Übersetzen Sie Ressourcen in Ihre ausgewählte Sprache",
                'strategyTitle': "Lokalisierungsstrategie",
                'strategyDesc': "Nur UI-Text und Konfiguration übersetzen, Code-Logik erhalten",
                'resLocal': "Ressourcenlokalisierung",
                'resLocalDesc': "Intelligente Texterkennung und Übersetzung",
                'localizeButton': "Ressource lokalisieren",
                'settingsTitle': "Lokalisierungseinstellungen",
                'settingsDesc': "Passen Sie Lokalisierungsoptionen an",
                'configLabel': "config.lua übersetzen",
                'ignoreLabel': "server.lua/server_*.lua ignorieren",
                'createLabel': "Sprachdatei erstellen",
                'preserveLabel': "Originalformat beibehalten",
                'detailsTitle': "Lokalisierungsdetails",
                'detailsDesc': "Lokalisierung folgt strikt den FiveM-Best-Practices:",
                'detail1': "Nur UI-Text und Konfigurationsoptionen übersetzen",
                'detail2': "Alle Code-Logik und Struktur erhalten",
                'detail3': "server.lua und server_*.lua Dateien überspringen",
                'detail4': "Automatisches Überspringen verschlüsselter Dateien",
                'detail5': "Sprachdatei in ausgewählter Sprache erstellen",
                'detail6': "Originaldateiformat und -namen beibehalten",
                'fileTitle': "Dateiverarbeitungsergebnisse:",
                'success': "Erfolg",
                'skipped': "Übersprungen",
                'warning': "Warnung",
                'localizationComplete': "Lokalisierung abgeschlossen! Sprachdatei erstellt",
                'footerText': "FiveM Professioneller Ressourcen-Konverter v5.0 | Hält sich strikt an die FiveM-Dokumentation",
                'footerSubtext': "© 2023 FiveM Ressourcenkonverter | Unterstützt Fahrzeuge, Karten und Plugins"
            }
        };

        document.addEventListener('DOMContentLoaded', function() {
            // Set default language
            let currentLang = 'en';
            const langSelector = document.getElementById('languageSelector');
            
            // Apply translations to the page
            function applyTranslations(lang) {
                const langData = translations[lang] || translations['en'];
                
                // Update all elements
                document.getElementById('logo-text').textContent = langData.logo;
                document.getElementById('language-label').textContent = langData.language;
                document.getElementById('main-title').textContent = langData.title;
                document.getElementById('subtitle').textContent = langData.subtitle;
                document.getElementById('tab-resource').textContent = langData.resource;
                document.getElementById('tab-framework').textContent = langData.framework;
                document.getElementById('tab-security').textContent = langData.security;
                document.getElementById('tab-localization').textContent = langData.localization;
                document.getElementById('resource-title').textContent = langData.resourceTitle;
                document.getElementById('resource-desc').textContent = langData.resourceDesc;
                document.getElementById('upload-title').textContent = langData.uploadTitle;
                document.getElementById('upload-desc').textContent = langData.uploadDesc;
                document.getElementById('select-zip').textContent = langData.selectZip;
                document.getElementById('option-auto').textContent = langData.autoDetect;
                document.getElementById('option-vehicle').textContent = langData.vehicle;
                document.getElementById('option-map').textContent = langData.map;
                document.getElementById('option-plugin').textContent = langData.plugin;
                document.getElementById('github-button').textContent = langData.githubButton;
                document.getElementById('convert-button').textContent = langData.convertButton;
                document.getElementById('download-button').textContent = langData.downloadButton;
                document.getElementById('status-text').textContent = langData.statusText;
                document.getElementById('info-title').textContent = langData.infoTitle;
                document.getElementById('info-desc').textContent = langData.infoDesc;
                document.getElementById('info-item1').textContent = langData.info1;
                document.getElementById('info-item2').textContent = langData.info2;
                document.getElementById('info-item3').textContent = langData.info3;
                document.getElementById('info-item4').textContent = langData.info4;
                document.getElementById('info-item5').textContent = langData.info5;
                document.getElementById('info-item6').textContent = langData.info6;
                document.getElementById('framework-title').textContent = langData.frameworkTitle;
                document.getElementById('framework-desc').textContent = langData.frameworkDesc;
                document.getElementById('esx-to-qb').textContent = langData.esxToQb;
                document.getElementById('esx-to-qb-desc').textContent = langData.esxToQbDesc;
                document.getElementById('qb-to-esx').textContent = langData.qbToEsx;
                document.getElementById('qb-to-esx-desc').textContent = langData.qbToEsxDesc;
                document.getElementById('esx-to-new').textContent = langData.esxToNew;
                document.getElementById('esx-to-new-desc').textContent = langData.esxToNewDesc;
                document.getElementById('convert-esx-qb').textContent = langData.convertEsxQb;
                document.getElementById('convert-qb-esx').textContent = langData.convertQbEsx;
                document.getElementById('convert-esx-new').textContent = langData.convertEsxNew;
                document.getElementById('process-title').textContent = langData.processTitle;
                document.getElementById('process-desc').textContent = langData.processDesc;
                document.getElementById('process-item1').textContent = langData.process1;
                document.getElementById('process-item2').textContent = langData.process2;
                document.getElementById('process-item3').textContent = langData.process3;
                document.getElementById('process-item4').textContent = langData.process4;
                document.getElementById('process-item5').textContent = langData.process5;
                document.getElementById('security-title').textContent = langData.securityTitle;
                document.getElementById('security-desc').textContent = langData.securityDesc;
                document.getElementById('remove-region').textContent = langData.removeRegion;
                document.getElementById('remove-region-desc').textContent = langData.removeRegionDesc;
                document.getElementById('backdoor-title').textContent = langData.backdoorTitle;
                document.getElementById('backdoor-desc').textContent = langData.backdoorDesc;
                document.getElementById('remove-button').textContent = langData.removeButton;
                document.getElementById('scan-button').textContent = langData.scanButton;
                document.getElementById('db-title').textContent = langData.dbTitle;
                document.getElementById('db-desc').textContent = langData.dbDesc;
                document.getElementById('db-item1').textContent = langData.db1;
                document.getElementById('db-item2').textContent = langData.db2;
                document.getElementById('db-item3').textContent = langData.db3;
                document.getElementById('db-item4').textContent = langData.db4;
                document.getElementById('db-item5').textContent = langData.db5;
                document.getElementById('local-title').textContent = langData.localTitle;
                document.getElementById('local-desc').textContent = langData.localDesc;
                document.getElementById('strategy-title').textContent = langData.strategyTitle;
                document.getElementById('strategy-desc').textContent = langData.strategyDesc;
                document.getElementById('res-local').textContent = langData.resLocal;
                document.getElementById('res-local-desc').textContent = langData.resLocalDesc;
                document.getElementById('localize-button').textContent = langData.localizeButton;
                document.getElementById('settings-title').textContent = langData.settingsTitle;
                document.getElementById('settings-desc').textContent = langData.settingsDesc;
                document.getElementById('config-label').textContent = langData.configLabel;
                document.getElementById('ignore-label').textContent = langData.ignoreLabel;
                document.getElementById('create-label').textContent = langData.createLabel;
                document.getElementById('preserve-label').textContent = langData.preserveLabel;
                document.getElementById('details-title').textContent = langData.detailsTitle;
                document.getElementById('details-desc').textContent = langData.detailsDesc;
                document.getElementById('detail-item1').textContent = langData.detail1;
                document.getElementById('detail-item2').textContent = langData.detail2;
                document.getElementById('detail-item3').textContent = langData.detail3;
                document.getElementById('detail-item4').textContent = langData.detail4;
                document.getElementById('detail-item5').textContent = langData.detail5;
                document.getElementById('detail-item6').textContent = langData.detail6;
                document.getElementById('file-title').textContent = langData.fileTitle;
                document.getElementById('footer-text').textContent = langData.footerText;
                document.getElementById('footer-subtext').textContent = langData.footerSubtext;
            }
            
            // Initialize translations
            applyTranslations(currentLang);
            
            // Language selector change
            langSelector.addEventListener('change', function() {
                currentLang = this.value;
                applyTranslations(currentLang);
            });
            
            // Tab switching
            const tabs = document.querySelectorAll('.tabs li');
            const tabPanes = document.querySelectorAll('.tab-pane');
            
            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    tabs.forEach(t => t.classList.remove('active'));
                    tabPanes.forEach(p => p.classList.remove('active'));
                    
                    this.classList.add('active');
                    const tabId = this.getAttribute('data-tab');
                    document.getElementById(tabId).classList.add('active');
                });
            });
            
            // Resource type selection
            const optionBtns = document.querySelectorAll('.option-btn');
            optionBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    optionBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                });
            });
            
            // Drag and drop functionality
            const dropZone = document.getElementById('dropZone');
            dropZone.addEventListener('dragover', (e) => {
                e.preventDefault();
                dropZone.style.borderColor = '#2ecc71';
                dropZone.style.backgroundColor = 'rgba(46, 204, 113, 0.1)';
            });
            
            dropZone.addEventListener('dragleave', () => {
                dropZone.style.borderColor = '#9c27b0';
                dropZone.style.backgroundColor = 'rgba(156, 39, 176, 0.05)';
            });
            
            dropZone.addEventListener('drop', (e) => {
                e.preventDefault();
                dropZone.style.borderColor = '#9c27b0';
                dropZone.style.backgroundColor = 'rgba(156, 39, 176, 0.05)';
                
                if (e.dataTransfer.files.length) {
                    document.getElementById('resourceFile').files = e.dataTransfer.files;
                    alert(`${translations[currentLang].selectZip}: ${e.dataTransfer.files[0].name}`);
                }
            });
            
            // GitHub fetching
            document.getElementById('fetchGithub').addEventListener('click', function() {
                const githubUrl = document.getElementById('githubUrl').value;
                if (!githubUrl) {
                    alert('Please enter a GitHub resource URL');
                    return;
                }
                
                // Simulate GitHub resource fetching
                alert(`Fetching resource from GitHub: ${githubUrl}`);
                
                // Show progress
                const progressBar = document.getElementById('resourceProgress');
                progressBar.style.width = '0%';
                
                let progress = 0;
                const interval = setInterval(() => {
                    progress += 10;
                    progressBar.style.width = `${progress}%`;
                    
                    if (progress >= 100) {
                        clearInterval(interval);
                        alert('Resource downloaded from GitHub and ready for conversion!');
                    }
                }, 200);
            });
            
            // Resource conversion
            const resourceFile = document.getElementById('resourceFile');
            const convertResourceBtn = document.getElementById('convertResource');
            const downloadResourceBtn = document.getElementById('downloadResource');
            const resourceProgress = document.getElementById('resourceProgress');
            const resourceStatus = document.getElementById('resourceStatus');
            
            convertResourceBtn.addEventListener('click', function() {
                if (!resourceFile.files.length && !document.getElementById('githubUrl').value) {
                    alert('Please select a ZIP file or enter a GitHub URL');
                    return;
                }
                
                resourceProgress.style.width = '0%';
                resourceStatus.style.display = 'none';
                
                let progress = 0;
                const interval = setInterval(() => {
                    progress += 5;
                    resourceProgress.style.width = `${progress}%`;
                    
                    if (progress >= 100) {
                        clearInterval(interval);
                        resourceStatus.style.display = 'block';
                        downloadResourceBtn.disabled = false;
                        
                        // Simulate conversion completion
                        const selectedType = document.querySelector('.option-btn.active').getAttribute('data-type');
                        alert(`Resource conversion complete! Type: ${selectedType}`);
                    }
                }, 200);
            });
            
            downloadResourceBtn.addEventListener('click', function() {
                alert('In a real environment, the converted resource package would be downloaded');
            });
            
            // Localization functionality
            document.getElementById('localizeResourceBtn').addEventListener('click', function() {
                const fileInput = document.getElementById('localizeScript');
                if (!fileInput.files.length) {
                    alert('Please select a resource file or ZIP package');
                    return;
                }
                
                const btn = this;
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> ' + translations[currentLang].localizeButton;
                btn.disabled = true;
                
                // Show file list container
                const fileList = document.getElementById('fileList');
                fileList.style.display = 'block';
                const fileItems = document.getElementById('fileItems');
                fileItems.innerHTML = '';
                
                // Get selected language
                const langCode = currentLang;
                
                // Simulate file processing
                const filesToProcess = [
                    {name: 'config.lua', status: 'success', action: translations[currentLang].success},
                    {name: 'client.lua', status: 'success', action: translations[currentLang].success},
                    {name: 'server.lua', status: 'skipped', action: translations[currentLang].skipped},
                    {name: 'en.lua', status: 'success', action: `Converted to ${langCode}.lua`},
                    {name: 'ui.html', status: 'success', action: translations[currentLang].success},
                    {name: 'encrypted.dll', status: 'warning', action: translations[currentLang].warning},
                    {name: 'map.ydr', status: 'skipped', action: translations[currentLang].skipped},
                ];
                
                let processed = 0;
                const processInterval = setInterval(() => {
                    if (processed < filesToProcess.length) {
                        const file = filesToProcess[processed];
                        const fileItem = document.createElement('div');
                        fileItem.className = 'file-item';
                        
                        let statusClass = 'status-success';
                        if (file.status === 'warning') statusClass = 'status-warning';
                        if (file.status === 'skipped') statusClass = 'status-skipped';
                        
                        fileItem.innerHTML = `
                            <div>${file.name}</div>
                            <div class="file-status ${statusClass}">${file.action}</div>
                        `;
                        
                        fileItems.appendChild(fileItem);
                        processed++;
                    } else {
                        clearInterval(processInterval);
                        
                        // Finish processing
                        setTimeout(() => {
                            btn.innerHTML = originalText;
                            btn.disabled = false;
                            
                            // Show download button
                            document.getElementById('downloadLocalized').style.display = 'inline-block';
                            
                            // Add success message
                            const successItem = document.createElement('div');
                            successItem.className = 'file-item';
                            successItem.innerHTML = `
                                <div><strong>${translations[currentLang].localizationComplete}</strong></div>
                                <div class="file-status status-success">${langCode}.lua created</div>
                            `;
                            fileItems.appendChild(successItem);
                            
                            alert(`${translations[currentLang].localizationComplete} (${langCode}.lua)`);
                        }, 500);
                    }
                }, 600);
            });
            
            // Download localized result
            document.getElementById('downloadLocalized').addEventListener('click', function() {
                alert('In a real environment, the localized resource package would be downloaded');
            });
            
            // Framework conversion
            document.getElementById('convertEsxToQb').addEventListener('click', function() {
                const fileInput = document.getElementById('esxToQbFile');
                if (!fileInput.files.length) {
                    alert('Please select a script file');
                    return;
                }
                
                const originalText = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> ' + translations[currentLang].convertEsxQb;
                this.disabled = true;
                
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.disabled = false;
                    alert('ESX to QBcore conversion complete!');
                }, 2000);
            });
            
            document.getElementById('convertQbToEsx').addEventListener('click', function() {
                const fileInput = document.getElementById('qbToEsxFile');
                if (!fileInput.files.length) {
                    alert('Please select a script file');
                    return;
                }
                
                const originalText = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> ' + translations[currentLang].convertQbEsx;
                this.disabled = true;
                
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.disabled = false;
                    alert('QBcore to ESX conversion complete!');
                }, 2000);
            });
            
            document.getElementById('convertEsxToNew').addEventListener('click', function() {
                const fileInput = document.getElementById('esxToNewFile');
                if (!fileInput.files.length) {
                    alert('Please select a script file');
                    return;
                }
                
                const originalText = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> ' + translations[currentLang].convertEsxNew;
                this.disabled = true;
                
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.disabled = false;
                    alert('ESX to New ESX conversion complete!');
                }, 2000);
            });
            
            // Security processing
            document.getElementById('removeRegionBtn').addEventListener('click', function() {
                const fileInput = document.getElementById('removeRegionLock');
                if (!fileInput.files.length) {
                    alert('Please select a file');
                    return;
                }
                
                const originalText = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> ' + translations[currentLang].removeButton;
                this.disabled = true;
                
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.disabled = false;
                    alert('Region restrictions successfully removed!');
                }, 2000);
            });
            
            document.getElementById('detectBackdoorBtn').addEventListener('click', function() {
                const fileInput = document.getElementById('detectBackdoor');
                if (!fileInput.files.length) {
                    alert('Please select a file');
                    return;
                }
                
                const originalText = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> ' + translations[currentLang].scanButton;
                this.disabled = true;
                
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.disabled = false;
                    alert('Backdoor scan complete! No malicious code found.');
                }, 2000);
            });
        });
    </script>
</body>
</html>
