Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F1270892A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrq-0000Cz-CN; Thu, 18 May 2023 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrK-0008SM-Ha
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrH-00056T-5M
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IFlJ43020112; Thu, 18 May 2023 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a1LQmwTZEKxIondKm+qmkw85veeRdn7UeAjAtkvhWY8=;
 b=Dh93VNKtT9y9B3VQ02rEm3q/47OiTNQeWd59V4UCJ4GPVmAa7IVGt7AFJktS9kCbZiDY
 NtdPfDqfyZtSeCivM+fEK1ZjPMh6DkIXiB15viFypwfwAljkB+lvvR2bfO9sCl6VqUit
 QdV73ryxjseHGz4KRjrKj7dlNMtVv6fLjlVUIGr7mAOOuiPB51JnZ5E4IV92aN7syA5Y
 +Ctu1g8bkLpz8ltsw2m/fTbyyg/gkVVd/Dpo+QLx0NNP9rF1P+OMHCUf9ak/qgBKVinV
 oq1deXQvi5/sb1Ay+S6XK2DL9K24tsgJfvtT8cVUROGGSE6LCU5kSEBzmTrpnR0ARLD2 Kg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qncbht1y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4Foc001216; 
 Thu, 18 May 2023 20:04:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3qj3mn247t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK1rTo030036;
 Thu, 18 May 2023 20:04:15 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 34IK4Enk001162
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 7A9396D2; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 17/44] Hexagon (target/hexagon) Clean up pred_written usage
Date: Thu, 18 May 2023 13:03:44 -0700
Message-Id: <20230518200411.271148-18-tsimpson@quicinc.com>
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
X-Proofpoint-GUID: DYMGy_NcDoVTEeTvWNMSM_d4jx8ivIdx
X-Proofpoint-ORIG-GUID: DYMGy_NcDoVTEeTvWNMSM_d4jx8ivIdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=393 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305180165
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

T25seSBlbmRsb29wIGluc3RydWN0aW9ucyB3aWxsIGNvbmRpdGlvbmFsbHkgd3JpdGUgdG8gYSBw
cmVkaWNhdGUuCldoZW4gdGhlcmUgaXMgYW4gZW5kbG9vcCBpbnN0cnVjdGlvbiwgd2UgcHJlbG9h
ZCB0aGUgdmFsdWVzIGludG8KbmV3X3ByZWRfdmFsdWUuCgpUaGUgb25seSBwbGFjZSBwcmVkX3dy
aXR0ZW4gaXMgbmVlZGVkIGlzIHdoZW4gSEVYX0RFQlVHIGlzIG9uLgoKV2UgcmVtb3ZlIHRoZSBs
YXN0IHVzZSBvZiBjaGVja19mb3JfYXR0cmliLiAgSG93ZXZlciwgbmV3IHVzZXMgd2lsbCBiZQpp
bnRyb2R1Y2VkIGxhdGVyIGluIHRoaXMgc2VyaWVzLCBzbyB3ZSBtYXJrIGl0IHdpdGggR19HTlVD
X1VOVVNFRC4KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBs
aW5hcm8ub3JnPgpNZXNzYWdlLUlkOiA8MjAyMzA0MjcyMzAwMTIuMzgwMDMyNy05LXRzaW1wc29u
QHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgIHwgMTYgKysrKyst
LS0tLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDUzICsrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyks
IDQ2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jIGIv
dGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKaW5kZXggZGFjNjJiOTBhNi4uOWJiYWNhNjMwMCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
cHRyLmMKQEAgLTEzNyw3ICsxMzcsOSBAQCB2b2lkIGdlbl9sb2dfcHJlZF93cml0ZShEaXNhc0Nv
bnRleHQgKmN0eCwgaW50IHBudW0sIFRDR3YgdmFsKQogICAgICAgICB0Y2dfZ2VuX2FuZF90bCho
ZXhfbmV3X3ByZWRfdmFsdWVbcG51bV0sCiAgICAgICAgICAgICAgICAgICAgICAgIGhleF9uZXdf
cHJlZF92YWx1ZVtwbnVtXSwgYmFzZV92YWwpOwogICAgIH0KLSAgICB0Y2dfZ2VuX29yaV90bCho
ZXhfcHJlZF93cml0dGVuLCBoZXhfcHJlZF93cml0dGVuLCAxIDw8IHBudW0pOworICAgIGlmIChI
RVhfREVCVUcpIHsKKyAgICAgICAgdGNnX2dlbl9vcmlfdGwoaGV4X3ByZWRfd3JpdHRlbiwgaGV4
X3ByZWRfd3JpdHRlbiwgMSA8PCBwbnVtKTsKKyAgICB9CiAgICAgc2V0X2JpdChwbnVtLCBjdHgt
PnByZWdzX3dyaXR0ZW4pOwogfQogCkBAIC04MjYsMTUgKzgyOCwxMyBAQCBzdGF0aWMgdm9pZCBn
ZW5fZW5kbG9vcDAoRGlzYXNDb250ZXh0ICpjdHgpCiAKICAgICAvKgogICAgICAqICAgIGlmIChs
cGNmZyA9PSAxKSB7Ci0gICAgICogICAgICAgIGhleF9uZXdfcHJlZF92YWx1ZVszXSA9IDB4ZmY7
Ci0gICAgICogICAgICAgIGhleF9wcmVkX3dyaXR0ZW4gfD0gMSA8PCAzOworICAgICAqICAgICAg
ICBwMyA9IDB4ZmY7CiAgICAgICogICAgfQogICAgICAqLwogICAgIFRDR0xhYmVsICpsYWJlbDEg
PSBnZW5fbmV3X2xhYmVsKCk7CiAgICAgdGNnX2dlbl9icmNvbmRpX3RsKFRDR19DT05EX05FLCBs
cGNmZywgMSwgbGFiZWwxKTsKICAgICB7Ci0gICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfbmV3
X3ByZWRfdmFsdWVbM10sIDB4ZmYpOwotICAgICAgICB0Y2dfZ2VuX29yaV90bChoZXhfcHJlZF93
cml0dGVuLCBoZXhfcHJlZF93cml0dGVuLCAxIDw8IDMpOworICAgICAgICBnZW5fbG9nX3ByZWRf
d3JpdGUoY3R4LCAzLCB0Y2dfY29uc3RhbnRfdGwoMHhmZikpOwogICAgIH0KICAgICBnZW5fc2V0
X2xhYmVsKGxhYmVsMSk7CiAKQEAgLTkwMywxNCArOTAzLDEyIEBAIHN0YXRpYyB2b2lkIGdlbl9l
bmRsb29wMDEoRGlzYXNDb250ZXh0ICpjdHgpCiAKICAgICAvKgogICAgICAqICAgIGlmIChscGNm
ZyA9PSAxKSB7Ci0gICAgICogICAgICAgIGhleF9uZXdfcHJlZF92YWx1ZVszXSA9IDB4ZmY7Ci0g
ICAgICogICAgICAgIGhleF9wcmVkX3dyaXR0ZW4gfD0gMSA8PCAzOworICAgICAqICAgICAgICBw
MyA9IDB4ZmY7CiAgICAgICogICAgfQogICAgICAqLwogICAgIHRjZ19nZW5fYnJjb25kaV90bChU
Q0dfQ09ORF9ORSwgbHBjZmcsIDEsIGxhYmVsMSk7CiAgICAgewotICAgICAgICB0Y2dfZ2VuX21v
dmlfdGwoaGV4X25ld19wcmVkX3ZhbHVlWzNdLCAweGZmKTsKLSAgICAgICAgdGNnX2dlbl9vcmlf
dGwoaGV4X3ByZWRfd3JpdHRlbiwgaGV4X3ByZWRfd3JpdHRlbiwgMSA8PCAzKTsKKyAgICAgICAg
Z2VuX2xvZ19wcmVkX3dyaXRlKGN0eCwgMywgdGNnX2NvbnN0YW50X3RsKDB4ZmYpKTsKICAgICB9
CiAgICAgZ2VuX3NldF9sYWJlbChsYWJlbDEpOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDAxZjQ0OGEz
MjUuLjBiMDIxYjMwMWEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0yMzksNyArMjM5LDcgQEAgc3RhdGlj
IGludCByZWFkX3BhY2tldF93b3JkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0
ICpjdHgsCiAgICAgcmV0dXJuIG53b3JkczsKIH0KIAotc3RhdGljIGJvb2wgY2hlY2tfZm9yX2F0
dHJpYihQYWNrZXQgKnBrdCwgaW50IGF0dHJpYikKK3N0YXRpYyBHX0dOVUNfVU5VU0VEIGJvb2wg
Y2hlY2tfZm9yX2F0dHJpYihQYWNrZXQgKnBrdCwgaW50IGF0dHJpYikKIHsKICAgICBmb3IgKGlu
dCBpID0gMDsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKICAgICAgICAgaWYgKEdFVF9BVFRS
SUIocGt0LT5pbnNuW2ldLm9wY29kZSwgYXR0cmliKSkgewpAQCAtMjYyLDExICsyNjIsNiBAQCBz
dGF0aWMgYm9vbCBuZWVkX3Nsb3RfY2FuY2VsbGVkKFBhY2tldCAqcGt0KQogICAgIHJldHVybiBm
YWxzZTsKIH0KIAotc3RhdGljIGJvb2wgbmVlZF9wcmVkX3dyaXR0ZW4oUGFja2V0ICpwa3QpCi17
Ci0gICAgcmV0dXJuIGNoZWNrX2Zvcl9hdHRyaWIocGt0LCBBX1dSSVRFU19QUkVEX1JFRyk7Ci19
Ci0KIHN0YXRpYyBib29sIG5lZWRfbmV4dF9QQyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBQ
YWNrZXQgKnBrdCA9IGN0eC0+cGt0OwpAQCAtNDE0LDcgKzQwOSw3IEBAIHN0YXRpYyB2b2lkIGdl
bl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAgICB0Y2dfZ2VuX21v
dmlfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgbmV4dF9QQyk7CiAgICAgICAgIH0KICAgICB9Ci0g
ICAgaWYgKG5lZWRfcHJlZF93cml0dGVuKHBrdCkpIHsKKyAgICBpZiAoSEVYX0RFQlVHKSB7CiAg
ICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfcHJlZF93cml0dGVuLCAwKTsKICAgICB9CiAKQEAg
LTQyOCw2ICs0MjMsMTcgQEAgc3RhdGljIHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRl
eHQgKmN0eCkKICAgICAgICAgfQogICAgIH0KIAorICAgIC8qCisgICAgICogUHJlbG9hZCB0aGUg
cHJlZGljYXRlZCBwcmVkIHJlZ2lzdGVycyBpbnRvIGhleF9uZXdfcHJlZF92YWx1ZVtwcmVkX251
bV0KKyAgICAgKiBPbmx5IGVuZGxvb3AgaW5zdHJ1Y3Rpb25zIGNvbmRpdGlvbmFsbHkgd3JpdGUg
dG8gcHJlZCByZWdpc3RlcnMKKyAgICAgKi8KKyAgICBpZiAocGt0LT5wa3RfaGFzX2VuZGxvb3Ap
IHsKKyAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBjdHgtPnByZWdfbG9nX2lkeDsgaSsrKSB7
CisgICAgICAgICAgICBpbnQgcHJlZF9udW0gPSBjdHgtPnByZWdfbG9nW2ldOworICAgICAgICAg
ICAgdGNnX2dlbl9tb3ZfdGwoaGV4X25ld19wcmVkX3ZhbHVlW3ByZWRfbnVtXSwgaGV4X3ByZWRb
cHJlZF9udW1dKTsKKyAgICAgICAgfQorICAgIH0KKwogICAgIC8qIFByZWxvYWQgdGhlIHByZWRp
Y2F0ZWQgSFZYIHJlZ2lzdGVycyBpbnRvIGZ1dHVyZV9WUmVncyBhbmQgdG1wX1ZSZWdzICovCiAg
ICAgaWYgKCFiaXRtYXBfZW1wdHkoY3R4LT5wcmVkaWNhdGVkX2Z1dHVyZV92cmVncywgTlVNX1ZS
RUdTKSkgewogICAgICAgICBpbnQgaSA9IGZpbmRfZmlyc3RfYml0KGN0eC0+cHJlZGljYXRlZF9m
dXR1cmVfdnJlZ3MsIE5VTV9WUkVHUyk7CkBAIC01MzUsNDEgKzU0MSwxNCBAQCBzdGF0aWMgdm9p
ZCBnZW5fcmVnX3dyaXRlcyhEaXNhc0NvbnRleHQgKmN0eCkKIAogc3RhdGljIHZvaWQgZ2VuX3By
ZWRfd3JpdGVzKERpc2FzQ29udGV4dCAqY3R4KQogewotICAgIGludCBpOwotCiAgICAgLyogRWFy
bHkgZXhpdCBpZiB0aGUgbG9nIGlzIGVtcHR5ICovCiAgICAgaWYgKCFjdHgtPnByZWdfbG9nX2lk
eCkgewogICAgICAgICByZXR1cm47CiAgICAgfQogCi0gICAgLyoKLSAgICAgKiBPbmx5IGVuZGxv
b3AgaW5zdHJ1Y3Rpb25zIHdpbGwgY29uZGl0aW9uYWxseQotICAgICAqIHdyaXRlIGEgcHJlZGlj
YXRlLiAgSWYgdGhlcmUgYXJlIG5vIGVuZGxvb3AKLSAgICAgKiBpbnN0cnVjdGlvbnMsIHdlIGNh
biB1c2UgdGhlIG5vbi1jb25kaXRpb25hbAotICAgICAqIHdyaXRlIG9mIHRoZSBwcmVkaWNhdGVz
LgotICAgICAqLwotICAgIGlmIChjdHgtPnBrdC0+cGt0X2hhc19lbmRsb29wKSB7Ci0gICAgICAg
IFRDR3YgemVybyA9IHRjZ19jb25zdGFudF90bCgwKTsKLSAgICAgICAgVENHdiBwcmVkX3dyaXR0
ZW4gPSB0Y2dfdGVtcF9uZXcoKTsKLSAgICAgICAgZm9yIChpID0gMDsgaSA8IGN0eC0+cHJlZ19s
b2dfaWR4OyBpKyspIHsKLSAgICAgICAgICAgIGludCBwcmVkX251bSA9IGN0eC0+cHJlZ19sb2db
aV07Ci0KLSAgICAgICAgICAgIHRjZ19nZW5fYW5kaV90bChwcmVkX3dyaXR0ZW4sIGhleF9wcmVk
X3dyaXR0ZW4sIDEgPDwgcHJlZF9udW0pOwotICAgICAgICAgICAgdGNnX2dlbl9tb3Zjb25kX3Rs
KFRDR19DT05EX05FLCBoZXhfcHJlZFtwcmVkX251bV0sCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcHJlZF93cml0dGVuLCB6ZXJvLAotICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGhleF9uZXdfcHJlZF92YWx1ZVtwcmVkX251bV0sCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaGV4X3ByZWRbcHJlZF9udW1dKTsKLSAgICAgICAgfQotICAgIH0gZWxzZSB7Ci0g
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPnByZWdfbG9nX2lkeDsgaSsrKSB7Ci0gICAgICAg
ICAgICBpbnQgcHJlZF9udW0gPSBjdHgtPnByZWdfbG9nW2ldOwotICAgICAgICAgICAgdGNnX2dl
bl9tb3ZfdGwoaGV4X3ByZWRbcHJlZF9udW1dLCBoZXhfbmV3X3ByZWRfdmFsdWVbcHJlZF9udW1d
KTsKLSAgICAgICAgICAgIGlmIChIRVhfREVCVUcpIHsKLSAgICAgICAgICAgICAgICAvKiBEbyB0
aGlzIHNvIEhFTFBFUihkZWJ1Z19jb21taXRfZW5kKSB3aWxsIGtub3cgKi8KLSAgICAgICAgICAg
ICAgICB0Y2dfZ2VuX29yaV90bChoZXhfcHJlZF93cml0dGVuLCBoZXhfcHJlZF93cml0dGVuLAot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgPDwgcHJlZF9udW0pOwotICAgICAgICAg
ICAgfQotICAgICAgICB9CisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBjdHgtPnByZWdfbG9nX2lk
eDsgaSsrKSB7CisgICAgICAgIGludCBwcmVkX251bSA9IGN0eC0+cHJlZ19sb2dbaV07CisgICAg
ICAgIHRjZ19nZW5fbW92X3RsKGhleF9wcmVkW3ByZWRfbnVtXSwgaGV4X25ld19wcmVkX3ZhbHVl
W3ByZWRfbnVtXSk7CiAgICAgfQogfQogCi0tIAoyLjI1LjEKCg==

