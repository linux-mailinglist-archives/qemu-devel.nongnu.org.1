Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E6F7DFF25
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 07:25:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qynb5-0006Cg-Hb; Fri, 03 Nov 2023 02:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qynax-00069E-3B
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 02:23:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qynas-0004CQ-Uk
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 02:23:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxfevrkURl4qg2AA--.39128S3;
 Fri, 03 Nov 2023 14:23:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH93hkURlQfg4AA--.60029S11; 
 Fri, 03 Nov 2023 14:23:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/10] linux-user/loongarch64: Add LSX sigcontext save/restore
Date: Fri,  3 Nov 2023 14:23:31 +0800
Message-Id: <20231103062332.2413724-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231103062332.2413724-1-gaosong@loongson.cn>
References: <20231103062332.2413724-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH93hkURlQfg4AA--.60029S11
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231101030816.2353416-6-gaosong@loongson.cn>
---
 linux-user/loongarch64/signal.c | 107 ++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 20 deletions(-)

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index 9336f40ffe..9c9b446a91 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -41,6 +41,14 @@ struct target_fpu_context {
 QEMU_BUILD_BUG_ON(offsetof(struct target_fpu_context, regs)
                   != offsetof_fpucontext_fr);
 
+#define LSX_CTX_MAGIC           0x53580001
+#define LSX_CTX_ALIGN           16
+struct target_lsx_context {
+    abi_ulong regs[2 * 32];
+    abi_ulong fcc;
+    abi_uint  fcsr;
+} QEMU_ALIGNED(LSX_CTX_ALIGN);
+
 #define CONTEXT_INFO_ALIGN      16
 struct target_sctx_info {
     abi_uint  magic;
@@ -81,9 +89,10 @@ struct ctx_layout {
 };
 
 struct extctx_layout {
-    unsigned int size;
+    unsigned long size;
     unsigned int flags;
     struct ctx_layout fpu;
+    struct ctx_layout lsx;
     struct ctx_layout end;
 };
 
@@ -105,7 +114,8 @@ static abi_ptr extframe_alloc(struct extctx_layout *extctx,
     return sp;
 }
 
-static abi_ptr setup_extcontext(struct extctx_layout *extctx, abi_ptr sp)
+static abi_ptr setup_extcontext(CPULoongArchState *env,
+                                struct extctx_layout *extctx, abi_ptr sp)
 {
     memset(extctx, 0, sizeof(struct extctx_layout));
 
@@ -114,8 +124,15 @@ static abi_ptr setup_extcontext(struct extctx_layout *extctx, abi_ptr sp)
 
     /* For qemu, there is no lazy fp context switch, so fp always present. */
     extctx->flags = SC_USED_FP;
-    sp = extframe_alloc(extctx, &extctx->fpu,
+
+    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+        sp = extframe_alloc(extctx, &extctx->lsx,
+                        sizeof(struct target_lsx_context), LSX_CTX_ALIGN, sp);
+
+    } else {
+        sp = extframe_alloc(extctx, &extctx->fpu,
                         sizeof(struct target_fpu_context), FPU_CTX_ALIGN, sp);
+    }
 
     return sp;
 }
@@ -125,7 +142,6 @@ static void setup_sigframe(CPULoongArchState *env,
                            struct extctx_layout *extctx)
 {
     struct target_sctx_info *info;
-    struct target_fpu_context *fpu_ctx;
     int i;
 
     __put_user(extctx->flags, &sc->sc_flags);
@@ -136,18 +152,39 @@ static void setup_sigframe(CPULoongArchState *env,
     }
 
     /*
-     * Set fpu context
+     * Set extension context
      */
-    info = extctx->fpu.haddr;
-    __put_user(FPU_CTX_MAGIC, &info->magic);
-    __put_user(extctx->fpu.size, &info->size);
 
-    fpu_ctx = (struct target_fpu_context *)(info + 1);
-    for (i = 0; i < 32; ++i) {
-        __put_user(env->fpr[i].vreg.D(0), &fpu_ctx->regs[i]);
+    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+        struct target_lsx_context *lsx_ctx;
+        info = extctx->lsx.haddr;
+
+        __put_user(LSX_CTX_MAGIC, &info->magic);
+        __put_user(extctx->lsx.size, &info->size);
+
+        lsx_ctx = (struct target_lsx_context *)(info + 1);
+
+        for (i = 0; i < 32; ++i) {
+            __put_user(env->fpr[i].vreg.UD(0), &lsx_ctx->regs[2 * i]);
+            __put_user(env->fpr[i].vreg.UD(1), &lsx_ctx->regs[2 * i + 1]);
+        }
+        __put_user(read_fcc(env), &lsx_ctx->fcc);
+        __put_user(env->fcsr0, &lsx_ctx->fcsr);
+    } else {
+        struct target_fpu_context *fpu_ctx;
+        info = extctx->fpu.haddr;
+
+        __put_user(FPU_CTX_MAGIC, &info->magic);
+        __put_user(extctx->fpu.size, &info->size);
+
+        fpu_ctx = (struct target_fpu_context *)(info + 1);
+
+        for (i = 0; i < 32; ++i) {
+            __put_user(env->fpr[i].vreg.UD(0), &fpu_ctx->regs[i]);
+        }
+        __put_user(read_fcc(env), &fpu_ctx->fcc);
+        __put_user(env->fcsr0, &fpu_ctx->fcsr);
     }
-    __put_user(read_fcc(env), &fpu_ctx->fcc);
-    __put_user(env->fcsr0, &fpu_ctx->fcsr);
 
     /*
      * Set end context
@@ -184,6 +221,15 @@ static bool parse_extcontext(struct extctx_layout *extctx, abi_ptr frame)
             extctx->fpu.size = size;
             extctx->size += size;
             break;
+        case LSX_CTX_MAGIC:
+            if (size < (sizeof(struct target_sctx_info) +
+                        sizeof(struct target_lsx_context))) {
+                return false;
+            }
+            extctx->lsx.gaddr = frame;
+            extctx->lsx.size = size;
+            extctx->size += size;
+            break;
         default:
             return false;
         }
@@ -197,19 +243,31 @@ static void restore_sigframe(CPULoongArchState *env,
                              struct extctx_layout *extctx)
 {
     int i;
+    abi_ulong fcc;
 
     __get_user(env->pc, &sc->sc_pc);
     for (i = 1; i < 32; ++i) {
         __get_user(env->gpr[i], &sc->sc_regs[i]);
     }
 
-    if (extctx->fpu.haddr) {
+    if (extctx->lsx.haddr) {
+        struct target_lsx_context *lsx_ctx =
+            extctx->lsx.haddr + sizeof(struct target_sctx_info);
+
+        for (i = 0; i < 32; ++i) {
+            __get_user(env->fpr[i].vreg.UD(0), &lsx_ctx->regs[2 * i]);
+            __get_user(env->fpr[i].vreg.UD(1), &lsx_ctx->regs[2 * i + 1]);
+        }
+        __get_user(fcc, &lsx_ctx->fcc);
+        write_fcc(env, fcc);
+        __get_user(env->fcsr0, &lsx_ctx->fcsr);
+        restore_fp_status(env);
+    } else if (extctx->fpu.haddr) {
         struct target_fpu_context *fpu_ctx =
             extctx->fpu.haddr + sizeof(struct target_sctx_info);
-        abi_ulong fcc;
 
         for (i = 0; i < 32; ++i) {
-            __get_user(env->fpr[i].vreg.D(0), &fpu_ctx->regs[i]);
+            __get_user(env->fpr[i].vreg.UD(0), &fpu_ctx->regs[i]);
         }
         __get_user(fcc, &fpu_ctx->fcc);
         write_fcc(env, fcc);
@@ -229,7 +287,7 @@ static abi_ptr get_sigframe(struct target_sigaction *ka,
 
     sp = target_sigsp(get_sp_from_cpustate(env), ka);
     sp = ROUND_DOWN(sp, 16);
-    sp = setup_extcontext(extctx, sp);
+    sp = setup_extcontext(env, extctx, sp);
     sp -= sizeof(struct target_rt_sigframe);
 
     assert(QEMU_IS_ALIGNED(sp, 16));
@@ -255,8 +313,14 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         force_sigsegv(sig);
         return;
     }
-    extctx.fpu.haddr = (void *)frame + (extctx.fpu.gaddr - frame_addr);
-    extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
+
+    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+        extctx.lsx.haddr = (void *)frame + (extctx.lsx.gaddr - frame_addr);
+        extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
+    } else {
+        extctx.fpu.haddr = (void *)frame + (extctx.fpu.gaddr - frame_addr);
+        extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
+    }
 
     tswap_siginfo(&frame->rs_info, info);
 
@@ -299,7 +363,10 @@ long do_rt_sigreturn(CPULoongArchState *env)
     if (!frame) {
         goto badframe;
     }
-    if (extctx.fpu.gaddr) {
+
+    if (extctx.lsx.gaddr) {
+        extctx.lsx.haddr = (void *)frame + (extctx.lsx.gaddr - frame_addr);
+    } else if (extctx.fpu.gaddr) {
         extctx.fpu.haddr = (void *)frame + (extctx.fpu.gaddr - frame_addr);
     }
 
-- 
2.25.1


