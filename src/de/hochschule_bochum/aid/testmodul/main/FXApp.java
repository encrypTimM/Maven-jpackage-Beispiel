package de.hochschule_bochum.aid.testmodul.main;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

public class FXApp extends Application {

	public static void main(String[] args) {
		launch();
	}

	@Override
	public void start(Stage primaryStage) throws Exception {
		StackPane root = new StackPane();
		
		root.getChildren().add(new ImageView(new Image("duke.png")));
		
		Scene sc = new Scene(root, 800, 800);
		sc.getStylesheets().add("layout.css");
		
		primaryStage.setScene(sc);
		primaryStage.setTitle("Maven Beispiel");
		primaryStage.show();
	}
}
