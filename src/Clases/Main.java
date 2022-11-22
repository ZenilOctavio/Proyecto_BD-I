/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Clases;

import Interfaces.Acceso;

/**
 *
 * @author Octavio
 */
public class Main {
    public static void main(String[] args) {
        String url= "jdbc:postgresql://localhost:5432/educando";
        Acceso acceso = new Acceso(url);
    }
}
