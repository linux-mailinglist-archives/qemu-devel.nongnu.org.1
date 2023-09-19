Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB107A5D46
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWdM-0002sC-9U; Tue, 19 Sep 2023 05:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qiWdA-0002qO-I3; Tue, 19 Sep 2023 05:02:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qiWd7-0003eX-9s; Tue, 19 Sep 2023 05:02:51 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J8s30O032268; Tue, 19 Sep 2023 09:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=kvAcZkOkiaikpxw3Odch76gUwwPbW8XRoUwbSL/Eb7I=;
 b=T3LU5ZBDv9lai3lkFBe01Z4zpnHGnM0C9cuQ4bVRMA9vmY5ByW/JbXUlX+vu4qEU+ue8
 YcuwRucc7oMq+9djDnrfZGWqXw61zeUo/sCUAl0eWgWzItiGksHYUF9cqo5QAdsJnzgG
 DjK4X6Ic6SpEw1o6anEsbcmy07xgAl5+55qf62AJHvwZ/wDXuq6HTZeA1YDpFQ2Zu1li
 l8M/NfqXjlC71crnDTUMYWxeO55+Do+5ycDYrOjWrSI13QJJLBWPRph3S6BFCJiUmmW4
 JId0bD03B2x0KVauBAOJuve28k5YBUOY3/32R97qWbwor77uF4Yt6oYCs7ds1YhL09ps zw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6pmq25rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:02:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38J92ges002241
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:02:42 GMT
Received: from qc-i7.qualcomm.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 02:02:40 -0700
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PATCH v2 2/3] include/hw/arm: move BSA definitions to bsa.h
Date: Tue, 19 Sep 2023 10:02:28 +0100
Message-ID: <20230919090229.188092-3-quic_llindhol@quicinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230919090229.188092-1-quic_llindhol@quicinc.com>
References: <20230919090229.188092-1-quic_llindhol@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 5oCbdSNEBRaKtxHGKXcxKoJqeS1OYXYs
X-Proofpoint-ORIG-GUID: 5oCbdSNEBRaKtxHGKXcxKoJqeS1OYXYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=372 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
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

virt.h defines a number of IRQs that are ultimately described by Arm's
Base System Architecture specification. Move these to a dedicated header
so that they can be reused by other platforms that do the same.
Include that header from virt.h to minimise churn.

Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
---
 include/hw/arm/bsa.h  | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h | 12 +-----------
 2 files changed, 38 insertions(+), 11 deletions(-)
 create mode 100644 include/hw/arm/bsa.h

diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
new file mode 100644
index 0000000000..e41f5d0ddc
--- /dev/null
+++ b/include/hw/arm/bsa.h
@@ -0,0 +1,37 @@
+/*
+ * Common definitions for Arm Base System Architecture (BSA) platforms.
+ *
+ * Copyright (c) 2015 Linaro Limited
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QEMU_ARM_BSA_H
+#define QEMU_ARM_BSA_H
+
+/* These are architectural INTID values */
+#define ARCH_GIC_MAINT_IRQ  25
+
+#define ARCH_TIMER_VIRT_IRQ   27
+#define ARCH_TIMER_S_EL1_IRQ  29
+#define ARCH_TIMER_NS_EL1_IRQ 30
+#define ARCH_TIMER_NS_EL2_IRQ 26
+
+#define VIRTUAL_PMU_IRQ 23
+
+#define PPI_TO_INTID(irq) ((irq) + 16)
+#define INTID_TO_PPI(irq) ((irq) - 16)
+
+#endif /* QEMU_ARM_BSA_H */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5704d95736..f69239850e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -34,6 +34,7 @@
 #include "qemu/notify.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
@@ -43,17 +44,6 @@
 #define NUM_VIRTIO_TRANSPORTS 32
 #define NUM_SMMU_IRQS          4
 
-#define ARCH_GIC_MAINT_IRQ  25
-
-#define ARCH_TIMER_VIRT_IRQ   27
-#define ARCH_TIMER_S_EL1_IRQ  29
-#define ARCH_TIMER_NS_EL1_IRQ 30
-#define ARCH_TIMER_NS_EL2_IRQ 26
-
-#define VIRTUAL_PMU_IRQ 23
-
-#define INTID_TO_PPI(irq) ((irq) - 16)
-
 /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
 #define PVTIME_SIZE_PER_CPU 64
 
-- 
2.30.2


