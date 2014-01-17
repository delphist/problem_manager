//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require select2
//= require select2_locale_ru
//= require jquery.maskedinput.min
//= require jquery.nouislider.min
//= require moment.min
//= require bootstrap-datetimepicker.min
//= require_tree .

$(function() {
    jQuery.fn.extend({
        insertAtCaret: function(myValue){
            return this.each(function(i) {
                if (document.selection) {
                    //For browsers like Internet Explorer
                    this.focus();
                    var sel = document.selection.createRange();
                    sel.text = myValue;
                    this.focus();
                }
                else if (this.selectionStart || this.selectionStart == '0') {
                    //For browsers like Firefox and Webkit based
                    var startPos = this.selectionStart;
                    var endPos = this.selectionEnd;
                    var scrollTop = this.scrollTop;
                    this.value = this.value.substring(0, startPos)+myValue+this.value.substring(endPos,this.value.length);
                    this.focus();
                    this.selectionStart = startPos + myValue.length;
                    this.selectionEnd = startPos + myValue.length;
                    this.scrollTop = scrollTop;
                } else {
                    this.value += myValue;
                    this.focus();
                }
            });
        }
    });

    function mention_user(id) {
        $('.mentionable').insertAtCaret('@u' + id);
    }

    $('.select2').select2();
    $(".phone-mask").mask("+7 (999) 999-99-99");

    $('.mention-select').on('select2-selecting', function(event) {
        mention_user(event.val);
        event.preventDefault();
        $(this).select2("close");
    })

    $('.datepicker').datetimepicker({
        pickTime: false,
        language: 'ru'
    });

    $(".range-select").each(function() {
        var dd = $(this);

        $(".slider", dd).noUiSlider({
            range: [parseInt(dd.attr('data-min')), parseInt(dd.attr('data-max'))]
            ,start: [parseInt(dd.attr('data-from').length > 0 ? dd.attr('data-from') : dd.attr('data-min')), parseInt(dd.attr('data-to').length > 0 ? dd.attr('data-to') : dd.attr('data-max'))]
            ,handles: 2
            ,step: parseInt(dd.attr('data-step'))
            ,margin: 0
            ,connect: true
            ,direction: 'ltr'
            ,orientation: 'horizontal'
            ,behaviour: 'tap-drag'
            ,serialization: {
                mark: ','
                ,resolution: 0.1
                ,to: [ $(".from", dd), $(".to", dd) ]
            }
        }).change(function() {
                $('.range-data', dd).html("(" + $(".from", dd).val() + " - " + $(".to", dd).val() + ")");
            });

        $('.range-data', dd).html("(" + $(".from", dd).val() + " - " + $(".to", dd).val() + ")");
    });

    $('.mention-user').on('click', function(e) {
        mention_user($(this).attr('data-user-id'));
        e.preventDefault();
    });

    if($('#select_map').length > 0) {
        var select_map;
        ymaps.ready(function() {
            select_map = new ymaps.Map("select_map", {
                center: [55.76, 37.64],
                zoom: 10
            });

            select_map.controls.add(
                new ymaps.control.ZoomControl()
            );

            $('.address_select_input').on('blur', function() {
                update_map_address($(this).val());
            });

            update_map_address($('.address_select_input').val());
        });

        function update_map_address(address) {
            if(address.length == 0) {
                $('.address_flash').addClass('hide');
                $('.address_fail').addClass('hide');
                $('.address_select_distance').val("");
                $('.address_select_distance_car').val("");
                $('.address_select_longitude').val("");
                $('.address_select_latitude').val("");
                return;
            }

            var geo_search = ymaps.geocode(address);

            $('.submit_form').attr('disabled', 'disabled');

            geo_search.then(
                function (result) {
                    found_object = result.geoObjects.get(0);

                    if(found_object == null) {
                        $('.address_flash').addClass('hide');
                        $('.address_fail').removeClass('hide');
                        $('.address_select_distance').val("");
                        $('.address_select_distance_car').val("");
                        $('.address_select_longitude').val("");
                        $('.address_select_latitude').val("");
                        $('.submit_form').attr('disabled', false);
                    } else {
                        coordinates = found_object.geometry.getCoordinates();
                        placemark = new ymaps.Placemark(found_object.geometry.getCoordinates());
                        select_map.geoObjects.add(placemark);

                        select_map.setCenter(coordinates);

                        $('.address_success .longitude').text(coordinates[0]);
                        $('.address_success .latitude').text(coordinates[1]);
                        $('.address_select_longitude').val(coordinates[0]);
                        $('.address_select_latitude').val(coordinates[1]);

                        route_length = ymaps.coordSystem.geo.getDistance([55.7500, 37.6167], coordinates);
                        $('.route .distance').text((route_length / 1000).toFixed(2) + " км");
                        $('.address_select_distance').val(route_length);

                        $('.auto_route .distance').text("вычисляется...");
                        ymaps.route(['Москва', coordinates]).then(
                            function (route) {
                                auto_route_length = route.getLength();
                                $('.auto_route').removeClass('hide');
                                $('.auto_route .distance').text((auto_route_length / 1000).toFixed(2) + " км");
                                $('.address_select_distance_car').val(auto_route_length);
                                $('.submit_form').attr('disabled', false);
                            },
                            function (error) {
                                $('.auto_route').removeClass('hide');
                                $('.auto_route .distance').text("Невозможно определить");
                                $('.address_select_distance_car').val("");
                                $('.submit_form').attr('disabled', false);
                            }
                        );

                        $('.address_flash').addClass('hide');
                        $('.address_success').removeClass('hide');
                    }
                },
                function (error) {
                    $('.address_flash').addClass('hide');
                    $('.address_fail').removeClass('hide');
                    $('.address_select_distance').val("");
                    $('.address_select_distance_car').val("");
                    $('.address_select_longitude').val("");
                    $('.address_select_latitude').val("");
                    $('.submit_form').attr('disabled', false);
                }
            );
        }
    }

    if($('#show_single_map').length > 0) {
        var show_single_map;
        var coordinates = [$('#show_single_map').attr('data-longitude'), $('#show_single_map').attr('data-latitude')]
        ymaps.ready(function() {
            show_single_map = new ymaps.Map("show_single_map", {
                center: coordinates,
                zoom: 10
            });

            show_single_map.controls.add(
                new ymaps.control.ZoomControl()
            );

            placemark = new ymaps.Placemark(coordinates);
            show_single_map.geoObjects.add(placemark);
        });
    }

    if($('#show_all_map').length > 0) {
        var show_all_map;
        ymaps.ready(function() {
            show_all_map = new ymaps.Map("show_all_map", {
                center: [55.76, 37.64],
                zoom: 5
            });

            show_all_map.controls.add(
                new ymaps.control.ZoomControl()
            );

            len = problems.length
            for(i = 0; i < len; i++) {
                problem = problems[i];
                coordinates = [problem[0], problem[1]];

                balloon_content = "";
                if(problem[4].length > 0) {
                    balloon_content = problem[4] + "<br /><a href='" + problem[5] + "'>Редактировать</a>";
                } else {
                    balloon_content = "<a href='" + problem[5] + "'>Редактировать</a>";
                }


                placemark = new ymaps.Placemark(coordinates, { balloonContent: balloon_content, iconContent: problem[3] }, { preset: "twirl#" + problem[2] + "StretchyIcon" });
                show_all_map.geoObjects.add(placemark);
            }
        });
    }
})