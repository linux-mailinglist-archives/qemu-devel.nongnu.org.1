Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD970890E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:08:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrw-0000dI-5r; Thu, 18 May 2023 16:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrg-0000Bw-NU
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrQ-000560-Ic
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJS8jY028246; Thu, 18 May 2023 20:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NnloGJl2zCpA6vPVIzVa1SNilsFair+YBU2ff/VaPKs=;
 b=UU+UKbAUesDdntO59jZYH6BFOZz9QQ6dWBvbDqoFV8440D9cYvdKiMkBSnsWe8HqtT5n
 j1GKhBx3Lt5ERCdilCVvjWR0AEYR7PL8IGEfnZGYNVyvlIbMtVodYyKhJihew7HZxXXW
 6hgIOf67JO8PpnjlWDQFbRombcMUXFdSltRtVb3HtUT77p6FaZv9sSySOH2dK+/XdzEV
 IfDFB/HrlbauNTF08gL7PFyuE4uKc0GzAqVQs6d40LATW7Y+doa+hOGJgKjijjEYChMu
 ZiFj9Im5H0A+euHad1p/kQEKCy7/mOPTohjpfRsPSinIkjvPxISIhs4RxgVSPNemejV2 IA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnfpw1r1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4E6K001161; 
 Thu, 18 May 2023 20:04:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3qj3mn2474-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:14 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4D0f001141;
 Thu, 18 May 2023 20:04:14 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 34IK4DJf001136
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:13 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 52C246A5; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 03/44] Hexagon (tests/tcg/hexagon) Add v68 scalar tests
Date: Thu, 18 May 2023 13:03:30 -0700
Message-Id: <20230518200411.271148-4-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518200411.271148-1-tsimpson@quicinc.com>
References: <20230518200411.271148-1-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: j-Fa58sZYa21FsLBuuBLFQIJh47QezPr
X-Proofpoint-GUID: j-Fa58sZYa21FsLBuuBLFQIJh47QezPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=806 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=tsimpson@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgpSZXZp
ZXdlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KTWVzc2FnZS1JZDogPDIwMjMw
NDI3MjI0MDU3LjM3NjY5NjMtNC10c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0ZXN0cy90Y2cv
aGV4YWdvbi92Njhfc2NhbGFyLmMgICAgfCAxODYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgfCAgIDIgKwogMiBmaWxlcyBj
aGFuZ2VkLCAxODggaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9o
ZXhhZ29uL3Y2OF9zY2FsYXIuYwoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL3Y2OF9z
Y2FsYXIuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Y2OF9zY2FsYXIuYwpuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwMDAwLi43YThhZGIxMTMwCi0tLSAvZGV2L251bGwKKysrIGIvdGVz
dHMvdGNnL2hleGFnb24vdjY4X3NjYWxhci5jCkBAIC0wLDAgKzEsMTg2IEBACisvKgorICogIENv
cHlyaWdodChjKSAyMDIzIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdo
dHMgUmVzZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNl
bnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICog
IFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUg
dXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBh
IGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0
aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4K
KyAqLworCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxzdGRib29sLmg+CisjaW5jbHVk
ZSA8c3RkaW50Lmg+CisKKy8qCisgKiAgVGVzdCB0aGUgc2NhbGFyIGNvcmUgaW5zdHJ1Y3Rpb25z
IHRoYXQgYXJlIG5ldyBpbiB2NjgKKyAqLworCitpbnQgZXJyOworCitzdGF0aWMgaW50IGJ1ZmZl
cjMyW10gPSB7IDEsIDIsIDMsIDQgfTsKK3N0YXRpYyBsb25nIGxvbmcgYnVmZmVyNjRbXSA9IHsg
NSwgNiwgNywgOCB9OworCitzdGF0aWMgdm9pZCBfX2NoZWNrMzIoaW50IGxpbmUsIHVpbnQzMl90
IHJlc3VsdCwgdWludDMyX3QgZXhwZWN0KQoreworICAgIGlmIChyZXN1bHQgIT0gZXhwZWN0KSB7
CisgICAgICAgIHByaW50ZigiRVJST1IgYXQgbGluZSAlZDogMHglMDh4ICE9IDB4JTA4eFxuIiwK
KyAgICAgICAgICAgICAgIGxpbmUsIHJlc3VsdCwgZXhwZWN0KTsKKyAgICAgICAgZXJyKys7Cisg
ICAgfQorfQorCisjZGVmaW5lIGNoZWNrMzIoUkVTLCBFWFApIF9fY2hlY2szMihfX0xJTkVfXywg
UkVTLCBFWFApCisKK3N0YXRpYyB2b2lkIF9fY2hlY2s2NChpbnQgbGluZSwgdWludDY0X3QgcmVz
dWx0LCB1aW50NjRfdCBleHBlY3QpCit7CisgICAgaWYgKHJlc3VsdCAhPSBleHBlY3QpIHsKKyAg
ICAgICAgcHJpbnRmKCJFUlJPUiBhdCBsaW5lICVkOiAweCUwMTZsbHggIT0gMHglMDE2bGx4XG4i
LAorICAgICAgICAgICAgICAgbGluZSwgcmVzdWx0LCBleHBlY3QpOworICAgICAgICBlcnIrKzsK
KyAgICB9Cit9CisKKyNkZWZpbmUgY2hlY2s2NChSRVMsIEVYUCkgX19jaGVjazY0KF9fTElORV9f
LCBSRVMsIEVYUCkKKworc3RhdGljIGlubGluZSBpbnQgbG9hZHdfYXEoaW50ICpwKQoreworICAg
IGludCByZXM7CisgICAgYXNtIHZvbGF0aWxlKCIlMCA9IG1lbXdfYXEoJTEpXG5cdCIKKyAgICAg
ICAgICAgICAgICAgOiAiPXIiKHJlcykgOiAiciIocCkpOworICAgIHJldHVybiByZXM7Cit9CisK
K3N0YXRpYyB2b2lkIHRlc3RfbG9hZHdfYXEodm9pZCkKK3sKKyAgICBpbnQgcmVzOworCisgICAg
cmVzID0gbG9hZHdfYXEoJmJ1ZmZlcjMyWzBdKTsKKyAgICBjaGVjazMyKHJlcywgMSk7CisgICAg
cmVzID0gbG9hZHdfYXEoJmJ1ZmZlcjMyWzFdKTsKKyAgICBjaGVjazMyKHJlcywgMik7Cit9CisK
K3N0YXRpYyBpbmxpbmUgbG9uZyBsb25nIGxvYWRkX2FxKGxvbmcgbG9uZyAqcCkKK3sKKyAgICBs
b25nIGxvbmcgcmVzOworICAgIGFzbSB2b2xhdGlsZSgiJTAgPSBtZW1kX2FxKCUxKVxuXHQiCisg
ICAgICAgICAgICAgICAgIDogIj1yIihyZXMpIDogInIiKHApKTsKKyAgICByZXR1cm4gcmVzOwor
fQorCitzdGF0aWMgdm9pZCB0ZXN0X2xvYWRkX2FxKHZvaWQpCit7CisgICAgbG9uZyBsb25nIHJl
czsKKworICAgIHJlcyA9IGxvYWRkX2FxKCZidWZmZXI2NFsyXSk7CisgICAgY2hlY2s2NChyZXMs
IDcpOworICAgIHJlcyA9IGxvYWRkX2FxKCZidWZmZXI2NFszXSk7CisgICAgY2hlY2s2NChyZXMs
IDgpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgcmVsZWFzZV9hdChpbnQgKnApCit7CisgICAg
YXNtIHZvbGF0aWxlKCJyZWxlYXNlKCUwKTphdFxuXHQiCisgICAgICAgICAgICAgICAgIDogOiAi
ciIocCkpOworfQorCitzdGF0aWMgdm9pZCB0ZXN0X3JlbGVhc2VfYXQodm9pZCkKK3sKKyAgICBy
ZWxlYXNlX2F0KCZidWZmZXIzMlsyXSk7CisgICAgY2hlY2s2NChidWZmZXIzMlsyXSwgMyk7Cisg
ICAgcmVsZWFzZV9hdCgmYnVmZmVyMzJbM10pOworICAgIGNoZWNrNjQoYnVmZmVyMzJbM10sIDQp
OworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgcmVsZWFzZV9zdChpbnQgKnApCit7CisgICAgYXNt
IHZvbGF0aWxlKCJyZWxlYXNlKCUwKTpzdFxuXHQiCisgICAgICAgICAgICAgICAgIDogOiAiciIo
cCkpOworfQorCitzdGF0aWMgdm9pZCB0ZXN0X3JlbGVhc2Vfc3Qodm9pZCkKK3sKKyAgICByZWxl
YXNlX3N0KCZidWZmZXIzMlsyXSk7CisgICAgY2hlY2s2NChidWZmZXIzMlsyXSwgMyk7CisgICAg
cmVsZWFzZV9zdCgmYnVmZmVyMzJbM10pOworICAgIGNoZWNrNjQoYnVmZmVyMzJbM10sIDQpOwor
fQorCitzdGF0aWMgaW5saW5lIHZvaWQgc3RvcmV3X3JsX2F0KGludCAqcCwgaW50IHZhbCkKK3sK
KyAgICBhc20gdm9sYXRpbGUoIm1lbXdfcmwoJTApOmF0ID0gJTFcblx0IgorICAgICAgICAgICAg
ICAgICA6IDogInIiKHApLCAiciIodmFsKSA6ICJtZW1vcnkiKTsKK30KKworc3RhdGljIHZvaWQg
dGVzdF9zdG9yZXdfcmxfYXQodm9pZCkKK3sKKyAgICBzdG9yZXdfcmxfYXQoJmJ1ZmZlcjMyWzJd
LCA5KTsKKyAgICBjaGVjazY0KGJ1ZmZlcjMyWzJdLCA5KTsKKyAgICBzdG9yZXdfcmxfYXQoJmJ1
ZmZlcjMyWzNdLCAxMCk7CisgICAgY2hlY2s2NChidWZmZXIzMlszXSwgMTApOworfQorCitzdGF0
aWMgaW5saW5lIHZvaWQgc3RvcmVkX3JsX2F0KGxvbmcgbG9uZyAqcCwgbG9uZyBsb25nIHZhbCkK
K3sKKyAgICBhc20gdm9sYXRpbGUoIm1lbWRfcmwoJTApOmF0ID0gJTFcblx0IgorICAgICAgICAg
ICAgICAgICA6IDogInIiKHApLCAiciIodmFsKSA6ICJtZW1vcnkiKTsKK30KKworc3RhdGljIHZv
aWQgdGVzdF9zdG9yZWRfcmxfYXQodm9pZCkKK3sKKyAgICBzdG9yZWRfcmxfYXQoJmJ1ZmZlcjY0
WzJdLCAxMSk7CisgICAgY2hlY2s2NChidWZmZXI2NFsyXSwgMTEpOworICAgIHN0b3JlZF9ybF9h
dCgmYnVmZmVyNjRbM10sIDEyKTsKKyAgICBjaGVjazY0KGJ1ZmZlcjY0WzNdLCAxMik7Cit9CisK
K3N0YXRpYyBpbmxpbmUgdm9pZCBzdG9yZXdfcmxfc3QoaW50ICpwLCBpbnQgdmFsKQoreworICAg
IGFzbSB2b2xhdGlsZSgibWVtd19ybCglMCk6c3QgPSAlMVxuXHQiCisgICAgICAgICAgICAgICAg
IDogOiAiciIocCksICJyIih2YWwpIDogIm1lbW9yeSIpOworfQorCitzdGF0aWMgdm9pZCB0ZXN0
X3N0b3Jld19ybF9zdCh2b2lkKQoreworICAgIHN0b3Jld19ybF9zdCgmYnVmZmVyMzJbMF0sIDEz
KTsKKyAgICBjaGVjazY0KGJ1ZmZlcjMyWzBdLCAxMyk7CisgICAgc3RvcmV3X3JsX3N0KCZidWZm
ZXIzMlsxXSwgMTQpOworICAgIGNoZWNrNjQoYnVmZmVyMzJbMV0sIDE0KTsKK30KKworc3RhdGlj
IGlubGluZSB2b2lkIHN0b3JlZF9ybF9zdChsb25nIGxvbmcgKnAsIGxvbmcgbG9uZyB2YWwpCit7
CisgICAgYXNtIHZvbGF0aWxlKCJtZW1kX3JsKCUwKTpzdCA9ICUxXG5cdCIKKyAgICAgICAgICAg
ICAgICAgOiA6ICJyIihwKSwgInIiKHZhbCkgOiAibWVtb3J5Iik7Cit9CisKK3N0YXRpYyB2b2lk
IHRlc3Rfc3RvcmVkX3JsX3N0KHZvaWQpCit7CisgICAgc3RvcmVkX3JsX3N0KCZidWZmZXI2NFsw
XSwgMTUpOworICAgIGNoZWNrNjQoYnVmZmVyNjRbMF0sIDE1KTsKKyAgICBzdG9yZWRfcmxfc3Qo
JmJ1ZmZlcjY0WzFdLCAxNSk7CisgICAgY2hlY2s2NChidWZmZXI2NFsxXSwgMTUpOworfQorCitp
bnQgbWFpbigpCit7CisgICAgdGVzdF9sb2Fkd19hcSgpOworICAgIHRlc3RfbG9hZGRfYXEoKTsK
KyAgICB0ZXN0X3JlbGVhc2VfYXQoKTsKKyAgICB0ZXN0X3JlbGVhc2Vfc3QoKTsKKyAgICB0ZXN0
X3N0b3Jld19ybF9hdCgpOworICAgIHRlc3Rfc3RvcmVkX3JsX2F0KCk7CisgICAgdGVzdF9zdG9y
ZXdfcmxfc3QoKTsKKyAgICB0ZXN0X3N0b3JlZF9ybF9zdCgpOworCisgICAgcHV0cyhlcnIgPyAi
RkFJTCIgOiAiUEFTUyIpOworICAgIHJldHVybiBlcnIgPyAxIDogMDsKK30KZGlmZiAtLWdpdCBh
L3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCBiL3Rlc3RzL3RjZy9oZXhhZ29uL01h
a2VmaWxlLnRhcmdldAppbmRleCA1OWIxYjA3NGU5Li5iNzUyOWUyM2JjIDEwMDY0NAotLS0gYS90
ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKKysrIGIvdGVzdHMvdGNnL2hleGFnb24v
TWFrZWZpbGUudGFyZ2V0CkBAIC03Niw2ICs3Niw4IEBAIEhFWF9URVNUUyArPSB0ZXN0X3ZtaW5o
CiBIRVhfVEVTVFMgKz0gdGVzdF92cG1weWgKIEhFWF9URVNUUyArPSB0ZXN0X3ZzcGxpY2ViCiAK
K0hFWF9URVNUUyArPSB2Njhfc2NhbGFyCisKIFRFU1RTICs9ICQoSEVYX1RFU1RTKQogCiAjIFRo
aXMgdGVzdCBoYXMgdG8gYmUgY29tcGlsZWQgZm9yIHRoZSAtbXY2N3QgdGFyZ2V0Ci0tIAoyLjI1
LjEKCg==

