package com.leszekszymaszek.dao;

import java.util.List;

import com.leszekszymaszek.entity.Bike;

public interface BikeDao {

    List<Bike> getBikes ();

    boolean addBike (Bike bike);

    Bike getBike (Long id);

    boolean deleteBike (Long id);

    boolean updateBike (Bike bike);

    List<Bike> searchBikes (String searchString, String sortingString);

    Long sumBikes ();

    Double valueOfBikes();

    Long numberOfDiffBrands ();


}
