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
            $.post("http://nuiweaponspawner/exit", JSON.stringify({}));
            return;
        }
    }

    $("#close").click(function() {
        $.post("http://nuiweaponspawner/exit", JSON.stringify({}));
        return;
    })

    $("#submit").click(function() {
        let inputVal = $("#input").val()
        $.post("http://nuiweaponspawner/main", JSON.stringify({
            text: inputVal
        }))
        return;
    })
})