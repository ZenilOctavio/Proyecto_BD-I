/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package Clases;

import Interfaces.Acceso;

/**
 *
 * @author Octavio
 */
public class SQL_Admi {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String url= "jdbc:postgresql://localhost:5432/educando";
                java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Acceso(url).setVisible(true);
            }
        });
    }
    
}
