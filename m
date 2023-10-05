Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283F7BAEC8
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 00:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoWk6-0005GY-3X; Thu, 05 Oct 2023 18:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qoWk1-0005FI-Ft
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 18:22:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qoWjy-0008Cz-8R
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 18:22:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395LTPUq032455; Thu, 5 Oct 2023 22:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=259pDZVI4P94mm8d2BKiJJyOtcoF6Z1axoJtFsOdN04=;
 b=JIuUVUNNzyhdz9CmBFkkjNdeKgP6ZaHK4kQrOhHCF2N6VIn+Tu6mSqSVaHYdTUwtz77T
 WW75rPFY4pkfW1iKgr8i49f6yWIsEaLkVxIuAMbSrjjeY3IH0VywVkGRPPeF7TyM73fa
 DTv11dQA5g02AN/NLP5/Nu2EhmSyRfrw8NpidEj7waboI1qZMR+D9lJrCsIj1cbSIOIn
 3AgRQVbplpa/ccDLULSwzLyRPulVuHGVPgUsc3leVOLMf8gqtHTS7iLEPv5L+tgc9NZP
 IBiqaKnuyEUFfvI8FEd8w9Y1ZyU9ZRTrhbfXt15+1GcOguEqsBn3KJfSLKFVpbWcnUZu gw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8ck433e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 22:22:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395MMUO7029355
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 5 Oct 2023 22:22:30 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 15:22:30 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH v2 0/3] hexagon: GETPC() and shadowing fixes
Date: Thu, 5 Oct 2023 15:22:03 -0700
Message-ID: <20231005222206.2784853-1-bcain@quicinc.com>
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
X-Proofpoint-GUID: 3U0NTkSS_OnsgV-KvTfvGQm6-TGf9Sw-
X-Proofpoint-ORIG-GUID: 3U0NTkSS_OnsgV-KvTfvGQm6-TGf9Sw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_17,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=406 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310050169
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

SW4gdjI6IHJld29ya2VkIHdpdGggc3VnZ2VzdGlvbnMgZnJvbSBQaGlsaXBwZSBhbmQgYWRkZWQg
YSBuZXcgcGF0Y2gKdG8gY292ZXIgLVdzaGFkb3c9Z2xvYmFsLgoKQnJpYW4gQ2FpbiAoMik6CiAg
dGFyZ2V0L2hleGFnb246IGZpeCBzb21lIG9jY3VycmVuY2VzIG9mIC1Xc2hhZG93PWxvY2FsCiAg
dGFyZ2V0L2hleGFnb246IGF2b2lkIHNoYWRvd2luZyBnbG9iYWxzCgpNYXRoZXVzIFRhdmFyZXMg
QmVybmFyZGlubyAoMSk6CiAgdGFyZ2V0L2hleGFnb246IG1vdmUgR0VUUEMoKSBjYWxscyB0byB0
b3AgbGV2ZWwgaGVscGVycwoKIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAg
ICB8IDU2ICsrKysrKysrLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuaCAgICAgICAg
ICAgICAgICAgfCAxOCArKystLS0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2FsdS5pZGVmICAg
ICAgICB8ICA2ICstCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICAgICAgICAgfCAx
OSArKystLS0KIHRhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oICAgICAgICAgICB8ICA2ICst
CiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMgfCAgNCArLQogdGFyZ2V0
L2hleGFnb24vbW12ZWMvc3lzdGVtX2V4dF9tbXZlYy5oIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29u
L29wX2hlbHBlci5jICAgICAgICAgICAgICB8IDg0ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0K
IHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5oICAgICAgICAgICAgICB8ICA5IC0tLQogdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgIHwgIDkgKystCiAxMCBmaWxlcyBjaGFu
Z2VkLCA5MSBpbnNlcnRpb25zKCspLCAxMjIgZGVsZXRpb25zKC0pCgotLSAKMi4yNS4xCgo=

