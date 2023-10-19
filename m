Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B47CEDEC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 04:19:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtIbh-00005s-JD; Wed, 18 Oct 2023 22:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qtIbf-00005b-7W
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 22:17:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qtIba-0001yH-Mr
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 22:17:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39J0sl6I008817; Thu, 19 Oct 2023 02:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=x760ds0qt+z9yywojooYyX/z1TVZtvbEtY731ytdkHw=;
 b=WkuV3Ead+lvPq+wh4E3arjfB6CyEdOalhQmnVkD4jZrDmUhq6FbCl4LeloiHphPyjipw
 hiehzn7/Bikc6Fp4qhOic+jJdDDU/YMWiRQ3bfBak/gqGGGZcbpK+W3E1sbP8WGSj5Qv
 AiHujq3l0zgkVZXF7D4EY+BjKdJXTnzoPqxAVwvdHyYEGdhNkjJ/ZKZBXEPCYx51T7ac
 qF5dwUToGtsf0ie/rFEmaQahdQ6jGZ37x8ABUlkR6ZcDdvy7YB/N7P4KmgI8g7WBNMLo
 G7M0gSpPal8aAZNx4merH3ZcV1rxGdhbhzFKasL/pbvYh2emCtqTmbOmh9zHNQJSa/Lc SQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt6mw2pvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 02:17:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J2Hfk6002324
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 02:17:41 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 19:17:41 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 0/2] hex queue - GETPC() fixes, shadowing fixes
Date: Wed, 18 Oct 2023 19:17:31 -0700
Message-ID: <20231019021733.2258592-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: kO-9i_lSywa2We-Vt9LqQlXTTzH8oUu0
X-Proofpoint-GUID: kO-9i_lSywa2We-Vt9LqQlXTTzH8oUu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxlogscore=569 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190017
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkZWFjYTNmZDMwZDNhODgyOTE2MGY4
ZDM3MDVkNjVhZDgzMTc2ODAwOgoKICBNZXJnZSB0YWcgJ3B1bGwtdmZpby0yMDIzMTAxOCcgb2Yg
aHR0cHM6Ly9naXRodWIuY29tL2xlZ29hdGVyL3FlbXUgaW50byBzdGFnaW5nICgyMDIzLTEwLTE4
IDA2OjIxOjE1IC0wNDAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6
CgogIGh0dHBzOi8vZ2l0aHViLmNvbS9xdWljL3FlbXUgdGFncy9wdWxsLWhleC0yMDIzMTAxOAoK
Zm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDIwYzM0YTkyMTZmNDE5Nzc4MDM2NTlmNWJk
NDU4NjE4YzI5MWQ1NmM6CgogIHRhcmdldC9oZXhhZ29uOiBmaXggc29tZSBvY2N1cnJlbmNlcyBv
ZiAtV3NoYWRvdz1sb2NhbCAoMjAyMy0xMC0xOCAxNjo1NjoxNyAtMDcwMCkKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KaGV4
YWdvbjogR0VUUEMoKSBmaXhlcywgc2hhZG93aW5nIGZpeGVzCgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkJyaWFuIENhaW4g
KDEpOgogICAgICB0YXJnZXQvaGV4YWdvbjogZml4IHNvbWUgb2NjdXJyZW5jZXMgb2YgLVdzaGFk
b3c9bG9jYWwKCk1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vICgxKToKICAgICAgdGFyZ2V0L2hl
eGFnb246IG1vdmUgR0VUUEMoKSBjYWxscyB0byB0b3AgbGV2ZWwgaGVscGVycwoKIHRhcmdldC9o
ZXhhZ29uL2ltcG9ydGVkL2FsdS5pZGVmIHwgIDYgKy0tCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3Mu
aCAgICAgICAgICB8IDE5ICsrKysrLS0tLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmgg
ICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgfCA4NCArKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuaCAgICAgICB8ICA5IC0tLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICB8
IDEwICsrLS0tCiA2IGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDgwIGRlbGV0aW9u
cygtKQo=

