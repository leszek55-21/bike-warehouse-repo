package com.leszekszymaszek.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public final class JspTaglibCustomFunctions {

    public static boolean contains(List list, Object o) {
        return list.contains(o);
    }

    public static String customFormatDate(LocalDateTime localDateTime) {
        //getting date part
        LocalDate date = localDateTime.toLocalDate();

        //getting time part
        LocalTime time = localDateTime.toLocalTime();

        //creating custom date format
        //first format date part
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String customDate = date.format(dateFormatter);

        //then format time part
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        String customTime = time.format(timeFormatter);

        return "On " + customDate + " at " + customTime;
    }
}
