Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB7708914
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjrt-0000Xs-8j; Thu, 18 May 2023 16:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrd-00009R-TT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1pzjrR-00057B-5D
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:04:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IJekx6023139; Thu, 18 May 2023 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XO+PTLUuIKsfm+hUT+BJ5RaYUUS9yjRB7c7q5ZdIgec=;
 b=FqH0G54CyliEMPsVvUQO5xDp6qgbZPA2tbHblFphHmcKS4U8X9r+zmPQrmBclAnb6bc1
 qQ292MMX7zfnBVPIx3q1hznSFTIw8VjBegNQ06sHeVM2aAJTThzdYgsP852JH32lbUcL
 E53HeLEhOSmaSG3+g2td36ZUht26tVKuzIqt4Avi7JtVI1xIzgOMj7jfIk0TkhE0kAQk
 yvubF4UqiOQWBpOR5JYAkzY+jTRAZ5ovnhF7ld8MTqwccSQ4iXuvqCSjcr8w527KJH4t
 ws6KXQIcSnA0PIpduAKH4SIJTjwzvdFD2buE78GYM4o+u0QN/FtuWi0/iIBFRpPTCXDx 9w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmxyp3sa2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:17 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IK4GSO013707; 
 Thu, 18 May 2023 20:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qmrx7jyxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:16 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IK4FFb013688;
 Thu, 18 May 2023 20:04:16 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34IK4FUG013649
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 20:04:15 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id AD8FD6E4; Thu, 18 May 2023 13:04:13 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com
Subject: [PULL v2 35/44] Hexagon: append eflags to unknown cpu model string
Date: Thu, 18 May 2023 13:04:02 -0700
Message-Id: <20230518200411.271148-36-tsimpson@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LQXTOaEq69tH1-4wvoE8BJSJ4exHu_Id
X-Proofpoint-GUID: LQXTOaEq69tH1-4wvoE8BJSJ4exHu_Id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=470
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpSdW5uaW5nIHFlbXUtaGV4YWdvbiB3aXRoIGEgYmluYXJ5IHRoYXQgd2FzIGNvbXBpbGVk
IGZvciBhbiBhcmNoIHZlcnNpb24KdW5rbm93biBieSBxZW11IGNhbiBwcm9kdWNlIGEgc29tZXdo
YXQgY29uZnVzaW5nIG1lc3NhZ2U6CgogIHFlbXUtaGV4YWdvbjogdW5hYmxlIHRvIGZpbmQgQ1BV
IG1vZGVsICd1bmtub3duJwoKTGV0J3MgZ2l2ZSBhIGJpdCBtb3JlIGluZm8gYnkgYXBwZW5kaW5n
IHRoZSBlZmxhZ3Mgc28gdGhhdCB0aGUgbWVzc2FnZQpiZWNvbWVzOgoKICBxZW11LWhleGFnb246
IHVuYWJsZSB0byBmaW5kIENQVSBtb2RlbCAndW5rbm93biAoMHg2OSknCgpTaWduZWQtb2ZmLWJ5
OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT4K
U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgpUZXN0
ZWQtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6
IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KTWVzc2FnZS1JZDogPDhhOGQw
MTNjYzYxOWI5NGZkNGZiNTc3YWU2YThkZjI2Y2VkYjk3MmIuMTY4MzIyNTgwNC5naXQucXVpY19t
YXRoYmVybkBxdWljaW5jLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5o
IHwgNyArKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYuaCBiL2xpbnV4
LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmgKaW5kZXggYTAyNzFhMGEyYS4uMzYwNTZmYzlmMCAx
MDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYuaAorKysgYi9saW51eC11
c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCkBAIC0yMCw2ICsyMCw5IEBACiAKIHN0YXRpYyBpbmxp
bmUgY29uc3QgY2hhciAqY3B1X2dldF9tb2RlbCh1aW50MzJfdCBlZmxhZ3MpCiB7CisgICAgc3Rh
dGljIGNoYXIgYnVmWzMyXTsKKyAgICBpbnQgZXJyOworCiAgICAgLyogRm9yIG5vdywgdHJlYXQg
YW55dGhpbmcgbmV3ZXIgdGhhbiB2NSBhcyBhIHY3MyAqLwogICAgIC8qIEZJWE1FIC0gRGlzYWJs
ZSBpbnN0cnVjdGlvbnMgdGhhdCBhcmUgbmV3ZXIgdGhhbiB0aGUgc3BlY2lmaWVkIGFyY2ggKi8K
ICAgICBpZiAoZWZsYWdzID09IDB4MDQgfHwgICAgLyogdjUgICovCkBAIC0zOSw3ICs0Miw5IEBA
IHN0YXRpYyBpbmxpbmUgY29uc3QgY2hhciAqY3B1X2dldF9tb2RlbCh1aW50MzJfdCBlZmxhZ3Mp
CiAgICAgICAgKSB7CiAgICAgICAgIHJldHVybiAidjczIjsKICAgICB9Ci0gICAgcmV0dXJuICJ1
bmtub3duIjsKKworICAgIGVyciA9IHNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksICJ1bmtub3du
ICgweCV4KSIsIGVmbGFncyk7CisgICAgcmV0dXJuIGVyciA+PSAwICYmIGVyciA8IHNpemVvZihi
dWYpID8gYnVmIDogInVua25vd24iOwogfQogCiAjZW5kaWYKLS0gCjIuMjUuMQoK

