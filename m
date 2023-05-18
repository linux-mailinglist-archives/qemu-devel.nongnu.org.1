Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0735370891C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzju1-0002cA-9G; Thu, 18 May 2023 16:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrd-00009O-Qc
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrR-00057J-7o
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJj7oH006371; Thu, 18 May 2023 20:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E8Y7heIPF29cb7m8wKnji3Sa10X2ugi7piC3uSFkdrk=;
 b=QlZHYKavU7jlDznDWlWd6+qTHIKd52ISxOFAoZ+4DuERr6SA5ErJwdq+zWCVlMT219O1
 NcqsIzJhW3vthAmtaqCFDZ+h/XpSK9YJ+iblLV4gJl/XEAz23IoDva59yiKbdEVuUDFH
 eTxYCB3hrRPZZfZTAmiscLzs6VwrDazZIANrAuH0ECYAgXlmaaY1g8lsBYtiUrSm5OHa
 biCpx2GWK0SbP2izuXencJOE6FTfcufrXl1/N0B+YvBSFIBQMAUw0RBVm6ubpdz/HyyX
 mzgpH/+SHYg2wRvaE6Ii8EvmdoueAslhwg21vAaGiXE7jWW0ilx6cnS4djJDFvOEFiRS Xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnb7ha6p4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4EYU013603; 
 Thu, 18 May 2023 20:04:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qmrx7jyx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4EuD013625;
 Thu, 18 May 2023 20:04:15 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34IK4EHm013608
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:14 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 71BBE6CF; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 14/44] Hexagon (target/hexagon) Add overrides for clr[tf]new
Date: Thu, 18 May 2023 13:03:41 -0700
Message-Id: <20230518200411.271148-15-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jt-zuN5Li5u-2WkM0z_iQpVdui0qjibJ
X-Proofpoint-GUID: jt-zuN5Li5u-2WkM0z_iQpVdui0qjibJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=607
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

VGhlc2UgaW5zdHJ1Y3Rpb25zIGhhdmUgaW1wbGljaXQgcmVhZHMgZnJvbSBwMCwgc28gd2UgZG9u
J3Qgd2FudAp0aGVtIGluIGhlbHBlcnMgd2hlbiBpZGVmLXBhcnNlciBpcyBvZmYuCgpTaWduZWQt
b2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KTWVzc2Fn
ZS1JZDogPDIwMjMwNDI3MjMwMDEyLjM4MDAzMjctNi10c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggfCAxNiArKysrKysrKysrKysrKysrCiB0YXJnZXQv
aGV4YWdvbi9tYWNyb3MuaCAgfCAgNCAtLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Zy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oCmluZGV4IGVmMTdmMmYxOGMuLmExZDdlYWJh
ZTcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9nZW5fdGNnLmgKQEAgLTExMDEsNiArMTEwMSwyMiBAQAogICAgICAgICBnZW5fanVtcChj
dHgsIHJpVik7IFwKICAgICB9IHdoaWxlICgwKQogCisvKiBpZiAocDAubmV3KSByMCA9ICMwICov
CisjZGVmaW5lIGZHRU5fVENHX1NBMV9jbHJ0bmV3KFNIT1JUQ09ERSkgXAorICAgIGRvIHsgXAor
ICAgICAgICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NPTkRfRVEsIFJkViwgXAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaGV4X25ld19wcmVkX3ZhbHVlWzBdLCB0Y2dfY29uc3RhbnRfdGwo
MCksIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIFJkViwgdGNnX2NvbnN0YW50X3RsKDAp
KTsgXAorICAgIH0gd2hpbGUgKDApCisKKy8qIGlmICghcDAubmV3KSByMCA9ICMwICovCisjZGVm
aW5lIGZHRU5fVENHX1NBMV9jbHJmbmV3KFNIT1JUQ09ERSkgXAorICAgIGRvIHsgXAorICAgICAg
ICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NPTkRfTkUsIFJkViwgXAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaGV4X25ld19wcmVkX3ZhbHVlWzBdLCB0Y2dfY29uc3RhbnRfdGwoMCksIFwK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgIFJkViwgdGNnX2NvbnN0YW50X3RsKDApKTsgXAor
ICAgIH0gd2hpbGUgKDApCisKICNkZWZpbmUgZkdFTl9UQ0dfSjJfcGF1c2UoU0hPUlRDT0RFKSBc
CiAgICAgZG8geyBcCiAgICAgICAgIHVpViA9IHVpVjsgXApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vbWFjcm9zLmggYi90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaAppbmRleCA3NjA2MzBkZThm
Li5iMWZmNDBjODk0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaAorKysgYi90
YXJnZXQvaGV4YWdvbi9tYWNyb3MuaApAQCAtMjI3LDEyICsyMjcsOCBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgZ2VuX2NhbmNlbCh1aW50MzJfdCBzbG90KQogCiAjaWZkZWYgUUVNVV9HRU5FUkFURQog
I2RlZmluZSBmTFNCTkVXKFBWQUwpICAgdGNnX2dlbl9hbmRpX3RsKExTQiwgKFBWQUwpLCAxKQot
I2RlZmluZSBmTFNCTkVXMCAgICAgICAgdGNnX2dlbl9hbmRpX3RsKExTQiwgaGV4X25ld19wcmVk
X3ZhbHVlWzBdLCAxKQotI2RlZmluZSBmTFNCTkVXMSAgICAgICAgdGNnX2dlbl9hbmRpX3RsKExT
QiwgaGV4X25ld19wcmVkX3ZhbHVlWzFdLCAxKQogI2Vsc2UKICNkZWZpbmUgZkxTQk5FVyhQVkFM
KSAgICgoUFZBTCkgJiAxKQotI2RlZmluZSBmTFNCTkVXMCAgICAgICAgKGVudi0+bmV3X3ByZWRf
dmFsdWVbMF0gJiAxKQotI2RlZmluZSBmTFNCTkVXMSAgICAgICAgKGVudi0+bmV3X3ByZWRfdmFs
dWVbMV0gJiAxKQogI2VuZGlmCiAKICNpZmRlZiBRRU1VX0dFTkVSQVRFCi0tIAoyLjI1LjEKCg==

