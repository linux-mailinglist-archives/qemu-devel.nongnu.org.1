Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3AA88DDC
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Apr 2025 23:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4RTw-00080o-FZ; Mon, 14 Apr 2025 17:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u4RTn-0007vC-SE; Mon, 14 Apr 2025 17:36:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u4RTk-0003Gi-QJ; Mon, 14 Apr 2025 17:36:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIZ6rI023528;
 Mon, 14 Apr 2025 21:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XbxOmOxaCGJ2wrgJR
 qkKjhBcMBVejLmaBs+JzNXKqsI=; b=Lxee5wajJoNNnU1X/Qw8+u+5kwP2sb0SJ
 w9X4f+kZc0Ekb+N/vafXAUpLFEz1dD2OeKwQr1YRtgj3F1AryNBuE9eMeN6Gh/gp
 Sz6soeM76siKuNKB69Kf5yKSnwSo9KFnRqKrOWPei8MyN7dGP1SaIhQhPyJ0409l
 1TwNb9e45ZhUZKdWuS+W80DWuuXf58P4TJ9cKyTOCXIG9QUrJPYD1wkdfh0EyhHw
 hqFletXeEWXhMPBVzd9h/GPLCTkChsEtUBphbOZmy2pVD6cQiBO0ixENyFmlAzxM
 zqGa1mntBTuwXmSbcLnfw39ud9W14AX7uy0nLa9K7bMPzMtYPuKEw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460q7x568m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 21:36:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHkBv9016746;
 Mon, 14 Apr 2025 21:36:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460571ys32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 21:36:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53ELaJsG28574366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 21:36:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBB1558054;
 Mon, 14 Apr 2025 21:36:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ADF95803F;
 Mon, 14 Apr 2025 21:36:20 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.75])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Apr 2025 21:36:20 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, stefanha@redhat.com, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net,
 alex.williamson@redhat.com
Subject: [PATCH v4 1/3] util: Add functions for s390x mmio read/write
Date: Mon, 14 Apr 2025 14:36:14 -0700
Message-ID: <20250414213616.2675-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414213616.2675-1-alifm@linux.ibm.com>
References: <20250414213616.2675-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uS6Hs53Qwd3AziXq0WnynD4Ge3OdycjY
X-Proofpoint-GUID: uS6Hs53Qwd3AziXq0WnynD4Ge3OdycjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=625 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504140157
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Starting with z15 (or newer) we can execute mmio
instructions from userspace. On older platforms
where we don't have these instructions available
we can fallback to using system calls to access
the PCI mapped resources.

This patch adds helper functions for mmio reads
and writes for s390x.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 include/qemu/s390x_pci_mmio.h |  24 ++++++
 util/meson.build              |   2 +
 util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 include/qemu/s390x_pci_mmio.h
 create mode 100644 util/s390x_pci_mmio.c

diff --git a/include/qemu/s390x_pci_mmio.h b/include/qemu/s390x_pci_mmio.h
new file mode 100644
index 0000000000..c5f63ecefa
--- /dev/null
+++ b/include/qemu/s390x_pci_mmio.h
@@ -0,0 +1,24 @@
+/*
+ * s390x PCI MMIO definitions
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Farhan Ali <alifm@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef S390X_PCI_MMIO_H
+#define S390X_PCI_MMIO_H
+
+#ifdef __s390x__
+uint8_t s390x_pci_mmio_read_8(const void *ioaddr);
+uint16_t s390x_pci_mmio_read_16(const void *ioaddr);
+uint32_t s390x_pci_mmio_read_32(const void *ioaddr);
+uint64_t s390x_pci_mmio_read_64(const void *ioaddr);
+
+void s390x_pci_mmio_write_8(void *ioaddr, uint8_t val);
+void s390x_pci_mmio_write_16(void *ioaddr, uint16_t val);
+void s390x_pci_mmio_write_32(void *ioaddr, uint32_t val);
+void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val);
+#endif /* __s390x__ */
+
+#endif /* S390X_PCI_MMIO_H */
diff --git a/util/meson.build b/util/meson.build
index 780b5977a8..acb21592f9 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -131,4 +131,6 @@ elif cpu in ['ppc', 'ppc64']
   util_ss.add(files('cpuinfo-ppc.c'))
 elif cpu in ['riscv32', 'riscv64']
   util_ss.add(files('cpuinfo-riscv.c'))
+elif cpu == 's390x'
+  util_ss.add(files('s390x_pci_mmio.c'))
 endif
diff --git a/util/s390x_pci_mmio.c b/util/s390x_pci_mmio.c
new file mode 100644
index 0000000000..820458a026
--- /dev/null
+++ b/util/s390x_pci_mmio.c
@@ -0,0 +1,148 @@
+/*
+ * s390x PCI MMIO definitions
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Farhan Ali <alifm@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <unistd.h>
+#include <sys/syscall.h>
+#include "qemu/s390x_pci_mmio.h"
+#include "elf.h"
+
+union register_pair {
+    unsigned __int128 pair;
+    struct {
+        uint64_t even;
+        uint64_t odd;
+    };
+};
+
+static bool is_mio_supported;
+
+static __attribute__((constructor)) void check_is_mio_supported(void)
+{
+    is_mio_supported = !!(qemu_getauxval(AT_HWCAP) & HWCAP_S390_PCI_MIO);
+}
+
+static uint64_t s390x_pcilgi(const void *ioaddr, size_t len)
+{
+    union register_pair ioaddr_len = { .even = (uint64_t)ioaddr,
+                                       .odd = len };
+    uint64_t val;
+    int cc;
+
+    asm volatile(
+        /* pcilgi */
+        ".insn   rre,0xb9d60000,%[val],%[ioaddr_len]\n"
+        "ipm     %[cc]\n"
+        "srl     %[cc],28\n"
+        : [cc] "=d"(cc), [val] "=d"(val),
+        [ioaddr_len] "+&d"(ioaddr_len.pair) :: "cc");
+
+    if (cc) {
+        val = -1ULL;
+    }
+
+    return val;
+}
+
+static void s390x_pcistgi(void *ioaddr, uint64_t val, size_t len)
+{
+    union register_pair ioaddr_len = {.even = (uint64_t)ioaddr, .odd = len};
+
+    asm volatile (
+        /* pcistgi */
+        ".insn   rre,0xb9d40000,%[val],%[ioaddr_len]\n"
+        : [ioaddr_len] "+&d" (ioaddr_len.pair)
+        : [val] "d" (val)
+        : "cc", "memory");
+}
+
+uint8_t s390x_pci_mmio_read_8(const void *ioaddr)
+{
+    uint8_t val = 0;
+
+    if (is_mio_supported) {
+        val = s390x_pcilgi(ioaddr, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
+    }
+    return val;
+}
+
+uint16_t s390x_pci_mmio_read_16(const void *ioaddr)
+{
+    uint16_t val = 0;
+
+    if (is_mio_supported) {
+        val = s390x_pcilgi(ioaddr, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
+    }
+    return val;
+}
+
+uint32_t s390x_pci_mmio_read_32(const void *ioaddr)
+{
+    uint32_t val = 0;
+
+    if (is_mio_supported) {
+        val = s390x_pcilgi(ioaddr, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
+    }
+    return val;
+}
+
+uint64_t s390x_pci_mmio_read_64(const void *ioaddr)
+{
+    uint64_t val = 0;
+
+    if (is_mio_supported) {
+        val = s390x_pcilgi(ioaddr, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_read, ioaddr, &val, sizeof(val));
+    }
+    return val;
+}
+
+void s390x_pci_mmio_write_8(void *ioaddr, uint8_t val)
+{
+    if (is_mio_supported) {
+        s390x_pcistgi(ioaddr, val, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
+    }
+}
+
+void s390x_pci_mmio_write_16(void *ioaddr, uint16_t val)
+{
+    if (is_mio_supported) {
+        s390x_pcistgi(ioaddr, val, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
+    }
+}
+
+void s390x_pci_mmio_write_32(void *ioaddr, uint32_t val)
+{
+    if (is_mio_supported) {
+        s390x_pcistgi(ioaddr, val, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
+    }
+}
+
+void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val)
+{
+    if (is_mio_supported) {
+        s390x_pcistgi(ioaddr, val, sizeof(val));
+    } else {
+        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
+    }
+}
+
-- 
2.43.0


