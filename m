Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6727DFF21
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 07:25:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qynb6-0006Ci-3H; Fri, 03 Nov 2023 02:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qynaw-00069C-QN
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 02:23:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qynat-0004CT-Kq
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 02:23:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxZ+jrkURl3qg2AA--.5923S3;
 Fri, 03 Nov 2023 14:23:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH93hkURlQfg4AA--.60029S10; 
 Fri, 03 Nov 2023 14:23:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/10] linux-user/loongarch64: Use abi_{ulong,uint} types
Date: Fri,  3 Nov 2023 14:23:30 +0800
Message-Id: <20231103062332.2413724-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231103062332.2413724-1-gaosong@loongson.cn>
References: <20231103062332.2413724-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH93hkURlQfg4AA--.60029S10
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
Message-Id: <20231101030816.2353416-5-gaosong@loongson.cn>
---
 linux-user/loongarch64/signal.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index cc8324b4b3..9336f40ffe 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -18,10 +18,10 @@
 #define SC_USED_FP              (1 << 0)
 
 struct target_sigcontext {
-    uint64_t sc_pc;
-    uint64_t sc_regs[32];
-    uint32_t sc_flags;
-    uint64_t sc_extcontext[0]   QEMU_ALIGNED(16);
+    abi_ulong sc_pc;
+    abi_ulong sc_regs[32];
+    abi_uint  sc_flags;
+    abi_ulong sc_extcontext[0]   QEMU_ALIGNED(16);
 };
 
 QEMU_BUILD_BUG_ON(sizeof(struct target_sigcontext) != sizeof_sigcontext);
@@ -33,9 +33,9 @@ QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_regs)
 #define FPU_CTX_MAGIC           0x46505501
 #define FPU_CTX_ALIGN           8
 struct target_fpu_context {
-    uint64_t regs[32];
-    uint64_t fcc;
-    uint32_t fcsr;
+    abi_ulong regs[32];
+    abi_ulong fcc;
+    abi_uint  fcsr;
 } QEMU_ALIGNED(FPU_CTX_ALIGN);
 
 QEMU_BUILD_BUG_ON(offsetof(struct target_fpu_context, regs)
@@ -43,9 +43,9 @@ QEMU_BUILD_BUG_ON(offsetof(struct target_fpu_context, regs)
 
 #define CONTEXT_INFO_ALIGN      16
 struct target_sctx_info {
-    uint32_t magic;
-    uint32_t size;
-    uint64_t padding;
+    abi_uint  magic;
+    abi_uint  size;
+    abi_ulong padding;
 } QEMU_ALIGNED(CONTEXT_INFO_ALIGN);
 
 QEMU_BUILD_BUG_ON(sizeof(struct target_sctx_info) != sizeof_sctx_info);
@@ -162,7 +162,7 @@ static bool parse_extcontext(struct extctx_layout *extctx, abi_ptr frame)
     memset(extctx, 0, sizeof(*extctx));
 
     while (1) {
-        uint32_t magic, size;
+        abi_uint magic, size;
 
         if (get_user_u32(magic, frame) || get_user_u32(size, frame + 4)) {
             return false;
@@ -206,7 +206,7 @@ static void restore_sigframe(CPULoongArchState *env,
     if (extctx->fpu.haddr) {
         struct target_fpu_context *fpu_ctx =
             extctx->fpu.haddr + sizeof(struct target_sctx_info);
-        uint64_t fcc;
+        abi_ulong fcc;
 
         for (i = 0; i < 32; ++i) {
             __get_user(env->fpr[i].vreg.D(0), &fpu_ctx->regs[i]);
-- 
2.25.1


