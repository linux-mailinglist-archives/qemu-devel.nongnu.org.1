Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4F7BF19E
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq3Ye-0006CE-Bj; Mon, 09 Oct 2023 23:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qq3YZ-00069I-Lt
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:37:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qq3YV-0005uD-SK
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:37:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxlPDgxiRlyIUwAA--.28025S3;
 Tue, 10 Oct 2023 11:37:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxP93cxiRl4NgdAA--.64991S8; 
 Tue, 10 Oct 2023 11:37:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, laurent@vivier.e,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, laurent@vivier.eu
Subject: [PATCH v1 6/6] linux-user/loongarch64: Add LASX sigcontext
 save/restore
Date: Tue, 10 Oct 2023 11:37:01 +0800
Message-Id: <20231010033701.385725-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231010033701.385725-1-gaosong@loongson.cn>
References: <20231010033701.385725-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxP93cxiRl4NgdAA--.64991S8
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 linux-user/loongarch64/signal.c | 67 ++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index 4b09e50a5f..e5b7688a2e 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -41,6 +41,14 @@ struct target_lsx_context {
     uint32_t fcsr;
 } QEMU_ALIGNED(LSX_CTX_ALIGN);
 
+#define LASX_CTX_MAGIC          0x41535801
+#define LASX_CTX_ALIGN          32
+struct target_lasx_context {
+    uint64_t regs[4 * 32];
+    uint64_t fcc;
+    uint32_t fcsr;
+} QEMU_ALIGNED(LASX_CTX_ALIGN);
+
 #define CONTEXT_INFO_ALIGN      16
 struct target_sctx_info {
     uint32_t magic;
@@ -78,6 +86,7 @@ struct extctx_layout {
     unsigned int flags;
     struct ctx_layout fpu;
     struct ctx_layout lsx;
+    struct ctx_layout lasx;
     struct ctx_layout end;
 };
 
@@ -110,7 +119,10 @@ static abi_ptr setup_extcontext(CPULoongArchState *env,
     /* For qemu, there is no lazy fp context switch, so fp always present. */
     extctx->flags = SC_USED_FP;
 
-    if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
+    if (env->extctx_flags & EXTCTX_FLAGS_LASX) {
+        sp = extframe_alloc(extctx, &extctx->lasx,
+                        sizeof(struct target_lasx_context), LASX_CTX_ALIGN, sp);
+    } else if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
         sp = extframe_alloc(extctx, &extctx->lsx,
                         sizeof(struct target_lsx_context), LSX_CTX_ALIGN, sp);
 
@@ -140,7 +152,24 @@ static void setup_sigframe(CPULoongArchState *env,
      * Set extension context
      */
 
-    if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
+    if (env->extctx_flags & EXTCTX_FLAGS_LASX) {
+        struct target_lasx_context *lasx_ctx;
+        info = extctx->lasx.haddr;
+
+        __put_user(LASX_CTX_MAGIC, &info->magic);
+        __put_user(extctx->lasx.size, &info->size);
+
+        lasx_ctx = (struct target_lasx_context *)(info + 1);
+
+        for (i = 0; i < 32; ++i) {
+            __put_user(env->fpr[i].vreg.UD(0), &lasx_ctx->regs[4 * i]);
+            __put_user(env->fpr[i].vreg.UD(1), &lasx_ctx->regs[4 * i + 1]);
+            __put_user(env->fpr[i].vreg.UD(2), &lasx_ctx->regs[4 * i + 2]);
+            __put_user(env->fpr[i].vreg.UD(3), &lasx_ctx->regs[4 * i + 3]);
+        }
+        __put_user(read_fcc(env), &lasx_ctx->fcc);
+        __put_user(env->fcsr0, &lasx_ctx->fcsr);
+    } else if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
         struct target_lsx_context *lsx_ctx;
         info = extctx->lsx.haddr;
 
@@ -215,6 +244,15 @@ static bool parse_extcontext(struct extctx_layout *extctx, abi_ptr frame)
             extctx->lsx.size = size;
             extctx->size += size;
             break;
+        case LASX_CTX_MAGIC:
+            if (size < (sizeof(struct target_sctx_info) +
+                        sizeof(struct target_lasx_context))) {
+                return false;
+            }
+            extctx->lasx.gaddr = frame;
+            extctx->lasx.size = size;
+            extctx->size += size;
+            break;
         default:
             return false;
         }
@@ -235,7 +273,21 @@ static void restore_sigframe(CPULoongArchState *env,
         __get_user(env->gpr[i], &sc->sc_regs[i]);
     }
 
-    if (extctx->lsx.haddr) {
+    if (extctx->lasx.haddr) {
+        struct target_lasx_context *lasx_ctx =
+            extctx->lasx.haddr + sizeof(struct target_sctx_info);
+
+        for (i = 0; i < 32; ++i) {
+            __get_user(env->fpr[i].vreg.UD(0), &lasx_ctx->regs[4 * i]);
+            __get_user(env->fpr[i].vreg.UD(1), &lasx_ctx->regs[4 * i + 1]);
+            __get_user(env->fpr[i].vreg.UD(2), &lasx_ctx->regs[4 * i + 2]);
+            __get_user(env->fpr[i].vreg.UD(3), &lasx_ctx->regs[4 * i + 3]);
+        }
+        __get_user(fcc, &lasx_ctx->fcc);
+        write_fcc(env, fcc);
+        __get_user(env->fcsr0, &lasx_ctx->fcsr);
+        restore_fp_status(env);
+    } else if (extctx->lsx.haddr) {
         struct target_lsx_context *lsx_ctx =
             extctx->lsx.haddr + sizeof(struct target_sctx_info);
 
@@ -299,7 +351,10 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         return;
     }
 
-    if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
+    if (env->extctx_flags & EXTCTX_FLAGS_LASX) {
+        extctx.lasx.haddr = (void *)frame + (extctx.lasx.gaddr - frame_addr);
+        extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
+    } else if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
         extctx.lsx.haddr = (void *)frame + (extctx.lsx.gaddr - frame_addr);
         extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
     } else if (env->extctx_flags & EXTCTX_FLAGS_FPU) {
@@ -349,7 +404,9 @@ long do_rt_sigreturn(CPULoongArchState *env)
         goto badframe;
     }
 
-    if (extctx.lsx.gaddr) {
+    if (extctx.lasx.gaddr) {
+        extctx.lasx.haddr = (void *)frame + (extctx.lasx.gaddr - frame_addr);
+    } else if (extctx.lsx.gaddr) {
         extctx.lsx.haddr = (void *)frame + (extctx.lsx.gaddr - frame_addr);
     } else if (extctx.fpu.gaddr) {
         extctx.fpu.haddr = (void *)frame + (extctx.fpu.gaddr - frame_addr);
-- 
2.25.1


