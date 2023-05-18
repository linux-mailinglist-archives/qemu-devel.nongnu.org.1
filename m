Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F5070891F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjuA-0002cC-UW; Thu, 18 May 2023 16:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjri-0000Ds-Bp
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrR-000572-56
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IGrLE7029198; Thu, 18 May 2023 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0q5fsoMJepICtdXhmCO6hNSDv/0bVV7f4P9ITRJKWA4=;
 b=g4wc9DSUD6ZgsODjpL+iYRuToCs/DRdgpwVRDq6d/U0I08LloqjDzPj6gEEVxTMWaJQG
 2a9UqS8qJSZPWc0ewKIPnPrqTHnZpSvzPQ4+IxuiQ/NyOdNhUoTK5NRAH63zH1Q3sgLV
 08SFdi2WfKUa/jLox30fIf5UCbMeFAK+gj5lRIxNHmUB0Q7gBBhfJfJkBXNy29BzmZ1x
 F/wxBKBvhp8GtVejLdYuzg4ZL80yfHjzwZBKcpw0+V6QfAwPnA6Mo8UibhuoYw1NZ00y
 HKjnyti+y6jQIQVLJ3KxuCd96P7z+ptergstFfFRp36fsSasWvRycTIC4niHdt6MIaU7 yQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73utj1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4Gh8013713; 
 Thu, 18 May 2023 20:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qmrx7jyxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4FEJ013668;
 Thu, 18 May 2023 20:04:15 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34IK4Fmu013633
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 856176D6; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 21/44] Hexagon (target/hexagon) Short-circuit packet
 predicate writes
Date: Thu, 18 May 2023 13:03:48 -0700
Message-Id: <20230518200411.271148-22-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: uBNHBI570DBjce_9LYOYgLRKK4ji8KVu
X-Proofpoint-GUID: uBNHBI570DBjce_9LYOYgLRKK4ji8KVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=815 malwarescore=0
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

SW4gY2VydGFpbiBjYXNlcywgd2UgY2FuIGF2b2lkIHRoZSBvdmVyaGVhZCBvZiB3cml0aW5nIHRv
IGhleF9uZXdfcHJlZF92YWx1ZQphbmQgd3JpdGUgZGlyZWN0bHkgdG8gaGV4X3ByZWQuICBXZSBj
b25zaWRlciBwcmVkaWNhdGUgcmVhZHMvd3JpdGVzIHdoZW4KY29tcHV0aW5nIGN0eC0+bmVlZF9j
b21taXQuICBUaGUgZ2V0X3Jlc3VsdF9wcmVkKCkgZnVuY3Rpb24gdXNlcyB0aGlzCmZpZWxkIHRv
IGRlY2lkZSBiZXR3ZWVuIGhleF9uZXdfcHJlZF92YWx1ZSBhbmQgaGV4X3ByZWQuICBUaGVuLCB3
ZSBjYW4KZWFybHktZXhpdCBmcm9tIGdlbl9wcmVkX3dyaXRlcy4KClNpZ25lZC1vZmYtYnk6IFRh
eWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpNZXNzYWdlLUlkOiA8MjAy
MzA0MjcyMzAwMTIuMzgwMDMyNy0xMy10c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5wdHIuaCAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgIHwg
MTUgKysrKysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDE0ICsrKysr
KysrKysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmggYi90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuaAppbmRleCA0MjA4NjdmOTM0Li5lMTFjY2MyMzU4IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuaApAQCAtMzUs
NiArMzUsNyBAQCB2b2lkIGdlbl9zdG9yZTRpKFRDR3ZfZW52IGNwdV9lbnYsIFRDR3YgdmFkZHIs
IGludDMyX3Qgc3JjLCB1aW50MzJfdCBzbG90KTsKIHZvaWQgZ2VuX3N0b3JlOGkoVENHdl9lbnYg
Y3B1X2VudiwgVENHdiB2YWRkciwgaW50NjRfdCBzcmMsIHVpbnQzMl90IHNsb3QpOwogVENHdiBn
ZW5fcmVhZF9yZWcoVENHdiByZXN1bHQsIGludCBudW0pOwogVENHdiBnZW5fcmVhZF9wcmVnKFRD
R3YgcHJlZCwgdWludDhfdCBudW0pOworVENHdiBnZXRfcmVzdWx0X3ByZWQoRGlzYXNDb250ZXh0
ICpjdHgsIGludCBwbnVtKTsKIHZvaWQgZ2VuX2xvZ19yZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpj
dHgsIGludCBybnVtLCBUQ0d2IHZhbCk7CiB2b2lkIGdlbl9sb2dfcHJlZF93cml0ZShEaXNhc0Nv
bnRleHQgKmN0eCwgaW50IHBudW0sIFRDR3YgdmFsKTsKIHZvaWQgZ2VuX3NldF91c3JfZmllbGQo
RGlzYXNDb250ZXh0ICpjdHgsIGludCBmaWVsZCwgVENHdiB2YWwpOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwppbmRleCA5ODU4
ZDdiYzM1Li41MDI1ZTE3MmNmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtMTEwLDggKzExMCwxOCBAQCBzdGF0aWMg
dm9pZCBnZW5fbG9nX3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwg
VENHdl9pNjQgdmFsKQogICAgIGdlbl9sb2dfcmVnX3dyaXRlKGN0eCwgcm51bSArIDEsIHZhbDMy
KTsKIH0KIAorVENHdiBnZXRfcmVzdWx0X3ByZWQoRGlzYXNDb250ZXh0ICpjdHgsIGludCBwbnVt
KQoreworICAgIGlmIChjdHgtPm5lZWRfY29tbWl0KSB7CisgICAgICAgIHJldHVybiBoZXhfbmV3
X3ByZWRfdmFsdWVbcG51bV07CisgICAgfSBlbHNlIHsKKyAgICAgICAgcmV0dXJuIGhleF9wcmVk
W3BudW1dOworICAgIH0KK30KKwogdm9pZCBnZW5fbG9nX3ByZWRfd3JpdGUoRGlzYXNDb250ZXh0
ICpjdHgsIGludCBwbnVtLCBUQ0d2IHZhbCkKIHsKKyAgICBUQ0d2IHByZWQgPSBnZXRfcmVzdWx0
X3ByZWQoY3R4LCBwbnVtKTsKICAgICBUQ0d2IGJhc2VfdmFsID0gdGNnX3RlbXBfbmV3KCk7CiAK
ICAgICB0Y2dfZ2VuX2FuZGlfdGwoYmFzZV92YWwsIHZhbCwgMHhmZik7CkBAIC0xMjQsMTAgKzEz
NCw5IEBAIHZvaWQgZ2VuX2xvZ19wcmVkX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcG51
bSwgVENHdiB2YWwpCiAgICAgICogc3RyYWlnaHQgYXNzaWdubWVudC4gIE90aGVyd2lzZSwgZG8g
YW4gYW5kLgogICAgICAqLwogICAgIGlmICghdGVzdF9iaXQocG51bSwgY3R4LT5wcmVnc193cml0
dGVuKSkgewotICAgICAgICB0Y2dfZ2VuX21vdl90bChoZXhfbmV3X3ByZWRfdmFsdWVbcG51bV0s
IGJhc2VfdmFsKTsKKyAgICAgICAgdGNnX2dlbl9tb3ZfdGwocHJlZCwgYmFzZV92YWwpOwogICAg
IH0gZWxzZSB7Ci0gICAgICAgIHRjZ19nZW5fYW5kX3RsKGhleF9uZXdfcHJlZF92YWx1ZVtwbnVt
XSwKLSAgICAgICAgICAgICAgICAgICAgICAgaGV4X25ld19wcmVkX3ZhbHVlW3BudW1dLCBiYXNl
X3ZhbCk7CisgICAgICAgIHRjZ19nZW5fYW5kX3RsKHByZWQsIHByZWQsIGJhc2VfdmFsKTsKICAg
ICB9CiAgICAgaWYgKEhFWF9ERUJVRykgewogICAgICAgICB0Y2dfZ2VuX29yaV90bChoZXhfcHJl
ZF93cml0dGVuLCBoZXhfcHJlZF93cml0dGVuLCAxIDw8IHBudW0pOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRl
eCA2ZmE4ODVjZjE2Li5iY2Y2NGY3MjVhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMzg2LDYgKzM4Niwx
NCBAQCBzdGF0aWMgYm9vbCBuZWVkX2NvbW1pdChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAg
fQogICAgIH0KIAorICAgIC8qIENoZWNrIGZvciBvdmVybGFwIGJldHdlZW4gcHJlZGljYXRlIHJl
YWRzIGFuZCB3cml0ZXMgKi8KKyAgICBmb3IgKGludCBpID0gMDsgaSA8IGN0eC0+cHJlZ19sb2df
aWR4OyBpKyspIHsKKyAgICAgICAgaW50IHBudW0gPSBjdHgtPnByZWdfbG9nW2ldOworICAgICAg
ICBpZiAodGVzdF9iaXQocG51bSwgY3R4LT5wcmVnc19yZWFkKSkgeworICAgICAgICAgICAgcmV0
dXJuIHRydWU7CisgICAgICAgIH0KKyAgICB9CisKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKQEAg
LTUwMyw3ICs1MTEsNyBAQCBzdGF0aWMgdm9pZCBnZW5fc3RhcnRfcGFja2V0KERpc2FzQ29udGV4
dCAqY3R4KQogICAgICAqIFByZWxvYWQgdGhlIHByZWRpY2F0ZWQgcHJlZCByZWdpc3RlcnMgaW50
byBoZXhfbmV3X3ByZWRfdmFsdWVbcHJlZF9udW1dCiAgICAgICogT25seSBlbmRsb29wIGluc3Ry
dWN0aW9ucyBjb25kaXRpb25hbGx5IHdyaXRlIHRvIHByZWQgcmVnaXN0ZXJzCiAgICAgICovCi0g
ICAgaWYgKHBrdC0+cGt0X2hhc19lbmRsb29wKSB7CisgICAgaWYgKGN0eC0+bmVlZF9jb21taXQg
JiYgcGt0LT5wa3RfaGFzX2VuZGxvb3ApIHsKICAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBj
dHgtPnByZWdfbG9nX2lkeDsgaSsrKSB7CiAgICAgICAgICAgICBpbnQgcHJlZF9udW0gPSBjdHgt
PnByZWdfbG9nW2ldOwogICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoaGV4X25ld19wcmVkX3Zh
bHVlW3ByZWRfbnVtXSwgaGV4X3ByZWRbcHJlZF9udW1dKTsKQEAgLTYyMiw4ICs2MzAsOCBAQCBz
dGF0aWMgdm9pZCBnZW5fcmVnX3dyaXRlcyhEaXNhc0NvbnRleHQgKmN0eCkKIAogc3RhdGljIHZv
aWQgZ2VuX3ByZWRfd3JpdGVzKERpc2FzQ29udGV4dCAqY3R4KQogewotICAgIC8qIEVhcmx5IGV4
aXQgaWYgdGhlIGxvZyBpcyBlbXB0eSAqLwotICAgIGlmICghY3R4LT5wcmVnX2xvZ19pZHgpIHsK
KyAgICAvKiBFYXJseSBleGl0IGlmIG5vdCBuZWVkZWQgb3IgdGhlIGxvZyBpcyBlbXB0eSAqLwor
ICAgIGlmICghY3R4LT5uZWVkX2NvbW1pdCB8fCAhY3R4LT5wcmVnX2xvZ19pZHgpIHsKICAgICAg
ICAgcmV0dXJuOwogICAgIH0KIAotLSAKMi4yNS4xCgo=

