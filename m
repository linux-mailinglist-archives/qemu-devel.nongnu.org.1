Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8979828772
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 14:54:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNCXx-0001Av-SV; Tue, 09 Jan 2024 08:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1738d0d938=kai.kang@windriver.com>)
 id 1rN8Hc-0003o6-46
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:20:29 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1738d0d938=kai.kang@windriver.com>)
 id 1rN8HZ-00033J-SM
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:20:27 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4097cffQ029611
 for <qemu-devel@nongnu.org>; Tue, 9 Jan 2024 09:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=PPS06212021; bh=3wHm8
 f9LXSOsx4ncjMyJ2rNfqL5xRHhbU+5nZ4vjcRw=; b=rLkwEJjKcmKzF/8pdqtcI
 TVgLQB7v4rDI1guYgw4n/HzH/XA92Rxt5/rdTevnuTM3KaDVDr7ReLkIYWEHVvQ6
 yRBWGFAq7Vj0xvJFm7914TUkOMSbSf/mcQ9q2hQJIVLbaQcxSs7jlW6R8aHUXh07
 qzj3XRXFyTN1Idq9cwPXYGLGXziLbN/tYU0OE12Rxzz2pvwYQR0YBPEFSq3c2s7j
 eELg1uD7YVAIqDgOUWEftUMUkVtpGyot5Bs8ySpZyZ9ccKjypIYx2Vif+6MQkXMC
 9c6ibHHy1Y7NVHi61ftKXus6CJCjjviG4yjzggn1LySj0oWO36QCcGhv2Hv0NqKN
 g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com
 [147.11.82.252])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vewekb2e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:20:22 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 01:20:55 -0800
Received: from pek-kkang-d2.wrs.com (128.224.34.219) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 01:20:54 -0800
From: Kai Kang <kai.kang@windriver.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] qdev: not add devices to bus in reverse order
Date: Tue, 9 Jan 2024 17:20:15 +0800
Message-ID: <20240109092015.4136865-1-kai.kang@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aXWGTiPkT_saVuNfVY65mMM3XbDOmWYK
X-Proofpoint-ORIG-GUID: aXWGTiPkT_saVuNfVY65mMM3XbDOmWYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 mlxlogscore=858 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090074
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=1738d0d938=kai.kang@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jan 2024 08:53:14 -0500
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

When this section of source codes were added via commit:

* 02e2da45c4 Add common BusState

it added devices to bus with LIST_INSERT_HEAD() which operated on the
single direction list. It didn't have something like LIST_INSERT_TAIL()
at that time and kept that way when turned to QTAILQ.

Then it causes the fist device in qemu command line inserted at the end
of the bus child link list. And when realize them, the first device will
be the last one to be realized.

Replace QTAILQ_INSERT_HEAD_RCU() with QTAILQ_INSERT_TAIL_RCU() to make
sure that devices are added to bus with the sequence in the command
line.

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 hw/core/qdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..5e2ff43715 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -89,7 +89,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
     kid->child = child;
     object_ref(OBJECT(kid->child));
 
-    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
+    QTAILQ_INSERT_TAIL_RCU(&bus->children, kid, sibling);
 
     /* This transfers ownership of kid->child to the property.  */
     snprintf(name, sizeof(name), "child[%d]", kid->index);
-- 
2.34.1


