package com.leszekszymaszek.controller;

import com.leszekszymaszek.entity.Bike;
import com.leszekszymaszek.entity.Comment;
import com.leszekszymaszek.entity.User;
import com.leszekszymaszek.service.BikeService;
import com.leszekszymaszek.service.UserService;
import com.leszekszymaszek.utils.AttributeNames;
import com.leszekszymaszek.utils.Mappings;
import com.leszekszymaszek.utils.MessagesForUser;
import com.leszekszymaszek.utils.ViewNames;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Slf4j
@Controller
public class BikeController {

    // == FIELDS ==
    private final BikeService bikeService;
    private final UserService userService;

    //== CONSTRUCTORS ==
    @Autowired
    public BikeController (BikeService bikeService, UserService userService) {
        this.bikeService = bikeService;
        this.userService = userService;
    }

    // == HANDLER METHODS ==

    // == showing all bikes ==
    @GetMapping(Mappings.BIKES)
    public String bikes (Model model, Principal principal) {

        //getting the total number of bikes in warehouse and adding it to the model as an attribute
        //displayed under the bikes table
        model.addAttribute(AttributeNames.QUANTITY_OF__ALL_BIKES, bikeService.sumBikes());

        //getting the total value (price * quantity in stock) of bikes in warehouse and adding it to the model as an attribute
        //displayed under the bikes table
        model.addAttribute(AttributeNames.VALUE_OF_ALL_BIKES, bikeService.valueOfBikes());

        // getting total number of different brands in table
        //displayed under the bikes table
        model.addAttribute(AttributeNames.DIFFERENT_BRANDS, bikeService.numberOfDiffBrands());

        // an attribute for all bikes list
        model.addAttribute(AttributeNames.BIKES, bikeService.getBikes());

        try {

            //getting logged in user (principal) from db if exist and adding to the model
            User user = userService.findByUserName(principal.getName());
            if (user != null) {
                model.addAttribute(AttributeNames.USER, user);
            }
        } catch (Exception e) {
            log.info("Exception occurs {}", e.getMessage());
        }

        return ViewNames.BIKES_LIST;
    }

    // == showing form for adding/editing bike ==
    @GetMapping(Mappings.ADD_BIKE)
    public String addBike (@RequestParam(required = false, defaultValue = "-1") Long id, Model model) {

        //getting proper bike from db
        Bike bike = bikeService.getBike(id);

        //if no bike found creating new one with defaults below and adding to the model
        //it will prepopulate the for for adding bike
        if (bike == null) {
            bike = new Bike("", "", "", "", LocalDate.now(), 0.00, 0, "");
        }
        model.addAttribute(AttributeNames.BIKE, bike);
        return ViewNames.ADD_BIKE;
    }

    // == adding/updating bike and redirecting to all items list ==
    @PostMapping(Mappings.ADD_BIKE)
    public String processBike (@Valid @ModelAttribute(AttributeNames.BIKE) Bike bike,
                               BindingResult bindingResult, Model model) {
        // form validation
        if (bindingResult.hasErrors()) {
            return ViewNames.ADD_BIKE;
        }

        //flag
        boolean success = false;
        log.info("bike from form = {}", bike);
        if (bike.getId() == null) {

            //if id 0 came from form(default value when adding new bike)
            //if add success "addBike" will return true
            success = bikeService.addBike(bike);

            //adding to the model boolean param and message
            model.addAttribute(AttributeNames.ADD_OR_EDIT_SUCCESS, success);
            model.addAttribute(AttributeNames.NEW_ADDED, MessagesForUser.NEW_BIKE_ADDED);
        } else {

            //if id is not 0 means we are editing existing bike (id field is populated
            //if update success "updateBike" will return true
            success = bikeService.updateBike(bike);

            //adding to the model boolean param and message
            model.addAttribute(AttributeNames.ADD_OR_EDIT_SUCCESS, success);
            model.addAttribute(AttributeNames.EDITED, MessagesForUser.BIKED_EDITED_SUCCESFULLY);
        }

        return "redirect:/" + Mappings.BIKES;
    }

    // == deleting bike ==
    @GetMapping(Mappings.DELETE_BIKE)
    public String deleteBike (@RequestParam Long id, Model model) {

        //if delete success "deleteBike" will return true
        boolean deleted = bikeService.deleteBike(id);

        //adding to the model boolean param
        model.addAttribute(AttributeNames.DELETE_SUCCESS, deleted);

        return "redirect:/" + Mappings.BIKES;
    }

    // == showing bike ==
    @GetMapping(Mappings.VIEW_BIKE)
    public String viewBike (@RequestParam Long id, Model model) {

        //getting proper bike by id
        Bike bike = bikeService.getBike(id);

        //getting logged user name
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentPrincipalName = authentication.getName();

        //getting user based on logged user name
        User user = userService.findByUserName(currentPrincipalName);
        log.info("bike have such comments: {}", bike.getComments());

        //flag
        boolean dateLaterThanNow = false;
        LocalDate inStockFrom = bike.getInStockFrom();
        //checking if inStockFrom is after Date.now if it is adding and attribute of true
        if (LocalDate.now().isBefore(inStockFrom)) {
            dateLaterThanNow = true;
            model.addAttribute(AttributeNames.DATE_LATER_THAN_NOW, dateLaterThanNow);
        }

        //getting comments for bike
        Collection<Comment> comments = bike.getComments();

        //creating a map containing comment and String message holding how many time
        //passed since comment was created
        Map<Comment, String> commentsAndPastTime = timePassedSinceCommented(comments);
        log.info("normal map is {}", commentsAndPastTime);

        //reversing commentsAndPastTime map
        Map<Comment, String> commentsAndPastTimeRev = reverseMap(commentsAndPastTime);
        log.info("reversed map is {}", commentsAndPastTimeRev);

        //adding attributes to the model
        model.addAttribute(AttributeNames.BIKE, bike);
        model.addAttribute(AttributeNames.USER, user);
        model.addAttribute(AttributeNames.COMMENTS_AND_THE_PAST_TIME_REV, commentsAndPastTimeRev);

        return ViewNames.VIEW_BIKE;
    }

    // == search for bike ==
    @PostMapping(Mappings.BIKES)
    public String searchBikes (@RequestParam String searchString,
                               @RequestParam(required = false, defaultValue = "") String sortString,
                               Model model) {
        log.info("searchingString param is {}", searchString);
        log.info("sortString param is {}", sortString);

        // search bikes from the service
        List<Bike> bikes = bikeService.searchBikes(searchString, sortString);
        log.info("list is {}", bikes);

        //flag
        boolean emptyBikesList = false;
        //checking if result list is empty, if it is adding an attribute
        if (bikes.isEmpty()) {
            emptyBikesList = true;
            model.addAttribute(AttributeNames.EMPTY_BIKES_LIST, emptyBikesList);
        }

        // add the bikes to the model
        model.addAttribute(AttributeNames.BIKES, bikes);

        //add searchstring to the model to save it in search field
        model.addAttribute(AttributeNames.SEARCH_STRING, searchString);

        // getting quantity of all bikes found
        Integer quantityOfSearchedBikes = countSearchedBikesQuantity(bikes);
        log.info("qty of bikes is {}", quantityOfSearchedBikes);

        //adding quantity attr of all bikes found to the model
        model.addAttribute(AttributeNames.QUANTITY_OF__ALL_BIKES, quantityOfSearchedBikes);

        // getting value of all bikes found
        Double valueOfSearchedBikes = countSearchedBikesValue(bikes);
        log.info("value of bikes is {}", valueOfSearchedBikes);

        // adding value attr of all bikes found to the model
        model.addAttribute(AttributeNames.VALUE_OF_ALL_BIKES, valueOfSearchedBikes);

        // getting number of diff brands of all bikes found
        Integer diffBrands = countDifferentBikeBrands(bikes);
        log.info("number of diff brands is {}", diffBrands);

        // adding number of brands attr to the model
        model.addAttribute(AttributeNames.DIFFERENT_BRANDS, diffBrands);


        return ViewNames.BIKES_LIST;
    }

    // == contact page ==
    @GetMapping(Mappings.CONTACT)
    public String contact () {
        return ViewNames.CONTACT;
    }



    // == PRIVATE METHODS ==

    //message generator for showing how many time passed since comment created
    //iterating over collection of comments checking how many time passed since
    //comment created, creating proper message, then adding to the map Comment as a key
    //and message as value
    private static Map<Comment, String> timePassedSinceCommented (Collection<Comment> comments) {

        Iterator<Comment> iter = comments.iterator();
        Map<Comment, String> commentsWithPastTime = new LinkedHashMap<>();
        String pastTime = "";
        while (iter.hasNext()) {
            Comment currComment = iter.next();
            for (Comment comment : comments) {

                if (comment.getCreatedAt().isBefore(LocalDateTime.now())) {
                    LocalDateTime createdAt = comment.getCreatedAt();
                    LocalDateTime now = LocalDateTime.now();
                    long yearsPassed = ChronoUnit.YEARS.between(createdAt, now);

                    if (yearsPassed > 0) {
                        pastTime = yearsPassed + (yearsPassed == 1 ? " year ago" : " years ago");
                        commentsWithPastTime.put(comment, pastTime);
                    } else {
                        long monthsPassed = ChronoUnit.MONTHS.between(createdAt, now);
                        if (monthsPassed > 0) {
                            pastTime = monthsPassed + (monthsPassed == 1 ? " month ago" : " months ago");
                            commentsWithPastTime.put(comment, pastTime);
                        } else {
                            long daysPassed = ChronoUnit.DAYS.between(createdAt, now);
                            if (daysPassed > 0) {
                                pastTime = daysPassed + (daysPassed == 1 ? " day ago" : " days ago");
                                commentsWithPastTime.put(comment, pastTime);
                            } else {
                                long hoursPassed = ChronoUnit.HOURS.between(createdAt, now);
                                if (hoursPassed > 0) {
                                    pastTime = hoursPassed + (hoursPassed == 1 ? " hour ago" : " hours ago");
                                    commentsWithPastTime.put(comment, pastTime);
                                } else {
                                    long minutesPassed = ChronoUnit.MINUTES.between(createdAt, now);
                                    if (minutesPassed > 0) {
                                        pastTime = minutesPassed + (minutesPassed == 1 ? " minute ago" : " minutes ago");
                                        commentsWithPastTime.put(comment, pastTime);
                                    } else {
                                        long secondsPassed = ChronoUnit.SECONDS.between(createdAt, now);
                                        if (secondsPassed > 0) {
                                            pastTime = "few seconds ago";
                                            commentsWithPastTime.put(comment, pastTime);
                                        } else {
                                            pastTime = "a moment ago";
                                            commentsWithPastTime.put(comment, pastTime);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return commentsWithPastTime;
    }

    //count quantity of all bikes searched f.e. 5 bikes of 1 model + 6 bikes of second model...
    private static Integer countSearchedBikesQuantity (List<Bike> bikes) {
        int counter = 0;
        ListIterator<Bike> iter = bikes.listIterator();
        while (iter.hasNext()) {
            counter += iter.next().getQuantityInStock();
        }

        return counter;
    }

    //quantity of first model * its price + quantity of second model * its price ...
    private static Double countSearchedBikesValue (List<Bike> bikes) {
        double value = 0;
        ListIterator<Bike> iter = bikes.listIterator();
        while (iter.hasNext()) {
            double qty = (double) iter.next().getQuantityInStock();
            iter.previous();
            double price = iter.next().getPrice();
            value += qty * price;
        }
        value = (double) Math.round(value * 100) / 100;
        return value;
    }

    //counting different brands in table
    private static Integer countDifferentBikeBrands (List<Bike> bikes) {
        // creating list of brands only
        List<String> brands = new ArrayList<>();

        ListIterator<Bike> iter = bikes.listIterator();
        while (iter.hasNext()) {
            // adding brands from "bikes" List to "brands" List
            brands.add(iter.next().getBrand().toLowerCase());
        }
        // set has no duplicates, it's size will be same as num of diff brands
        Set<String> uniqueBrands = new HashSet<>(brands);
        Integer diffBrands = uniqueBrands.size();
        return diffBrands;
    }

    //reversing comments collection
    //maybe I will use it later
    public static Collection<Comment> reverseCollection (Collection<Comment> commentsNotReversed) {
        List<Comment> commentsNotReversedList = new ArrayList<>(commentsNotReversed);
        Comparator<Comment> comparator = Collections.reverseOrder();
        Collections.sort(commentsNotReversedList, comparator);

        Collection<Comment> commentsReversed = new ArrayList<>();
        for (Comment comment : commentsNotReversedList) {
            commentsReversed.add(comment);
        }
        return commentsReversed;

    }

    //reversing map
    public static Map<Comment, String> reverseMap (Map<Comment, String> mapNotReversed) {
        List<Comment> comments = new ArrayList<>(mapNotReversed.keySet());
        Map<Comment, String> reversedMap = new LinkedHashMap<>();
        for (int i = comments.size() - 1; i >= 0; i--) {
            Comment commentKey = comments.get(i);
            String stringValue = mapNotReversed.get(commentKey);
            reversedMap.put(commentKey, stringValue);
        }
        return reversedMap;
    }
}
