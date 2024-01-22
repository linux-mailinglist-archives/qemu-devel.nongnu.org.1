Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A34835B0A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:36:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRnuR-00037n-Bt; Mon, 22 Jan 2024 01:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnuB-0002v6-6d
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu6-0005hz-BL
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:34 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M6OT8h024757; Mon, 22 Jan 2024 06:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=IYiZk/GBqRHJeJPrwnR4FO2QwYacn8pHriutCfzyGH0=; b=bM
 crogphNxgM4NgaaYgamGSmiE4EZhZTktbHdN2Dbbap7jxR1kMZMnanqREbIqD8QX
 uiEEowLNRjVebB37u37YGAJkaWHpcEAi2hh3plFgjWVBMwDBskF1uJWBy23VGhnf
 Ar090K/WKtE9Hk5ApiTHcBXZuUyOAjZET3ecJajHI5xuP0KFhBjBiYSKj2AGJEBR
 oQSAWAgnk7vs0mbX2aNtg4tfaLC41C/icgT8Ghes1DaSvD8AXEo1tC24HtsTNcS/
 dGJTYeqqHSMaR4Nd3WYPLb5rbQeGE5lXuy+X8IP/nrRiW/oHD0PK8N66prqFvjDF
 LvH24k2ze8qCXqPQRWvA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr54wu5r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M6ZPc3009493
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:25 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 22:35:24 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 02/15] Hexagon (target/hexagon) Fix shadow variable when
 idef-parser is off
Date: Sun, 21 Jan 2024 22:34:48 -0800
Message-ID: <20240122063501.782041-3-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CskULiHEHPc9j8XGJ7MtcgqpE8NqCoWi
X-Proofpoint-GUID: CskULiHEHPc9j8XGJ7MtcgqpE8NqCoWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxlogscore=486 clxscore=1011 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220046
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkFkZGluZyAt
V2Vycm9yPXNoYWRvdz1jb21wYXRpYmxlLWxvY2FsIGNhdXNlcyBIZXhhZ29uIG5vdCB0byBidWls
ZAp3aGVuIGlkZWYtcGFyc2VyIGlzIG9mZi4gIFRoZSAibGFiZWwiIHZhcmlhYmxlIGluIENIRUNL
X05PU0hVRl9QUkVECnNoYWRvd3MgYSB2YXJpYWJsZSBpbiB0aGUgc3Vycm91bmRpbmcgY29kZS4K
ClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+
ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KTWVzc2FnZS1JZDog
PDIwMjMxMTMwMTgzOTU1LjU0MzE0LTEtbHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdv
bi9tYWNyb3MuaCB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oIGIvdGFy
Z2V0L2hleGFnb24vbWFjcm9zLmgKaW5kZXggOWE1MWI1NzA5Yi4uZjk5MzkwZTJhOCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9z
LmgKQEAgLTkzLDEzICs5MywxMyBAQAogCiAjZGVmaW5lIENIRUNLX05PU0hVRl9QUkVEKEdFVF9F
QSwgU0laRSwgUFJFRCkgXAogICAgIGRvIHsgXAotICAgICAgICBUQ0dMYWJlbCAqbGFiZWwgPSBn
ZW5fbmV3X2xhYmVsKCk7IFwKLSAgICAgICAgdGNnX2dlbl9icmNvbmRpX3RsKFRDR19DT05EX0VR
LCBQUkVELCAwLCBsYWJlbCk7IFwKKyAgICAgICAgVENHTGFiZWwgKm5vc2h1Zl9sYWJlbCA9IGdl
bl9uZXdfbGFiZWwoKTsgXAorICAgICAgICB0Y2dfZ2VuX2JyY29uZGlfdGwoVENHX0NPTkRfRVEs
IFBSRUQsIDAsIG5vc2h1Zl9sYWJlbCk7IFwKICAgICAgICAgR0VUX0VBOyBcCiAgICAgICAgIGlm
IChpbnNuLT5zbG90ID09IDAgJiYgY3R4LT5wa3QtPnBrdF9oYXNfc3RvcmVfczEpIHsgXAogICAg
ICAgICAgICAgcHJvYmVfbm9zaHVmX2xvYWQoRUEsIFNJWkUsIGN0eC0+bWVtX2lkeCk7IFwKICAg
ICAgICAgfSBcCi0gICAgICAgIGdlbl9zZXRfbGFiZWwobGFiZWwpOyBcCisgICAgICAgIGdlbl9z
ZXRfbGFiZWwobm9zaHVmX2xhYmVsKTsgXAogICAgICAgICBpZiAoaW5zbi0+c2xvdCA9PSAwICYm
IGN0eC0+cGt0LT5wa3RfaGFzX3N0b3JlX3MxKSB7IFwKICAgICAgICAgICAgIHByb2Nlc3Nfc3Rv
cmUoY3R4LCAxKTsgXAogICAgICAgICB9IFwKLS0gCjIuMjUuMQoK

