package com.leszekszymaszek.dao;

import com.leszekszymaszek.entity.Bike;
import com.leszekszymaszek.utils.SortingStrings;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Slf4j
@Repository
public class BikeDaoImpl implements BikeDao {

    // == CONSTANTS ==

    // == query params ==
    public static final String QUERY_PARAMS_BRAND = "brand";
    public static final String QUERY_PARAMS_MODEL = "model";
    public static final String QUERY_PARAMS_TYPE = "type";
    public static final String QUERY_PARAMS_DETAILS = "details";
    public static final String QUERY_PARAMS_IMAGE_URL = "image_url";
    public static final String QUERY_PARAMS_IN_STOCK_FROM = "in_stock_from";
    public static final String QUERY_PARAMS_PRICE = "price";
    public static final String QUERY_PARAMS_QUANTITY_IN_STOCK = "quantity_in_stock";
    public static final String QUERY_PARAMS_ID = "id";
    public static final String QUERY_PARAMS_SEARCH_STRING = "searchString";

    //== column names ==
    public static final String TABLE_NAME = "bike";
    public static final String COL_BRAND = "brand";
    public static final String COL_MODEL = "model";
    public static final String COL_TYPE = "type";
    public static final String COL_DETAILS = "details";
    public static final String COL_IMAGE_URL = "image_url";
    public static final String COL_IN_STOCK_FROM = "in_stock_from";
    public static final String COL_PRICE = "price";
    public static final String COL_QUANTITY_IN_STOCK = "quantity_in_stock";
    public static final String COL_ID = "id";

    // == query fragments ==
    public static final String ORDER_BY = " order by ";
    public static final String DESCENDING_ORDER = " desc";
    public static final String ASCENDING_ORDER = " asc";

    // == query strings ==
    public static final String UPDATE_QUERY = "update Bike set " + COL_BRAND + "=:" + QUERY_PARAMS_BRAND +
            ", " + COL_MODEL + "=:" + QUERY_PARAMS_MODEL+ ", " + COL_TYPE + "=:" + QUERY_PARAMS_TYPE +
            ", " + COL_DETAILS + "=:" + QUERY_PARAMS_DETAILS + ", " + COL_IMAGE_URL + "=:" + QUERY_PARAMS_IMAGE_URL +
            ", " + COL_IN_STOCK_FROM + "=:" + QUERY_PARAMS_IN_STOCK_FROM + ", " + COL_PRICE + "=:" + QUERY_PARAMS_PRICE +
            ", " + COL_QUANTITY_IN_STOCK + "=:" + QUERY_PARAMS_QUANTITY_IN_STOCK +
            " where " + COL_ID + "=:" + QUERY_PARAMS_ID;

    public static final String SHOW_ALL_BIKES_QUERY = "from Bike";
    public static final String DELETE_BIKE_QUERY = "delete from Bike where " + COL_ID + "=:";

            // search for brand, model, or type - case insensitive
    public static final String SEARCH_FOR_BIKE_QUERY = "from Bike where lower(" + COL_BRAND + ") like :" + QUERY_PARAMS_SEARCH_STRING +
            " or lower(" + COL_MODEL + ") like :" + QUERY_PARAMS_SEARCH_STRING +
            " or lower(" + COL_TYPE + ") like :" + QUERY_PARAMS_SEARCH_STRING;
    public static final String SUM_QUANTITY_OF_ALL_BIKES_QUERY = "select SUM(quantityInStock) from Bike";
    public static final String COUNT_TOTAL_VALUE_OF_BIKES_QUERY = "select sum(price * quantityInStock) from Bike";

    // == FIELDS ==
    private final SessionFactory sessionFactory;

    // == CONSTRUCTORS ==
    @Autowired
    public BikeDaoImpl (SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    // == PUBLIC METHODS ==
    @Override
    public List<Bike> getBikes () {

        // get current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        // create a query
        Query<Bike> query = currentSession.createQuery(SHOW_ALL_BIKES_QUERY, Bike.class);
        log.info("the new query is: {}", query.getQueryString());
        // execute query and get result list
        List<Bike> bikes = query.getResultList();
        log.info("bikes list is {}", bikes);

        // return the results
        return bikes;
    }

    @Override
    public boolean addBike (Bike bike) {

        // get current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        // logger logs bike with proper date - same as in datepicker
        log.info("bike to save is: {}", bike);
        // save or update bike

        // adding 1 day to date from form - temporary solution for error saving in mysql with
        // one day earlier than specified in form
        bike.setInStockFrom(bike.getInStockFrom().plusDays(1));

        // flag = true if saveOrUpdate success
        boolean success = false;
        try {
            currentSession.saveOrUpdate(bike);
            success = true;
        } catch (Exception e) {
            success = false;
        }
        return success;
    }

    @Override
    public Bike getBike (Long id) {

        // get current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        // now retrieve/read from database using the primary key
        Bike bike = currentSession.get(Bike.class, id);

        return bike;
    }

    @Override
    public boolean deleteBike (Long id) {

        // get current hiberante session
        Session currentSession = sessionFactory.getCurrentSession();

        // deleteComment object with primary key
        Query query = currentSession.createQuery(DELETE_BIKE_QUERY + QUERY_PARAMS_ID);
        query.setParameter(QUERY_PARAMS_ID, id);

        //executeUpdate will return positive int if success
        int result = query.executeUpdate();
        if (result > 0) {
            return true;
        }
        return false;
    }

    @Override
    public boolean updateBike (Bike bike) {
        // get current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        //create query - setting many params
        Query query = currentSession.createQuery(UPDATE_QUERY);
        query.setParameter(QUERY_PARAMS_BRAND, bike.getBrand());
        query.setParameter(QUERY_PARAMS_MODEL, bike.getModel());
        query.setParameter(QUERY_PARAMS_TYPE, cutCorrectType(bike.getType()));
        query.setParameter(QUERY_PARAMS_DETAILS, bike.getDetails());
        query.setParameter(QUERY_PARAMS_IMAGE_URL, bike.getImageUrl());
        query.setParameter(QUERY_PARAMS_IN_STOCK_FROM, bike.getInStockFrom().plusDays(1));
        query.setParameter(QUERY_PARAMS_PRICE, bike.getPrice());
        query.setParameter(QUERY_PARAMS_QUANTITY_IN_STOCK, bike.getQuantityInStock());
        query.setParameter(QUERY_PARAMS_ID, bike.getId());

        //executeUpdate will return positive int if success
        int result = query.executeUpdate();
        if (result > 0) {
            return true;
        }
        return false;
    }

    @Override
    public List<Bike> searchBikes (String searchString, String sortingString) {

        // get the current hibernate session
        Session session = sessionFactory.getCurrentSession();

        Query<Bike> query = null;

        // only search by brand, model, or type, if searchingString is not empty
        if(searchString != null && searchString.trim().length() > 0) {
            query = session.createQuery(SEARCH_FOR_BIKE_QUERY, Bike.class);
            if(sortingString != null && sortingString.trim().length() > 0) {
                query = createProperQuery(sortingString, query.getQueryString());
            }

            query.setParameter(QUERY_PARAMS_SEARCH_STRING, "%" + searchString + "%");
            log.info("query is {}", query.getQueryString());
        } else {
            // searchString is empty - get all bikes
            query = session.createQuery(SHOW_ALL_BIKES_QUERY, Bike.class);
            if(sortingString != null && sortingString.trim().length() > 0) {
                query = createProperQuery(sortingString, query.getQueryString());
            }
        }

        // execute query and get result list
        List<Bike> foundBikes = query.getResultList();
        return foundBikes;
    }

    @Override
    public Long sumBikes () {
        // get the current hibernate session
        Session session = sessionFactory.getCurrentSession();

        // creating proper query
        Query<Long> query = session.createQuery(SUM_QUANTITY_OF_ALL_BIKES_QUERY);
        log.info("query string = {}", query.getQueryString());

        //getting query result
        Long numBikes = query.getSingleResult();
        return numBikes;
    }

    @Override
    public Double valueOfBikes () {
        // get the current hibernate session
        Session session = sessionFactory.getCurrentSession();

        // creating proper query
        Query<Double> query = session.createQuery(COUNT_TOTAL_VALUE_OF_BIKES_QUERY);
        log.info("query string = {}", query.getQueryString());

        //getting query result
        Double result = query.getSingleResult();
        return result;
    }

    @Override
    public Long numberOfDiffBrands () {
        // get the current hibernate session
        Session session = sessionFactory.getCurrentSession();

        // creating proper query
        Query<Long> query = session.createQuery("select count(distinct brand) from Bike");
        log.info("query string = {}", query.getQueryString());

        //getting query result
        Long result = query.getSingleResult();
        return result;
    }

    // == PRIVATE METHODS ==
    // returning proper query for sortingString from dropdown
    private Query<Bike> createProperQuery (String sortingString, String queryString) {

        // get the current hibernate session
        Session session = sessionFactory.getCurrentSession();

        // creating proper query
        if(sortingString.equals(SortingStrings.BRAND_ASCENDING)) {
            return session.createQuery(queryString + ORDER_BY + COL_BRAND + ASCENDING_ORDER, Bike.class);
        } else if(sortingString.equals(SortingStrings.BRAND_DESCENDING)) {
            return session.createQuery(queryString + ORDER_BY + COL_BRAND + DESCENDING_ORDER, Bike.class);
        } else if(sortingString.equals(SortingStrings.PRICE_ASCENDING)) {
            return session.createQuery(queryString + ORDER_BY + COL_PRICE + ASCENDING_ORDER, Bike.class);
        } else if(sortingString.equals(SortingStrings.PRICE_DESCENDING)) {
            return session.createQuery(queryString + ORDER_BY + COL_PRICE + DESCENDING_ORDER, Bike.class);
        } else if(sortingString.equals(SortingStrings.QUANTITY_ASCENDING)) {
            return  session.createQuery(queryString + ORDER_BY + COL_QUANTITY_IN_STOCK + ASCENDING_ORDER, Bike.class);
        } else if(sortingString.equals(SortingStrings.QUANTITY_DESCENDING)) {
            return session.createQuery(queryString + ORDER_BY + COL_QUANTITY_IN_STOCK + DESCENDING_ORDER, Bike.class);
        } else if(sortingString.equals(SortingStrings.ADDED_ASCENDING)) {
            return session.createQuery(queryString + ORDER_BY + COL_IN_STOCK_FROM + ASCENDING_ORDER, Bike.class);
        } else if(sortingString.equals(SortingStrings.ADDED_DESCENDING)) {
            return session.createQuery(queryString + ORDER_BY + COL_IN_STOCK_FROM + DESCENDING_ORDER, Bike.class);
        } else if(sortingString.equals(SortingStrings.EMPTY)){
            return session.createQuery(queryString, Bike.class);
        } else {
            return null;
        }
    }

    // trick: cutting old bike type with coma, leaving only new type added
    private static String cutCorrectType(String typeReceived) {
        if(!typeReceived.contains(",")) {
            return typeReceived;
        } else {
            String correctType = typeReceived.substring(typeReceived.indexOf(",")+1, typeReceived.length());
            return correctType;
        }
    }
}
