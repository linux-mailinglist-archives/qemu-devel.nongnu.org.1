Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B826F708913
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjsy-0001gr-O1; Thu, 18 May 2023 16:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrc-000096-1q
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrR-000575-4g
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJMhSk007042; Thu, 18 May 2023 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EKMC9tsMiifAweBREZnggaihOw9Eh274cix625NYdEo=;
 b=cGc5HVN/ThhruPOnsNEUMDnM57fkuaC6Qimh7TKjQpUWV+54wwziVH0SnxRguOxq+9ku
 EeaN+kXmKPE7SvfOBaGFo1VctB8I73Vc56eF814RPiKCdPhaf9LU4b1HtX6BNrExNu2O
 2g9Nxbta2royAlyYflWjirbXu7w/MFHSPyOxuHIvwjp7aGBdAKwl76VWHW0Fjcgm9ADR
 TaXr5egF+PRozdvCmGEkWSlvh4vw2+npbhEt/Pt63QOYw0K7rxqIZB3fmsZxwZ7sg5v4
 SKH/Sy+cX194tYtg/jdDxxeNzeITKrX+8lJM4HYJb1oFdhKq4PeDjk+JA7pf5nvYius5 aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnb7ha6p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4GIL013695; 
 Thu, 18 May 2023 20:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qmrx7jyxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4Ds0013564;
 Thu, 18 May 2023 20:04:15 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34IK4F1x013636
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 87ADD68B; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 22/44] Hexagon (target/hexagon) Short-circuit packet HVX
 writes
Date: Thu, 18 May 2023 13:03:49 -0700
Message-Id: <20230518200411.271148-23-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3O7JxuD-LrERxp3lheDXTbvKScbfI4o6
X-Proofpoint-GUID: 3O7JxuD-LrERxp3lheDXTbvKScbfI4o6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=712
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180165
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
IGZ1dHVyZV9WUmVncwphbmQgd3JpdGUgZGlyZWN0bHkgdG8gVlJlZ3MuICBXZSBjb25zaWRlciBI
VlggcmVhZHMvd3JpdGVzIHdoZW4gY29tcHV0aW5nCmN0eC0+bmVlZF9jb21taXQuICBUaGVuLCB3
ZSBjYW4gZWFybHktZXhpdCBmcm9tIGdlbl9jb21taXRfaHZ4LgoKU2lnbmVkLW9mZi1ieTogVGF5
bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgpSZXZpZXdlZC1ieTogUmljaGFyZCBI
ZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+Ck1lc3NhZ2UtSWQ6IDwyMDIz
MDQyNzIzMDAxMi4zODAwMzI3LTE0LXRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL2dlbnB0ci5jICAgIHwgIDYgKysrKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5j
IHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hh
bmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCmluZGV4IDUwMjVl
MTcyY2YuLjgyYTM0MDhlYjQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCkBAIC0xMTA0LDcgKzExMDQsMTEgQEAgc3RhdGlj
IHZvaWQgZ2VuX2xvZ192cmVnX3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGludHB0cl90
IHNyY29mZiwgaW50IG51bSwKIAogc3RhdGljIGludHB0cl90IGdldF9yZXN1bHRfcXJlZyhEaXNh
c0NvbnRleHQgKmN0eCwgaW50IHFudW0pCiB7Ci0gICAgcmV0dXJuICBvZmZzZXRvZihDUFVIZXhh
Z29uU3RhdGUsIGZ1dHVyZV9RUmVnc1txbnVtXSk7CisgICAgaWYgKGN0eC0+bmVlZF9jb21taXQp
IHsKKyAgICAgICAgcmV0dXJuICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGZ1dHVyZV9RUmVn
c1txbnVtXSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgcmV0dXJuICBvZmZzZXRvZihDUFVIZXhh
Z29uU3RhdGUsIFFSZWdzW3FudW1dKTsKKyAgICB9CiB9CiAKIHN0YXRpYyB2b2lkIGdlbl92cmVn
X2xvYWQoRGlzYXNDb250ZXh0ICpjdHgsIGludHB0cl90IGRzdG9mZiwgVENHdiBzcmMsCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCmluZGV4IGJjZjY0ZjcyNWEuLjhlN2E0Mzc3YzggMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC03
MCw2ICs3MCwxMCBAQCBpbnRwdHJfdCBjdHhfZnV0dXJlX3ZyZWdfb2ZmKERpc2FzQ29udGV4dCAq
Y3R4LCBpbnQgcmVnbnVtLAogewogICAgIGludHB0cl90IG9mZnNldDsKIAorICAgIGlmICghY3R4
LT5uZWVkX2NvbW1pdCkgeworICAgICAgICByZXR1cm4gb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRl
LCBWUmVnc1tyZWdudW1dKTsKKyAgICB9CisKICAgICAvKiBTZWUgaWYgaXQgaXMgYWxyZWFkeSBh
bGxvY2F0ZWQgKi8KICAgICBmb3IgKGludCBpID0gMDsgaSA8IGN0eC0+ZnV0dXJlX3ZyZWdzX2lk
eDsgaSsrKSB7CiAgICAgICAgIGlmIChjdHgtPmZ1dHVyZV92cmVnc19udW1baV0gPT0gcmVnbnVt
KSB7CkBAIC0zNzQsNyArMzc4LDcgQEAgc3RhdGljIGJvb2wgbmVlZF9jb21taXQoRGlzYXNDb250
ZXh0ICpjdHgpCiAgICAgICAgIHJldHVybiB0cnVlOwogICAgIH0KIAotICAgIGlmIChwa3QtPm51
bV9pbnNucyA9PSAxKSB7CisgICAgaWYgKHBrdC0+bnVtX2luc25zID09IDEgJiYgIXBrdC0+cGt0
X2hhc19odngpIHsKICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgIH0KIApAQCAtMzk0LDYgKzM5
OCw0MCBAQCBzdGF0aWMgYm9vbCBuZWVkX2NvbW1pdChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAg
ICAgfQogICAgIH0KIAorICAgIC8qIENoZWNrIGZvciBvdmVybGFwIGJldHdlZW4gSFZYIHJlYWRz
IGFuZCB3cml0ZXMgKi8KKyAgICBmb3IgKGludCBpID0gMDsgaSA8IGN0eC0+dnJlZ19sb2dfaWR4
OyBpKyspIHsKKyAgICAgICAgaW50IHZudW0gPSBjdHgtPnZyZWdfbG9nW2ldOworICAgICAgICBp
ZiAodGVzdF9iaXQodm51bSwgY3R4LT52cmVnc19yZWFkKSkgeworICAgICAgICAgICAgcmV0dXJu
IHRydWU7CisgICAgICAgIH0KKyAgICB9CisgICAgaWYgKCFiaXRtYXBfZW1wdHkoY3R4LT52cmVn
c191cGRhdGVkX3RtcCwgTlVNX1ZSRUdTKSkgeworICAgICAgICBpbnQgaSA9IGZpbmRfZmlyc3Rf
Yml0KGN0eC0+dnJlZ3NfdXBkYXRlZF90bXAsIE5VTV9WUkVHUyk7CisgICAgICAgIHdoaWxlIChp
IDwgTlVNX1ZSRUdTKSB7CisgICAgICAgICAgICBpZiAodGVzdF9iaXQoaSwgY3R4LT52cmVnc19y
ZWFkKSkgeworICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICAgICAgfQorICAg
ICAgICAgICAgaSA9IGZpbmRfbmV4dF9iaXQoY3R4LT52cmVnc191cGRhdGVkX3RtcCwgTlVNX1ZS
RUdTLCBpICsgMSk7CisgICAgICAgIH0KKyAgICB9CisgICAgaWYgKCFiaXRtYXBfZW1wdHkoY3R4
LT52cmVnc19zZWxlY3QsIE5VTV9WUkVHUykpIHsKKyAgICAgICAgaW50IGkgPSBmaW5kX2ZpcnN0
X2JpdChjdHgtPnZyZWdzX3NlbGVjdCwgTlVNX1ZSRUdTKTsKKyAgICAgICAgd2hpbGUgKGkgPCBO
VU1fVlJFR1MpIHsKKyAgICAgICAgICAgIGlmICh0ZXN0X2JpdChpLCBjdHgtPnZyZWdzX3JlYWQp
KSB7CisgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CisgICAgICAgICAgICB9CisgICAgICAg
ICAgICBpID0gZmluZF9uZXh0X2JpdChjdHgtPnZyZWdzX3NlbGVjdCwgTlVNX1ZSRUdTLCBpICsg
MSk7CisgICAgICAgIH0KKyAgICB9CisKKyAgICAvKiBDaGVjayBmb3Igb3ZlcmxhcCBiZXR3ZWVu
IEhWWCBwcmVkaWNhdGUgcmVhZHMgYW5kIHdyaXRlcyAqLworICAgIGZvciAoaW50IGkgPSAwOyBp
IDwgY3R4LT5xcmVnX2xvZ19pZHg7IGkrKykgeworICAgICAgICBpbnQgcW51bSA9IGN0eC0+cXJl
Z19sb2dbaV07CisgICAgICAgIGlmICh0ZXN0X2JpdChxbnVtLCBjdHgtPnFyZWdzX3JlYWQpKSB7
CisgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAgfQorICAgIH0KKwogICAgIHJldHVy
biBmYWxzZTsKIH0KIApAQCAtNzkwLDYgKzgyOCwxMiBAQCBzdGF0aWMgdm9pZCBnZW5fY29tbWl0
X2h2eChEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBpbnQgaTsKIAorICAgIC8qIEVhcmx5IGV4
aXQgaWYgbm90IG5lZWRlZCAqLworICAgIGlmICghY3R4LT5uZWVkX2NvbW1pdCkgeworICAgICAg
ICBnX2Fzc2VydCghcGt0X2hhc19odnhfc3RvcmUoY3R4LT5wa3QpKTsKKyAgICAgICAgcmV0dXJu
OworICAgIH0KKwogICAgIC8qCiAgICAgICogICAgZm9yIChpID0gMDsgaSA8IGN0eC0+dnJlZ19s
b2dfaWR4OyBpKyspIHsKICAgICAgKiAgICAgICAgaW50IHJudW0gPSBjdHgtPnZyZWdfbG9nW2ld
OwotLSAKMi4yNS4xCgo=

