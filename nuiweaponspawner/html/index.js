$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    display(false)
    window.addEventListener("message", function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("http://nui/exit", JSON.stringify({}));
            return;
        }
    }

    $("#close").click(function() {
        $.post("http://nui/exit", JSON.stringify({}));
        return;
    })

    $("#submit").click(function() {
        let inputVal = $("#input").val()
        if (inputVal.legnth  >= 100) {
            $.post("http://nui/error", JSON.stringify({
                error: "Too many characters. Must be less than 100."
            }))
            return;
        } else if (!inputVal) {
            $.post("http://nui/error", JSON.stringify({
                error: "Input field was blank."
            }))
            return;
        }
        $.post("http://nui/main", JSON.stringify({
            text: inputVal
        }))
        return;
    })
})