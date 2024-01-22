Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 585AB835B13
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:37:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRnuQ-00035e-KT; Mon, 22 Jan 2024 01:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnuD-0002y5-78
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rRnuA-0005mF-R3
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 01:35:36 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M6Fml1020815; Mon, 22 Jan 2024 06:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=4F7vtuBfRC57vdA/6iJvblIvZCOldoC7JvEvLwfKS74=; b=VJ
 tjTp1s3zxI/lP6sm6kWGDNtrEQo8co2mUfBwlPsMI7HhwS4O63eweT+YE//NrRz7
 THRCrhJ+aouXw9p3COADRnl8CfEmjsE9olFPc/Cbwlo1L+uwu4gYNtj58i83X3J2
 0KetsR9mHGlI/OAZ0jmc09beNOgpXb+kEJ885cb5q79vQ6Hqbn4iCyqkUeGnXBE7
 Mlor5FEy3hzNfx+RVIdnl29yfsQytTTVg5M7ZwgNz64KihQRSdzNMCATMg4m+PMO
 KQyZzs7wjC4FTh6iXc5tQYbdbMM9e3WvKo+V06J0WFozv62BwLzKXsNotFbx26UU
 BaJMlFcqBNK3tGJqovpw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr7bqk0xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M6ZUGm009582
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 06:35:30 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 22:35:30 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 15/15] target/hexagon: reduce scope of def_regnum,
 remove dead assignment
Date: Sun, 21 Jan 2024 22:35:01 -0800
Message-ID: <20240122063501.782041-16-bcain@quicinc.com>
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
X-Proofpoint-GUID: dqu4zF78eFJQmJNbtU4Nhw-Ryw0x4t5W
X-Proofpoint-ORIG-GUID: dqu4zF78eFJQmJNbtU4Nhw-Ryw0x4t5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=423 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

VGhpcyBpcyBpbnRlbmRlZCB0byBhZGRyZXNzIGEgY292ZXJpdHkgZmluZGluZzogQ0lEIDE1Mjc0
MDguCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KUmV2aWV3
ZWQtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxxdWljX21hdGhiZXJuQHF1aWNpbmMu
Y29tPgpNZXNzYWdlLUlkOiA8MjAyNDAxMTQyMzQ0NTMuNDExNDU4Ny0xLWJjYWluQHF1aWNpbmMu
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYyB8IDQgKy0t
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYyBiL3RhcmdldC9o
ZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYwppbmRleCAxNzRlYjNiNzhiLi4yMDJkODRj
N2MwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMK
KysrIGIvdGFyZ2V0L2hleGFnb24vbW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jCkBAIC0zMyw3ICsz
Myw2IEBAIGNoZWNrX25ld192YWx1ZShQYWNrZXQgKnBrdCkKICAgICBjb25zdCBjaGFyICpkc3Rz
dHIgPSBOVUxMOwogICAgIHVpbnQxNl90IGRlZl9vcGNvZGU7CiAgICAgY2hhciBsZXR0ZXI7Ci0g
ICAgaW50IGRlZl9yZWdudW07CiAKICAgICBmb3IgKGkgPSAxOyBpIDwgcGt0LT5udW1faW5zbnM7
IGkrKykgewogICAgICAgICB1aW50MTZfdCB1c2Vfb3Bjb2RlID0gcGt0LT5pbnNuW2ldLm9wY29k
ZTsKQEAgLTc4LDcgKzc3LDYgQEAgY2hlY2tfbmV3X3ZhbHVlKFBhY2tldCAqcGt0KQogICAgICAg
ICAgICAgICAgIH0KICAgICAgICAgICAgIH0KICAgICAgICAgICAgIGlmICgoZHN0c3RyID09IE5V
TEwpICAmJiBHRVRfQVRUUklCKGRlZl9vcGNvZGUsIEFfQ1ZJX0dBVEhFUikpIHsKLSAgICAgICAg
ICAgICAgICBkZWZfcmVnbnVtID0gMDsKICAgICAgICAgICAgICAgICBwa3QtPmluc25baV0ucmVn
bm9bdXNlX3JlZ2lkeF0gPSBkZWZfb3JlZzsKICAgICAgICAgICAgICAgICBwa3QtPmluc25baV0u
bmV3X3ZhbHVlX3Byb2R1Y2VyX3Nsb3QgPSBwa3QtPmluc25bZGVmX2lkeF0uc2xvdDsKICAgICAg
ICAgICAgIH0gZWxzZSB7CkBAIC04Niw3ICs4NCw3IEBAIGNoZWNrX25ld192YWx1ZShQYWNrZXQg
KnBrdCkKICAgICAgICAgICAgICAgICAgICAgLyogc3RpbGwgbm90IHRoZXJlLCB3ZSBoYXZlIGEg
YmFkIHBhY2tldCAqLwogICAgICAgICAgICAgICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OwogICAgICAgICAgICAgICAgIH0KLSAgICAgICAgICAgICAgICBkZWZfcmVnbnVtID0gcGt0LT5p
bnNuW2RlZl9pZHhdLnJlZ25vW2RzdHN0ciAtIHJlZ2luZm9dOworICAgICAgICAgICAgICAgIGlu
dCBkZWZfcmVnbnVtID0gcGt0LT5pbnNuW2RlZl9pZHhdLnJlZ25vW2RzdHN0ciAtIHJlZ2luZm9d
OwogICAgICAgICAgICAgICAgIC8qIE5vdyBwYXRjaCB1cCB0aGUgY29uc3VtZXIgd2l0aCB0aGUg
cmVnaXN0ZXIgbnVtYmVyICovCiAgICAgICAgICAgICAgICAgcGt0LT5pbnNuW2ldLnJlZ25vW3Vz
ZV9yZWdpZHhdID0gZGVmX3JlZ251bSBeIGRlZl9vcmVnOwogICAgICAgICAgICAgICAgIC8qIHNw
ZWNpYWwgY2FzZSBmb3IgKFZ4LFZ5KSAqLwotLSAKMi4yNS4xCgo=

