Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8F5791953
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:03:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdA8o-0006x1-C6; Mon, 04 Sep 2023 10:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdA8N-0006tM-V3
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdA8I-00088Q-HK
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693836049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGcJ34kwy0LVOQwYnN3F2+fzebsswC9QQNw9e5u8JW0=;
 b=EBwgOxMKc1WBuJk0FXfWyICWeWLiIG2EwFrDURY6dGoHcvWV0UBW+SkehJ36rAoQ3xrUik
 7x81JJIUnxptlZOs3f23H7L+Ui67ZrbSMl6lSkUNrUQ/kjNreXI7gnQpZHBf4mH27u3EQA
 i0uiIrQV0OKAktk3pCCV2B9U3R7MlqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-D0Dp-ilFMquqnW2r3BkzYw-1; Mon, 04 Sep 2023 10:00:46 -0400
X-MC-Unique: D0Dp-ilFMquqnW2r3BkzYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97DEE8008A4;
 Mon,  4 Sep 2023 14:00:45 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EA451121314;
 Mon,  4 Sep 2023 14:00:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [risu PATCH 1/4] s390x: Add basic s390x support to the C code
Date: Mon,  4 Sep 2023 16:00:37 +0200
Message-Id: <20230904140040.33153-2-thuth@redhat.com>
In-Reply-To: <20230904140040.33153-1-thuth@redhat.com>
References: <20230904140040.33153-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With these changes, it is now possible to compile the "risu" binary
for s390x hosts.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 risu_reginfo_s390x.c | 142 +++++++++++++++++++++++++++++++++++++++++++
 risu_reginfo_s390x.h |  23 +++++++
 risu_s390x.c         |  48 +++++++++++++++
 test_s390x.S         |  32 ++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 risu_reginfo_s390x.c
 create mode 100644 risu_reginfo_s390x.h
 create mode 100644 risu_s390x.c
 create mode 100644 test_s390x.S

diff --git a/risu_reginfo_s390x.c b/risu_reginfo_s390x.c
new file mode 100644
index 0000000..9e118a2
--- /dev/null
+++ b/risu_reginfo_s390x.c
@@ -0,0 +1,142 @@
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
+#include <ucontext.h>
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
+void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+{
+    int i;
+
+    memset(ri, 0, sizeof(*ri));
+
+    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.psw.addr);
+    ri->psw_mask = uc->uc_mcontext.psw.mask;
+    ri->psw_addr = uc->uc_mcontext.psw.addr - image_start_address;
+
+    for (i = 0; i < 16; i++) {
+        ri->gregs[i] = uc->uc_mcontext.gregs[i];
+    }
+
+    memcpy(&ri->fpregs, &uc->uc_mcontext.fpregs, sizeof(fpregset_t));
+}
+
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+{
+    int i;
+
+    if (m->psw_mask != a->psw_mask || m->psw_addr != a->psw_addr) {
+        return 0;
+    }
+
+    /* Skip return address register and stack register for comparison */
+    for (i = 0; i < 14; i++) {
+        if (m->gregs[i] != a->gregs[i]) {
+            return 0;
+        }
+    }
+
+    if (memcmp(&m->fpregs, &a->fpregs, sizeof(fpregset_t))) {
+        return 0;
+    }
+
+    return 1;
+}
+
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+int reginfo_dump(struct reginfo *ri, FILE * f)
+{
+    int i;
+
+    fprintf(f, "  faulting insn 0x%x\n", ri->faulting_insn);
+    fprintf(f, "  PSW mask      0x%" PRIx64 "\n\n", ri->psw_mask);
+    fprintf(f, "  PSW addr offs 0x%" PRIx64 "\n\n", ri->psw_addr);
+
+    for (i = 0; i < 16/2; i++) {
+        fprintf(f, "\tr%d: %16lx\tr%02d: %16lx\n", i, ri->gregs[i],
+                i + 8, ri->gregs[i + 8]);
+    }
+    fprintf(f, "\n");
+
+    for (i = 0; i < 16/2; i++) {
+        fprintf(f, "\tf%d: %16lx\tf%02d: %16lx\n",
+                i, *(uint64_t *)&ri->fpregs.fprs[i],
+                i + 8, *(uint64_t *)&ri->fpregs.fprs[i + 8]);
+    }
+    fprintf(f, "\tFPC: %8x\n\n", ri->fpregs.fpc);
+
+    return !ferror(f);
+}
+
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+{
+    int i;
+
+    if (m->psw_mask != a->psw_mask) {
+        fprintf(f, "Mismatch: PSW mask master: [%016lx] - PSW mask apprentice: [%016lx]\n",
+                m->psw_mask, a->psw_mask);
+    }
+
+    if (m->psw_addr != a->psw_addr) {
+        fprintf(f, "Mismatch: PSW addr offset master: [%016lx] - PSW addr offset apprentice: [%016lx]\n",
+                m->psw_addr, a->psw_addr);
+    }
+
+    /* Skip return address register and stack register for comparison */
+    for (i = 0; i < 14; i++) {
+        if (m->gregs[i] != a->gregs[i]) {
+            fprintf(f, "Mismatch: r%d master: [%016lx] - r%d apprentice: [%016lx]\n",
+                    i, m->gregs[i], i, a->gregs[i]);
+        }
+    }
+
+    for (i = 0; i < 16; i++) {
+        if (*(uint64_t *)&m->fpregs.fprs[i] != *(uint64_t *)&a->fpregs.fprs[i]) {
+            fprintf(f, "Mismatch: f%d master: [%016lx] - f%d apprentice: [%016lx]\n",
+                    i, *(uint64_t *)&m->fpregs.fprs[i],
+                    i, *(uint64_t *)&a->fpregs.fprs[i]);
+        }
+    }
+
+    if (m->fpregs.fpc != a->fpregs.fpc) {
+        fprintf(f, "Mismatch: FPC master: [%08x] - FPC apprentice: [%08x]\n",
+                m->fpregs.fpc, a->fpregs.fpc);
+    }
+
+    return !ferror(f);
+}
diff --git a/risu_reginfo_s390x.h b/risu_reginfo_s390x.h
new file mode 100644
index 0000000..b55a11d
--- /dev/null
+++ b/risu_reginfo_s390x.h
@@ -0,0 +1,23 @@
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
+    uint32_t faulting_insn;
+    uint64_t psw_mask;
+    uint64_t psw_addr;
+    gregset_t gregs;
+    fpregset_t fpregs;
+};
+
+#endif /* RISU_REGINFO_S390X_H */
diff --git a/risu_s390x.c b/risu_s390x.c
new file mode 100644
index 0000000..4a83869
--- /dev/null
+++ b/risu_s390x.c
@@ -0,0 +1,48 @@
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
+    // ucontext_t *uc = (ucontext_t *) vuc;
+    // uc->uc_mcontext.psw.addr += 4;
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
+    return ri->gregs[0];
+}
+
+RisuOp get_risuop(struct reginfo *ri)
+{
+    uint32_t insn = ri->faulting_insn;
+    uint32_t op = insn & 0xff;
+    uint32_t key = insn & ~0xff;
+    return (key != 0x835a0f00) ? OP_SIGILL : op;
+}
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+   return ri->psw_addr;
+}
diff --git a/test_s390x.S b/test_s390x.S
new file mode 100644
index 0000000..b67594f
--- /dev/null
+++ b/test_s390x.S
@@ -0,0 +1,32 @@
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
+
+    /* do compare */
+    .int 0x835a0f00
+    /* exit test */
+    .int 0x835a0f01
-- 
2.39.3


