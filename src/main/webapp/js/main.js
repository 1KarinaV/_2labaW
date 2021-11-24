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
        if ($("#x-buttons").hasClass("ready")) {
            return parseFloat($("button[type='button'].selected-x").val());
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

    /*unction validateX() {
        if ($("input[type='button']").is(":checked")) {
            $(".button-block").removeClass("button-error");
            return true;
        } else {
            $(".button-block").addClass("button-error");
            return false;
        }
    }*/
    function validateX() {
        if (#X-form !== undefined) {
            $('.input-form__info').text('Choose coordinate')
            return true;
        } else {
            $('.input-form__info').text('Choose X!')
            return false;
        }
    }

    function validateR() {
        let ready = $("#R_form").hasClass("ready");
        if (!ready) {
            $("#R_form").addClass("checkbox-error");
        } else {
            $("#R_form").removeClass("checkbox-error");
        }
        return ready;
    }

    function validateData() {
        let x = validateX();
        let y = validateY();
        let r = validateR();
        return x && y && r;
    }

    $("input[name='r-value']").click(function () {
        if ($(this).hasClass("selected-r")) {
            $(this).removeClass("selected-r");
            $("#R_form").removeClass("ready");
        } else {
            $(this).addClass("selected-r");
            $(this).siblings("input.selected-r").removeClass("selected-r");
            $("#R_form").addClass("ready");
        }
    });

    $("button[type='reset']").click(function () {
        if ($("input[name='r-value']").hasClass("selected-r")) {
            $("input[name='r-value']").removeClass("selected-r");
            $("#R_form").removeClass("ready");
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
            let cX = 193 + x * 140 / r;
            let cY = 193 - y * 140 / r;
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
        if ($("#R_form").hasClass("ready")) {
            let x = (e.offsetX - 193) * getR() / 140;
            let y = (193 - e.offsetY) * getR() / 140;
            requestWithArgs(x.toFixed(1), y.toFixed(1));
        } else {
            alert("Choose R value.");
        }
    })
});