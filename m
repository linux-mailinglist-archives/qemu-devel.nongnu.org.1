Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B07712823
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YJC-0005rL-4z; Fri, 26 May 2023 10:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q2YJ5-0005pD-HW
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:20:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q2YJ3-0007CE-4i
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:20:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QAg3YY000555; Fri, 26 May 2023 14:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pHiKIa1pVcZ3RWRnlcQ04egP+hfXD+E7M6b9+9wWZn0=;
 b=cVXybS1Cww7ezTEtw7OLcIEWIAygP2hJ3OoFVRF2WdEPGxGYyjMcp1zjcbYfMB9ufqUP
 jSG9LiGoAXpDLur3BipauroJ4jouhAfaEmdp0Igv+z4xYrF5CfSpbp5XBqmZ1dtyn7lh
 BKlMO075RAGrWc6tbIr2Qzf2RJlqEfCFYPoyY8V1W/iiQIMfthWFsmx8zIXzzyQTQ19V
 LUzccjueyvd3BiKtfquMeIX6uknt95/PW1MHS8vdPCnx3q/Q1/Njwl9fWvyGxNC7dRj2
 9sQMNZXtg5OQAJZOBzZ2sT/9SioELqKzcHDq+cEibvOqfv0XKhU6W0/0LqdP/Bt554wC eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtq28gwt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:31 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34QEKUO8014070; 
 Fri, 26 May 2023 14:20:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qtvwq8dmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:30 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QEKUZd014049;
 Fri, 26 May 2023 14:20:30 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34QEKT8D014046
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:30 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id ACB976CE; Fri, 26 May 2023 07:20:29 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com
Subject: [PULL 4/5] Hexagon: fix outdated `hex_new_*` comments
Date: Fri, 26 May 2023 07:20:27 -0700
Message-Id: <20230526142028.1277954-5-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526142028.1277954-1-tsimpson@quicinc.com>
References: <20230526142028.1277954-1-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: O8ZLfYiPObPKmn_mZlKVsHp5RtLm0CvE
X-Proofpoint-ORIG-GUID: O8ZLfYiPObPKmn_mZlKVsHp5RtLm0CvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_05,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxlogscore=678 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260120
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=tsimpson@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTb21lIGNvZGUgY29tbWVudHMgcmVmZXIgdG8gaGV4X25ld192YWx1ZSBhbmQgaGV4X25l
d19wcmVkX3ZhbHVlLCB3aGljaApoYXZlIGJlZW4gdHJhbnNmZXJyZWQgdG8gRGlzYXNDb250ZXh0
IGFuZCwgaW4gdGhlIGNhc2Ugb2YgaGV4X25ld192YWx1ZSwKc2hvdWxkIG5vdyBiZSBhY2Nlc3Nl
ZCB0aHJvdWdoIGdldF9yZXN1bHRfZ3ByKCkuCgpJbiBvcmRlciB0byBmaXggdGhpcyBvdXRkYXRl
ZCBjb21tZW50cyBhbmQgYWxzbyBhdm9pZCBoYXZpbmcgdG8gdHdlYWsKdGhlbSB3aGVuZXZlciB3
ZSBtYWtlIGEgdmFyaWFibGUgbmFtZSBjaGFuZ2UgaW4gdGhlIGZ1dHVyZSwgbGV0J3MKcmVwbGFj
ZSB0aGVtIHdpdGggcHNldWRvY29kZS4KClN1Z2dlc3RlZC1ieTogVGF5bG9yIFNpbXBzb24gPHRz
aW1wc29uQHF1aWNpbmMuY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFy
ZGlubyA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1w
c29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24g
PHRzaW1wc29uQHF1aWNpbmMuY29tPgpNZXNzYWdlLUlkOiA8OGUxNjg5ZTI4ZGQ3YjEzMTgzNjli
NTUxMjdjZjQ3YjgyYWI3NTkyMS4xNjg0OTM5MDc4LmdpdC5xdWljX21hdGhiZXJuQHF1aWNpbmMu
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgIHwgMjYgKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgIDIgKy0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwppbmRleCBj
YjJhYTI4YTE5Li5iY2IyODdkZDhiIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIu
YworKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtODc4LDkgKzg3OCw5IEBAIHN0YXRp
YyB2b2lkIGdlbl9lbmRsb29wMChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgKi8KICAgICBpZiAo
IWN0eC0+aXNfdGlnaHRfbG9vcCkgewogICAgICAgICAvKgotICAgICAgICAgKiAgICBpZiAoaGV4
X2dwcltIRVhfUkVHX0xDMF0gPiAxKSB7Ci0gICAgICAgICAqICAgICAgICBQQyA9IGhleF9ncHJb
SEVYX1JFR19TQTBdOwotICAgICAgICAgKiAgICAgICAgaGV4X25ld192YWx1ZVtIRVhfUkVHX0xD
MF0gPSBoZXhfZ3ByW0hFWF9SRUdfTEMwXSAtIDE7CisgICAgICAgICAqICAgIGlmIChMQzAgPiAx
KSB7CisgICAgICAgICAqICAgICAgICBQQyA9IFNBMDsKKyAgICAgICAgICogICAgICAgIExDMC0t
OwogICAgICAgICAgKiAgICB9CiAgICAgICAgICAqLwogICAgICAgICBUQ0dMYWJlbCAqbGFiZWwz
ID0gZ2VuX25ld19sYWJlbCgpOwpAQCAtODk3LDkgKzg5Nyw5IEBAIHN0YXRpYyB2b2lkIGdlbl9l
bmRsb29wMChEaXNhc0NvbnRleHQgKmN0eCkKIHN0YXRpYyB2b2lkIGdlbl9lbmRsb29wMShEaXNh
c0NvbnRleHQgKmN0eCkKIHsKICAgICAvKgotICAgICAqICAgIGlmIChoZXhfZ3ByW0hFWF9SRUdf
TEMxXSA+IDEpIHsKLSAgICAgKiAgICAgICAgUEMgPSBoZXhfZ3ByW0hFWF9SRUdfU0ExXTsKLSAg
ICAgKiAgICAgICAgaGV4X25ld192YWx1ZVtIRVhfUkVHX0xDMV0gPSBoZXhfZ3ByW0hFWF9SRUdf
TEMxXSAtIDE7CisgICAgICogICAgaWYgKExDMSA+IDEpIHsKKyAgICAgKiAgICAgICAgUEMgPSBT
QTE7CisgICAgICogICAgICAgIExDMS0tOwogICAgICAqICAgIH0KICAgICAgKi8KICAgICBUQ0dM
YWJlbCAqbGFiZWwgPSBnZW5fbmV3X2xhYmVsKCk7CkBAIC05NDYsMTQgKzk0NiwxMiBAQCBzdGF0
aWMgdm9pZCBnZW5fZW5kbG9vcDAxKERpc2FzQ29udGV4dCAqY3R4KQogICAgIGdlbl9zZXRfbGFi
ZWwobGFiZWwyKTsKIAogICAgIC8qCi0gICAgICogICAgaWYgKGhleF9ncHJbSEVYX1JFR19MQzBd
ID4gMSkgewotICAgICAqICAgICAgICBQQyA9IGhleF9ncHJbSEVYX1JFR19TQTBdOwotICAgICAq
ICAgICAgICBoZXhfbmV3X3ZhbHVlW0hFWF9SRUdfTEMwXSA9IGhleF9ncHJbSEVYX1JFR19MQzBd
IC0gMTsKLSAgICAgKiAgICB9IGVsc2UgewotICAgICAqICAgICAgICBpZiAoaGV4X2dwcltIRVhf
UkVHX0xDMV0gPiAxKSB7Ci0gICAgICogICAgICAgICAgICBoZXhfbmV4dF9wYyA9IGhleF9ncHJb
SEVYX1JFR19TQTFdOwotICAgICAqICAgICAgICAgICAgaGV4X25ld192YWx1ZVtIRVhfUkVHX0xD
MV0gPSBoZXhfZ3ByW0hFWF9SRUdfTEMxXSAtIDE7Ci0gICAgICogICAgICAgIH0KKyAgICAgKiAg
ICBpZiAoTEMwID4gMSkgeworICAgICAqICAgICAgICBQQyA9IFNBMDsKKyAgICAgKiAgICAgICAg
TEMwLS07CisgICAgICogICAgfSBlbHNlIGlmIChMQzEgPiAxKSB7CisgICAgICogICAgICAgIFBD
ID0gU0ExOworICAgICAqICAgICAgICBMQzEtLTsKICAgICAgKiAgICB9CiAgICAgICovCiAgICAg
dGNnX2dlbl9icmNvbmRpX3RsKFRDR19DT05EX0xFVSwgaGV4X2dwcltIRVhfUkVHX0xDMF0sIDEs
IGxhYmVsMyk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGIxOGYxYTkwNTEuLjg4MzhhYjIzNjQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jCkBAIC01NTYsNyArNTU2LDcgQEAgc3RhdGljIHZvaWQgZ2VuX3N0YXJ0X3BhY2tl
dChEaXNhc0NvbnRleHQgKmN0eCkKICAgICB9CiAKICAgICAvKgotICAgICAqIFByZWxvYWQgdGhl
IHByZWRpY2F0ZWQgcHJlZCByZWdpc3RlcnMgaW50byBoZXhfbmV3X3ByZWRfdmFsdWVbcHJlZF9u
dW1dCisgICAgICogUHJlbG9hZCB0aGUgcHJlZGljYXRlZCBwcmVkIHJlZ2lzdGVycyBpbnRvIGN0
eC0+bmV3X3ByZWRfdmFsdWVbcHJlZF9udW1dCiAgICAgICogT25seSBlbmRsb29wIGluc3RydWN0
aW9ucyBjb25kaXRpb25hbGx5IHdyaXRlIHRvIHByZWQgcmVnaXN0ZXJzCiAgICAgICovCiAgICAg
aWYgKGN0eC0+bmVlZF9jb21taXQgJiYgcGt0LT5wa3RfaGFzX2VuZGxvb3ApIHsKLS0gCjIuMjUu
MQoK

