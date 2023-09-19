Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F597A5D52
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWdM-0002sH-Hm; Tue, 19 Sep 2023 05:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qiWdC-0002r1-Tk; Tue, 19 Sep 2023 05:02:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qiWd8-0003fC-Ju; Tue, 19 Sep 2023 05:02:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J4mVYl030811; Tue, 19 Sep 2023 09:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=X358Qci7eBUp0d3GGAIEVUXJ8V/d9JnpxNWbFzx7jh8=;
 b=poJZ8uZE0uwIhFzMjkwQ5ex4HE058nJNhPZUZXhDgNi0J5Igcj9RFon4k73P00rS0Qii
 VmjFzUcQTsyRHgfhIIQmbSBCs84dxzsuFIZpIINcm1nzEQXkLSY71aRBO0e9wNSquehg
 ioZDavHRQMIBKpxRVDbovN1kHD2YbCp1yElBt3sVc/9jRsp0BnmR1ytTA9uxK4MXPcD+
 zjqxA3YsOeCN9LGc8TjK/eY1TzBh2o36xuqLs2czZVrq2DV0Ui7AsQ9FlQWKvI9icBqQ
 WWUXIyQftlM+FmkD84lTASmJgbIwRmf4MC/WFLP36ZvivVyJ53Xo5wo+Q3tZBBAgqnwr jA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6qf6j3dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:02:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38J92iA5031275
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:02:44 GMT
Received: from qc-i7.qualcomm.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 02:02:42 -0700
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PATCH v2 3/3] hw/arm/sbsa-ref: use bsa.h for PPI definitions
Date: Tue, 19 Sep 2023 10:02:29 +0100
Message-ID: <20230919090229.188092-4-quic_llindhol@quicinc.com>
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
X-Proofpoint-GUID: O6Kdu7CfXDnsRZKrlVQvt-YkvM7ylS_D
X-Proofpoint-ORIG-GUID: O6Kdu7CfXDnsRZKrlVQvt-YkvM7ylS_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=435 mlxscore=0 adultscore=0
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

Use the private peripheral interrupt definitions from bsa.h instead of
defining them locally. Refactor to use the INTIDs defined there instead
of the PPI# used previously.

Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
---
 hw/arm/sbsa-ref.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index bc89eb4806..1ef23ae442 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -2,6 +2,7 @@
  * ARM SBSA Reference Platform emulation
  *
  * Copyright (c) 2018 Linaro Limited
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  * Written by Hongbo Zhang <hongbo.zhang@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -30,6 +31,7 @@
 #include "exec/hwaddr.h"
 #include "kvm_arm.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/bsa.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/block/flash.h"
@@ -55,13 +57,6 @@
 #define NUM_SMMU_IRQS   4
 #define NUM_SATA_PORTS  6
 
-#define VIRTUAL_PMU_IRQ        7
-#define ARCH_GIC_MAINT_IRQ     9
-#define ARCH_TIMER_VIRT_IRQ    11
-#define ARCH_TIMER_S_EL1_IRQ   13
-#define ARCH_TIMER_NS_EL1_IRQ  14
-#define ARCH_TIMER_NS_EL2_IRQ  10
-
 enum {
     SBSA_FLASH,
     SBSA_MEM,
@@ -478,7 +473,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
      */
     for (i = 0; i < smp_cpus; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
-        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
         int irq;
         /*
          * Mapping from the output timer irq lines from the CPU to the
@@ -494,14 +489,17 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
                                   qdev_get_gpio_in(sms->gic,
-                                                   ppibase + timer_irq[irq]));
+                                                   intidbase + timer_irq[irq]));
         }
 
         qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
-                                    qdev_get_gpio_in(sms->gic, ppibase
+                                    qdev_get_gpio_in(sms->gic,
+                                                     intidbase
                                                      + ARCH_GIC_MAINT_IRQ));
+
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(sms->gic, ppibase
+                                    qdev_get_gpio_in(sms->gic,
+                                                     intidbase
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-- 
2.30.2


