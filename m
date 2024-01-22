Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC729835B17
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:38:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRnuQ-00035f-Kc; Mon, 22 Jan 2024 01:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnuB-0002uV-0f
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu6-0005iG-BY
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:34 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M5jYmi025012; Mon, 22 Jan 2024 06:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=bI7Ac5ElqYoNGnLgfYdVn0HVuuAwvXTV88MgPQz2x0I=; b=fy
 cekGuGo2DxqIVbR1Hg7wTjaJ5fofGGesxy+2XbLNGQIst1ZhdwSjm1KQRwUUTsWK
 gvtFPzrPqg3vGlPT9ZkIQSy59ACd4o+N2UMEI1xGi1T++1/nZJGt/87RI5K7mS+T
 j97k+JmlSjzwZQZxBdcqFfzFiwiqjee/VnLaj6CU1cD5zrjCESXW/qzTi+ZbLBvd
 Xw+eSNBOCpYwWy7/JvoLnU7fblPiqBp8euw8op5cwSrvIRpCirn7Z3pXWHj9Q06j
 86lZo6G1uEOj4dZrp5k/AWWLwm5Un7hjf/LdKiOYEApt721tr3MFcy+kAa5G8dAp
 koWvmsL++PkdM3SXV1kw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr5s4u45r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M6ZQ4U004566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:27 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 22:35:26 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 07/15] Hexagon (target/hexagon) Make generators object oriented
 - gen_idef_parser_funcs
Date: Sun, 21 Jan 2024 22:34:53 -0800
Message-ID: <20240122063501.782041-8-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8D1MdQhrQm-NlWH5BSTBD4-6fjzwO1as
X-Proofpoint-GUID: 8D1MdQhrQm-NlWH5BSTBD4-6fjzwO1as
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=474 priorityscore=1501 impostorscore=0 malwarescore=0
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2Vk
LWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KTWVzc2FnZS1JZDogPDIwMjMxMjEw
MjIwNzEyLjQ5MTQ5NC02LWx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX2lk
ZWZfcGFyc2VyX2Z1bmNzLnB5IHwgMjAgKysrKy0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2dlbl9pZGVmX3BhcnNlcl9mdW5jcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9p
ZGVmX3BhcnNlcl9mdW5jcy5weQppbmRleCBmNDUxOGU2NTNmLi41NTBhNDhjYjdiIDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3MucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5CkBAIC00Niw2ICs0Niw3IEBAIGRlZiBt
YWluKCk6CiAgICAgaGV4X2NvbW1vbi5yZWFkX3NlbWFudGljc19maWxlKHN5cy5hcmd2WzFdKQog
ICAgIGhleF9jb21tb24ucmVhZF9hdHRyaWJzX2ZpbGUoc3lzLmFyZ3ZbMl0pCiAgICAgaGV4X2Nv
bW1vbi5jYWxjdWxhdGVfYXR0cmlicygpCisgICAgaGV4X2NvbW1vbi5pbml0X3JlZ2lzdGVycygp
CiAgICAgdGFncmVncyA9IGhleF9jb21tb24uZ2V0X3RhZ3JlZ3MoKQogICAgIHRhZ2ltbXMgPSBo
ZXhfY29tbW9uLmdldF90YWdpbW1zKCkKIApAQCAtMTMyLDIyICsxMzMsOSBAQCBkZWYgbWFpbigp
OgogCiAgICAgICAgICAgICBhcmd1bWVudHMgPSBbXQogICAgICAgICAgICAgZm9yIHJlZ3R5cGUs
IHJlZ2lkIGluIHJlZ3M6Ci0gICAgICAgICAgICAgICAgcHJlZml4ID0gImluICIgaWYgaGV4X2Nv
bW1vbi5pc19yZWFkKHJlZ2lkKSBlbHNlICIiCi0KLSAgICAgICAgICAgICAgICBpc19wYWlyID0g
aGV4X2NvbW1vbi5pc19wYWlyKHJlZ2lkKQotICAgICAgICAgICAgICAgIGlzX3NpbmdsZV9vbGQg
PSBoZXhfY29tbW9uLmlzX3NpbmdsZShyZWdpZCkgYW5kIGhleF9jb21tb24uaXNfb2xkX3ZhbCgK
LSAgICAgICAgICAgICAgICAgICAgcmVndHlwZSwgcmVnaWQsIHRhZwotICAgICAgICAgICAgICAg
ICkKLSAgICAgICAgICAgICAgICBpc19zaW5nbGVfbmV3ID0gaGV4X2NvbW1vbi5pc19zaW5nbGUo
cmVnaWQpIGFuZCBoZXhfY29tbW9uLmlzX25ld192YWwoCi0gICAgICAgICAgICAgICAgICAgIHJl
Z3R5cGUsIHJlZ2lkLCB0YWcKLSAgICAgICAgICAgICAgICApCi0KLSAgICAgICAgICAgICAgICBp
ZiBpc19wYWlyIG9yIGlzX3NpbmdsZV9vbGQ6Ci0gICAgICAgICAgICAgICAgICAgIGFyZ3VtZW50
cy5hcHBlbmQoZiJ7cHJlZml4fXtyZWd0eXBlfXtyZWdpZH1WIikKLSAgICAgICAgICAgICAgICBl
bGlmIGlzX3NpbmdsZV9uZXc6Ci0gICAgICAgICAgICAgICAgICAgIGFyZ3VtZW50cy5hcHBlbmQo
ZiJ7cHJlZml4fXtyZWd0eXBlfXtyZWdpZH1OIikKLSAgICAgICAgICAgICAgICBlbHNlOgotICAg
ICAgICAgICAgICAgICAgICBoZXhfY29tbW9uLmJhZF9yZWdpc3RlcihyZWd0eXBlLCByZWdpZCkK
KyAgICAgICAgICAgICAgICByZWcgPSBoZXhfY29tbW9uLmdldF9yZWdpc3Rlcih0YWcsIHJlZ3R5
cGUsIHJlZ2lkKQorICAgICAgICAgICAgICAgIHByZWZpeCA9ICJpbiAiIGlmIHJlZy5pc19yZWFk
KCkgZWxzZSAiIgorICAgICAgICAgICAgICAgIGFyZ3VtZW50cy5hcHBlbmQoZiJ7cHJlZml4fXty
ZWcucmVnX3RjZygpfSIpCiAKICAgICAgICAgICAgIGZvciBpbW1sZXR0LCBiaXRzLCBpbW1zaGlm
dCBpbiBpbW1zOgogICAgICAgICAgICAgICAgIGFyZ3VtZW50cy5hcHBlbmQoaGV4X2NvbW1vbi5p
bW1fbmFtZShpbW1sZXR0KSkKLS0gCjIuMjUuMQoK

