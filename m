Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A752E810C7C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 09:33:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDKeq-0001jk-BW; Wed, 13 Dec 2023 03:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rDKee-0001hZ-Rp
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 03:31:46 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rDKeb-0008Du-7m
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 03:31:44 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx6ujna3llOZwAAA--.3703S3;
 Wed, 13 Dec 2023 16:31:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxguPka3ll6BQCAA--.14323S4; 
 Wed, 13 Dec 2023 16:31:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, maobibo@loongson.cn
Subject: [risu PATCH v2 2/6] loongarch: reginfo suport LSX/LASX
Date: Wed, 13 Dec 2023 16:18:35 +0800
Message-Id: <20231213081839.4176614-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231213081839.4176614-1-gaosong@loongson.cn>
References: <20231213081839.4176614-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxguPka3ll6BQCAA--.14323S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 risu_reginfo_loongarch64.c | 107 +++++++++++++++++++++++++++++++++----
 risu_reginfo_loongarch64.h |   3 +-
 2 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/risu_reginfo_loongarch64.c b/risu_reginfo_loongarch64.c
index 16384f1..09a1eb6 100644
--- a/risu_reginfo_loongarch64.c
+++ b/risu_reginfo_loongarch64.c
@@ -37,6 +37,8 @@ struct extctx_layout {
         unsigned long size;
         unsigned int flags;
         struct _ctx_layout fpu;
+        struct _ctx_layout lsx;
+        struct _ctx_layout lasx;
         struct _ctx_layout end;
 };
 
@@ -72,6 +74,20 @@ static int parse_extcontext(struct sigcontext *sc, struct extctx_layout *extctx)
             }
             extctx->fpu.addr = info;
             break;
+        case LSX_CTX_MAGIC:
+            if (size < (sizeof(struct sctx_info) +
+                        sizeof(struct lsx_context))) {
+                return -1;
+            }
+            extctx->lsx.addr = info;
+            break;
+        case LASX_CTX_MAGIC:
+            if (size < (sizeof(struct sctx_info) +
+                        sizeof(struct lasx_context))) {
+                return -1;
+            }
+            extctx->lasx.addr = info;
+            break;
         default:
             return -1;
        }
@@ -100,15 +116,40 @@ void reginfo_init(struct reginfo *ri, ucontext_t *context, void *siaddr)
     ri->faulting_insn = *(uint32_t *)uc->uc_mcontext.sc_pc;
 
     parse_extcontext(&uc->uc_mcontext, &extctx);
-    if (extctx.fpu.addr) {
+    if (extctx.lasx.addr) {
+        struct sctx_info *info = extctx.lasx.addr;
+        struct lasx_context *lasx_ctx = (struct lasx_context *)((char *)info +
+                                        sizeof(struct sctx_info));
+        for (i = 0; i < 32; i++) {
+            ri->vregs[4 * i] = lasx_ctx->regs[4 * i];
+            ri->vregs[4 * i + 1] = lasx_ctx->regs[4 * i + 1];
+            ri->vregs[4 * i + 2] = lasx_ctx->regs[4 * i + 2];
+            ri->vregs[4 * i + 3] = lasx_ctx->regs[4 * i + 3];
+        }
+        ri->fcsr = lasx_ctx->fcsr;
+        ri->fcc = lasx_ctx->fcc;
+        ri->vl = 256;
+    } else if (extctx.lsx.addr) {
+        struct sctx_info *info = extctx.lsx.addr;
+        struct lsx_context *lsx_ctx = (struct lsx_context *)((char *)info +
+                                      sizeof(struct sctx_info));
+        for (i = 0; i < 32; i++) {
+            ri->vregs[4 * i] = lsx_ctx->regs[4 * i + 1];
+            ri->vregs[4 * i + 1] = lsx_ctx->regs[4 * i + 1];
+        }
+        ri->fcsr = lsx_ctx->fcsr;
+        ri->fcc = lsx_ctx->fcc;
+        ri->vl = 128;
+    } else if (extctx.fpu.addr) {
         struct sctx_info *info = extctx.fpu.addr;
         struct fpu_context *fpu_ctx = (struct fpu_context *)((char *)info +
-                                       sizeof(struct sctx_info));
+                                      sizeof(struct sctx_info));
         for(i = 0; i < 32; i++) {
-	    ri->fpregs[i] = fpu_ctx->regs[i];
+	    ri->vregs[4 * i] = fpu_ctx->regs[4 * i];
         }
-	ri->fcsr = fpu_ctx->fcsr;
-	ri->fcc = fpu_ctx->fcc;
+        ri->fcsr = fpu_ctx->fcsr;
+        ri->fcc = fpu_ctx->fcc;
+        ri->vl = 64;
     }
 }
 
@@ -132,9 +173,23 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "  flags  : %08x\n", ri->flags);
     fprintf(f, "  fcc    : %016" PRIx64 "\n", ri->fcc);
     fprintf(f, "  fcsr   : %08x\n", ri->fcsr);
+    fprintf(f, "  vl     : %016" PRIx64 "\n", ri->vl);
 
-    for (i = 0; i < 32; i++) {
-        fprintf(f, "  f%-2d    : %016lx\n", i, ri->fpregs[i]);
+    if (ri->vl == 256) {
+        for (i = 0; i < 32; i++) {
+            fprintf(f, "  vreg%-2d    : {%016lx, %016lx, %016lx, %016lx}\n", i,
+                    ri->vregs[4 * i + 3], ri->vregs[4 * i + 2],
+                    ri->vregs[4 * i + 1], ri->vregs[4 * i]);
+        }
+    } else if (ri->vl == 128) {
+        for (i = 0; i < 32; i++) {
+            fprintf(f, "  vreg%-2d    : {%016lx, %016lx}\n", i,
+                    ri->vregs[4 * i + 1], ri->vregs[4 * i]);
+        }
+    } else if (ri->vl == 64) {
+        for (i = 0; i < 32; i++) {
+            fprintf(f, "  vreg%-2d    : %016lx\n", i, ri->vregs[4 * i]);
+        }
     }
 
     return !ferror(f);
@@ -145,6 +200,11 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 {
     int i;
     fprintf(f, "mismatch detail (master : apprentice):\n");
+
+    if (m->vl != a->vl) {
+        fprintf(f, "  vl mismatch %08lx vs %08lx\n", m->vl, a->vl);
+    }
+
     if (m->faulting_insn != a->faulting_insn) {
         fprintf(f, "  faulting insn mismatch %08x vs %08x\n",
                 m->faulting_insn, a->faulting_insn);
@@ -172,10 +232,35 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
         fprintf(f, "  fcsr   : %08x vs %08x\n", m->fcsr, a->fcsr);
     }
 
-    for (i = 0; i < 32; i++) {
-        if (m->fpregs[i]!= a->fpregs[i]) {
-            fprintf(f, "  f%-2d    : %016lx vs %016lx\n",
-                    i, m->fpregs[i], a->fpregs[i]);
+    if (m->vl == 256) {
+        for (i = 0; i < 32; i++) {
+            if (m->vregs[4 * i + 3] != a->vregs[4 * i + 3] ||
+                m->vregs[4 * i + 2] != a->vregs[4 * i + 2] ||
+                m->vregs[4 * i + 1] != a->vregs[4 * i + 1] ||
+                m->vregs[4 * i] != a->vregs[4 * i]) {
+                fprintf(f, "  vreg%-2d    : {%016lx, %016lx, %016lx, %016lx} vs"
+                           " {%016lx, %016lx, %016lx, %016lx}\n", i,
+                        m->vregs[4 * i + 3], m->vregs[4 * i + 2],
+                        m->vregs[4 * i + 1], m->vregs[4 * i],
+                        a->vregs[4 * i + 3], a->vregs[4 * i + 2],
+                        a->vregs[4 * i + 1], a->vregs[4 * i]);
+            }
+        }
+    } else if (m->vl == 128) {
+        for (i = 0; i < 32; i++) {
+            if (m->vregs[4 * i + 1] != a->vregs[4 * i + 1] ||
+                m->vregs[4 * i] != a->vregs[4 * i]) {
+                fprintf(f, "  vreg%-2d    : {%016lx, %016lx} vs {%016lx, %016lx}\n",
+                        i, m->vregs[4 * i + 1], m->vregs[4 * i],
+                        a->vregs[4 * i + 1], m->vregs[4 * i]);
+            }
+        }
+    } else if (m->vl == 64) {
+        for (i = 0; i < 32; i++) {
+            if (m->vregs[4 * i]  != a->vregs[4 * i]) {
+                fprintf(f, "  vreg%-2d  : %016lx vs %016lx\n", i,
+                        m->vregs[4 * i], a->vregs[4 * i]);
+            }
         }
     }
 
diff --git a/risu_reginfo_loongarch64.h b/risu_reginfo_loongarch64.h
index b6c5aaa..892b477 100644
--- a/risu_reginfo_loongarch64.h
+++ b/risu_reginfo_loongarch64.h
@@ -19,7 +19,8 @@ struct reginfo {
     uint32_t flags;
     uint32_t fcsr;
     uint32_t faulting_insn;
-    uint64_t fpregs[32];
+    uint64_t vregs[4 * 32];
+    uint64_t vl;
 };
 
 #endif /* RISU_REGINFO_LOONGARCH64_H */
-- 
2.25.1


