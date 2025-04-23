import json
from flask import jsonify, Blueprint, request

import os


main_url = "/api"
news = "/news"
news_file = r"C:\Users\ersin\Desktop\backend\news3.json"

analyst = "/analyst"
analyst_file = r"C:\Users\ersin\Desktop\backend\static\all_analyst_advice.json"
analyst_file = r"C:\Users\ersin\Desktop\backend\analyst.json"

news_detail = "/news-detail"
analyst_detail = "/analyst-detail"
news_detail_file = r"C:\Users\ersin\Desktop\backend\news2.json"

apiBilgi = Blueprint("apiBilgi", __name__, url_prefix=main_url)


klasor_yolu = "static/haberler"

@apiBilgi.route('/news', methods=["POST"])
def news_route():
    page = request.args.get("page")
    print(page)
    if page == None:
        page = 1
    # with open(news_file, "r", encoding="utf-8") as file:
    #     data = json.load(file) 
    # return data
    data = {"news": []}
    dosyalar = [entry.name for entry in os.scandir(klasor_yolu) if entry.is_file()]
    if int(page) <= len(dosyalar) / 10 + 1:
        first = (int(page) - 1) * 10
        last = int(page) * 10
        for dosya in dosyalar[first:last]:
            with open("static/haberler/" + dosya, "r", encoding="utf-8") as file:
                ic = json.load(file)
            
            data["news"].append({
                "stock_symbol": dosya.split("-")[1].split(".")[0],
                "analysis_date": "Analiz Tarihi (örn: 2025-03-07)",
                "input_source": {
                    "type": "Veri Türü (örn: cap_report, youtube_video, tweets)",
                    "details": {
                        "source_identifier": "Kaynak Tanımlayıcı (örn: dosya adı, video linki, tweet sayısı)",
                        "keywords": ["Anahtar Kelime 1", "Anahtar Kelime 2"],
                        "sample_content": ["Örnek İçerik 1", "Örnek İçerik 2"]
                    }
                },
                **ic,  
                "metrics": {
                    "confidence_level": "Analiz Güvenilirlik Seviyesi (0-100 arası)",
                    "data_volume": "Veri Miktarı (örn: 1 video, 50 tweet)"
                }
            })
        data["before"] = str(int(page) - 1)
        data["after"] = str(int(page) + 1)
            
    # with open("kontro.json", "w", encoding="utf-8") as file:
    #     json.dump(data, file, ensure_ascii=False, indent=4)
    return data



# @apiBilgi.route(analyst, methods=["POST"])
# def analyst_route():
#     with open(analyst_file, "r", encoding="utf-8") as file:
#         data = json.load(file) 
#     print(data)
#     return data

@apiBilgi.route(analyst, methods=["POST"])
def analyst_route():
    page = request.args.get("page")
    print(page)
    if page == None:
        page = 1
    
    with open(analyst_file, "r", encoding="utf-8") as file:
        data = json.load(file) 
        
    response = {"info": {}}
        
    # print(len(data["info"]))
    if int(page) < len(data["info"]):
        first = (int(page) - 1) * 10
        last = int(page) * 10
        response["info"] = data["info"][first:last]
        
    response["before"] = str(int(page) - 1)
    response["after"] = str(int(page) + 1)
    
    
    return response

@apiBilgi.route(news_detail, methods=["POST"])
def news_detail_route():
    name = request.args.get("name")
    if name == None:
        return None
    
    dosyalar = [entry.name for entry in os.scandir(klasor_yolu) if entry.is_file()]
 
    name = name.upper()
    if "1-" + name + ".json" in dosyalar:
        with open("static/haberler/" + "1-" + name + ".json", "r", encoding="utf-8") as file:
            ic = json.load(file)
        
            data = {
                "stock_symbol": name,
                "analysis_date": "Analiz Tarihi (örn: 2025-03-07)",
                "input_source": {
                    "type": "Veri Türü (örn: cap_report, youtube_video, tweets)",
                    "details": {
                        "source_identifier": "Kaynak Tanımlayıcı (örn: dosya adı, video linki, tweet sayısı)",
                        "keywords": ["Anahtar Kelime 1", "Anahtar Kelime 2"],
                        "sample_content": ["Örnek İçerik 1", "Örnek İçerik 2"]
                    }
                },
                **ic,  
                "metrics": {
                    "confidence_level": "Analiz Güvenilirlik Seviyesi (0-100 arası)",
                    "data_volume": "Veri Miktarı (örn: 1 video, 50 tweet)"
                }
            }
        
    else:
        return None
    return data


@apiBilgi.route(analyst_detail, methods=["POST"])
def analyst_detail_route():
    name = request.args.get("name")
    print(name)
    if name == None:
        return None
    
    with open(analyst_file, "r", encoding="utf-8") as file:
        data = json.load(file) 
        
    response = {"info": {}}
    for d in data["info"]:
        if d["name"] == name:
            response["info"] = [d]
        
        
    
        
    response["before"] = str(0)
    response["after"] = str(0)
    return response


@apiBilgi.route('/favourites', methods=["POST"])
def favourites_route():
    name = request.args.get("name")
    print(name)
    if name == None:
        return None
    
    dosyalar = [entry.name for entry in os.scandir(klasor_yolu) if entry.is_file()]
    data = {"news": []}
    name = name.upper()
    if "1-" + name + ".json" in dosyalar:
        print(name)
        with open("static/haberler/" + "1-" + name + ".json", "r", encoding="utf-8") as file:
            ic = json.load(file)
        
            data["news"].append({
                "stock_symbol": name,
                "analysis_date": "Analiz Tarihi (örn: 2025-03-07)",
                "input_source": {
                    "type": "Veri Türü (örn: cap_report, youtube_video, tweets)",
                    "details": {
                        "source_identifier": "Kaynak Tanımlayıcı (örn: dosya adı, video linki, tweet sayısı)",
                        "keywords": ["Anahtar Kelime 1", "Anahtar Kelime 2"],
                        "sample_content": ["Örnek İçerik 1", "Örnek İçerik 2"]
                    }
                },
                **ic,  
                "metrics": {
                    "confidence_level": "Analiz Güvenilirlik Seviyesi (0-100 arası)",
                    "data_volume": "Veri Miktarı (örn: 1 video, 50 tweet)"
                }
            })
        data["before"] = str(0)
        data["after"] = str(0)
        
    else:
        return None
            
    # with open("kontro.json", "w", encoding="utf-8") as file:
    #     json.dump(data, file, ensure_ascii=False, indent=4)
    return data
