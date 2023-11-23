Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD347F57EC
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 06:59:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r62jZ-0004Ug-Sy; Thu, 23 Nov 2023 00:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r62j1-00045S-Gd; Thu, 23 Nov 2023 00:58:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r62ix-00064S-D9; Thu, 23 Nov 2023 00:58:06 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AN5gZMf001464; Thu, 23 Nov 2023 05:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AmQElR1lXvXobUE+kT9oKittMZjyMPLtrkvSZTbljKo=;
 b=mgeuPIqxxRD3fNRKPURXD/ePI8rwXzlHi4FTSRoWnXTDT7iDoFO8AKVXgVSulGtIlNE3
 0a76CvRMrorZGMfv+dzAlfMc9r+2w7vTz8ONXG+sX04iaR84FY+Fb6LlqnpAr+iwbX9c
 ncMq5nT0kcGrC7LGak54AaNhHauwtdkT5Fi1OPWbTP5o1HKsn/gNBdjRNkyugzO9Jrtu
 xTivAVoFuGpWC8PPIX7zDiuDidvCnPnJvoXJyQNUVcq8mkaVEr+qjwlz04y+2+vk6+23
 0D8GdzWjER3Ojogh2wQdw8PqGpJ8UpRTEsmMURJzBYBOQxmKWYLsWOpHopxWZrfNxo2R kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj0ts08bu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:57:44 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN5gTCo001312;
 Thu, 23 Nov 2023 05:57:43 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj0ts08bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:57:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AN44MtZ002211; Thu, 23 Nov 2023 05:57:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkmwma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Nov 2023 05:57:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AN5vf7D26411408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Nov 2023 05:57:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 058F720043;
 Thu, 23 Nov 2023 05:57:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BD1120040;
 Thu, 23 Nov 2023 05:57:39 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Nov 2023 05:57:39 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, harshpb@linux.ibm.com
Subject: [PATCH v3 1/2] ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ
 range for CPU IPIs.
Date: Thu, 23 Nov 2023 11:27:32 +0530
Message-Id: <20231123055733.1002890-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231123055733.1002890-1-harshpb@linux.ibm.com>
References: <20231123055733.1002890-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8rUYjKXEzzIJg0CXg4bzXmQLD5YrA4zV
X-Proofpoint-GUID: qUqK_jPiBqg1yy8e-6sOzI3OfAfoA3y3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230040
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
the range of CPU IPIs during initialization of nr-irqs property.
It is more appropriate to have its own define which can be further
reused as appropriate for correct interpretation.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Suggested-by: Cedric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h | 14 +++++++++++++-
 hw/ppc/spapr_irq.c         |  6 ++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c22a72c9e2..4fd2d5853d 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -14,9 +14,21 @@
 #include "qom/object.h"
 
 /*
- * IRQ range offsets per device type
+ * The XIVE IRQ backend uses the same layout as the XICS backend but
+ * covers the full range of the IRQ number space. The IRQ numbers for
+ * the CPU IPIs are allocated at the bottom of this space, below 4K,
+ * to preserve compatibility with XICS which does not use that range.
+ */
+
+/*
+ * CPU IPI range (XIVE only)
  */
 #define SPAPR_IRQ_IPI        0x0
+#define SPAPR_IRQ_NR_IPIS    0x1000
+
+/*
+ * IRQ range offsets per device type
+ */
 
 #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
 #define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a0d1e1298e..97b2fc42ab 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -23,6 +23,8 @@
 
 #include "trace.h"
 
+QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE);
+
 static const TypeInfo spapr_intc_info = {
     .name = TYPE_SPAPR_INTC,
     .parent = TYPE_INTERFACE,
@@ -329,7 +331,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         int i;
 
         dev = qdev_new(TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
+        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
          * priority
@@ -356,7 +358,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     }
 
     spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
+                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
 
     /*
      * Mostly we don't actually need this until reset, except that not
-- 
2.39.3


