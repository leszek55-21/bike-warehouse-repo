package com.leszekszymaszek.service;

import com.leszekszymaszek.dao.BikeDao;
import com.leszekszymaszek.dao.CommentDao;
import com.leszekszymaszek.entity.Bike;
import com.leszekszymaszek.entity.Comment;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

@Slf4j
@Service
public class BikeServiceImpl implements BikeService {

    // == FIELDS ==
    private final BikeDao bikeDao;
    private final CommentDao commentDao;

    // == CONSTRUCTORS ==
    @Autowired
    private BikeServiceImpl (BikeDao bikeDao, CommentDao commentDao) {
        this.bikeDao = bikeDao;
        this.commentDao = commentDao;
    }

    // == PUBLIC METHODS ==
    @Override
    @Transactional
    public List<Bike> getBikes () {
        return bikeDao.getBikes();
    }

    @Override
    @Transactional
    public boolean addBike (Bike bike) {
        return bikeDao.addBike(bike);
    }

    @Override
    @Transactional
    public Bike getBike (Long id) {
        return bikeDao.getBike(id);
    }

    @Override
    @Transactional
    public boolean deleteBike (Long id) {
         return bikeDao.deleteBike(id);
    }

    @Override
    @Transactional
    public boolean updateBike (Bike bike) {
        return bikeDao.updateBike(bike);
    }

    @Override
    @Transactional
    public List<Bike> searchBikes (String searchString, String sortingString) {
        return bikeDao.searchBikes(searchString, sortingString);
    }

    @Override
    @Transactional
    public Long sumBikes () {
        return bikeDao.sumBikes();
    }

    @Override
    @Transactional
    public Double valueOfBikes (){
        return bikeDao.valueOfBikes();
    }

    @Override
    @Transactional
    public Long numberOfDiffBrands () {
        return bikeDao.numberOfDiffBrands();
    }

    @Override
    @Transactional
    public boolean addComment(Comment comment) {
        return commentDao.addComment(comment);
    }
}
