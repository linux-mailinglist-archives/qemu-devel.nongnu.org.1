Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0EC7DDB56
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 04:09:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy1as-0003wv-Mw; Tue, 31 Oct 2023 23:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qy1aq-0003vj-0n
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:08:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qy1al-0005qa-Ul
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:08:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxZ+gmwUFlyCM2AA--.4735S3;
 Wed, 01 Nov 2023 11:08:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdwdwUFltsk3AA--.55379S3; 
 Wed, 01 Nov 2023 11:08:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, laurent@vivier.eu,
 maobibo@loongson.cn
Subject: [PATCH v2 1/6] linux-user/loongarch64: Use traps to track LSX/LASX
 usage
Date: Wed,  1 Nov 2023 11:08:11 +0800
Message-Id: <20231101030816.2353416-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231101030816.2353416-1-gaosong@loongson.cn>
References: <20231101030816.2353416-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdwdwUFltsk3AA--.55379S3
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/cpu_loop.c           | 13 +++++++++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 894fdd111a..73d7b6796a 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -72,6 +72,19 @@ void cpu_loop(CPULoongArchState *env)
         case EXCCODE_BCE:
             force_sig_fault(TARGET_SIGSYS, TARGET_SI_KERNEL, env->pc);
             break;
+
+        /*
+         * Begin with LSX and LASX disabled, then enable on the first trap.
+         * In this way we can tell if the unit is in use.  This is used to
+         * choose the layout of any signal frame.
+         */
+        case EXCCODE_SXD:
+            env->CSR_EUEN |= R_CSR_EUEN_SXE_MASK;
+            break;
+        case EXCCODE_ASXD:
+            env->CSR_EUEN |= R_CSR_EUEN_ASXE_MASK;
+            break;
+
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
             break;
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 98f856bb29..92b1d22e28 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -4,8 +4,6 @@
  * Copyright (c) 2022-2023 Loongson Technology Corporation Limited
  */
 
-#ifndef CONFIG_USER_ONLY
-
 static bool check_vec(DisasContext *ctx, uint32_t oprsz)
 {
     if ((oprsz == 16) && ((ctx->base.tb->flags & HW_FLAGS_EUEN_SXE) == 0)) {
@@ -21,15 +19,6 @@ static bool check_vec(DisasContext *ctx, uint32_t oprsz)
     return true;
 }
 
-#else
-
-static bool check_vec(DisasContext *ctx, uint32_t oprsz)
-{
-    return true;
-}
-
-#endif
-
 static bool gen_vvvv_ptr_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.25.1


