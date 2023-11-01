Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6EB7DDB5C
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 04:10:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy1au-0003xn-VY; Tue, 31 Oct 2023 23:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qy1aq-0003wA-Dv
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:08:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qy1am-0005qx-TG
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:08:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx2eoqwUFl1yM2AA--.35204S3;
 Wed, 01 Nov 2023 11:08:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdwdwUFltsk3AA--.55379S8; 
 Wed, 01 Nov 2023 11:08:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, laurent@vivier.eu,
 maobibo@loongson.cn
Subject: [PATCH v2 6/6] linux-user/loongarch64: Add LASX sigcontext
 save/restore
Date: Wed,  1 Nov 2023 11:08:16 +0800
Message-Id: <20231101030816.2353416-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231101030816.2353416-1-gaosong@loongson.cn>
References: <20231101030816.2353416-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdwdwUFltsk3AA--.55379S8
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
 linux-user/loongarch64/signal.c | 68 ++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index 9c9b446a91..39ea82c814 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -49,6 +49,14 @@ struct target_lsx_context {
     abi_uint  fcsr;
 } QEMU_ALIGNED(LSX_CTX_ALIGN);
 
+#define LASX_CTX_MAGIC          0x41535801
+#define LASX_CTX_ALIGN          32
+struct target_lasx_context {
+    abi_ulong regs[4 * 32];
+    abi_ulong fcc;
+    abi_uint  fcsr;
+} QEMU_ALIGNED(LASX_CTX_ALIGN);
+
 #define CONTEXT_INFO_ALIGN      16
 struct target_sctx_info {
     abi_uint  magic;
@@ -93,6 +101,7 @@ struct extctx_layout {
     unsigned int flags;
     struct ctx_layout fpu;
     struct ctx_layout lsx;
+    struct ctx_layout lasx;
     struct ctx_layout end;
 };
 
@@ -125,10 +134,12 @@ static abi_ptr setup_extcontext(CPULoongArchState *env,
     /* For qemu, there is no lazy fp context switch, so fp always present. */
     extctx->flags = SC_USED_FP;
 
-    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE)) {
+        sp = extframe_alloc(extctx, &extctx->lasx,
+                        sizeof(struct target_lasx_context), LASX_CTX_ALIGN, sp);
+    } else if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
         sp = extframe_alloc(extctx, &extctx->lsx,
                         sizeof(struct target_lsx_context), LSX_CTX_ALIGN, sp);
-
     } else {
         sp = extframe_alloc(extctx, &extctx->fpu,
                         sizeof(struct target_fpu_context), FPU_CTX_ALIGN, sp);
@@ -155,7 +166,24 @@ static void setup_sigframe(CPULoongArchState *env,
      * Set extension context
      */
 
-    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE)) {
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
+    } else if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
         struct target_lsx_context *lsx_ctx;
         info = extctx->lsx.haddr;
 
@@ -230,6 +258,15 @@ static bool parse_extcontext(struct extctx_layout *extctx, abi_ptr frame)
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
@@ -250,7 +287,21 @@ static void restore_sigframe(CPULoongArchState *env,
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
 
@@ -314,7 +365,10 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         return;
     }
 
-    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
+    if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE)) {
+        extctx.lasx.haddr = (void *)frame + (extctx.lasx.gaddr - frame_addr);
+        extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
+    } else if (FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE)) {
         extctx.lsx.haddr = (void *)frame + (extctx.lsx.gaddr - frame_addr);
         extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
     } else {
@@ -364,7 +418,9 @@ long do_rt_sigreturn(CPULoongArchState *env)
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


