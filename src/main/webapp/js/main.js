$(function () {

    function getY() {
        let y = $("input[name='y-value']").val();
        let regex = /^[+-]?[0-9]{1,10}([.]?[0-9]{1,10})?$/;
        if (y.match(regex)) {
            return parseFloat(y);
        } else {
            return NaN;
        }
    }

    function getR() {
        if ($("input[type='checkbox']").is(":checked")) {
            return parseFloat($("input[type='checkbox']:checked").val());
        } else {
            return NaN;
        }
    }

    function getX() {
        if ($("#r-buttons").hasClass("ready")) {
            return parseFloat($("button[type='button'].selected-r").val());
        } else {
            return NaN;
        }
    }

    function validateY() {
        let y = getY();
        const MIN_Y = -3;
        const MAX_Y = 3;
        if (y > MIN_Y && y < MAX_Y) {
            $("input[type='text']").removeClass('text-error');
            return true;
        } else {
            $("input[type='text']").addClass('text-error');
            return false;
        }
    }

    function validateR() {
        if ($("input[type='checkbox']").is(":checked")) {
            $(".checkbox").removeClass("checkbox-error");
            return true;
        } else {
            $(".checkbox").addClass("checkbox-error");
            return false;
        }
    }

    function validateX() {
        let ready = $("#r-buttons").hasClass("ready");
        if (!ready) {
            $("#r-buttons").addClass("buttons-error");
        } else {
            $("#r-buttons").removeClass("buttons-error");
        }
        return ready;
    }

    function validateData() {
        let x = validateX();
        let y = validateY();
        let r = validateR();
        return x && y && r;
    }

    $("button[type='button']").click(function () {
        if ($(this).hasClass("selected-r")) {
            $(this).removeClass("selected-r");
            $("#r-buttons").removeClass("ready");
        } else {
            $(this).addClass("selected-r");
            $(this).siblings("button.selected-r").removeClass("selected-r");
            $("#r-buttons").addClass("ready");
        }
    });

    $("button[type='reset']").click(function () {
        if ($("button[type='button']").hasClass("selected-r")) {
            $("button[type='button']").removeClass("selected-r");
            $("#r-buttons").removeClass("ready");
        }
        clearTable();
    })

    function clearTable() {
        $.ajax({
            url: "controller",
            type: "POST",
            data: {clear: "true"},
            success: function (data) {
                $("table").html(data);
                drawPoints();
            }
        });
    }

    $("form").submit(function (event) {
        event.preventDefault();
        if (validateData()) {
            requestWithArgs(getX(), getY());
        }
    })

    function drawPoints() {
        $("circle").remove();
        $("table tbody tr").each(function (row) {
            let x = parseFloat(row.cells[0].innerText);
            let y = parseFloat(row.cells[1].innerText);
            let r = parseFloat(row.cells[2].innerText);
            let cX = 150 + x * 120 / r;
            let cY = 150 - y * 120 / r;
            $("svg").append(`<circle r="5" cx=${cX} cy=${cY} fill="cyan"
                fill-opacity="0.85"></circle>`);
        })
    }

    function requestWithArgs(xArg, yArg) {
        $.ajax({
            url: "controller",
            type: "POST",
            data: {x: xArg, y: yArg, r: getR()},
            success: function (data) {
                $("table").html(data);
                drawPoints();
            }
        });
    }

    $("svg").click(function (e) {
        if ($("#r-buttons").hasClass("ready")) {
            let x = (e.offsetX - 150) * getR() / 120;
            let y = (150 - e.offsetY) * getR() / 120;
            requestWithArgs(x.toFixed(1), y.toFixed(1));
        } else {
            alert("Choose X value.");
        }
    })
});