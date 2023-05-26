Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3B712824
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YJ7-0005qB-Jm; Fri, 26 May 2023 10:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q2YJ5-0005pB-FJ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:20:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q2YJ2-0007CV-Ly
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:20:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QDuOv2010139; Fri, 26 May 2023 14:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tfRkx1RV0pm/XNJq7P/Pus6COtErLqnqzsu1xbrkqhg=;
 b=Zw5L8frMNMEvojjiXh3zwBzTu94WjDggtrmItG6bKmK9lvSskmI06xPAFds0RazovqDJ
 ButeqX4zBlA934Tc1OPtJkkMRPMEpOByP/9B9yl8JjruT/8xHv19gEbMTyXcg8E3MxFl
 JgrukR/ZcK1GSPCaY6Rkbnwy3GbvzP9UbC8tsQtZ52XU0+RIUw5K5Nf1RScB4WloksuA
 oPWnlz5Oqv2hgC0+t1AB6d97BNs1f0cK2TVO5jbPx7LF4GhFqWxk0ppfS4s5qKIFHzhV
 dRLkK9nPDQQXmT6pWI3iktwS/BBf5wK+SFrlOIUaxHQE8jt5ZIZ+1zdqHKbLL3oWVIcI TA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt5ufu4d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:32 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34QEKVd5032706; 
 Fri, 26 May 2023 14:20:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3qt382gsk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:31 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QEKUWa032690;
 Fri, 26 May 2023 14:20:30 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 34QEKUJV032673
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:30 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id AF9506D0; Fri, 26 May 2023 07:20:29 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com
Subject: [PULL 5/5] Hexagon (target/hexagon) Change Hexagon maintainer
Date: Fri, 26 May 2023 07:20:28 -0700
Message-Id: <20230526142028.1277954-6-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526142028.1277954-1-tsimpson@quicinc.com>
References: <20230526142028.1277954-1-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: igSG_hs6U9w-hpDs4ZgXxVnABKaaWNVc
X-Proofpoint-GUID: igSG_hs6U9w-hpDs4ZgXxVnABKaaWNVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_05,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxlogscore=461 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260120
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

Q2hhbmdlIEhleGFnb24gbWFpbnRhaW5lciBmcm9tIFRheWxvciBTaW1wc29uIHRvIEJyaWFuIENh
aW4KUHV0IFRheWxvcidzIGdtYWlsIGFkZHJlc3MgaW4gLm1haWxtYXAKClNpZ25lZC1vZmYtYnk6
IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXgg
QmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZwpNZXNzYWdlLUlkOiA8MjAyMzA1MjQxNjUz
NTUuMzE1NzcwMC0yLXRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIE1BSU5UQUlORVJTIHwgMiAr
LQogLm1haWxtYXAgICAgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwppbmRl
eCAxYzkzYWIwZWU1Li40YjAyNWE3YjYzIDEwMDY0NAotLS0gYS9NQUlOVEFJTkVSUworKysgYi9N
QUlOVEFJTkVSUwpAQCAtMjE4LDcgKzIxOCw3IEBAIEY6IHRlc3RzL3RjZy9jcmlzLwogRjogZGlz
YXMvY3Jpcy5jCiAKIEhleGFnb24gVENHIENQVXMKLU06IFRheWxvciBTaW1wc29uIDx0c2ltcHNv
bkBxdWljaW5jLmNvbT4KK006IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPgogUzogU3Vw
cG9ydGVkCiBGOiB0YXJnZXQvaGV4YWdvbi8KIFg6IHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2Vy
LwpkaWZmIC0tZ2l0IGEvLm1haWxtYXAgYi8ubWFpbG1hcAppbmRleCBiYmU2ZDNmZDY5Li5iNTdk
YTQ4MjdlIDEwMDY0NAotLS0gYS8ubWFpbG1hcAorKysgYi8ubWFpbG1hcApAQCAtNzgsNiArNzgs
NyBAQCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+IDxwaGlsbWRA
cmVkaGF0LmNvbT4KIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4g
PHBoaWxtZEBmdW5naWJsZS5jb20+CiBTdGVmYW4gQnJhbmtvdmljIDxzdGVmYW4uYnJhbmtvdmlj
QHN5cm1pYS5jb20+IDxzdGVmYW4uYnJhbmtvdmljQHJ0LXJrLmNvbS5jb20+CiBZb25nYm9rIEtp
bSA8eW9uZ2Jvay5raW1AbWlwcy5jb20+IDx5b25nYm9rLmtpbUBpbWd0ZWMuY29tPgorVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4gPHRzaW1wc29uQHF1aWNpbmMuY29t
PgogCiAjIEFsc28gbGlzdCBwcmVmZXJyZWQgbmFtZSBmb3JtcyB3aGVyZSBwZW9wbGUgaGF2ZSBj
aGFuZ2VkIHRoZWlyCiAjIGdpdCBhdXRob3IgY29uZmlnLCBvciBoYWQgdXRmOC9sYXRpbjEgZW5j
b2RpbmcgaXNzdWVzLgotLSAKMi4yNS4xCgo=

