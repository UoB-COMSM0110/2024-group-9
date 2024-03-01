package main.java;

import processing.core.PApplet;
import processing.data.JSONArray;
import processing.data.JSONObject;

class Leaderboard {
    private String domain;
    private JSONArray topTen;
    private final PApplet parent;

    Leaderboard(String domain, PApplet parent) {
        this.domain = domain;
        this.parent = parent;
    }

    public JSONArray getScores(boolean update) {
        if (update) {
            return updateScores();
        }
        return this.topTen;
    }

    public JSONArray updateScores() {
        JSONObject jsonArray = parent.loadJSONObject(domain + "/top-ten");
        this.topTen = jsonArray.getJSONArray("top_ten");
        return topTen;
    }
}
