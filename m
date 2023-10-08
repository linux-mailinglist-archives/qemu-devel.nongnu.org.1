Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D12D7BD0C1
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 00:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpbyY-0000zi-Oo; Sun, 08 Oct 2023 18:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qpbyS-0000xR-Rr
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 18:10:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qpbyP-0003T4-Km
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 18:10:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 398MA38U005293; Sun, 8 Oct 2023 22:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=gC3wljjVuLH8N2qMlsocJM/MKJ8X6JUfsPfD6aLirwk=;
 b=YqnM6p6O1xWuOGKITDzjqmSdKyE/418yACEAuj+1cCz+URZetVNV1dl2z9uYid2+pzBL
 5/9teag+PVzJqw0AGJJfv42c8vZWxGu+L4de6VvIoAgoiMf4m/AO4MIGEAsAnwHK59AK
 hwSEp/vlcp9WOOx5lYv5WiOd8yJWKtfBYH6Sn5g0bb7dLBWbAcCKAJJhm31wiECrFXaW
 L7DppakccrvisNCkelq6j7KfZ17XlkF59Yi/C1ON43shQv0Q8dy8v4is9BfwUkR4hKfn
 w0zOXZoHXziIrdd2Txx0A4j90fcIOTo89WqeejVoeLyVvt/2oabSJdbc2/Y7hiZ/XeBe 9A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkhj1130h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Oct 2023 22:10:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 398MA1TF018150
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 8 Oct 2023 22:10:01 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 8 Oct 2023 15:10:01 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH v3 0/3] hexagon: GETPC() fixes, shadowing fixes
Date: Sun, 8 Oct 2023 15:09:42 -0700
Message-ID: <20231008220945.983643-1-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: MM7xDILO_1Mc2M_By6RW5G3da1ktR7Mg
X-Proofpoint-GUID: MM7xDILO_1Mc2M_By6RW5G3da1ktR7Mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-08_20,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=434 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310080202
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

Q2hhbmdlcyBzaW5jZSB2MjoKICAgIC0gcmViYXNlZCwgc3VnZ2VzdGVkIGJ5IE1hcmt1cwogICAg
ICAgIC0gcy9jcHVfZW52L3RjZ19lbnYvCiAgICAgICAgLSBGb3IgbG9jYWwgc2hhZG93czogcy90
Y2dfZW52L3RjZ19lbnZfLwoKQnJpYW4gQ2FpbiAoMik6CiAgdGFyZ2V0L2hleGFnb246IGZpeCBz
b21lIG9jY3VycmVuY2VzIG9mIC1Xc2hhZG93PWxvY2FsCiAgdGFyZ2V0L2hleGFnb246IGF2b2lk
IHNoYWRvd2luZyBnbG9iYWxzCgpNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyAoMSk6CiAgdGFy
Z2V0L2hleGFnb246IG1vdmUgR0VUUEMoKSBjYWxscyB0byB0b3AgbGV2ZWwgaGVscGVycwoKIHRh
cmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICB8IDU2ICsrKysrKysrLS0tLS0t
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuaCAgICAgICAgICAgICAgICAgfCAxOCArKystLS0K
IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2FsdS5pZGVmICAgICAgICB8ICA2ICstCiB0YXJnZXQv
aGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICAgICAgICAgfCAxOSArKystLS0KIHRhcmdldC9oZXhh
Z29uL21tdmVjL21hY3Jvcy5oICAgICAgICAgICB8ICAyICstCiB0YXJnZXQvaGV4YWdvbi9tbXZl
Yy9zeXN0ZW1fZXh0X21tdmVjLmMgfCAgNCArLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvc3lzdGVt
X2V4dF9tbXZlYy5oIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAg
ICAgICB8IDg0ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5oICAgICAgICAgICAgICB8ICA5IC0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
ICAgICAgICAgICAgIHwgMTAgKy0tCiAxMCBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCsp
LCAxMjAgZGVsZXRpb25zKC0pCgotLSAKMi4yNS4xCgo=

