from googleapiclient.discovery import build
import pandas as pd
import os
from dotenv import load_dotenv

load_dotenv()
API_KEY=os.getenv("YOUTUBE_API_KEY")
youtube = build('youtube','v3',developerKey=API_KEY)

def get_channel_details(channel_id):
    request = youtube.channels().list(
        part='snippet, statistics',  #snippet :metadata - stats : subs,views...
        id=channel_id
    )
    response = request.execute()
    if response['items']:
        channel=response['items'][0]
        data = dict(channel_name=channel['snippet']['title'],
                    total_subscribers=channel['statistics']['subscriberCount'],
                    total_views=channel['statistics']['viewCount'],
                    total_videos=channel['statistics']['videoCount'],
        )
        return data
    else:
        return None

df = pd.read_csv("youtube_data_united-kingdom.csv")

channel_ids = df['NOMBRE'].str.split('@').str[-1].unique()

channel_stats = []
for channel_id in channel_ids:
    stats = get_channel_details(channel_id)
    if stats is not None:
        channel_stats.append(stats)

stats_df = pd.DataFrame(channel_stats)

df.reset_index(drop=True, inplace=True)
stats_df.reset_index(drop=True, inplace=True)

combined_df = pd.concat([df, stats_df], axis=1)

combined_df.to_csv('python_youtube_data_uk_updated.csv', index=False)

#combined_df.head(10)

"""
#for the 5 missing channel IDs

def search_channel_id(youtube, channel_username):
    request = youtube.search().list(
        part="snippet",
        q=channel_username,
        type="channel",
        maxResults=1
    )
    response = request.execute()

    if 'items' in response and response['items']:
        return response['items'][0]['snippet']['channelId']
    else:
        print(f"No channel found for username: {channel_username}")
        return None
invalid_channels = ["sidemen", "juliusdein", "liverpoolfc", "sirhcchris2010", "thedadlab"]
corrected_channel_ids = {}

for username in invalid_channels:
    corrected_id = search_channel_id(youtube, username)
    if corrected_id:
        corrected_channel_ids[username] = corrected_id
print(corrected_channel_ids)"""
