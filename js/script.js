var apexSkillBar = (function () {
    "use strict";
    var scriptVersion = "1.0";
    var util = {
        version: "1.0.1",
        escapeHTML: function (str) {
            if (str === null) {
                return null;
            }
            if (typeof str === "undefined") {
                return;
            }
            if (typeof str === "object") {
                try {
                    str = JSON.stringify(str);
                } catch (e) {
                    /*do nothing */
                }
            }
            try {
                return apex.util.escapeHTML(String(str));
            } catch (e) {
                str = String(str);
                return str
                    .replace(/&/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;")
                    .replace(/"/g, "&quot;")
                    .replace(/'/g, "&#x27;")
                    .replace(/\//g, "&#x2F;");
            }
        },
        loader: {
            start: function (id) {

                try {
                    apex.util.showSpinner($(id));
                } catch (e) {
                    /* define loader */
                    var faLoader = $("<span></span>");
                    faLoader.attr("id", "loader" + id);
                    faLoader.addClass("ct-loader fa-stack fa-3x");

                    /* define circle for loader */
                    var faCircle = $("<i></i>");
                    faCircle.addClass("fa fa-circle fa-stack-2x");
                    faCircle.css("color", "rgba(121,121,121,0.6)");

                    /* define refresh icon with animation */
                    var faRefresh = $("<i></i>");
                    faRefresh.addClass("fa fa-refresh fa-spin fa-inverse fa-stack-1x");
                    faRefresh.css("animation-duration", "1.8s");

                    /* append loader */
                    faLoader.append(faCircle);
                    faLoader.append(faRefresh);
                    $(id).append(faLoader);
                }
            },
            stop: function (id) {
                $(id + " > .u-Processing").remove();
                $(id + " > .ct-loader").remove();
            }
        },
        noDataMessage: {
            show: function (id, text) {
                var div = $("<div></div>")
                    .css("margin", "12px")
                    .css("text-align", "center")
                    .css("padding", "64px 0")
                    .addClass("nodatafoundmessage");

                var subDiv = $("<div></div>");

                var subDivSpan = $("<span></span>")
                    .addClass("fa")
                    .addClass("fa-search")
                    .addClass("fa-2x")
                    .css("height", "32px")
                    .css("width", "32px")
                    .css("color", "#D0D0D0")
                    .css("margin-bottom", "16px");

                subDiv.append(subDivSpan);

                var span = $("<span></span>")
                    .text(text)
                    .css("display", "block")
                    .css("color", "#707070")
                    .css("font-size", "12px");

                div
                    .append(subDiv)
                    .append(span);

                $(id).append(div);
            },
            hide: function (id) {
                $(id).children('.nodatafoundmessage').remove();
            }
        }
    };
    /************************************************************************
     **
     ** Used to render the html into region
     **
     ***********************************************************************/
    function renderHTML(pParentID, pData, pEscapeHTML) {
        var value = 0;
        $.each(pData, function (idx, data) {
            if (data.VALUE && data.VALUE <= 100 && data.VALUE >= 0) {
                value = data.VALUE
            }

            // create whole bar div
            var skillBar = $("<div></div>");
            skillBar.addClass("skillbar");
            skillBar.addClass("clearfix");
            skillBar.attr("data-percent", value + "%");

            // create title div
            var skillBarTitle = $("<div></div>");
            skillBarTitle.addClass("skillbar-title");
            if (data.TITLE_COLOR) {
                skillBarTitle.css("background", util.escapeHTML(data.TITLE_COLOR));
            }

            // create span for title div
            var span = $("<span></span>");

            if (pEscapeHTML !== false) {
                span.text(data.TITLE);
            } else {
                span.html(data.TITLE);
            }

            skillBarTitle.append(span);

            skillBar.append(skillBarTitle);

            // create bar
            var skillBarBar = $("<div></div>");
            skillBarBar.addClass("skillbar-bar");
            if (data.BAR_COLOR) {
                skillBarBar.css("background", util.escapeHTML(data.BAR_COLOR));
            }

            skillBar.append(skillBarBar);

            // create percent bar
            var skillBarPercent = $("<div></div>");
            skillBarPercent.addClass("skill-bar-percent");
            skillBarPercent.text(value + "%");

            skillBar.append(skillBarPercent);

            $(pParentID).append(skillBar);

        });

        $(pParentID).find(".skillbar").each(function () {
            $(this).find('.skillbar-bar').animate({
                width: $(this).attr('data-percent')
            }, 1500);
        });
    }
    /************************************************************************
     **
     ** Used to check data and to call rendering
     **
     ***********************************************************************/
    function prepareData(pParentID, pData, pNoDataFound, pEscapeHTML) {
        /* empty container for new stuff */
        $(pParentID).empty();

        if (pData.row && pData.row.length > 0) {
            renderHTML(pParentID, pData.row, pEscapeHTML);
        } else {
            $(pParentID).css("min-height", "");
            util.noDataMessage.show(pParentID, pNoDataFound);
        }
        util.loader.stop(pParentID);
    }

    return {
        render: function (regionID, ajaxID, noDataFoundMessage, items2Submit, escapeRequired, refreshTime, offlineData) {
            var parentID = "#" + regionID + "-p";

            /************************************************************************
             **
             ** Used to get data from APEX
             **
             ***********************************************************************/
            function getData() {
                $(parentID).css("min-height", "120px");
                util.loader.start(parentID);

                var submitItems = items2Submit;
                try {
                    apex.server.plugin(
                        ajaxID, {
                            pageItems: submitItems
                        }, {
                            success: function (pData) {
                                prepareData(parentID, pData, noDataFoundMessage, escapeRequired)
                            },
                            error: function (d) {
                                console.error(d.responseText);
                            },
                            dataType: "json"
                        });
                } catch (e) {
                    console.error("Error while try to get Data from APEX");
                    console.error(e);
                    // try to work offline
                    try {
                        if (offlineData) {
                            prepareData(parentID, offlineData, noDataFoundMessage, escapeRequired);
                        }
                    } catch (e) {
                        console.error("Error while try to run native mode");
                        console.error(e);
                    }
                }

            }

            // load data
            getData();

            /************************************************************************
             **
             ** Used to bind APEx Refresh event (DA's)
             **
             ***********************************************************************/
            try {
                apex.jQuery("#" + regionID).bind("apexrefresh", function () {
                    getData();
                });
            } catch (e) {
                console.error("Error while try to bind APEX refresh event");
                console.error(e);
            }

            /************************************************************************
             **
             ** Used to refresh by a timer
             **
             ***********************************************************************/
            if (refreshTime && refreshTime > 0) {
                setInterval(function () {
                    getData();
                }, refreshTime * 1000);
            }
        }
    }

})();
