package com.jhs.exam.exam2.http.servlet;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.jhs.exam.exam2.app.App;

@WebListener
public class InitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
    	App.start();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        
    }
}
