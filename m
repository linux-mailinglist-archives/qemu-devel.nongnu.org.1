Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9997A02B7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:34:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkb6-0000hn-N6; Thu, 14 Sep 2023 07:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb4-0000go-NI
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb2-00082k-BU
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694691199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZVSfJ4MJuu5mqijvGN0NmVeZKgtLE/XqMVt1DWKRPU=;
 b=E5NbBOKMnSX+r4nPD6BCcgFRrm7Zuye7vBG7j4OGgAvNpsv53gvjCnJms76VWLOMDGvqjA
 F2Mb9E4DnFgiMjkKklrahiUDXdmTxY89FmEmkW58EGKmK/0QTeOiFUMj1q6ueG4PKDB4vG
 aI6wtmJcD4DXnDfpebH+VYVmNXMZUWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-ntSrBGGOPFOdBuupFRSOzg-1; Thu, 14 Sep 2023 07:33:16 -0400
X-MC-Unique: ntSrBGGOPFOdBuupFRSOzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5404B800D8E;
 Thu, 14 Sep 2023 11:33:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4844B1054FC1;
 Thu, 14 Sep 2023 11:33:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [risu PATCH v3 2/7] s390x: Add basic s390x support to the C code
Date: Thu, 14 Sep 2023 13:33:06 +0200
Message-ID: <20230914113311.379537-3-thuth@redhat.com>
In-Reply-To: <20230914113311.379537-1-thuth@redhat.com>
References: <20230914113311.379537-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

With these changes, it is now possible to compile the "risu" binary
for s390x hosts.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 risu_reginfo_s390x.c | 140 +++++++++++++++++++++++++++++++++++++++++++
 risu_reginfo_s390x.h |  25 ++++++++
 risu_s390x.c         |  51 ++++++++++++++++
 test_s390x.S         |  53 ++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 risu_reginfo_s390x.c
 create mode 100644 risu_reginfo_s390x.h
 create mode 100644 risu_s390x.c
 create mode 100644 test_s390x.S

diff --git a/risu_reginfo_s390x.c b/risu_reginfo_s390x.c
new file mode 100644
index 0000000..3fd91b9
--- /dev/null
+++ b/risu_reginfo_s390x.c
@@ -0,0 +1,140 @@
+/******************************************************************************
+ * Copyright 2023 Red Hat Inc.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Thomas Huth - initial implementation
+ *****************************************************************************/
+
+#include <stdio.h>
+#include <signal.h>
+#include <asm/ucontext.h>
+#include <string.h>
+#include <math.h>
+#include <stdlib.h>
+#include <sys/user.h>
+
+#include "risu.h"
+#include "risu_reginfo_s390x.h"
+
+
+const struct option * const arch_long_opts;
+const char * const arch_extra_help;
+
+void process_arch_opt(int opt, const char *arg)
+{
+    abort();
+}
+
+void arch_init(void)
+{
+}
+
+int reginfo_size(struct reginfo *ri)
+{
+    return sizeof(*ri);
+}
+
+/* reginfo_init: initialize with a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
+{
+    struct ucontext_extended *uce = (struct ucontext_extended *)uc;
+
+    memset(ri, 0, sizeof(*ri));
+
+    /*
+     * We can get the size of the instruction by looking at the
+     * first two bits of the instruction
+     */
+    switch (*(uint8_t *)siaddr >> 6) {
+    case 0:
+        ri->faulting_insn = *(uint16_t *)siaddr;
+        ri->faulting_insn_len = 2;
+        break;
+    case 3:
+        ri->faulting_insn = ((*(uint32_t *)siaddr) << 16)
+                            | *(uint16_t *)(siaddr + 4);
+        ri->faulting_insn_len = 6;
+        break;
+    default:
+        ri->faulting_insn = *(uint32_t *)siaddr;
+        ri->faulting_insn_len = 4;
+    }
+
+    ri->psw_mask = uce->uc_mcontext.regs.psw.mask;
+    ri->pc_offset = (uintptr_t)siaddr - image_start_address;
+
+    memcpy(ri->gprs, uce->uc_mcontext.regs.gprs, sizeof(ri->gprs));
+
+    ri->fpc = uc->uc_mcontext.fpregs.fpc;
+    memcpy(ri->fprs, &uc->uc_mcontext.fpregs.fprs, sizeof(ri->fprs));
+}
+
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+{
+    return m->pc_offset == a->pc_offset &&
+           m->fpc == a->fpc &&
+           memcmp(m->gprs, a->gprs, sizeof(m->gprs)) == 0 &&
+           memcmp(&m->fprs, &a->fprs, sizeof(m->fprs)) == 0;
+}
+
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+int reginfo_dump(struct reginfo *ri, FILE * f)
+{
+    int i;
+
+    fprintf(f, "  faulting insn 0x%" PRIx64 "\n", ri->faulting_insn);
+    fprintf(f, "  PSW mask      0x%" PRIx64 "\n", ri->psw_mask);
+    fprintf(f, "  PC offset     0x%" PRIx64 "\n\n", ri->pc_offset);
+
+    for (i = 0; i < 16/2; i++) {
+        fprintf(f, "\tr%d: %16lx\tr%02d: %16lx\n", i, ri->gprs[i],
+                i + 8, ri->gprs[i + 8]);
+    }
+    fprintf(f, "\n");
+
+    for (i = 0; i < 16/2; i++) {
+        fprintf(f, "\tf%d: %16lx\tf%02d: %16lx\n",
+                i, *(uint64_t *)&ri->fprs[i],
+                i + 8, *(uint64_t *)&ri->fprs[i + 8]);
+    }
+    fprintf(f, "\tFPC: %8x\n\n", ri->fpc);
+
+    return !ferror(f);
+}
+
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+{
+    int i;
+
+    if (m->pc_offset != a->pc_offset) {
+        fprintf(f, "Mismatch: PC offset master: [%016lx] - PC offset apprentice: [%016lx]\n",
+                m->pc_offset, a->pc_offset);
+    }
+
+    for (i = 0; i < 16; i++) {
+        if (m->gprs[i] != a->gprs[i]) {
+            fprintf(f, "Mismatch: r%d master: [%016lx] - r%d apprentice: [%016lx]\n",
+                    i, m->gprs[i], i, a->gprs[i]);
+        }
+    }
+
+    for (i = 0; i < 16; i++) {
+        if (*(uint64_t *)&m->fprs[i] != *(uint64_t *)&a->fprs[i]) {
+            fprintf(f, "Mismatch: f%d master: [%016lx] - f%d apprentice: [%016lx]\n",
+                    i, *(uint64_t *)&m->fprs[i],
+                    i, *(uint64_t *)&a->fprs[i]);
+        }
+    }
+
+    if (m->fpc != a->fpc) {
+        fprintf(f, "Mismatch: FPC master: [%08x] - FPC apprentice: [%08x]\n",
+                m->fpc, a->fpc);
+    }
+
+    return !ferror(f);
+}
diff --git a/risu_reginfo_s390x.h b/risu_reginfo_s390x.h
new file mode 100644
index 0000000..c65fff7
--- /dev/null
+++ b/risu_reginfo_s390x.h
@@ -0,0 +1,25 @@
+/******************************************************************************
+ * Copyright 2023 Red Hat Inc.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Thomas Huth - initial implementation
+ *****************************************************************************/
+
+#ifndef RISU_REGINFO_S390X_H
+#define RISU_REGINFO_S390X_H
+
+struct reginfo {
+    uint64_t psw_mask;
+    uint64_t pc_offset;
+    uint64_t faulting_insn;
+    int faulting_insn_len;
+    uint32_t fpc;
+    uint64_t gprs[16];
+    uint64_t fprs[16];
+};
+
+#endif /* RISU_REGINFO_S390X_H */
diff --git a/risu_s390x.c b/risu_s390x.c
new file mode 100644
index 0000000..cf9c72c
--- /dev/null
+++ b/risu_s390x.c
@@ -0,0 +1,51 @@
+/******************************************************************************
+ * Copyright 2023 Red Hat Inc.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Thomas Huth - initial implementation
+ *****************************************************************************/
+
+#include <sys/user.h>
+
+#include "risu.h"
+
+void advance_pc(void *vuc)
+{
+    /*
+     * Note: The PSW address already points to the next instruction
+     * after we get a SIGILL, so we must not advance it here!
+     */
+}
+
+void set_ucontext_paramreg(void *vuc, uint64_t value)
+{
+    ucontext_t *uc = vuc;
+    uc->uc_mcontext.gregs[0] = value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gprs[0];
+}
+
+RisuOp get_risuop(struct reginfo *ri)
+{
+    uint32_t insn = ri->faulting_insn;
+    uint32_t op = insn & 0xff;
+    uint32_t key = insn & ~0xff;
+
+    if (ri->faulting_insn_len == 4 && key == 0x835a0f00) {
+        return op;
+    }
+
+    return OP_SIGILL;
+}
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+   return ri->pc_offset;
+}
diff --git a/test_s390x.S b/test_s390x.S
new file mode 100644
index 0000000..16f3c6f
--- /dev/null
+++ b/test_s390x.S
@@ -0,0 +1,53 @@
+/*****************************************************************************
+ * Copyright 2023 Red Hat Inc.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Thomas Huth - initial implementation
+ *****************************************************************************/
+
+    /* Initialise the general purpose registers */
+    lgfi %r0, 0
+    lgfi %r1, 0x1111111
+    lgfi %r2, 0x2222222
+    lgfi %r3, 0x3333333
+    lgfi %r4, 0x4444444
+    lgfi %r5, 0x5555555
+    lgfi %r6, 0x6666666
+    lgfi %r7, 0x7777777
+    lgfi %r8, 0x8888888
+    lgfi %r9, 0x9999999
+    lgfi %r10, 0xaaaaaaa
+    lgfi %r11, 0xbbbbbbb
+    lgfi %r12, 0xccccccc
+    lgfi %r13, 0xddddddd
+    lgfi %r14, 0xeeeeeee
+    lgfi %r15, 0xfffffff
+
+    /* Initialize floating point registers */
+    ldgr %f0,%r0
+    ldgr %f1,%r1
+    ldgr %f2,%r2
+    ldgr %f3,%r3
+    ldgr %f4,%r4
+    ldgr %f5,%r5
+    ldgr %f6,%r6
+    ldgr %f7,%r7
+    ldgr %f8,%r8
+    ldgr %f9,%r9
+    ldgr %f10,%r10
+    ldgr %f11,%r11
+    ldgr %f12,%r12
+    ldgr %f13,%r13
+    ldgr %f14,%r14
+    ldgr %f15,%r15
+
+    /* do compare */
+    .int 0x835a0f00
+    nop
+
+    /* exit test */
+    .int 0x835a0f01
-- 
2.41.0


