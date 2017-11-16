package com.spring.dao.dao_impl;

import com.spring.dao.AuditoriumDao;
import com.spring.domain.Auditorium;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Repository;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

@Repository
public class FileAuditoriumDaoImpl implements AuditoriumDao {

    private ServletContext servletContext;


    private String pathName;

    @Autowired
    public FileAuditoriumDaoImpl( @Value("/auditoriums") String pathName, ServletContext servletContext) {
        this.pathName = pathName;
        this.servletContext = servletContext;
    }

//    @PostConstruct
//    public void init() throws IOException { //todo
//        File folder = new File(pathName);
//        if (!folder.exists())
//            throw new IOException("folder with auditoriums info does not exist");
//        if (!folder.canRead())
//            throw new IOException("folder with auditoriums info cannot be read");
//        if (!folder.isDirectory())
//            throw new IOException("folder with auditoriums info should be a directory, not a file");
//    }

    @Override
    public Set<Auditorium> findAll() {

        System.out.println("begin findAll() function");
        String folderPath = servletContext.getRealPath("WEB-INF/classes/" + pathName);


        Set<Auditorium> auditoriums = new HashSet<>();
        File folder = new File(folderPath);

        if (folder.listFiles() == null) {
            System.out.println("listFiles is null");
            System.out.println(folder.getName());
            System.out.println(folder.exists());
            System.out.println(folder.getAbsolutePath());
            System.out.println(folder.getAbsoluteFile());
            System.out.println(folder.isDirectory());
        }

        Properties prop;
        for (File file : folder.listFiles()) {
            prop = new Properties();
            try (InputStream is = new FileInputStream(file)) {
                prop.load(is);
                Auditorium auditorium = new Auditorium();
                auditorium.setName(prop.getProperty("name"));
                auditorium.setNumberOfSeats(Integer.parseInt(prop.getProperty("numberOfSeats")));

                String[] tempRes = prop.getProperty("vipSeats").split(",");
                Set<Long> vipSeats = new HashSet<>();
                for (String s : tempRes) {
                    Long vipSeat = Long.parseLong(s);
                    vipSeats.add(vipSeat);
                }
                auditorium.setVipSeats(vipSeats);
                auditoriums.add(auditorium);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return auditoriums;
    }

    @Override
    public Auditorium findByName(String name) {

        for (Auditorium auditorium : findAll()) {
            if (name.equals(auditorium.getName()))
                return auditorium;
        }
        return null;
    }

}
