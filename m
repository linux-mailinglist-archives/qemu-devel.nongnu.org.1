Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4858835B0F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:37:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRnuI-0002xV-Bl; Mon, 22 Jan 2024 01:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnuB-0002ui-3j
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnu6-0005ih-Ul
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:34 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M4OgoI000401; Mon, 22 Jan 2024 06:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=dFH+HG06zfKiopktb353Moq6doZG2fZedvCoF+a14f8=; b=ha
 kHIFP/ErA8mQVUlafnqtUWwcJoGXiBIVJF1rBa7/F8yhtvNf/mav6re7x2aibqr6
 VWW4MQgQSFWLENTwzWDwYMoGDVPQT8a2xMWsEqZWM+TOxi4azQt4g2ENx78S4mnu
 e4n2qWalgjT66KiY02/ymH0GeLnEF+EgNPOZBIRnL3LDAX/OuwJ0zNL0+r5qR4k1
 TXdlN9EhMyNGEZ570n72bMNOVRqfh0oqPYQryp8mrBmMGHAPd8e/cr7XXvgDYEZF
 quuluSJU0QCYFzLAgQi0py26lZziG50IJmDerfvC3tuCflxQyuoSygQvN098pbSl
 8Qw9Jh+XgGIN/35cTbUQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr56d35g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M6ZQ4W004566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:27 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 22:35:27 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 08/15] Hexagon (target/hexagon) Make generators object oriented
 - gen_op_regs
Date: Sun, 21 Jan 2024 22:34:54 -0800
Message-ID: <20240122063501.782041-9-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RtJSL5eBqIjdLBp2jVfhmbpCGXaPmZTE
X-Proofpoint-GUID: RtJSL5eBqIjdLBp2jVfhmbpCGXaPmZTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 mlxlogscore=373 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClJldmlld2Vk
LWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KU2lnbmVkLW9mZi1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KTWVzc2FnZS1JZDogPDIwMjMxMjEw
MjIwNzEyLjQ5MTQ5NC03LWx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX29w
X3JlZ3MucHkgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fb3BfcmVncy5weSBi
L3RhcmdldC9oZXhhZ29uL2dlbl9vcF9yZWdzLnB5CmluZGV4IGE4YTc3MTIxMjkuLjdiN2IzMzg5
NWEgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl9vcF9yZWdzLnB5CisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2dlbl9vcF9yZWdzLnB5CkBAIC03MCw2ICs3MCw3IEBAIGRlZiBzdHJpcF9yZWdf
cHJlZml4KHgpOgogZGVmIG1haW4oKToKICAgICBoZXhfY29tbW9uLnJlYWRfc2VtYW50aWNzX2Zp
bGUoc3lzLmFyZ3ZbMV0pCiAgICAgaGV4X2NvbW1vbi5yZWFkX2F0dHJpYnNfZmlsZShzeXMuYXJn
dlsyXSkKKyAgICBoZXhfY29tbW9uLmluaXRfcmVnaXN0ZXJzKCkKICAgICB0YWdyZWdzID0gaGV4
X2NvbW1vbi5nZXRfdGFncmVncyhmdWxsPVRydWUpCiAgICAgdGFnaW1tcyA9IGhleF9jb21tb24u
Z2V0X3RhZ2ltbXMoKQogCkBAIC04MCwxMSArODEsMTIgQEAgZGVmIG1haW4oKToKICAgICAgICAg
ICAgIHdyZWdzID0gW10KICAgICAgICAgICAgIHJlZ2lkcyA9ICIiCiAgICAgICAgICAgICBmb3Ig
cmVndHlwZSwgcmVnaWQsIF8sIG51bXJlZ3MgaW4gcmVnczoKLSAgICAgICAgICAgICAgICBpZiBo
ZXhfY29tbW9uLmlzX3JlYWQocmVnaWQpOgorICAgICAgICAgICAgICAgIHJlZyA9IGhleF9jb21t
b24uZ2V0X3JlZ2lzdGVyKHRhZywgcmVndHlwZSwgcmVnaWQpCisgICAgICAgICAgICAgICAgaWYg
cmVnLmlzX3JlYWQoKToKICAgICAgICAgICAgICAgICAgICAgaWYgcmVnaWRbMF0gbm90IGluIHJl
Z2lkczoKICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lkcyArPSByZWdpZFswXQogICAgICAg
ICAgICAgICAgICAgICBycmVncy5hcHBlbmQocmVndHlwZSArIHJlZ2lkICsgbnVtcmVncykKLSAg
ICAgICAgICAgICAgICBpZiBoZXhfY29tbW9uLmlzX3dyaXR0ZW4ocmVnaWQpOgorICAgICAgICAg
ICAgICAgIGlmIHJlZy5pc193cml0dGVuKCk6CiAgICAgICAgICAgICAgICAgICAgIHdyZWdzLmFw
cGVuZChyZWd0eXBlICsgcmVnaWQgKyBudW1yZWdzKQogICAgICAgICAgICAgICAgICAgICBpZiBy
ZWdpZFswXSBub3QgaW4gcmVnaWRzOgogICAgICAgICAgICAgICAgICAgICAgICAgcmVnaWRzICs9
IHJlZ2lkWzBdCi0tIAoyLjI1LjEKCg==

