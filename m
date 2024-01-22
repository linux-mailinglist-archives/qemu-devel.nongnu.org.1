Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E93DA835B12
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:37:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRnuU-00038v-B2; Mon, 22 Jan 2024 01:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnuB-0002wh-S4
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu8-0005ix-4Y
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:35 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M3M5qm022950; Mon, 22 Jan 2024 06:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=vDtJiwCkO5zIwS9JE32m5F/Vk41BRwcMTgmSJGPsWeE=; b=IX
 3vkXLP5jMzZjlEI4JOgkNi+O7wqsuNXjfzK7inW1mI8AYydpAkYjnL45nXTpTTNm
 z6uaDg566nF+ef5NI1KOGglmLwX0vTv7ZostknA/eXCGbygzoLF0QrjJ6/V2yC9X
 IzJ0i4AhSixedRhunNiLE2lKb6xwi3mGJIFuL8tO1kak+2vSfJPwXy58XLT1sQCp
 5r/jqUJ00pqDupB+00/oVVrjH7TDCIKHbdW6XDTXSBNOvqGFUWFMhK+p1WFbvNwQ
 T7e49O5DPett0DzBdQLL3OcyY/hQwqmqu3TpPYVNl2p0d824NUirDw/mmANA53g5
 4OF5oqlC61PMp6ZS3I+Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr5s4u45t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M6ZS7r004593
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:28 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 22:35:28 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 10/15] Hexagon (target/hexagon) Remove unused WRITES_PRED_REG
 attribute
Date: Sun, 21 Jan 2024 22:34:56 -0800
Message-ID: <20240122063501.782041-11-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122063501.782041-1-bcain@quicinc.com>
References: <20240122063501.782041-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: NeRLunDlowrbdtZS2iFBrC6xQezyAyk1
X-Proofpoint-GUID: NeRLunDlowrbdtZS2iFBrC6xQezyAyk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1
 mlxscore=1 suspectscore=0
 spamscore=1 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=223 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220046
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClRoaXMgaXMg
dGhlIG9ubHkgcmVtYWluaW5nIHVzZSBvZiB0aGUgaXNfd3JpdHRlbiBmdW5jdGlvbi4gIFdlIHdp
bGwKcmVtb3ZlIGl0IGluIHRoZSBzdWJzZXF1ZW50IGNvbW1pdC4KClNpZ25lZC1vZmYtYnk6IFRh
eWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBCcmlh
biBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KTWVzc2FnZS1JZDogPDIwMjMxMjEwMjIwNzEyLjQ5
MTQ5NC05LWx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5p
bmMgfCAgMSAtCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICB8IDExIC0tLS0tLS0t
LS0tCiAyIGZpbGVzIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYu
aC5pbmMKaW5kZXggMjFkNDU3ZmE0YS4uODc5NDJkNDZmNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vYXR0cmlic19kZWYuaC5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYu
aC5pbmMKQEAgLTExNyw3ICsxMTcsNiBAQCBERUZfQVRUUklCKElNUExJQ0lUX1JFQURTX1AxLCAi
UmVhZHMgdGhlIFAxIHJlZ2lzdGVyIiwgIiIsICIiKQogREVGX0FUVFJJQihJTVBMSUNJVF9SRUFE
U19QMiwgIlJlYWRzIHRoZSBQMiByZWdpc3RlciIsICIiLCAiIikKIERFRl9BVFRSSUIoSU1QTElD
SVRfUkVBRFNfUDMsICJSZWFkcyB0aGUgUDMgcmVnaXN0ZXIiLCAiIiwgIiIpCiBERUZfQVRUUklC
KElNUExJQ0lUX1dSSVRFU19VU1IsICJNYXkgd3JpdGUgVVNSIiwgIiIsICIiKQotREVGX0FUVFJJ
QihXUklURVNfUFJFRF9SRUcsICJXcml0ZXMgYSBwcmVkaWNhdGUgcmVnaXN0ZXIiLCAiIiwgIiIp
CiBERUZfQVRUUklCKENPTU1VVEVTLCAiVGhlIG9wZXJhdGlvbiBpcyBjb21tdW5pdGl2ZSIsICIi
LCAiIikKIERFRl9BVFRSSUIoREVBTExPQ1JFVCwgImRlYWxsb2NfcmV0dXJuIiwgIiIsICIiKQog
REVGX0FUVFJJQihERUFMTE9DRlJBTUUsICJkZWFsbG9jZnJhbWUiLCAiIiwgIiIpCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2Nv
bW1vbi5weQppbmRleCA0NTY1ZGQxOTUzLi5jYTVlOTYzMGMxIDEwMDc1NQotLS0gYS90YXJnZXQv
aGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkK
QEAgLTk0LDEwICs5NCw2IEBAIGRlZiBpc19jb25kX2NhbGwodGFnKToKIGRlZiBjYWxjdWxhdGVf
YXR0cmlicygpOgogICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlJFQURfUEMiLCAiQV9JTVBM
SUNJVF9SRUFEU19QQyIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmVFJBUCIsICJBX0lN
UExJQ0lUX1JFQURTX1BDIikKLSAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZXUklURV9QMCIs
ICJBX1dSSVRFU19QUkVEX1JFRyIpCi0gICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmV1JJVEVf
UDEiLCAiQV9XUklURVNfUFJFRF9SRUciKQotICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZldS
SVRFX1AyIiwgIkFfV1JJVEVTX1BSRURfUkVHIikKLSAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIo
ImZXUklURV9QMyIsICJBX1dSSVRFU19QUkVEX1JFRyIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0
cmliKCJmU0VUX09WRVJGTE9XIiwgIkFfSU1QTElDSVRfV1JJVEVTX1VTUiIpCiAgICAgYWRkX3Fl
bXVfbWFjcm9fYXR0cmliKCJmU0VUX0xQQ0ZHIiwgIkFfSU1QTElDSVRfV1JJVEVTX1VTUiIpCiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmTE9BRCIsICJBX1NDQUxBUl9MT0FEIikKQEAgLTEy
MiwxMyArMTE4LDYgQEAgZGVmIGNhbGN1bGF0ZV9hdHRyaWJzKCk6CiAgICAgICAgICAgICAgICAg
Y29udGludWUKICAgICAgICAgICAgIG1hY3JvID0gbWFjcm9zW21hY25hbWVdCiAgICAgICAgICAg
ICBhdHRyaWJkaWN0W3RhZ10gfD0gc2V0KG1hY3JvLmF0dHJpYnMpCi0gICAgIyBGaWd1cmUgb3V0
IHdoaWNoIGluc3RydWN0aW9ucyB3cml0ZSBwcmVkaWNhdGUgcmVnaXN0ZXJzCi0gICAgdGFncmVn
cyA9IGdldF90YWdyZWdzKCkKLSAgICBmb3IgdGFnIGluIHRhZ3M6Ci0gICAgICAgIHJlZ3MgPSB0
YWdyZWdzW3RhZ10KLSAgICAgICAgZm9yIHJlZ3R5cGUsIHJlZ2lkIGluIHJlZ3M6Ci0gICAgICAg
ICAgICBpZiByZWd0eXBlID09ICJQIiBhbmQgaXNfd3JpdHRlbihyZWdpZCk6Ci0gICAgICAgICAg
ICAgICAgYXR0cmliZGljdFt0YWddLmFkZCgiQV9XUklURVNfUFJFRF9SRUciKQogICAgICMgTWFy
ayBjb25kaXRpb25hbCBqdW1wcyBhbmQgY2FsbHMKICAgICAjICAgICBOb3QgYWxsIGluc3RydWN0
aW9ucyBhcmUgcHJvcGVybHkgbWFya2VkIHdpdGggQV9DT05ERVhFQwogICAgIGZvciB0YWcgaW4g
dGFnczoKLS0gCjIuMjUuMQoK

