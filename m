Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C97FCB2E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 01:00:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r87zl-0005lq-9V; Tue, 28 Nov 2023 19:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r87zT-0005eF-Ka; Tue, 28 Nov 2023 18:59:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r87zM-0008Cb-8l; Tue, 28 Nov 2023 18:59:43 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASNM0OO015171; Tue, 28 Nov 2023 23:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=vils0Lsx1jeooDxI7zqEsl19UlekqvJ/dO1ZLJolcsE=;
 b=cpHg1LhlzCOaAPQVeJ02yeaAsLI00K/p5dupAsovMSy/Coxle7BvWnvP1o30aNuQW6M0
 BUj+FDDCOOCYLFzB0fGLMss4lk3e2ZuAd3lIoZh8KT+/4BOJxXFw084jQgMCD9VVfz95
 EdDmtFpfyDBwBnVYJduqsDDl/n3YCJ1kiSAtxsrE7IcSjNL4YRG540bwyoME3rYq19qA
 yjYZFcnc83ht2eqArX5sWEaS5ADllyBuQdvR3s9wQ3peWW3tWGEPUJwTkAXPLXuIp7jv
 gaTiAex0wMTmMaCZOPDKUQL4s2MX2KUt+PF2eryVYjO1xpGIXclTit4uN9ZZJzxKSfTE Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unstn8mpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 23:59:17 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASNxG2a012166;
 Tue, 28 Nov 2023 23:59:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unstn8mju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 23:59:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASMwYuF027538; Tue, 28 Nov 2023 23:57:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumykv9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 23:57:05 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ASNv4IF42992162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 23:57:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC7BD58063;
 Tue, 28 Nov 2023 23:57:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D10A5806B;
 Tue, 28 Nov 2023 23:57:04 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Nov 2023 23:57:04 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v8 04/10] hw/fsi: IBM's On-chip Peripheral Bus
Date: Tue, 28 Nov 2023 17:56:54 -0600
Message-Id: <20231128235700.599584-5-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128235700.599584-1-ninad@linux.ibm.com>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2R4YYU92nQ_b_jnFOvQ7tWTc4lVMX7mv
X-Proofpoint-GUID: rJ5tdIqLFAhlkfPvE6YMBfIvQMwUX8ca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_25,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=690 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
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

This is a part of patchset where IBM's Flexible Service Interface is
introduced.

The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
POWER processors. This now makes an appearance in the ASPEED SoC due
to tight integration of the FSI master IP with the OPB, mainly the
existence of an MMIO-mapping of the CFAM address straight onto a
sub-region of the OPB address space.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
[ clg: - removed FSIMasterState object and fsi_opb_realize()
       - simplified OPBus ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/fsi/opb.h | 25 +++++++++++++++++++++++++
 hw/fsi/opb.c         | 36 ++++++++++++++++++++++++++++++++++++
 hw/fsi/Kconfig       |  4 ++++
 hw/fsi/meson.build   |  1 +
 4 files changed, 66 insertions(+)
 create mode 100644 include/hw/fsi/opb.h
 create mode 100644 hw/fsi/opb.c

diff --git a/include/hw/fsi/opb.h b/include/hw/fsi/opb.h
new file mode 100644
index 0000000000..c112206f9e
--- /dev/null
+++ b/include/hw/fsi/opb.h
@@ -0,0 +1,25 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM On-Chip Peripheral Bus
+ */
+#ifndef FSI_OPB_H
+#define FSI_OPB_H
+
+#include "exec/memory.h"
+#include "hw/fsi/fsi-master.h"
+
+#define TYPE_OP_BUS "opb"
+OBJECT_DECLARE_SIMPLE_TYPE(OPBus, OP_BUS)
+
+typedef struct OPBus {
+        /*< private >*/
+        BusState bus;
+
+        /*< public >*/
+        MemoryRegion mr;
+        AddressSpace as;
+} OPBus;
+
+#endif /* FSI_OPB_H */
diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
new file mode 100644
index 0000000000..6474754890
--- /dev/null
+++ b/hw/fsi/opb.c
@@ -0,0 +1,36 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM On-chip Peripheral Bus
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/log.h"
+
+#include "hw/fsi/opb.h"
+
+static void fsi_opb_init(Object *o)
+{
+    OPBus *opb = OP_BUS(o);
+
+    memory_region_init_io(&opb->mr, OBJECT(opb), NULL, opb,
+                          NULL, UINT32_MAX);
+    address_space_init(&opb->as, &opb->mr, "opb");
+}
+
+static const TypeInfo opb_info = {
+    .name = TYPE_OP_BUS,
+    .parent = TYPE_BUS,
+    .instance_init = fsi_opb_init,
+    .instance_size = sizeof(OPBus),
+};
+
+static void fsi_opb_register_types(void)
+{
+    type_register_static(&opb_info);
+}
+
+type_init(fsi_opb_register_types);
diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
index de1594a335..9755baa8cc 100644
--- a/hw/fsi/Kconfig
+++ b/hw/fsi/Kconfig
@@ -1,3 +1,7 @@
+config FSI_OPB
+    bool
+    select FSI_CFAM
+
 config FSI_CFAM
     bool
     select FSI
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index cafd009c6d..ba92881370 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1,3 +1,4 @@
 system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
 system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
 system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-slave.c'))
+system_ss.add(when: 'CONFIG_FSI_OPB', if_true: files('opb.c'))
-- 
2.39.2


