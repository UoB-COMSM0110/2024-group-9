import java.io.*;
import java.net.*;

int MAX_RETRIES = 5;
int CONNECT_TIMEOUT = 1500;
int READ_TIMEOUT = 1500;

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
    int retries = 0;
    JSONArray topTen = new JSONArray();

    // Try and retrieve leaderboard JSON 5 times
    while (retries < MAX_RETRIES) {
        HttpURLConnection connection = null;
        try {
            URL url = new URL(domain + "/top-ten");
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(CONNECT_TIMEOUT);
            connection.setReadTimeout(READ_TIMEOUT);

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                // Create JSONArray object from retrieved JSON
                JSONObject jsonResponse = parseJSONObject(response.toString());
                topTen = jsonResponse.getJSONArray("top_ten");
                break;
            } else {
                System.out.println("HTTP request failed with response code: " + responseCode);
            }
        } catch (SocketTimeoutException e) {
            System.out.println("Connection timed out. Retrying...");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
        retries++;
    }
    if (topTen.size() == 0) {
      println("Unable to update leaderboard");
    }
    return topTen;
}
}
