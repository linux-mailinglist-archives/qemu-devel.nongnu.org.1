Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC38CB9EF
	for <lists+qemu-devel@lfdr.de>; Wed, 22 May 2024 05:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cuN-0003U1-9V; Tue, 21 May 2024 23:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuK-0003SD-BJ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuG-0004AE-Ts
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f4472561f1so1120567b3a.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 20:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716349487; x=1716954287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQc6zsisJMaVnI573tc7E5e7k10EWW0D4y87pSLLi8M=;
 b=mYlGyPkSCXj5LLRz1rrmHmKruzT3WR6VYqlUToUwTCby7xM5OpCeZCtLbBznKFD+K3
 G/et5EXSzbjMDysNb4NwKEPuHTOMzIM2wKob/WxnKepE9kjUz5SNRtsjOFazJerJjfQp
 KBLBLk/oXkW+Z+OFIZD161GJi5Hb8gTzErblwOSDED8AM46pfunZPOtBYPVG9UQPoTRy
 NVjRA6yo6L4JJDSdtM4fA0gwwpskyJLl/eNDVMyYOyaMSxfxf+uFYQamViWdy4LZPmpt
 6ef9xJ8zpR9b+Q3SWGu+ocwWvk7P+489b+k9lqoH9TreVNSOcyIBfTUcxAf8rU22fcGZ
 KPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349487; x=1716954287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQc6zsisJMaVnI573tc7E5e7k10EWW0D4y87pSLLi8M=;
 b=vXEf8CWjPthw2B1JV9GomCyrhM5BCFVZjATM2LeZju0uQ0+iWTVV5uxa1OkX6pzH6c
 R3/nv5/tv3wyaMlATR9suI4WcsxHZa2+Chs51UmHuUzyRwBgim8BletSSZ5isi+l32Kw
 baA9099lMcOhLusGTbs782MDUF18JfNJd6dUPZ3fHYOEM9Oq2SaBhJsa6Nn5fvsBtypE
 PVkU7zwlS69nD5EIDXCAe9Ayt4GbH1pA19zG+J7w1Dy1MZpnBp6VHPq87Hy36zyPPggo
 eLXjgrqha2XAKncho8R1nTP/pxshX3s6gV9VU7+I9hT5+IjUGxlpyk9kTNa7h/h0c2Ga
 FXhQ==
X-Gm-Message-State: AOJu0YxwQaPcU+rbQ4v25Uq88I8K+p8mcPjRwzt3TIK7G3WT+mBUxdPO
 hWWRSEc79DCww19Nn5ysmX09Osq/26/PGFqMW1eEqPEU8HaSoiiVQwCvSJnr5uBy1BKUNMm3JVF
 J
X-Google-Smtp-Source: AGHT+IGaTBwR0rCScRqemdTAcLozT3KLY7+3gABYScN2fQyU8MOm/jhDx7i3BNRBKrIomC2SP7pVZQ==
X-Received: by 2002:a05:6a00:21c9:b0:6f3:e6d6:7fde with SMTP id
 d2e1a72fcca58-6f6d6171137mr1217830b3a.26.1716349487258; 
 Tue, 21 May 2024 20:44:47 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm21416617b3a.162.2024.05.21.20.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:44:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 4/8] risu: Add initial sparc64 support
Date: Tue, 21 May 2024 20:44:38 -0700
Message-Id: <20240522034442.140293-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522034442.140293-1-richard.henderson@linaro.org>
References: <20240522034442.140293-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Best effort for both Linux and Solaris as a host, since the
gcc compile farm has more working Sparc Solaris hosts than
Sparc Linux hosts.

What's missing is a value for %gsr from Solaris.
This could complicate comparison of VIS instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile               |   3 +
 risu_reginfo_sparc64.h |  36 ++++++++
 risu.c                 |   2 +
 risu_reginfo_sparc64.c | 186 +++++++++++++++++++++++++++++++++++++++++
 risu_sparc64.c         |  52 ++++++++++++
 configure              |   2 +
 test_sparc64.s         | 137 ++++++++++++++++++++++++++++++
 7 files changed, 418 insertions(+)
 create mode 100644 risu_reginfo_sparc64.h
 create mode 100644 risu_reginfo_sparc64.c
 create mode 100644 risu_sparc64.c
 create mode 100644 test_sparc64.s

diff --git a/Makefile b/Makefile
index 2bd08aa..f503499 100644
--- a/Makefile
+++ b/Makefile
@@ -53,6 +53,9 @@ $(PROG): $(OBJS)
 %_$(ARCH).elf: test.ld %_$(ARCH).o
 	$(LD) -o $@ -T $^
 
+test_sparc64.o: test_sparc64.s
+	$(AS) -Av9a -o $@ $<
+
 clean:
 	rm -f $(PROG) $(OBJS) $(BINO) $(BINE)
 
diff --git a/risu_reginfo_sparc64.h b/risu_reginfo_sparc64.h
new file mode 100644
index 0000000..b1d5341
--- /dev/null
+++ b/risu_reginfo_sparc64.h
@@ -0,0 +1,36 @@
+/******************************************************************************
+ * Copyright (c) 2024 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *****************************************************************************/
+
+#ifndef RISU_REGINFO_SPARC64_H
+#define RISU_REGINFO_SPARC64_H
+
+#ifdef __linux__
+typedef struct sigcontext host_context_t;
+#else
+typedef ucontext_t host_context_t;
+#endif
+
+struct reginfo {
+    uint32_t faulting_insn;
+    uint32_t ccr;
+
+    uint64_t pc;
+    uint64_t npc;
+
+    uint64_t g[8];
+    uint64_t o[8];
+    uint64_t l[8];
+    uint64_t i[8];
+
+    uint64_t y;
+    uint64_t fsr;
+
+    uint64_t fregs[32];
+};
+
+#endif /* RISU_REGINFO_SPARC64_H */
diff --git a/risu.c b/risu.c
index c9c3a38..422b32e 100644
--- a/risu.c
+++ b/risu.c
@@ -30,6 +30,8 @@
 #ifdef __linux__
 #include <endian.h>
 #define HOST_BIG_ENDIAN  (__BYTE_ORDER == __BIG_ENDIAN)
+#elif defined(__sparc__)
+#define HOST_BIG_ENDIAN  1
 #else
 #error Need HOST_BIG_ENDIAN
 #endif
diff --git a/risu_reginfo_sparc64.c b/risu_reginfo_sparc64.c
new file mode 100644
index 0000000..be002e3
--- /dev/null
+++ b/risu_reginfo_sparc64.c
@@ -0,0 +1,186 @@
+/******************************************************************************
+ * Copyright (c) 2024 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *****************************************************************************/
+
+#include <stdio.h>
+#include <ucontext.h>
+#include <string.h>
+#include <signal.h>
+#include <stdlib.h>
+
+#include "risu.h"
+#include "risu_reginfo_sparc64.h"
+
+#define STACK_BIAS 2047
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
+void reginfo_init(struct reginfo *ri, host_context_t *hc, void *siaddr)
+{
+    memset(ri, 0, sizeof(*ri));
+
+#ifdef __linux__
+    ri->pc = hc->sigc_regs.tpc;
+    ri->npc = hc->sigc_regs.tnpc;
+    ri->ccr = (hc->sigc_regs.tstate >> 32) & 0xff;
+    ri->y = hc->sigc_regs.y;
+
+    /* g + o */
+    memcpy(&ri->g, hc->sigc_regs.u_regs, 16 * 8);
+    /* l + i are just before sc */
+    memcpy(&ri->l, (void *)hc - 8 * 8 * 3, 16 * 8);
+
+    if (hc->sigc_fpu_save) {
+        ri->fsr = hc->sigc_fpu_save->si_fsr;
+        /* TODO: ri->gsr = hc->sigc_fpu_save->si_gsr; */
+        memcpy(ri->fregs, hc->sigc_fpu_save->si_float_regs, 32 * 8);
+    }
+#elif defined(__sun__)
+    ri->pc = hc->uc_mcontext.gregs[REG_PC];
+    ri->npc = hc->uc_mcontext.gregs[REG_nPC];
+    ri->ccr = hc->uc_mcontext.gregs[REG_CCR];
+
+    /* G and O are in the signal frame. */
+    memcpy(&ri->g[1], &hc->uc_mcontext.gregs[REG_G1], 7 * sizeof(greg_t));
+    memcpy(&ri->o[0], &hc->uc_mcontext.gregs[REG_O0], 8 * sizeof(greg_t));
+
+    /* L and I are flushed to the regular stack frame. */
+    memcpy(&ri->l[0], (void *)(ri->o[6] + STACK_BIAS), 16 * sizeof(greg_t));
+
+    ri->y = hc->uc_mcontext.gregs[REG_Y];
+    ri->fsr = hc->uc_mcontext.fpregs.fpu_fsr;
+    /* ??? Despite %gsr being asr19, uc->mc.asrs[19-16] is not populated. */
+
+    memcpy(&ri->fregs[0], &hc->uc_mcontext.fpregs.fpu_fr,
+           32 * sizeof(uint64_t));
+#endif
+
+    ri->g[7] = 0xdeadbeefdeadbeeful;  /* tp */
+    ri->o[6] = 0xdeadbeefdeadbeeful;  /* sp */
+    ri->i[6] = 0xdeadbeefdeadbeeful;  /* fp */
+
+    ri->faulting_insn = *(uint32_t *)ri->pc;
+
+    ri->pc -= image_start_address;
+    ri->npc -= image_start_address;
+}
+
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
+bool reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
+{
+    return memcmp(r1, r2, reginfo_size(r1)) == 0;
+}
+
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+void reginfo_dump(struct reginfo *ri, FILE * f)
+{
+    int i;
+
+    fprintf(f, "  insn   : %08x\n", ri->faulting_insn);
+    fprintf(f, "  ccr    : %02x\n", ri->ccr);
+    fprintf(f, "  pc     : %016" PRIx64 "\n", ri->pc);
+    fprintf(f, "  npc    : %016" PRIx64 "\n", ri->npc);
+
+    for (i = 1; i < 8; i++) {
+        fprintf(f, "  G%d     : %016" PRIx64 "\n", i, ri->g[i]);
+    }
+    for (i = 0; i < 8; i++) {
+        fprintf(f, "  O%d     : %016" PRIx64 "\n", i, ri->o[i]);
+    }
+    for (i = 0; i < 8; i++) {
+        fprintf(f, "  L%d     : %016" PRIx64 "\n", i, ri->l[i]);
+    }
+    for (i = 0; i < 8; i++) {
+        fprintf(f, "  I%d     : %016" PRIx64 "\n", i, ri->i[i]);
+    }
+
+    fprintf(f, "  y      : %016" PRIx64 "\n", ri->y);
+    fprintf(f, "  fsr    : %016" PRIx64 "\n", ri->fsr);
+
+    for (i = 0; i < 32; i++) {
+        fprintf(f, "  F%-2d    : %016" PRIx64 "\n", i * 2, ri->fregs[i]);
+    }
+}
+
+/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
+{
+    int i;
+
+    if (m->faulting_insn != a->faulting_insn) {
+        fprintf(f, "  insn   : %08x vs %08x\n",
+                m->faulting_insn, a->faulting_insn);
+    }
+    if (m->ccr != a->ccr) {
+        fprintf(f, "  ccr    : %02x vs %02x\n", m->ccr, a->ccr);
+    }
+    if (m->pc != a->pc) {
+        fprintf(f, "  pc     : %016" PRIx64 " vs %016" PRIx64 "\n",
+                m->pc, a->pc);
+    }
+    if (m->npc != a->npc) {
+        fprintf(f, "  npc    : %016" PRIx64 " vs %016" PRIx64 "\n",
+                m->npc, a->npc);
+    }
+
+    for (i = 1; i < 8; i++) {
+        if (m->g[i] != a->g[i]) {
+            fprintf(f, "  G%d     : %016" PRIx64 " vs %016" PRIx64 "\n",
+                    i, m->g[i], a->g[i]);
+        }
+    }
+    for (i = 0; i < 8; i++) {
+        if (m->o[i] != a->o[i]) {
+            fprintf(f, "  O%d     : %016" PRIx64 " vs %016" PRIx64 "\n",
+                    i, m->o[i], a->o[i]);
+        }
+    }
+    for (i = 0; i < 8; i++) {
+        if (m->l[i] != a->l[i]) {
+            fprintf(f, "  L%d     : %016" PRIx64 " vs %016" PRIx64 "\n",
+                    i, m->l[i], a->l[i]);
+        }
+    }
+    for (i = 0; i < 8; i++) {
+        if (m->i[i] != a->i[i]) {
+            fprintf(f, "  I%d     : %016" PRIx64 " vs %016" PRIx64 "\n",
+                    i, m->i[i], a->i[i]);
+        }
+    }
+
+    if (m->y != a->y) {
+        fprintf(f, "  y      : %016" PRIx64 " vs %016" PRIx64 "\n",
+                m->y, a->y);
+    }
+    if (m->fsr != a->fsr) {
+        fprintf(f, "  fsr    : %016" PRIx64 " vs %016" PRIx64 "\n",
+                m->fsr, a->fsr);
+    }
+
+    for (i = 0; i < 32; i++) {
+        if (m->fregs[i] != a->fregs[i]) {
+            fprintf(f, "  F%-2d    : %016" PRIx64 " vs %016" PRIx64 "\n",
+                    i * 2, m->fregs[i], a->fregs[i]);
+        }
+    }
+}
diff --git a/risu_sparc64.c b/risu_sparc64.c
new file mode 100644
index 0000000..48b5cfe
--- /dev/null
+++ b/risu_sparc64.c
@@ -0,0 +1,52 @@
+/******************************************************************************
+ * Copyright (c) 2024 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *****************************************************************************/
+
+#include <signal.h>
+#include "risu.h"
+
+void advance_pc(host_context_t *hc)
+{
+#ifdef __linux__
+    hc->sigc_regs.tpc = hc->sigc_regs.tnpc;
+    hc->sigc_regs.tnpc += 4;
+#else
+    hc->uc_mcontext.gregs[REG_PC] = hc->uc_mcontext.gregs[REG_nPC];
+    hc->uc_mcontext.gregs[REG_nPC] += 4;
+#endif
+}
+
+void set_ucontext_paramreg(host_context_t *hc, uint64_t value)
+{
+#ifdef __linux__
+    hc->sigc_regs.u_regs[15] = value;
+#else
+    hc->uc_mcontext.gregs[REG_O7] = value;
+#endif
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->o[7];
+}
+
+RisuOp get_risuop(struct reginfo *ri)
+{
+    /* Return the risuop we have been asked to do
+     * (or OP_SIGILL if this was a SIGILL for a non-risuop insn)
+     */
+    uint32_t insn = ri->faulting_insn;
+    uint32_t op = insn & 0xf;
+    uint32_t key = insn & ~0xf;
+    uint32_t risukey = 0x000dead0;
+    return (key != risukey) ? OP_SIGILL : op;
+}
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+   return ri->pc;
+}
diff --git a/configure b/configure
index 39275a2..965f338 100755
--- a/configure
+++ b/configure
@@ -62,6 +62,8 @@ guess_arch() {
         ARCH="ppc64"
     elif check_define __s390x__ ; then
         ARCH="s390x"
+    elif check_define __sparc__ && check_define __arch64__ ; then
+        ARCH="sparc64"
     else
         echo "This cpu is not supported by risu. Try -h. " >&2
         exit 1
diff --git a/test_sparc64.s b/test_sparc64.s
new file mode 100644
index 0000000..c131d81
--- /dev/null
+++ b/test_sparc64.s
@@ -0,0 +1,137 @@
+/*****************************************************************************
+ * Copyright (c) 2024 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *****************************************************************************/
+
+/* Initialise the fp regs */
+
+	.register %g2, #ignore
+	.register %g3, #ignore
+	.register %g6, #ignore
+
+.text
+	rd	%pc, %g1
+	sethi	%pc22(.Ldata+4), %g2
+	or	%g2, %pc10(.Ldata+8), %g2
+	add	%g2, %g1, %g1
+
+	ldd	[%g1 + 4 * 0], %f0
+	ldd	[%g1 + 4 * 2], %f2
+	ldd	[%g1 + 4 * 4], %f4
+	ldd	[%g1 + 4 * 6], %f6
+	ldd	[%g1 + 4 * 8], %f8
+	ldd	[%g1 + 4 * 10], %f10
+	ldd	[%g1 + 4 * 12], %f12
+	ldd	[%g1 + 4 * 14], %f14
+	ldd	[%g1 + 4 * 16], %f16
+	ldd	[%g1 + 4 * 18], %f18
+	ldd	[%g1 + 4 * 20], %f20
+	ldd	[%g1 + 4 * 22], %f22
+	ldd	[%g1 + 4 * 24], %f24
+	ldd	[%g1 + 4 * 26], %f26
+	ldd	[%g1 + 4 * 28], %f28
+	ldd	[%g1 + 4 * 30], %f30
+	ldd	[%g1 + 4 * 32], %f32
+	ldd	[%g1 + 4 * 34], %f34
+	ldd	[%g1 + 4 * 36], %f36
+	ldd	[%g1 + 4 * 38], %f38
+	ldd	[%g1 + 4 * 40], %f40
+	ldd	[%g1 + 4 * 42], %f42
+	ldd	[%g1 + 4 * 44], %f44
+	ldd	[%g1 + 4 * 46], %f46
+	ldd	[%g1 + 4 * 48], %f48
+	ldd	[%g1 + 4 * 50], %f50
+	ldd	[%g1 + 4 * 52], %f52
+	ldd	[%g1 + 4 * 54], %f54
+	ldd	[%g1 + 4 * 56], %f56
+	ldd	[%g1 + 4 * 58], %f58
+	ldd	[%g1 + 4 * 60], %f60
+	ldd	[%g1 + 4 * 62], %f62
+
+/* Initialize the special regs */
+
+	wr	%g0, 0x100, %y
+	wr	%g0, 0x200, %gsr
+	cmp	%g0, %g0
+
+/* Initialise the gp regs */
+
+	mov	1, %g1
+	mov	2, %g2
+	mov	3, %g3
+	mov	4, %g4
+	mov	5, %g5
+	mov	6, %g6
+	/* g7 is the thread pointer */
+
+	mov	8, %o0
+	mov	9, %o1
+	mov	10, %o2
+	mov	11, %o3
+	mov	12, %o4
+	mov	13, %o5
+	/* o6 is the stack pointer */
+	mov	15, %o7
+
+	mov	16, %l0
+	mov	17, %l1
+	mov	18, %l2
+	mov	19, %l3
+	mov	20, %l4
+	mov	21, %l5
+	mov	22, %l6
+	mov	23, %l7
+
+	mov	24, %i0
+	mov	25, %i1
+	mov	26, %i2
+	mov	27, %i3
+	mov	28, %i4
+	mov	29, %i5
+	/* i6 is the frame pointer */
+	mov	31, %i7
+
+/* Do compare. */
+
+	illtrap	0xdead0
+	illtrap	0xdead1
+
+.data
+	.align	8
+.Ldata:
+	.double 1
+	.double 2
+	.double 3
+	.double 4
+	.double 5
+	.double 6
+	.double 7
+	.double 8
+	.double 9
+	.double 10
+	.double 11
+	.double 12
+	.double 13
+	.double 14
+	.double 15
+	.double 16
+	.double 17
+	.double 18
+	.double 19
+	.double 20
+	.double 21
+	.double 22
+	.double 23
+	.double 24
+	.double 25
+	.double 26
+	.double 27
+	.double 28
+	.double 29
+	.double 30
+	.double 31
+	.double 32
+
-- 
2.34.1


