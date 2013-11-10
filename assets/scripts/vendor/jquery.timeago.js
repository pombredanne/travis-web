/*
 * timeago: a jQuery plugin, version: 0.9.2 (2010-09-14)
 * @requires jQuery v1.2.3 or later
 *
 * Timeago is a jQuery plugin that makes it easy to support automatically
 * updating fuzzy timestamps (e.g. '4 minutes ago' or 'about 1 day ago').
 *
 * For usage and examples, visit:
 * http://timeago.yarp.com/
 *
 * Licensed under the MIT:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Copyright (c) 2008-2010, Ryan McGeary (ryanonjavascript -[at]- mcgeary [*dot*] org)
 */
(function($) {
  $.timeago = function(timestamp) {
    if (timestamp instanceof Date) return inWords(timestamp);
    else if (typeof timestamp == 'string') return inWords($.timeago.parse(timestamp));
    else return inWords($.timeago.datetime(timestamp));
  };
  var $t = $.timeago;

  $.extend($.timeago, {
    settings: {
      refreshMillis: 3000,
      allowFuture: false,
      strings: {
        prefixAgo: null,
        prefixFromNow: null,
        suffixAgo: 'ago',
        suffixFromNow: 'from now',
        seconds: 'less than a minute',
        minute: 'about a minute',
        minutes: '%d minutes',
        hour: 'about an hour',
        hours: 'about %d hours',
        day: 'a day',
        days: '%d days',
        month: 'about a month',
        months: '%d months',
        year: 'about a year',
        years: '%d years',
        numbers: [],
      },
      nowFunction: function() { return new Date().getTime(); }
    },
    distanceInWords: function(date) {
      if(!date) {
        return;
      }
      if(typeof date == 'string') {
        date = $.timeago.parse(date);
      }
      return $.timeago.inWords($.timeago.distance(date));
    },
    inWords: function(distanceMillis) {
      var $l = this.settings.strings;
      var prefix = $l.prefixAgo;
      var suffix = $l.suffixAgo;
      if (this.settings.allowFuture) {
        if (distanceMillis < 0) {
          prefix = $l.prefixFromNow;
          suffix = $l.suffixFromNow;
        }
        distanceMillis = Math.abs(distanceMillis);
      } else {
        if (distanceMillis < 0) {
          distanceMillis = 0;
        }
      }

      var seconds = distanceMillis / 1000;
      var minutes = seconds / 60;
      var hours = minutes / 60;
      var days = hours / 24;
      var years = days / 365;

      function substitute(stringOrFunction, number) {
        var string = $.isFunction(stringOrFunction) ? stringOrFunction(number, distanceMillis) : stringOrFunction;
        var value = ($l.numbers && $l.numbers[number]) || number;
        return string.replace(/%d/i, value);
      }

      var words = seconds < 55 && substitute($l.seconds, Math.round(seconds)) ||
        seconds < 90 && substitute($l.minute, 1) ||
        minutes < 55 && substitute($l.minutes, Math.round(minutes)) ||
        minutes < 90 && substitute($l.hour, 1) ||
        hours < 24 && substitute($l.hours, Math.round(hours)) ||
        hours < 48 && substitute($l.day, 1) ||
        days < 30 && substitute($l.days, Math.floor(days)) ||
        days < 60 && substitute($l.month, 1) ||
        days < 365 && substitute($l.months, Math.floor(days / 30)) ||
        years < 2 && substitute($l.year, 1) ||
        substitute($l.years, Math.floor(years));

      return $.trim([prefix, words, suffix].join(' '));
    },
    distance: function(date) {
      return (this.now() - date.getTime());
    },
    now: function() {
      return this.settings.nowFunction.call(this);
    },
    parse: function(iso8601) {
      var s = $.trim(iso8601);
      s = s.replace(/\.\d\d\d+/,''); // remove milliseconds
      s = s.replace(/-/,'/').replace(/-/,'/');
      s = s.replace(/T/,' ').replace(/Z/,' UTC');
      s = s.replace(/([\+-]\d\d)\:?(\d\d)/,' $1$2'); // -04:00 -> -0400
      return new Date(s);
    }
  });

  $.fn.timeago = function() {
    this.each(function() {
      var data = prepareData(this);
      if (!isNaN(data.datetime)) {
        $(this).text(inWords(data.datetime));
      }
    });
    return this;
  };

  function prepareData(element) {
    element = $(element);
    if (!element.data('timeago') || (element.data('timeago').title != element.attr('title'))) {
      element.data('timeago', { datetime: $t.parse(element.attr('title')), title: element.attr('title') });
    }
    return element.data('timeago');
  }

  function inWords(date) {
    return $t.inWords(distance(date));
  }

  function distance(date) {
    return $t.distance(date);
  }

  // fix for IE6 suckage
  document.createElement('abbr');
  document.createElement('time');
})(jQuery);



