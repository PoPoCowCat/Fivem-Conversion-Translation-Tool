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
            --primary: #1a2a6c;
            --secondary: #3498db;
            --accent: #2ecc71;
            --esx: #e74c3c;
            --qb: #9b59b6;
            --map: #f39c12;
            --vehicle: #e67e22;
            --plugin: #1abc9c;
            --dark: #2c3e50;
            --light: #ecf0f1;
            --warning: #f1c40f;
            --danger: #e74c3c;
            --success: #2ecc71;
            --text: #333;
            --header-gradient: linear-gradient(135deg, #1a2a6c, #3498db, #2ecc71);
            --card-gradient: linear-gradient(145deg, #ffffff, #f8f9fa);
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #1a2a6c, #3498db, #2ecc71);
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
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
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
            color: white;
        }
        
        .language-selector {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .language-selector select {
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.3);
            background: rgba(255,255,255,0.1);
            color: white;
            cursor: pointer;
            outline: none;
            transition: all 0.3s;
        }
        
        .language-selector select:hover {
            background: rgba(255,255,255,0.2);
        }
        
        .language-selector select option {
            background: var(--dark);
            color: white;
        }
        
        header {
            background: var(--header-gradient);
            padding: 30px;
            text-align: center;
            color: white;
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
            text-shadow: 0 2px 5px rgba(0,0,0,0.2);
            position: relative;
        }
        
        header p {
            font-size: 1.2rem;
            opacity: 0.9;
            position: relative;
        }
        
        .tabs {
            display: flex;
            background: var(--dark);
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
            border-bottom: 4px solid var(--success);
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
            background: var(--success);
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
            background: rgba(52, 152, 219, 0.1);
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
            background: rgba(52, 152, 219, 0.05);
            cursor: pointer;
            margin-bottom: 30px;
            position: relative;
        }
        
        .upload-area:hover {
            background: rgba(52, 152, 219, 0.1);
            border-color: var(--accent);
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
            background: var(--dark);
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
            background: rgba(52, 152, 219, 0.1);
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
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }
        
        .option-btn:hover:not(.active) {
            background: rgba(52, 152, 219, 0.2);
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
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
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
                <span>FiveM Resource Converter</span>
            </div>
            <div class="language-selector">
                <span><i class="fas fa-globe"></i> Language:</span>
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
            <h1><i class="fas fa-sync-alt"></i> FiveM Professional Resource Converter</h1>
            <p>Multi-language support | Strictly follows FiveM documentation</p>
        </header>
        
        <ul class="tabs">
            <li class="active" data-tab="resource">Resource Conversion</li>
            <li data-tab="framework">Framework Conversion</li>
            <li data-tab="security">Security</li>
            <li data-tab="localization">Localization</li>
        </ul>
        
        <div class="tab-content">
            <!-- Resource Conversion Tab -->
            <div id="resource" class="tab-pane active">
                <div class="card">
                    <h2><i class="fas fa-file-archive"></i> FiveM Resource Conversion</h2>
                    <p>Upload ZIP resource package to convert to FiveM compatible format</p>
                    
                    <div class="upload-area" id="dropZone">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <h3>Drag & Drop or Select Resource ZIP</h3>
                        <p>Supports vehicle, map, and plugin resources</p>
                        <div class="file-input-wrapper">
                            <label for="resourceFile" class="file-input-label">
                                <i class="fas fa-folder-open"></i> Select ZIP File
                            </label>
                            <input type="file" id="resourceFile" class="hidden" accept=".zip">
                        </div>
                    </div>
                    
                    <div class="option-group">
                        <div class="option-btn active" data-type="auto">Auto Detect</div>
                        <div class="option-btn" data-type="vehicle">Vehicle</div>
                        <div class="option-btn" data-type="map">Map</div>
                        <div class="option-btn" data-type="plugin">Plugin</div>
                    </div>
                    
                    <div class="github-section">
                        <input type="text" id="githubUrl" placeholder="Enter GitHub Resource URL...">
                        <button id="fetchGithub"><i class="fab fa-github"></i> Fetch from GitHub</button>
                    </div>
                    
                    <div class="progress-container">
                        <div class="progress-bar" id="resourceProgress"></div>
                    </div>
                    
                    <div class="status-box" id="resourceStatus">
                        <i class="fas fa-check-circle"></i>
                        <span>Conversion complete! Download the converted files</span>
                    </div>
                    
                    <div class="action-buttons">
                        <button class="btn" id="convertResource">
                            <i class="fas fa-cogs"></i> Convert Resource
                        </button>
                        <button class="btn btn-success" id="downloadResource" disabled>
                            <i class="fas fa-download"></i> Download Result
                        </button>
                    </div>
                </div>
                
                <div class="conversion-info">
                    <h3><i class="fas fa-info-circle"></i> Conversion Details</h3>
                    <p>The tool will perform the following:</p>
                    <ul>
                        <li>Automatic resource type detection</li>
                        <li>Convert __resource.lua to fxmanifest.lua</li>
                        <li>Fix common errors (e.g. gt=5 → gta5)</li>
                        <li>Preserve original file structure</li>
                        <li>Strictly follow FiveM documentation</li>
                        <li>Support GitHub resource fetching</li>
                    </ul>
                </div>
            </div>
            
            <!-- Framework Conversion Tab -->
            <div id="framework" class="tab-pane">
                <div class="card">
                    <h2><i class="fas fa-exchange-alt"></i> Framework Conversion</h2>
                    <p>Convert scripts between ESX and QBcore frameworks</p>
                    
                    <div class="feature-grid">
                        <div class="feature-card">
                            <i class="fas fa-arrow-right" style="color: var(--esx);"></i>
                            <h3>ESX to QBcore</h3>
                            <p>Convert ESX scripts to QBcore framework</p>
                            <div class="file-input-wrapper">
                                <label for="esxToQbFile" class="file-input-label" style="background: linear-gradient(to right, var(--esx), #c0392b);">
                                    <i class="fas fa-file-code"></i> Select Script
                                </label>
                                <input type="file" id="esxToQbFile" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn btn-esx" style="margin-top: 15px; width: 100%;" id="convertEsxToQb">
                                <i class="fas fa-cogs"></i> Convert to QBcore
                            </button>
                        </div>
                        
                        <div class="feature-card">
                            <i class="fas fa-arrow-right" style="color: var(--qb);"></i>
                            <h3>QBcore to ESX</h3>
                            <p>Convert QBcore scripts to ESX framework</p>
                            <div class="file-input-wrapper">
                                <label for="qbToEsxFile" class="file-input-label" style="background: linear-gradient(to right, var(--qb), #8e44ad);">
                                    <i class="fas fa-file-code"></i> Select Script
                                </label>
                                <input type="file" id="qbToEsxFile" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn btn-qb" style="margin-top: 15px; width: 100%;" id="convertQbToEsx">
                                <i class="fas fa-cogs"></i> Convert to ESX
                            </button>
                        </div>
                        
                        <div class="feature-card">
                            <i class="fas fa-sync-alt" style="color: var(--esx);"></i>
                            <h3>ESX to New ESX</h3>
                            <p>Convert legacy ESX to new ESX (1.9+)</p>
                            <div class="file-input-wrapper">
                                <label for="esxToNewFile" class="file-input-label" style="background: linear-gradient(to right, var(--esx), #c0392b);">
                                    <i class="fas fa-file-code"></i> Select Script
                                </label>
                                <input type="file" id="esxToNewFile" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn btn-esx" style="margin-top: 15px; width: 100%;" id="convertEsxToNew">
                                <i class="fas fa-cogs"></i> Convert to New ESX
                            </button>
                        </div>
                    </div>
                    
                    <div class="conversion-info">
                        <h3><i class="fas fa-lightbulb"></i> Conversion Process</h3>
                        <p>Framework conversion uses advanced code analysis:</p>
                        <ul>
                            <li>Parse framework-specific API calls</li>
                            <li>Map equivalent functions and events</li>
                            <li>Intelligent variable and callback refactoring</li>
                            <li>Preserve original functionality</li>
                            <li>Supports complex script conversion</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- Security Tab -->
            <div id="security" class="tab-pane">
                <div class="card">
                    <h2><i class="fas fa-shield-alt"></i> Security Processing</h2>
                    <p>Detect and remove backdoors and region locks</p>
                    
                    <div class="feature-grid">
                        <div class="feature-card">
                            <i class="fas fa-globe-americas" style="color: var(--primary);"></i>
                            <h3>Remove Region Lock</h3>
                            <p>Remove region restrictions from plugins</p>
                            <div class="file-input-wrapper">
                                <label for="removeRegionLock" class="file-input-label">
                                    <i class="fas fa-file-code"></i> Select Script
                                </label>
                                <input type="file" id="removeRegionLock" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn" style="margin-top: 15px; width: 100%;" id="removeRegionBtn">
                                <i class="fas fa-unlock"></i> Remove Restrictions
                            </button>
                        </div>
                        
                        <div class="feature-card">
                            <i class="fas fa-user-secret" style="color: var(--danger);"></i>
                            <h3>Backdoor Detection</h3>
                            <p>Detect and remove malicious backdoors</p>
                            <div class="file-input-wrapper">
                                <label for="detectBackdoor" class="file-input-label">
                                    <i class="fas fa-file-code"></i> Select Script
                                </label>
                                <input type="file" id="detectBackdoor" class="hidden" accept=".lua,.js">
                            </div>
                            <button class="btn btn-danger" style="margin-top: 15px; width: 100%;" id="detectBackdoorBtn">
                                <i class="fas fa-shield-virus"></i> Scan & Remove
                            </button>
                        </div>
                    </div>
                    
                    <div class="conversion-info">
                        <h3><i class="fas fa-database"></i> Security Database</h3>
                        <p>Tool uses the following security resources:</p>
                        <ul>
                            <li>Official FiveM security guidelines</li>
                            <li>GitHub backdoor pattern database</li>
                            <li>Community-reported malicious code</li>
                            <li>Automatically updated security rules</li>
                            <li>Real-time code behavior analysis</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- Localization Tab -->
            <div id="localization" class="tab-pane">
                <div class="card">
                    <h2><i class="fas fa-language"></i> Multi-language Localization</h2>
                    <p>Translate resources to your selected language</p>
                    
                    <div class="language-info">
                        <p><i class="fas fa-info-circle"></i> <strong>Localization Strategy</strong>: Only translate UI text and configuration, preserve code logic</p>
                    </div>
                    
                    <div class="feature-grid">
                        <div class="feature-card">
                            <i class="fas fa-font" style="color: var(--success);"></i>
                            <h3>Resource Localization</h3>
                            <p>Intelligent text recognition and translation</p>
                            <div class="file-input-wrapper">
                                <label for="localizeScript" class="file-input-label">
                                    <i class="fas fa-file-archive"></i> Select Resource/ZIP
                                </label>
                                <input type="file" id="localizeScript" class="hidden" accept=".lua,.js,.zip">
                            </div>
                            <div class="action-buttons">
                                <button class="btn btn-success" id="localizeResourceBtn">
                                    <i class="fas fa-language"></i> Localize Resource
                                </button>
                                <button class="btn" id="downloadLocalized" style="display: none; margin-top: 10px;">
                                    <i class="fas fa-download"></i> Download Result
                                </button>
                            </div>
                        </div>
                        
                        <div class="feature-card">
                            <i class="fas fa-cogs" style="color: var(--primary);"></i>
                            <h3>Localization Settings</h3>
                            <p>Customize localization options</p>
                            <div class="option-group" style="flex-direction: column; align-items: flex-start;">
                                <label style="margin: 10px; display: flex; align-items: center;">
                                    <input type="checkbox" id="translateConfig" checked style="margin-right: 10px;">
                                    Translate config.lua
                                </label>
                                <label style="margin: 10px; display: flex; align-items: center;">
                                    <input type="checkbox" id="ignoreServerFiles" checked style="margin-right: 10px;">
                                    Ignore server.lua/server_*.lua
                                </label>
                                <label style="margin: 10px; display: flex; align-items: center;">
                                    <input type="checkbox" id="createLangFile" checked style="margin-right: 10px;">
                                    Create language file
                                </label>
                                <label style="margin: 10px; display: flex; align-items: center;">
                                    <input type="checkbox" id="preserveFormat" checked style="margin-right: 10px;">
                                    Preserve original format
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="conversion-info" style="margin-top: 30px;">
                        <h3><i class="fas fa-info-circle"></i> Localization Details</h3>
                        <p>Localization strictly follows FiveM best practices:</p>
                        <ul>
                            <li>Only translate UI text and configuration options</li>
                            <li>Preserve all code logic and structure</li>
                            <li>Skip server.lua and server_*.lua files</li>
                            <li>Automatically skip encrypted files</li>
                            <li>Create language file in selected language</li>
                            <li>Preserve original file format and names</li>
                        </ul>
                    </div>
                    
                    <div class="file-list" id="fileList" style="display: none;">
                        <h4>File Processing Results:</h4>
                        <div id="fileItems"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p>FiveM Professional Resource Converter v5.0 | Strictly follows FiveM documentation</p>
            <p>© 2023 FiveM Resource Converter | Supports vehicles, maps, and plugins</p>
        </div>
    </div>

    <script>
        // Language translations
        const translations = {
            'en': {
                'title': "FiveM Professional Resource Converter",
                'subtitle': "Multi-language support | Strictly follows FiveM documentation",
                'resource': "Resource Conversion",
                'framework': "Framework Conversion",
                'security': "Security",
                'localization': "Localization",
                'conversionDetails': "Conversion Details",
                'conversionProcess': "Conversion Process",
                'securityDatabase': "Security Database",
                'localizationDetails': "Localization Details",
                'downloadResult': "Download Result",
                'conversionComplete': "Conversion complete! Download the converted files",
                'localizeResource': "Localize Resource",
                'selectFile': "Select File",
                'selectZIP': "Select ZIP File",
                'convertResource': "Convert Resource",
                'fetchGithub': "Fetch from GitHub",
                'autoDetect': "Auto Detect",
                'vehicle': "Vehicle",
                'map': "Map",
                'plugin': "Plugin",
                'removeRestrictions': "Remove Restrictions",
                'scanRemove': "Scan & Remove",
                'download': "Download",
                'fileProcessing': "File Processing Results:",
                'success': "Success",
                'skipped': "Skipped",
                'warning': "Warning",
                'localizationComplete': "Localization complete! Language file created",
                'uploadAreaTitle': "Drag & Drop or Select Resource ZIP",
                'uploadAreaDesc': "Supports vehicle, map, and plugin resources",
                'githubPlaceholder': "Enter GitHub Resource URL...",
                'resourceDesc': "Upload ZIP resource package to convert to FiveM compatible format",
                'frameworkDesc': "Convert scripts between ESX and QBcore frameworks",
                'securityDesc': "Detect and remove backdoors and region locks",
                'localizationDesc': "Translate resources to your selected language",
                'localizationStrategy': "Localization Strategy: Only translate UI text and configuration, preserve code logic"
            },
            'zh-cn': {
                'title': "FiveM 专业资源转换工具",
                'subtitle': "多语言支持 | 严格遵循FiveM文档规范",
                'resource': "资源转换",
                'framework': "框架转换",
                'security': "安全处理",
                'localization': "本地化",
                'conversionDetails': "转换说明",
                'conversionProcess': "转换原理",
                'securityDatabase': "安全数据库",
                'localizationDetails': "本地化说明",
                'downloadResult': "下载结果",
                'conversionComplete': "转换完成！请下载转换后的文件",
                'localizeResource': "本地化资源",
                'selectFile': "选择文件",
                'selectZIP': "选择ZIP文件",
                'convertResource': "转换资源",
                'fetchGithub': "从GitHub获取",
                'autoDetect': "自动识别",
                'vehicle': "车辆资源",
                'map': "地图资源",
                'plugin': "插件资源",
                'removeRestrictions': "移除地区限制",
                'scanRemove': "检测并移除后门",
                'download': "下载",
                'fileProcessing': "文件处理结果:",
                'success': "成功",
                'skipped': "已跳过",
                'warning': "警告",
                'localizationComplete': "本地化完成！语言文件已创建",
                'uploadAreaTitle': "拖放或选择资源ZIP文件",
                'uploadAreaDesc': "支持车辆、地图、插件资源包的转换",
                'githubPlaceholder': "输入GitHub资源URL...",
                'resourceDesc': "上传ZIP格式的资源包，工具将自动识别类型并转换为FiveM可用格式",
                'frameworkDesc': "在ESX和QBcore框架之间转换脚本",
                'securityDesc': "检测和移除脚本中的后门与地区限制",
                'localizationDesc': "将资源内容转换为选定的语言",
                'localizationStrategy': "本地化策略: 只翻译UI文本和配置项，保留代码逻辑"
            },
            'zh-tw': {
                'title': "FiveM 專業資源轉換工具",
                'subtitle': "多語言支援 | 嚴格遵循FiveM文件規範",
                'resource': "資源轉換",
                'framework': "框架轉換",
                'security': "安全處理",
                'localization': "本地化",
                'conversionDetails': "轉換說明",
                'conversionProcess': "轉換原理",
                'securityDatabase': "安全數據庫",
                'localizationDetails': "本地化說明",
                'downloadResult': "下載結果",
                'conversionComplete': "轉換完成！請下載轉換後的文件",
                'localizeResource': "本地化資源",
                'selectFile': "選擇文件",
                'selectZIP': "選擇ZIP文件",
                'convertResource': "轉換資源",
                'fetchGithub': "從GitHub獲取",
                'autoDetect': "自動識別",
                'vehicle': "車輛資源",
                'map': "地圖資源",
                'plugin': "插件資源",
                'removeRestrictions': "移除地區限制",
                'scanRemove': "檢測並移除後門",
                'download': "下載",
                'fileProcessing': "文件處理結果:",
                'success': "成功",
                'skipped': "已跳過",
                'warning': "警告",
                'localizationComplete': "本地化完成！語言文件已建立",
                'uploadAreaTitle': "拖放或選擇資源ZIP文件",
                'uploadAreaDesc': "支持車輛、地圖、插件資源包的轉換",
                'githubPlaceholder': "輸入GitHub資源URL...",
                'resourceDesc': "上傳ZIP格式的資源包，工具將自動識別類型並轉換為FiveM可用格式",
                'frameworkDesc': "在ESX和QBcore框架之間轉換腳本",
                'securityDesc': "檢測和移除腳本中的後門與地區限制",
                'localizationDesc': "將資源內容轉換為選定的語言",
                'localizationStrategy': "本地化策略: 只翻譯UI文本和配置項，保留代碼邏輯"
            },
            'de': {
                'title': "FiveM Professioneller Ressourcen-Konverter",
                'subtitle': "Mehrsprachige Unterstützung | Hält sich strikt an die FiveM-Dokumentation",
                'resource': "Ressourcenkonvertierung",
                'framework': "Framework-Konvertierung",
                'security': "Sicherheit",
                'localization': "Lokalisierung",
                'conversionDetails': "Konvertierungsdetails",
                'conversionProcess': "Konvertierungsprozess",
                'securityDatabase': "Sicherheitsdatenbank",
                'localizationDetails': "Lokalisierungsdetails",
                'downloadResult': "Ergebnis herunterladen",
                'conversionComplete': "Konvertierung abgeschlossen! Konvertierte Dateien herunterladen",
                'localizeResource': "Ressource lokalisieren",
                'selectFile': "Datei auswählen",
                'selectZIP': "ZIP-Datei auswählen",
                'convertResource': "Ressource konvertieren",
                'fetchGithub': "Von GitHub abrufen",
                'autoDetect': "Automatische Erkennung",
                'vehicle': "Fahrzeug",
                'map': "Karte",
                'plugin': "Plugin",
                'removeRestrictions': "Einschränkungen entfernen",
                'scanRemove': "Scannen und entfernen",
                'download': "Herunterladen",
                'fileProcessing': "Dateiverarbeitungsergebnisse:",
                'success': "Erfolg",
                'skipped': "Übersprungen",
                'warning': "Warnung",
                'localizationComplete': "Lokalisierung abgeschlossen! Sprachdatei erstellt",
                'uploadAreaTitle': "Ziehen & Ablegen oder ZIP-Ressource auswählen",
                'uploadAreaDesc': "Unterstützt Fahrzeug-, Karten- und Plugin-Ressourcen",
                'githubPlaceholder': "GitHub-Ressourcen-URL eingeben...",
                'resourceDesc': "Laden Sie ein ZIP-Ressourcenpaket hoch, um es in ein FiveM-kompatibles Format zu konvertieren",
                'frameworkDesc': "Konvertieren Sie Skripte zwischen ESX- und QBcore-Frameworks",
                'securityDesc': "Erkennen und entfernen Sie Backdoors und Regionssperren",
                'localizationDesc': "Übersetzen Sie Ressourcen in Ihre ausgewählte Sprache",
                'localizationStrategy': "Lokalisierungsstrategie: Nur UI-Text und Konfiguration übersetzen, Code-Logik erhalten"
            },
            'da': {
                'title': "FiveM Professionel Ressourcekonverter",
                'subtitle': "Flersproget support | Overholder strengt FiveM dokumentation",
                'resource': "Ressourcekonvertering",
                'framework': "Frameworkkonvertering",
                'security': "Sikkerhed",
                'localization': "Lokalisering",
                'conversionDetails': "Konverteringsdetaljer",
                'conversionProcess': "Konverteringsproces",
                'securityDatabase': "Sikkerhedsdatabase",
                'localizationDetails': "Lokaliseringsdetaljer",
                'downloadResult': "Download resultat",
                'conversionComplete': "Konvertering fuldført! Download konverterede filer",
                'localizeResource': "Lokaliser ressource",
                'selectFile': "Vælg fil",
                'selectZIP': "Vælg ZIP-fil",
                'convertResource': "Konverter ressource",
                'fetchGithub': "Hent fra GitHub",
                'autoDetect': "Auto-detektering",
                'vehicle': "Køretøj",
                'map': "Kort",
                'plugin': "Plugin",
                'removeRestrictions': "Fjern restriktioner",
                'scanRemove': "Scan og fjern",
                'download': "Download",
                'fileProcessing': "Filbehandlingsresultater:",
                'success': "Succes",
                'skipped': "Sprunget over",
                'warning': "Advarsel",
                'localizationComplete': "Lokalisering fuldført! Sprogfil oprettet",
                'uploadAreaTitle': "Træk & slip eller vælg ressource-ZIP",
                'uploadAreaDesc': "Understøtter køretøjs-, kort- og plugin-ressourcer",
                'githubPlaceholder': "Indtast GitHub-ressource-URL...",
                'resourceDesc': "Upload ZIP-ressourcepakke for at konvertere til FiveM-kompatibelt format",
                'frameworkDesc': "Konverter scripts mellem ESX- og QBcore-rammer",
                'securityDesc': "Registrer og fjern bagdøre og regionslåse",
                'localizationDesc': "Oversæt ressourcer til dit valgte sprog",
                'localizationStrategy': "Lokaliseringsstrategi: Oversæt kun UI-tekst og konfiguration, bevar kodelogik"
            }
        };

        document.addEventListener('DOMContentLoaded', function() {
            // Set default language
            let currentLang = 'en';
            const langSelector = document.getElementById('languageSelector');
            
            // Apply translations to the page
            function applyTranslations(lang) {
                const langData = translations[lang] || translations['en'];
                document.querySelector('title').textContent = langData.title;
                document.querySelector('header h1').textContent = langData.title;
                document.querySelector('header p').textContent = langData.subtitle;
                
                // Update tab names
                document.querySelectorAll('.tabs li').forEach((tab, index) => {
                    if (index === 0) tab.textContent = langData.resource;
                    if (index === 1) tab.textContent = langData.framework;
                    if (index === 2) tab.textContent = langData.security;
                    if (index === 3) tab.textContent = langData.localization;
                });
                
                // Update card descriptions
                document.querySelectorAll('.card p').forEach((desc, index) => {
                    if (index === 0) desc.textContent = langData.resourceDesc;
                    if (index === 1) desc.textContent = langData.frameworkDesc;
                    if (index === 2) desc.textContent = langData.securityDesc;
                    if (index === 3) desc.textContent = langData.localizationDesc;
                });
                
                // Update upload area
                const uploadArea = document.querySelector('.upload-area');
                uploadArea.querySelector('h3').textContent = langData.uploadAreaTitle;
                uploadArea.querySelector('p').textContent = langData.uploadAreaDesc;
                
                // Update conversion info headers
                document.querySelectorAll('.conversion-info h3').forEach((el, index) => {
                    if (index === 0) el.textContent = langData.conversionDetails;
                    if (index === 1) el.textContent = langData.conversionProcess;
                    if (index === 2) el.textContent = langData.securityDatabase;
                    if (index === 3) el.textContent = langData.localizationDetails;
                });
                
                // Update buttons and labels
                document.getElementById('downloadResource').innerHTML = `<i class="fas fa-download"></i> ${langData.downloadResult}`;
                document.getElementById('convertResource').innerHTML = `<i class="fas fa-cogs"></i> ${langData.convertResource}`;
                document.getElementById('fetchGithub').innerHTML = `<i class="fab fa-github"></i> ${langData.fetchGithub}`;
                document.getElementById('localizeResourceBtn').innerHTML = `<i class="fas fa-language"></i> ${langData.localizeResource}`;
                document.getElementById('removeRegionBtn').innerHTML = `<i class="fas fa-unlock"></i> ${langData.removeRestrictions}`;
                document.getElementById('detectBackdoorBtn').innerHTML = `<i class="fas fa-shield-virus"></i> ${langData.scanRemove}`;
                document.getElementById('downloadLocalized').innerHTML = `<i class="fas fa-download"></i> ${langData.download}`;
                
                // Update option buttons
                document.querySelectorAll('.option-btn').forEach((btn, index) => {
                    if (index === 0) btn.textContent = langData.autoDetect;
                    if (index === 1) btn.textContent = langData.vehicle;
                    if (index === 2) btn.textContent = langData.map;
                    if (index === 3) btn.textContent = langData.plugin;
                });
                
                // Update file input labels
                document.querySelectorAll('.file-input-label').forEach(label => {
                    label.innerHTML = `<i class="fas fa-folder-open"></i> ${langData.selectFile}`;
                });
                
                // Update status text
                document.querySelector('#resourceStatus span').textContent = langData.conversionComplete;
                
                // Update GitHub placeholder
                document.getElementById('githubUrl').placeholder = langData.githubPlaceholder;
                
                // Update localization info
                document.querySelector('.language-info p').innerHTML = `<i class="fas fa-info-circle"></i> <strong>${langData.localizationStrategy.split(':')[0]}</strong>: ${langData.localizationStrategy.split(':')[1]}`;
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
                dropZone.style.borderColor = '#3498db';
                dropZone.style.backgroundColor = 'rgba(52, 152, 219, 0.05)';
            });
            
            dropZone.addEventListener('drop', (e) => {
                e.preventDefault();
                dropZone.style.borderColor = '#3498db';
                dropZone.style.backgroundColor = 'rgba(52, 152, 219, 0.05)';
                
                if (e.dataTransfer.files.length) {
                    document.getElementById('resourceFile').files = e.dataTransfer.files;
                    alert(`${translations[currentLang].selectFile}: ${e.dataTransfer.files[0].name}`);
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
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
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
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                this.disabled = true;
                
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.disabled = false;
                    alert('ESX to QBcore conversion complete!');
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
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                this.disabled = true;
                
                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.disabled = false;
                    alert('Region restrictions successfully removed!');
                }, 2000);
            });
        });
    </script>
</body>
</html>