class Leaderboard {
    private String domain;
    private JSONArray topTen;

    Leaderboard(String domain) {
        this.domain = domain;
    }

    public JSONArray getScores(boolean update) {
        if (update) {
            return updateScores();
        }
        return this.topTen;
    }

    public JSONArray updateScores() {
        JSONObject jsonArray = loadJSONObject(domain + "/top-ten");
        this.topTen = jsonArray.getJSONArray("top_ten");
        return topTen;
    }
}
