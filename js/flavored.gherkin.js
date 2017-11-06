$(document).ready(function () {

    $(".tabs .tab").click(function () {
        $(".tabs a").removeClass("blue-text").addClass("white-text");
        $(this).find('a').removeClass("white-text").addClass("blue-text");
    });

    $("span#flavours>span.flavour").click(function () {
        var selected = $("span#flavours>span.flavour.selected");
        selected.removeClass("selected").addClass("z-depth-5");
        var selectedColor = selected.attr('class').replace(" flavour chip z-depth-5", "");
        var toSelectColor = $(this).attr('class').replace(" flavour chip z-depth-5", "");
        $('#summaryTable').DataTable().destroy();
        $("." + selectedColor + ":not(span#flavours>span.flavour)").removeClass(selectedColor).addClass(toSelectColor);
        drawSummaryTable();
        $(this).removeClass("z-depth-5").addClass("selected");
        var color = $(this).css("background-color").replace('rgb', 'rgba').replace(')', ', 1)');
        drawScenariosTagsChart(color);
    });

    var features = $(".feature");
    $("table#featuresCount tbody").append("<tr><th>Total Features</th><td>" + features.length + "</td></tr>");
    $("table#scenariosCount tbody").append("<tr><th>Total Scenarios</th><td>" + $(".scenario, .example").length + "</td></tr>");

    var tagsData = {};
    $(".f-tag").each(function () {
        var tag = ($(this).attr('class')).replace('f-tag tag-', '@');
        var feature = $(this).closest(".feature");
        var sCount = feature.find(".scenario").length;
        var sid = feature.find('.scenario-outline a').attr('href');
        var eCount = $(sid).find(".example").length;
        var count = sCount + eCount;
        if (tagsData.hasOwnProperty(tag)) {
            tagsData[tag] += count;
        } else {
            tagsData[tag] = count;
        }
    });
    $(".s-tag").each(function () {
        var tag = ($(this).attr('class')).replace('s-tag tag-', '@');
        var count = $(this).closest(".modal").find(".example").length;
        if (count === 0) {
            count = 1;
        }
        if (tagsData.hasOwnProperty(tag)) {
            tagsData[tag] += count;
        } else {
            tagsData[tag] = count;
        }
    });
    var tags = Object.keys(tagsData);
    var tagsCounts = Object.values(tagsData);

    $("#scenariosTagsChart").attr("height", tags.length + "0px");
    function drawScenariosTagsChart(color) {
        new Chart(document.getElementById("scenariosTagsChart").getContext("2d"), {
            type: 'horizontalBar',
            data: {
                labels: tags,
                datasets: [{
                    label: 'Scenarios',
                    backgroundColor: color.replace(', 1)', ', 0.2)'),
                    borderColor: color,
                    borderWidth: 1,
                    data: tagsCounts
                }]
            },
            options: {
                legend: {
                    display: false
                },
                tooltips: {
                    mode: 'index',
                    intersect: false
                },
                responsive: true,
                scales: {
                    xAxes: [{
                        position: "top",
                        display: true,
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        }).draw();
    }
    drawScenariosTagsChart('rgba(121, 85, 72, 1)');

    features.each(function () {
        var $this = $(this);
        var sCount = $this.find(".scenario").length;
        var sid = $this.find('.scenario-outline a').attr('href');
        var eCount = $(sid).find(".example").length;
        var count = sCount + eCount;
        $this.find(".collapsible-header").append("<span class=\"new badge brown lighten-2\" data-badge-caption=\"Scenarios\">" + count + "</span>");
    });

    $(".scenario-outline").each(function () {
        var $this = $(this);
        var sid = $this.find('a').attr('href');
        var count = $(sid).find(".example").length;
        $this.append("<span class=\"new badge brown lighten-2\" data-badge-caption=\"Examples\">" + count + "</span>");
    });

    function drawSummaryTable() {
        $.when($('#summaryTable').DataTable({
            "language": {
                "search": "<i class=\"material-icons\">search</i> Search",
                "searchPlaceholder": "Search",
                "lengthMenu": "Show _MENU_",
                "info": "Showing _START_ to _END_ of _TOTAL_",
                "infoFiltered": "filtered from _MAX_"
            }
        })).done(function () {
            $('select').material_select();
        });
    }
    drawSummaryTable();

    $("#loading-flavour").remove();
});
