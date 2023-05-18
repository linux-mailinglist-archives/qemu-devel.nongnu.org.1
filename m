Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A2708932
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjru-0000Yd-29; Thu, 18 May 2023 16:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrd-00009P-S6
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrR-00057d-Og
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IBDBKp017058; Thu, 18 May 2023 20:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zpA1ward4pPZk6yDa7sxE5TTn1ZtYRKhLjhzoOWKn3Q=;
 b=DMKFAKbgus9YcPeA/ua1qqSvrA55HwrRhbsIWQfuoLqoKpQwkjdIkBPXgqg4v+Ya0hrb
 5jZA9/HAR4nwkBYHsiwB526YAyBF6psLR0lUE1L7MgdcdUHla2KqQb0Dzj7QburZcXam
 W9sDFPokkzWREdHnFmzr9vv6tPw9smfGbKVRsoVKFlJ8GGk1sFj1fnS2Z0nA5RgBo3Rp
 6h+wOdF33YuAJF50SSCtrzL45x3Oqx5PjyOlu8qLKs/rhPhL6zygoEhz8jRsipWFgdhw
 8rxpKv37/twzM68gk9U5K8kkfTqnB3sPrfp3uIW4ONoJLdS4ghn/MY1m1vTMqhn4HN3U 4w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn8d2jeww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:18 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4HSN028889; 
 Thu, 18 May 2023 20:04:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qmryp306j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4FfY028642;
 Thu, 18 May 2023 20:04:16 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 34IK4Fn3028734
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 7D3AE6D3; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 18/44] Hexagon (target/hexagon) Don't overlap dest writes
 with source reads
Date: Thu, 18 May 2023 13:03:45 -0700
Message-Id: <20230518200411.271148-19-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: F2wLJReUe0iAA6bqcZ3GqT8SeOvJW59R
X-Proofpoint-GUID: F2wLJReUe0iAA6bqcZ3GqT8SeOvJW59R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=831 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

V2hlbiBnZW5lcmF0aW5nIFRDRywgbWFrZSBzdXJlIHdlIGhhdmUgcmVhZCBhbGwgdGhlIG9wZXJh
bmQgcmVnaXN0ZXJzCmJlZm9yZSB3cml0aW5nIHRvIHRoZSBkZXN0aW5hdGlvbiByZWdpc3RlcnMu
CgpUaGlzIGlzIGEgcHJlcmVxdWVzaXRlIGZvciBzaG9ydC1jaXJjdWl0aW5nIHdoZXJlIHRoZSBz
b3VyY2UgYW5kIGRlc3QKb3BlcmFuZHMgY291bGQgYmUgdGhlIHNhbWUuCgpTaWduZWQtb2ZmLWJ5
OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBSaWNo
YXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KTWVzc2FnZS1JZDog
PDIwMjMwNDI3MjMwMDEyLjM4MDAzMjctMTAtdHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jIGIvdGFyZ2V0L2hleGFn
b24vZ2VucHRyLmMKaW5kZXggOWJiYWNhNjMwMC4uM2M3ZTBkYWZhZiAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTk3
MSw2ICs5NzEsNyBAQCBzdGF0aWMgdm9pZCBnZW5fY21waV9qdW1wbnYoRGlzYXNDb250ZXh0ICpj
dHgsCiAvKiBTaGlmdCBsZWZ0IHdpdGggc2F0dXJhdGlvbiAqLwogc3RhdGljIHZvaWQgZ2VuX3No
bF9zYXQoRGlzYXNDb250ZXh0ICpjdHgsIFRDR3YgZHN0LCBUQ0d2IHNyYywgVENHdiBzaGlmdF9h
bXQpCiB7CisgICAgVENHdiB0bXAgPSB0Y2dfdGVtcF9uZXcoKTsgICAgLyogSW4gY2FzZSBkc3Qg
PT0gc3JjICovCiAgICAgVENHdiB1c3IgPSBnZXRfcmVzdWx0X2dwcihjdHgsIEhFWF9SRUdfVVNS
KTsKICAgICBUQ0d2IHNoMzIgPSB0Y2dfdGVtcF9uZXcoKTsKICAgICBUQ0d2IGRzdF9zYXIgPSB0
Y2dfdGVtcF9uZXcoKTsKQEAgLTk5NSwxNyArOTk2LDE3IEBAIHN0YXRpYyB2b2lkIGdlbl9zaGxf
c2F0KERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2IGRzdCwgVENHdiBzcmMsIFRDR3Ygc2hpZnRfYW10
KQogICAgICAqLwogCiAgICAgdGNnX2dlbl9hbmRpX3RsKHNoMzIsIHNoaWZ0X2FtdCwgMzEpOwot
ICAgIHRjZ19nZW5fbW92Y29uZF90bChUQ0dfQ09ORF9FUSwgZHN0LCBzaDMyLCBzaGlmdF9hbXQs
CisgICAgdGNnX2dlbl9tb3Zjb25kX3RsKFRDR19DT05EX0VRLCB0bXAsIHNoMzIsIHNoaWZ0X2Ft
dCwKICAgICAgICAgICAgICAgICAgICAgICAgc3JjLCB0Y2dfY29uc3RhbnRfdGwoMCkpOwotICAg
IHRjZ19nZW5fc2hsX3RsKGRzdCwgZHN0LCBzaDMyKTsKLSAgICB0Y2dfZ2VuX3Nhcl90bChkc3Rf
c2FyLCBkc3QsIHNoMzIpOworICAgIHRjZ19nZW5fc2hsX3RsKHRtcCwgdG1wLCBzaDMyKTsKKyAg
ICB0Y2dfZ2VuX3Nhcl90bChkc3Rfc2FyLCB0bXAsIHNoMzIpOwogICAgIHRjZ19nZW5fbW92Y29u
ZF90bChUQ0dfQ09ORF9MVCwgc2F0dmFsLCBzcmMsIHRjZ19jb25zdGFudF90bCgwKSwgbWluLCBt
YXgpOwogCiAgICAgdGNnX2dlbl9zZXRjb25kX3RsKFRDR19DT05EX05FLCBvdmYsIGRzdF9zYXIs
IHNyYyk7CiAgICAgdGNnX2dlbl9zaGxpX3RsKG92Ziwgb3ZmLCByZWdfZmllbGRfaW5mb1tVU1Jf
T1ZGXS5vZmZzZXQpOwogICAgIHRjZ19nZW5fb3JfdGwodXNyLCB1c3IsIG92Zik7CiAKLSAgICB0
Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NPTkRfRVEsIGRzdCwgZHN0X3Nhciwgc3JjLCBkc3QsIHNh
dHZhbCk7CisgICAgdGNnX2dlbl9tb3Zjb25kX3RsKFRDR19DT05EX0VRLCBkc3QsIGRzdF9zYXIs
IHNyYywgdG1wLCBzYXR2YWwpOwogfQogCiBzdGF0aWMgdm9pZCBnZW5fc2FyKFRDR3YgZHN0LCBU
Q0d2IHNyYywgVENHdiBzaGlmdF9hbXQpCkBAIC0xMjI4LDIyICsxMjI5LDI4IEBAIHZvaWQgZ2Vu
X3NhdF9pMzIoVENHdiBkZXN0LCBUQ0d2IHNvdXJjZSwgaW50IHdpZHRoKQogCiB2b2lkIGdlbl9z
YXRfaTMyX292ZmwoVENHdiBvdmZsLCBUQ0d2IGRlc3QsIFRDR3Ygc291cmNlLCBpbnQgd2lkdGgp
CiB7Ci0gICAgZ2VuX3NhdF9pMzIoZGVzdCwgc291cmNlLCB3aWR0aCk7Ci0gICAgdGNnX2dlbl9z
ZXRjb25kX3RsKFRDR19DT05EX05FLCBvdmZsLCBzb3VyY2UsIGRlc3QpOworICAgIFRDR3YgdG1w
ID0gdGNnX3RlbXBfbmV3KCk7ICAgIC8qIEluIGNhc2UgZGVzdCA9PSBzb3VyY2UgKi8KKyAgICBn
ZW5fc2F0X2kzMih0bXAsIHNvdXJjZSwgd2lkdGgpOworICAgIHRjZ19nZW5fc2V0Y29uZF90bChU
Q0dfQ09ORF9ORSwgb3ZmbCwgc291cmNlLCB0bXApOworICAgIHRjZ19nZW5fbW92X3RsKGRlc3Qs
IHRtcCk7CiB9CiAKIHZvaWQgZ2VuX3NhdHVfaTMyKFRDR3YgZGVzdCwgVENHdiBzb3VyY2UsIGlu
dCB3aWR0aCkKIHsKKyAgICBUQ0d2IHRtcCA9IHRjZ190ZW1wX25ldygpOyAgICAvKiBJbiBjYXNl
IGRlc3QgPT0gc291cmNlICovCiAgICAgVENHdiBtYXhfdmFsID0gdGNnX2NvbnN0YW50X3RsKCgx
IDw8IHdpZHRoKSAtIDEpOwogICAgIFRDR3YgemVybyA9IHRjZ19jb25zdGFudF90bCgwKTsKLSAg
ICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NPTkRfR1RVLCBkZXN0LCBzb3VyY2UsIG1heF92YWws
IG1heF92YWwsIHNvdXJjZSk7Ci0gICAgdGNnX2dlbl9tb3Zjb25kX3RsKFRDR19DT05EX0xULCBk
ZXN0LCBzb3VyY2UsIHplcm8sIHplcm8sIGRlc3QpOworICAgIHRjZ19nZW5fbW92Y29uZF90bChU
Q0dfQ09ORF9HVFUsIHRtcCwgc291cmNlLCBtYXhfdmFsLCBtYXhfdmFsLCBzb3VyY2UpOworICAg
IHRjZ19nZW5fbW92Y29uZF90bChUQ0dfQ09ORF9MVCwgdG1wLCBzb3VyY2UsIHplcm8sIHplcm8s
IHRtcCk7CisgICAgdGNnX2dlbl9tb3ZfdGwoZGVzdCwgdG1wKTsKIH0KIAogdm9pZCBnZW5fc2F0
dV9pMzJfb3ZmbChUQ0d2IG92ZmwsIFRDR3YgZGVzdCwgVENHdiBzb3VyY2UsIGludCB3aWR0aCkK
IHsKLSAgICBnZW5fc2F0dV9pMzIoZGVzdCwgc291cmNlLCB3aWR0aCk7Ci0gICAgdGNnX2dlbl9z
ZXRjb25kX3RsKFRDR19DT05EX05FLCBvdmZsLCBzb3VyY2UsIGRlc3QpOworICAgIFRDR3YgdG1w
ID0gdGNnX3RlbXBfbmV3KCk7ICAgIC8qIEluIGNhc2UgZGVzdCA9PSBzb3VyY2UgKi8KKyAgICBn
ZW5fc2F0dV9pMzIodG1wLCBzb3VyY2UsIHdpZHRoKTsKKyAgICB0Y2dfZ2VuX3NldGNvbmRfdGwo
VENHX0NPTkRfTkUsIG92ZmwsIHNvdXJjZSwgdG1wKTsKKyAgICB0Y2dfZ2VuX21vdl90bChkZXN0
LCB0bXApOwogfQogCiB2b2lkIGdlbl9zYXRfaTY0KFRDR3ZfaTY0IGRlc3QsIFRDR3ZfaTY0IHNv
dXJjZSwgaW50IHdpZHRoKQpAQCAtMTI1NiwyNyArMTI2MywzMyBAQCB2b2lkIGdlbl9zYXRfaTY0
KFRDR3ZfaTY0IGRlc3QsIFRDR3ZfaTY0IHNvdXJjZSwgaW50IHdpZHRoKQogCiB2b2lkIGdlbl9z
YXRfaTY0X292ZmwoVENHdiBvdmZsLCBUQ0d2X2k2NCBkZXN0LCBUQ0d2X2k2NCBzb3VyY2UsIGlu
dCB3aWR0aCkKIHsKKyAgICBUQ0d2X2k2NCB0bXAgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7IC8qIElu
IGNhc2UgZGVzdCA9PSBzb3VyY2UgKi8KICAgICBUQ0d2X2k2NCBvdmZsXzY0OwotICAgIGdlbl9z
YXRfaTY0KGRlc3QsIHNvdXJjZSwgd2lkdGgpOworICAgIGdlbl9zYXRfaTY0KHRtcCwgc291cmNl
LCB3aWR0aCk7CiAgICAgb3ZmbF82NCA9IHRjZ190ZW1wX25ld19pNjQoKTsKLSAgICB0Y2dfZ2Vu
X3NldGNvbmRfaTY0KFRDR19DT05EX05FLCBvdmZsXzY0LCBkZXN0LCBzb3VyY2UpOworICAgIHRj
Z19nZW5fc2V0Y29uZF9pNjQoVENHX0NPTkRfTkUsIG92ZmxfNjQsIHRtcCwgc291cmNlKTsKKyAg
ICB0Y2dfZ2VuX21vdl9pNjQoZGVzdCwgdG1wKTsKICAgICB0Y2dfZ2VuX3RydW5jX2k2NF90bChv
dmZsLCBvdmZsXzY0KTsKIH0KIAogdm9pZCBnZW5fc2F0dV9pNjQoVENHdl9pNjQgZGVzdCwgVENH
dl9pNjQgc291cmNlLCBpbnQgd2lkdGgpCiB7CisgICAgVENHdl9pNjQgdG1wID0gdGNnX3RlbXBf
bmV3X2k2NCgpOyAgICAvKiBJbiBjYXNlIGRlc3QgPT0gc291cmNlICovCiAgICAgVENHdl9pNjQg
bWF4X3ZhbCA9IHRjZ19jb25zdGFudF9pNjQoKDFMTCA8PCB3aWR0aCkgLSAxTEwpOwogICAgIFRD
R3ZfaTY0IHplcm8gPSB0Y2dfY29uc3RhbnRfaTY0KDApOwotICAgIHRjZ19nZW5fbW92Y29uZF9p
NjQoVENHX0NPTkRfR1RVLCBkZXN0LCBzb3VyY2UsIG1heF92YWwsIG1heF92YWwsIHNvdXJjZSk7
Ci0gICAgdGNnX2dlbl9tb3Zjb25kX2k2NChUQ0dfQ09ORF9MVCwgZGVzdCwgc291cmNlLCB6ZXJv
LCB6ZXJvLCBkZXN0KTsKKyAgICB0Y2dfZ2VuX21vdmNvbmRfaTY0KFRDR19DT05EX0dUVSwgdG1w
LCBzb3VyY2UsIG1heF92YWwsIG1heF92YWwsIHNvdXJjZSk7CisgICAgdGNnX2dlbl9tb3Zjb25k
X2k2NChUQ0dfQ09ORF9MVCwgdG1wLCBzb3VyY2UsIHplcm8sIHplcm8sIHRtcCk7CisgICAgdGNn
X2dlbl9tb3ZfaTY0KGRlc3QsIHRtcCk7CiB9CiAKIHZvaWQgZ2VuX3NhdHVfaTY0X292ZmwoVENH
diBvdmZsLCBUQ0d2X2k2NCBkZXN0LCBUQ0d2X2k2NCBzb3VyY2UsIGludCB3aWR0aCkKIHsKKyAg
ICBUQ0d2X2k2NCB0bXAgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7ICAgIC8qIEluIGNhc2UgZGVzdCA9
PSBzb3VyY2UgKi8KICAgICBUQ0d2X2k2NCBvdmZsXzY0OwotICAgIGdlbl9zYXR1X2k2NChkZXN0
LCBzb3VyY2UsIHdpZHRoKTsKKyAgICBnZW5fc2F0dV9pNjQodG1wLCBzb3VyY2UsIHdpZHRoKTsK
ICAgICBvdmZsXzY0ID0gdGNnX3RlbXBfbmV3X2k2NCgpOwotICAgIHRjZ19nZW5fc2V0Y29uZF9p
NjQoVENHX0NPTkRfTkUsIG92ZmxfNjQsIGRlc3QsIHNvdXJjZSk7CisgICAgdGNnX2dlbl9zZXRj
b25kX2k2NChUQ0dfQ09ORF9ORSwgb3ZmbF82NCwgdG1wLCBzb3VyY2UpOworICAgIHRjZ19nZW5f
bW92X2k2NChkZXN0LCB0bXApOwogICAgIHRjZ19nZW5fdHJ1bmNfaTY0X3RsKG92ZmwsIG92Zmxf
NjQpOwogfQogCi0tIAoyLjI1LjEKCg==

