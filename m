Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D537B70FC02
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 18:55:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1rkg-0007x0-AU; Wed, 24 May 2023 12:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q1rkc-0007wq-Vt
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:54:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q1rkZ-0000n5-Qy
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:54:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34OGZKUM030881; Wed, 24 May 2023 16:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+nb9J8Z+arM5XsF1Pit1ou+/F6KNyLc4IAXQ8nF9avw=;
 b=T/mjNBbAklsveycfuNdmJRe9mH62t626Mwy7N9saamsSJAamFtzSb+QA5xEujoOtSAYU
 4h4pfNUoNSERVu/FLyBzC/cFgrVj+iBBM8i5MWw9b9+Tvw2oZz+7XPH4GGiaNY6Tij7V
 GkWR6NZclErXw+uMZX7iGAOY6yhvTfb3B5CLmOJw5IrwAwBqWK25EHo7AKhEkCnsjZWw
 cURTmzLO9QY4syQL17MaIRpg1q7Pa2yuqN6WkCfdr4xG/zN/Hmx1KqElKd6GSoLI4Hvo
 b6uXS7JehDAKXQu71pdTZ3U0Ou7ZLrouLFTHUrI3arr5sesSHKmgKAhTwdD1GtYNm8W/ AQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs42utcg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 16:54:05 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34OGs3M4002928; 
 Wed, 24 May 2023 16:54:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3qrdtpw5hx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 16:54:03 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34OGs3bj002908;
 Wed, 24 May 2023 16:54:03 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 34OGs3q3002894
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 16:54:03 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id 07FC5663; Wed, 24 May 2023 09:54:03 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, bcain@quicinc.com, quic_mathbern@quicinc.com,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
Subject: [PATCH 1/1] Hexagon (target/hexagon) Change Hexagon maintainer
Date: Wed, 24 May 2023 09:53:55 -0700
Message-Id: <20230524165355.3157700-2-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524165355.3157700-1-tsimpson@quicinc.com>
References: <20230524165355.3157700-1-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: eblAW9cyvve8O9di8pAMEuT5ILd6se1t
X-Proofpoint-GUID: eblAW9cyvve8O9di8pAMEuT5ILd6se1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=592 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240138
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=tsimpson@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Q2hhbmdlIEhleGFnb24gbWFpbnRhaW5lciBmcm9tIFRheWxvciBTaW1wc29uIHRvIEJyaWFuIENh
aW4KUHV0IFRheWxvcidzIGdtYWlsIGFkZHJlc3MgaW4gLm1haWxtYXAKClNpZ25lZC1vZmYtYnk6
IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiBNQUlOVEFJTkVSUyB8
IDIgKy0KIC5tYWlsbWFwICAgIHwgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMK
aW5kZXggMWI2NDY2NDk2ZC4uNDI2ZDMzZjRjYiAxMDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysr
IGIvTUFJTlRBSU5FUlMKQEAgLTIxNSw3ICsyMTUsNyBAQCBGOiB0ZXN0cy90Y2cvY3Jpcy8KIEY6
IGRpc2FzL2NyaXMuYwogCiBIZXhhZ29uIFRDRyBDUFVzCi1NOiBUYXlsb3IgU2ltcHNvbiA8dHNp
bXBzb25AcXVpY2luYy5jb20+CitNOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KIFM6
IFN1cHBvcnRlZAogRjogdGFyZ2V0L2hleGFnb24vCiBYOiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBh
cnNlci8KZGlmZiAtLWdpdCBhLy5tYWlsbWFwIGIvLm1haWxtYXAKaW5kZXggYmJlNmQzZmQ2OS4u
YjU3ZGE0ODI3ZSAxMDA2NDQKLS0tIGEvLm1haWxtYXAKKysrIGIvLm1haWxtYXAKQEAgLTc4LDYg
Kzc4LDcgQEAgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPiA8cGhp
bG1kQHJlZGhhdC5jb20+CiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5v
cmc+IDxwaGlsbWRAZnVuZ2libGUuY29tPgogU3RlZmFuIEJyYW5rb3ZpYyA8c3RlZmFuLmJyYW5r
b3ZpY0BzeXJtaWEuY29tPiA8c3RlZmFuLmJyYW5rb3ZpY0BydC1yay5jb20uY29tPgogWW9uZ2Jv
ayBLaW0gPHlvbmdib2sua2ltQG1pcHMuY29tPiA8eW9uZ2Jvay5raW1AaW1ndGVjLmNvbT4KK1Rh
eWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+IDx0c2ltcHNvbkBxdWljaW5j
LmNvbT4KIAogIyBBbHNvIGxpc3QgcHJlZmVycmVkIG5hbWUgZm9ybXMgd2hlcmUgcGVvcGxlIGhh
dmUgY2hhbmdlZCB0aGVpcgogIyBnaXQgYXV0aG9yIGNvbmZpZywgb3IgaGFkIHV0ZjgvbGF0aW4x
IGVuY29kaW5nIGlzc3Vlcy4KLS0gCjIuMjUuMQoK

