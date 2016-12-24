<style>
/* Dashboard CSS */

.dashboard-stat2 {
    background: #e4e4e4 none repeat scroll 0 0;
    border-radius: 4px;
    padding: 15px 15px 30px;
    cursor:pointer;
}
.dashboard-stat2, .dashboard-stat2 .display {
    margin-bottom: 20px;
}

.dashboard-stat2 .display::after, .dashboard-stat2 .display::before {
    content: " ";
    display: table;
}

.dashboard-stat1:hover {
    cursor: pointer;
} 


.dashboard-stat2 .display::after {
    clear: both;
}
.dashboard-stat2 .display::after, .dashboard-stat2 .display::before {
    content: " ";
    display: table;
}
body, h1, h2, h3, h4, h5, h6 {
    font-family: "Open Sans",sans-serif;
}
.dashboard-stat2 .display .number {
    display: inline-block;
    float: left;
}
.dashboard-stat2 .display .number h3 {
    font-size: 30px;
    font-weight: 400;
    margin: 0 0 2px;
    padding: 0;
}
.font-green-sharp {
    color: #2ab4c0 !important;
}
.font-red-haze {
    color: #f36a5a !important;
}
.font-blue-sharp {
    color: #5c9bd1 !important;
}
.font-purple-soft {
    color: #8877a9 !important;
}
h3 {
    font-size: 24px;
}
h1, h2, h3, h4, h5, h6 {
    font-weight: 300;
}
.dashboard-stat2 .display .number small {
    color: #aab5bc;
    font-size: 13px;
    font-weight: 600;
    text-transform: uppercase;
}
.dashboard-stat2 .display .icon {
    display: inline-block;
    float: right;
    padding: 7px 0 0;
}
.dashboard-stat2 .display .icon > i {
    color: #cbd4e0;
    font-size: 26px;
}

.dashboard-stat2 .progress-info {
    clear: both;
}
.dashboard-stat2 .progress-info .progress {
    clear: both;
    display: block;
    height: 4px;
    margin: 0;
}
.progress {
    background-image: none;
    border: 0 none;
    box-shadow: none;
    filter: none;
}
.progress-bar.green-sharp {
    background: #2ab4c0 none repeat scroll 0 0 !important;
    color: #fff !important;
}
.progress-bar.red-haze {
    background: #f36a5a none repeat scroll 0 0 !important;
    color: #fff !important;
}
.progress-bar.blue-sharp {
    background: #5c9bd1 none repeat scroll 0 0 !important;
    color: #fff !important;
}
.progress-bar.purple-soft {
    background: #8877a9 none repeat scroll 0 0 !important;
    color: #fff !important;
}
.dashboard-stat2 .progress-info .status {
    color: #aab5bc;
    font-size: 11px;
    font-weight: 600;
    margin-top: 5px;
    text-transform: uppercase;
}
.dashboard-stat2 .progress-info .status .status-title {
    display: inline-block;
    float: left;
}
.dashboard-stat2 .progress-info .status .status-number {
    display: inline-block;
    float: right;
}
</style>
<div class="row">
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                            <div class="dashboard-stat2 " id="introJsDashboard_1">
                                <div class="display">
                                    <div class="number">
                                        <h3 class="font-green-sharp">
                                            <span data-counter="counterup" id="toBeRequested" ></span>
                                        </h3>
                                        <small>To be requested</small>
                                    </div>
                                    <div class="icon">
                                        <i class='fa fa-bar-chart-o' aria-hidden='true'></i>
                                    </div>
                                </div>
                                <div class="progress-info">
                                    <div class="progress">
                                        <span class="progress-bar progress-bar-success green-sharp" style="width: 100%;">
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
                            <div class="dashboard-stat2 " id="introJsDashboard_2">
                                <div class="display">
                                    <div class="number">
                                        <h3 class="font-red-haze">
                                            <span data-counter="counterup" id="pendingApproval"></span>
                                        </h3>
                                        <small>Pending approval from SCC</small>
                                    </div>
                                    <div class="icon">
                                        <i class="fa fa-money" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="progress-info">
                                    <div class="progress">
                                        <span class="progress-bar progress-bar-success red-haze" style="width: 100%;">
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
                            <div class="dashboard-stat2 " id="introJsDashboard_3">
                                <div class="display">
                                    <div class="number">
                                        <h3 class="font-blue-sharp">
                                            <span data-counter="counterup" id="pendingClarification"></span>
                                        </h3>
                                        <small>Pending clarifications to SCC</small>
                                    </div>
                                    <div class="icon">
                                        <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="progress-info">
                                    <div class="progress">
                                        <span class="progress-bar progress-bar-success blue-sharp" style="width: 100%;">
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                            <div class="dashboard-stat2 " id="introJsDashboard_4">
                                <div class="display">
                                    <div class="number">
                                        <h3 class="font-blue-sharp">
                                            <span data-counter="counterup" id="inProgress"></span>
                                        </h3>
                                        <small>In Progress</small>
                                    </div>
                                    <div class="icon">
                                        <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="progress-info">
                                    <div class="progress">
                                        <span class="progress-bar progress-bar-success blue-sharp" style="width: 100%;">
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                            <div class="dashboard-stat2 " id="introJsDashboard_5">
                                <div class="display">
                                    <div class="number">
                                        <h3 class="font-blue-sharp">
                                            <span data-counter="counterup" id="rejected"></span>
                                        </h3>
                                        <small>Historic</small>
                                    </div>
                                    <div class="icon">
                                        <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="progress-info">
                                    <div class="progress">
                                        <span class="progress-bar progress-bar-success blue-sharp" style="width: 100%;">
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


