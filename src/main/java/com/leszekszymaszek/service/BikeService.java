package com.leszekszymaszek.service;

import java.util.List;

import com.leszekszymaszek.entity.Bike;
import com.leszekszymaszek.entity.Comment;


public interface BikeService {

	List<Bike> getBikes ();

	boolean addBike (Bike bike);

	Bike getBike (Long theId);

	boolean deleteBike (Long theId);

	boolean updateBike (Bike bike);

	List<Bike> searchBikes (String searchString, String sortingString);

	Long sumBikes();

	Double valueOfBikes();

	Long numberOfDiffBrands ();

	boolean addComment(Comment comment);
	
}
