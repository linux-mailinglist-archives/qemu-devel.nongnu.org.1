Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68C7C720D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyCn-0002kw-Hs; Thu, 12 Oct 2023 12:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qqyCl-0002h9-4r; Thu, 12 Oct 2023 12:06:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qqyCi-0005jE-OJ; Thu, 12 Oct 2023 12:06:30 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CG0cWC029792; Thu, 12 Oct 2023 16:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=Uf0Jk8zhNTC+DvSKrRSIm10dLZDq0OUseVUP6WF2Sfc=;
 b=X9u8k6VrLfPGzVq7jOWP+nLqTFnGQROtNL5uJbBG7tagtRE41W1ff0MmX/4WAurCN9rr
 rMqE32ZCqLYLxZg7bOIS9cLQntWd5M73jnrpHCXqr2rwt7+5n0fIuFtNUUbFB+jVcY2U
 vnd/L+egkoMgl8uMmW2lJSRBoSlPkx9K0AXTPqAZJHhioXrQMgsLZFzxZ0VJI//MBSvG
 XVDj0r8VP1xLum2Y0iK3irdxm+VGs4POD5HsJ4Gp5WPqfxfi/iwDuRhaMjUdXX89fGMk
 Fx7eM/te9514nvUDYTVjfMGgl1LtXWJAocqseVdh/6POOhvJTw/SVjV944MovfCyx4tu xA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpkxj07hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:24 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CG3gvB010248;
 Thu, 12 Oct 2023 16:06:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpkxj07gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CF6kmQ000685; Thu, 12 Oct 2023 16:06:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5m0dpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CG6Io817105508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 16:06:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DFF72004B;
 Thu, 12 Oct 2023 16:06:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A785C20040;
 Thu, 12 Oct 2023 16:06:16 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 16:06:16 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@linux.ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v2 1/3] hw/ppc: Add pnv pervasive common chiplet units
Date: Thu, 12 Oct 2023 11:06:08 -0500
Message-Id: <20231012160610.2428-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231012160610.2428-1-chalapathi.v@linux.ibm.com>
References: <20231012160610.2428-1-chalapathi.v@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RWBjijnr3qgyAX8m9razIEvUItZtRX5E
X-Proofpoint-ORIG-GUID: W-968WiBflnxbPKTO2aRRLus7vlcaHKQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 20 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120133
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This part of the patchset creates a common pervasive chiplet model where it
houses the common units of a chiplets.

The chiplet control unit is common across chiplets and this commit implements
the chiplet control registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/meson.build             |   1 +
 hw/ppc/pnv_pervasive.c         | 151 +++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_pervasive.h |  39 +++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 hw/ppc/pnv_pervasive.c
 create mode 100644 include/hw/ppc/pnv_pervasive.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7c2c52434a..c80d2f6cfb 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -50,6 +50,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_bmc.c',
   'pnv_homer.c',
   'pnv_pnor.c',
+  'pnv_pervasive.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv_pervasive.c b/hw/ppc/pnv_pervasive.c
new file mode 100644
index 0000000000..ef337625eb
--- /dev/null
+++ b/hw/ppc/pnv_pervasive.c
@@ -0,0 +1,151 @@
+/*
+ * QEMU PowerPC pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_pervasive.h"
+#include "hw/ppc/fdt.h"
+#include <libfdt.h>
+
+#define CPLT_CONF0               0x08
+#define CPLT_CONF0_OR            0x18
+#define CPLT_CONF0_CLEAR         0x28
+#define CPLT_CONF1               0x09
+#define CPLT_CONF1_OR            0x19
+#define CPLT_CONF1_CLEAR         0x29
+#define CPLT_STAT0               0x100
+#define CPLT_MASK0               0x101
+#define CPLT_PROTECT_MODE        0x3FE
+#define CPLT_ATOMIC_CLOCK        0x3FF
+
+uint64_t pnv_chiplet_ctrl_read(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
+              unsigned size)
+{
+    uint64_t val = 0xffffffffffffffffull;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i <= 5; i++) {
+        if (reg == i) {
+            val = ctrl_regs->cplt_ctrl[i];
+            return val;
+        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                           "xscom read at 0x%016lx\n",
+                                          __func__, (unsigned long)reg);
+            return val;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        val = ctrl_regs->cplt_cfg0;
+        break;
+    case CPLT_CONF0_OR:
+    case CPLT_CONF0_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%016lx\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_CONF1:
+        val = ctrl_regs->cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%016lx\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_STAT0:
+        val = ctrl_regs->cplt_stat0;
+        break;
+    case CPLT_MASK0:
+        val = ctrl_regs->cplt_mask0;
+        break;
+    case CPLT_PROTECT_MODE:
+        val = ctrl_regs->ctrl_protect_mode;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        val = ctrl_regs->ctrl_atomic_lock;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                 "read at 0x%016lx\n", __func__, (unsigned long)reg);
+    }
+    return val;
+}
+
+void pnv_chiplet_ctrl_write(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
+                                 uint64_t val, unsigned size)
+{
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i <= 5; i++) {
+        if (reg == i) {
+            ctrl_regs->cplt_ctrl[i] = val;
+            return;
+        } else if (reg == (i + 0x10)) {
+            ctrl_regs->cplt_ctrl[i] |= val;
+            return;
+        } else if (reg == (i + 0x20)) {
+            ctrl_regs->cplt_ctrl[i] &= ~val;
+            return;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        ctrl_regs->cplt_cfg0 = val;
+        break;
+    case CPLT_CONF0_OR:
+        ctrl_regs->cplt_cfg0 |= val;
+        break;
+    case CPLT_CONF0_CLEAR:
+        ctrl_regs->cplt_cfg0 &= ~val;
+        break;
+    case CPLT_CONF1:
+        ctrl_regs->cplt_cfg1 = val;
+        break;
+    case CPLT_CONF1_OR:
+        ctrl_regs->cplt_cfg1 |= val;
+        break;
+    case CPLT_CONF1_CLEAR:
+        ctrl_regs->cplt_cfg1 &= ~val;
+        break;
+    case CPLT_STAT0:
+        ctrl_regs->cplt_stat0 = val;
+        break;
+    case CPLT_MASK0:
+        ctrl_regs->cplt_mask0 = val;
+        break;
+    case CPLT_PROTECT_MODE:
+        ctrl_regs->ctrl_protect_mode = val;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        ctrl_regs->ctrl_atomic_lock = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                       "write at 0x%016lx\n", __func__, (unsigned long)reg);
+    }
+    return;
+}
diff --git a/include/hw/ppc/pnv_pervasive.h b/include/hw/ppc/pnv_pervasive.h
new file mode 100644
index 0000000000..53c40e473c
--- /dev/null
+++ b/include/hw/ppc/pnv_pervasive.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU PowerPC pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_PNV_PERVASIVE_H
+#define PPC_PNV_PERVASIVE_H
+
+typedef struct PnvChipletControlRegs {
+    uint64_t cplt_ctrl[6];
+    uint64_t cplt_cfg0;
+    uint64_t cplt_cfg1;
+    uint64_t cplt_stat0;
+    uint64_t cplt_mask0;
+    uint64_t ctrl_protect_mode;
+    uint64_t ctrl_atomic_lock;
+} PnvChipletControlRegs;
+
+uint64_t pnv_chiplet_ctrl_read(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
+                unsigned size);
+void pnv_chiplet_ctrl_write(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
+                uint64_t val, unsigned size);
+#endif /*PPC_PNV_PERVASIVE_H */
-- 
2.31.1


