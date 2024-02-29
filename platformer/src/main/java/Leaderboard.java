package main.java;

import processing.core.PApplet;
import processing.data.JSONObject;

class Leaderboard {
    private String domain;
    private int[] scores;
    private final PApplet parent;

    Leaderboard(String domain, PApplet parent) {
        this.domain = domain;
        this.parent = parent;
    }

    public JSONObject getScores(boolean update) {
        if (update) {
            return updateScores();
        }
        return null;
    }

    public JSONObject updateScores() {
        JSONObject jsonArray = parent.loadJSONObject(domain + "/top-ten");
        System.out.println(jsonArray);
        return jsonArray;
    }
}
