from django.shortcuts import render
from django.http import HttpResponse, HttpResponseForbidden, HttpResponseNotFound, JsonResponse
import hashlib
import json

jsonString = ""
#jsonObj = ""

def robots_txt(request):
	# Block search engine indexing
	return HttpResponse("User-Agent: *\nDisallow: /", content_type="text/plain")

# GAMMA API
def echo_api(request, user_txt):
	# Demo API to output URL string
	return JsonResponse({'user_input': user_txt, 'request': request.method, 'server': request.META.get("SERVER_NAME"), 'ip': request.META.get("REMOTE_ADDR")})

def validateJSON(request):
	if request.method == 'POST' and request.META.get("SERVER_NAME") == "ai.teamgamma.ga":
		if request.POST.get("checksum", None) != None and request.POST.get("sounddata", None) != None:
			data_test = hashlib.md5(request.POST.get("sounddata", None).encode())
			if data_test == request.POST.get("checksum", None):
				# Used to send data to neural network
				jsonString = request.POST.get("sounddata", None)
				return JsonResponse({'result': 'Ok'})
			else:
				return JsonResponse({'result': 'Invalid Checksum'})
		else:
			return JsonResponse({'result': 'Invalid Request'})
	else:
		return JsonResponse({'result': 'Bad Request'})

#Send data to neural network
def postJSON():
	#Create new json file
	f = open("spectrograph.json","w+")
#convert json to string
#x = json.dumps(jsonObj)
	#convert string to json
	x = json.loads(jsonString)
	#write to file
	f.write(x)
	f.close()