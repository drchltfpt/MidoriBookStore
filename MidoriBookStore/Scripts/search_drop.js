$(document).ready(function () {

    $(".selLabel").click(function () {
        $('.dropdown').toggleClass('active');
    });

    $(".dropdown-list li").click(function () {
        $('.selLabel').text($(this).text());
        $('.dropdown').removeClass('active');
        $('.selected-item p span').text($('.selLabel').text());
    });

});

$(document).ready(function () {

    $(".selLabel1").click(function () {
        $('.dropdown').toggleClass('active');
    });

    $(".dropdown-list li").click(function () {
        $('.selLabel1').text($(this).text());
        $('.dropdown').removeClass('active');
        $('.selected-item1 p span').text($('.selLabel1').text());
    });

});