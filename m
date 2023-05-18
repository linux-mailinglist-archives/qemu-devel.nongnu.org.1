Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F3B708925
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrq-0000FH-Bx; Thu, 18 May 2023 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrM-0008TY-9S
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrJ-000562-Ph
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJtGrC015740; Thu, 18 May 2023 20:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ufrc1EiRiQknUCYviW2/Maq1aR2IHBXu/paH5kqJcic=;
 b=iLsbwLoBJXMhrIWwSBh7eYlcIXmTVAAZDnyvDAKTEG8Q7OuX9WNUAN970L4/hJy62BUS
 wJ2bVrc1zvum8ckyH5gZLhMy8dA/IdIH7poeAITmWuuS0wMCH4CJe9VM4kG2vCNG7jVv
 EzD8dvq7jE5QrdEqeV4fW5rAY5KEZUE5wxPyBpyKX/z26WmkeBuEC//kn4a6mWWIdbKS
 pqFFgpBRAU/+IHjvJkanTCpI+rNmLYGs1PBG2s0UvV7Ag1KSQhAkOwOET9+euuUCsyjt
 XpTRQpuawpx1TrPtU+DlEQfYMHotRcFnxB0o6LdirlLCQDTNXlQUFQW1pCmadoSjmcPQ cQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73utj1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4ERJ001171; 
 Thu, 18 May 2023 20:04:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3qj3mn247a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:14 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4EhZ001153;
 Thu, 18 May 2023 20:04:14 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 34IK4EfP001144
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:14 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 638996CA; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 09/44] Hexagon (tests/tcg/hexagon) Add v73 scalar tests
Date: Thu, 18 May 2023 13:03:36 -0700
Message-Id: <20230518200411.271148-10-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4Sme4Vyy2j28OMOKtseoK9a2dTZI63UQ
X-Proofpoint-GUID: 4Sme4Vyy2j28OMOKtseoK9a2dTZI63UQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=tsimpson@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

VGVzdHMgYWRkZWQgZm9yIHRoZSBmb2xsb3dpbmcgaW5zdHJ1Y3Rpb25zCiAgICBKMl9jYWxscmgK
ICAgIEoyX2p1bXByaAoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1
aWNpbmMuY29tPgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KTWVz
c2FnZS1JZDogPDIwMjMwNDI3MjI0MDU3LjM3NjY5NjMtMTAtdHNpbXBzb25AcXVpY2luYy5jb20+
Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vdjczX3NjYWxhci5jICAgIHwgOTYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0IHwg
IDIgKwogMiBmaWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvdGNnL2hleGFnb24vdjczX3NjYWxhci5jCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNn
L2hleGFnb24vdjczX3NjYWxhci5jIGIvdGVzdHMvdGNnL2hleGFnb24vdjczX3NjYWxhci5jCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLmZlZTY3ZmM1MzEKLS0tIC9kZXYv
bnVsbAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi92NzNfc2NhbGFyLmMKQEAgLTAsMCArMSw5NiBA
QAorLyoKKyAqICBDb3B5cmlnaHQoYykgMjAyMyBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwg
SW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlz
aGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24g
MiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJz
aW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhh
dCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhv
dXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBG
SVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhh
dmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICog
IGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3Jn
L2xpY2Vuc2VzLz4uCisgKi8KKworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkYm9v
bC5oPgorI2luY2x1ZGUgPHN0ZGludC5oPgorCisvKgorICogIFRlc3QgdGhlIHNjYWxhciBjb3Jl
IGluc3RydWN0aW9ucyB0aGF0IGFyZSBuZXcgaW4gdjczCisgKi8KKworaW50IGVycjsKKworc3Rh
dGljIHZvaWQgX19jaGVjazMyKGludCBsaW5lLCB1aW50MzJfdCByZXN1bHQsIHVpbnQzMl90IGV4
cGVjdCkKK3sKKyAgICBpZiAocmVzdWx0ICE9IGV4cGVjdCkgeworICAgICAgICBwcmludGYoIkVS
Uk9SIGF0IGxpbmUgJWQ6IDB4JTA4eCAhPSAweCUwOHhcbiIsCisgICAgICAgICAgICAgICBsaW5l
LCByZXN1bHQsIGV4cGVjdCk7CisgICAgICAgIGVycisrOworICAgIH0KK30KKworI2RlZmluZSBj
aGVjazMyKFJFUywgRVhQKSBfX2NoZWNrMzIoX19MSU5FX18sIFJFUywgRVhQKQorCitzdGF0aWMg
dm9pZCBfX2NoZWNrNjQoaW50IGxpbmUsIHVpbnQ2NF90IHJlc3VsdCwgdWludDY0X3QgZXhwZWN0
KQoreworICAgIGlmIChyZXN1bHQgIT0gZXhwZWN0KSB7CisgICAgICAgIHByaW50ZigiRVJST1Ig
YXQgbGluZSAlZDogMHglMDE2bGx4ICE9IDB4JTAxNmxseFxuIiwKKyAgICAgICAgICAgICAgIGxp
bmUsIHJlc3VsdCwgZXhwZWN0KTsKKyAgICAgICAgZXJyKys7CisgICAgfQorfQorCisjZGVmaW5l
IGNoZWNrNjQoUkVTLCBFWFApIF9fY2hlY2s2NChfX0xJTkVfXywgUkVTLCBFWFApCisKK3N0YXRp
YyBib29sIG15X2Z1bmNfY2FsbGVkOworCitzdGF0aWMgdm9pZCBteV9mdW5jKHZvaWQpCit7Cisg
ICAgbXlfZnVuY19jYWxsZWQgPSB0cnVlOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgY2FsbHJo
KHZvaWQgKmZ1bmMpCit7CisgICAgYXNtIHZvbGF0aWxlKCJjYWxscmggJTBcblx0IgorICAgICAg
ICAgICAgICAgICA6IDogInIiKGZ1bmMpCisgICAgICAgICAgICAgICAgIC8qIE1hcmsgdGhlIGNh
bGxlci1zYXZlIHJlZ2lzdGVycyBhcyBjbG9iYmVyZWQgKi8KKyAgICAgICAgICAgICAgICAgOiAi
cjAiLCAicjEiLCAicjIiLCAicjMiLCAicjQiLCAicjUiLCAicjYiLCAicjciLCAicjgiLCAicjki
LAorICAgICAgICAgICAgICAgICAgICJyMTAiLCAicjExIiwgInIxMiIsICJyMTMiLCAicjE0Iiwg
InIxNSIsICJyMjgiLAorICAgICAgICAgICAgICAgICAgICJwMCIsICJwMSIsICJwMiIsICJwMyIp
OworfQorCitzdGF0aWMgdm9pZCB0ZXN0X2NhbGxyaCh2b2lkKQoreworICAgIG15X2Z1bmNfY2Fs
bGVkID0gZmFsc2U7CisgICAgY2FsbHJoKCZteV9mdW5jKTsKKyAgICBjaGVjazMyKG15X2Z1bmNf
Y2FsbGVkLCB0cnVlKTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9qdW1wcmgodm9pZCkKK3sKKyAg
ICB1aW50MzJfdCByZXM7CisgICAgYXNtICgiJTAgPSAjNVxuXHQiCisgICAgICAgICAicjAgPSAj
IzFmXG5cdCIKKyAgICAgICAgICJqdW1wcmggcjBcblx0IgorICAgICAgICAgIiUwID0gIzNcblx0
IgorICAgICAgICAgImp1bXAgMmZcblx0IgorICAgICAgICAgIjE6XG5cdCIKKyAgICAgICAgICIl
MCA9ICMxXG5cdCIKKyAgICAgICAgICIyOlxuXHQiCisgICAgICAgICA6ICI9ciIocmVzKSA6IDog
InIwIik7CisgICAgY2hlY2szMihyZXMsIDEpOworfQorCitpbnQgbWFpbigpCit7CisgICAgdGVz
dF9jYWxscmgoKTsKKyAgICB0ZXN0X2p1bXByaCgpOworCisgICAgcHV0cyhlcnIgPyAiRkFJTCIg
OiAiUEFTUyIpOworICAgIHJldHVybiBlcnIgPyAxIDogMDsKK30KZGlmZiAtLWdpdCBhL3Rlc3Rz
L3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCBiL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxl
LnRhcmdldAppbmRleCA1NThjMDU2MTQ4Li4zMTcyZjJlNGRiIDEwMDY0NAotLS0gYS90ZXN0cy90
Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZp
bGUudGFyZ2V0CkBAIC03OSw2ICs3OSw3IEBAIEhFWF9URVNUUyArPSB0ZXN0X3ZzcGxpY2ViCiBI
RVhfVEVTVFMgKz0gdjY4X3NjYWxhcgogSEVYX1RFU1RTICs9IHY2OF9odngKIEhFWF9URVNUUyAr
PSB2NjlfaHZ4CitIRVhfVEVTVFMgKz0gdjczX3NjYWxhcgogCiBURVNUUyArPSAkKEhFWF9URVNU
UykKIApAQCAtOTgsNiArOTksNyBAQCB2NjhfaHZ4OiB2NjhfaHZ4LmMgaHZ4X21pc2MuaCB2Nm1w
eV9yZWYuYy5pbmMKIHY2OF9odng6IENGTEFHUyArPSAtbWh2eCAtV25vLXVudXNlZC1mdW5jdGlv
bgogdjY5X2h2eDogdjY5X2h2eC5jIGh2eF9taXNjLmgKIHY2OV9odng6IENGTEFHUyArPSAtbWh2
eCAtV25vLXVudXNlZC1mdW5jdGlvbgordjczX3NjYWxhcjogQ0ZMQUdTICs9IC1Xbm8tdW51c2Vk
LWZ1bmN0aW9uCiAKIGh2eF9oaXN0b2dyYW06IGh2eF9oaXN0b2dyYW0uYyBodnhfaGlzdG9ncmFt
X3Jvdy5TCiAJJChDQykgJChDRkxBR1MpICQoQ1JPU1NfQ0NfR1VFU1RfQ0ZMQUdTKSAkXiAtbyAk
QCAkKExERkxBR1MpCi0tIAoyLjI1LjEKCg==

