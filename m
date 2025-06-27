Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 641CDAEAD4B
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Jun 2025 05:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUzhf-0005GL-RJ; Thu, 26 Jun 2025 23:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uUzhb-0005Ed-Ox
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:24:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uUzhX-000672-Sd
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:24:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx_eLtDl5ovwgeAQ--.26155S3;
 Fri, 27 Jun 2025 11:24:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XiDl5oz10sAQ--.3598S11;
 Fri, 27 Jun 2025 11:24:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v3 9/9] target/loongarch:Implement csrrd CSR_MSGIR register
Date: Fri, 27 Jun 2025 11:01:38 +0800
Message-Id: <20250627030138.2482055-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250627030138.2482055-1-gaosong@loongson.cn>
References: <20250627030138.2482055-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XiDl5oz10sAQ--.3598S11
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

implement the read-clear feature for CSR_MSGIR register.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/csr.c                        |  5 +++++
 target/loongarch/tcg/csr_helper.c             | 21 +++++++++++++++++++
 target/loongarch/tcg/helper.h                 |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc     |  1 +
 4 files changed, 28 insertions(+)

diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 7ea0a30450..f973780bba 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -97,6 +97,11 @@ static CSRInfo csr_info[] = {
     CSR_OFF(DBG),
     CSR_OFF(DERA),
     CSR_OFF(DSAVE),
+    CSR_OFF_ARRAY(MSGIS, 0),
+    CSR_OFF_ARRAY(MSGIS, 1),
+    CSR_OFF_ARRAY(MSGIS, 2),
+    CSR_OFF_ARRAY(MSGIS, 3),
+    CSR_OFF(MSGIR),
 };
 
 CSRInfo *get_csr(unsigned int csr_num)
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 2942d7feb8..f7cc24166c 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -68,6 +68,27 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
     return cpu_loongarch_get_constant_timer_ticks(cpu);
 }
 
+target_ulong helper_csrrd_msgir(CPULoongArchState *env)
+{
+    int64_t old_v = env->CSR_MSGIR;
+    int irq = FIELD_EX64(env->CSR_MSGIR, CSR_MSGIR, INTNUM);
+
+    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, MSGINT)) {
+        clear_bit(irq, &env->CSR_MSGIS[irq / 64]);
+        env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, INTNUM, 0);
+        for (int i = 256; i >= 0; i--) {
+            if (test_bit(i, &(env->CSR_MSGIS[i / 64]))) {
+                return old_v;
+            }
+        }
+        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
+        env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 0);
+        env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 1);
+    }
+
+    return old_v;
+}
+
 target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
 {
     int64_t old_v = env->CSR_ESTAT;
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 1d5cb0198c..db57dbfc16 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -100,6 +100,7 @@ DEF_HELPER_1(rdtime_d, i64, env)
 DEF_HELPER_1(csrrd_pgd, i64, env)
 DEF_HELPER_1(csrrd_cpuid, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
+DEF_HELPER_1(csrrd_msgir, i64, env)
 DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
 DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index ecbfe23b63..2619b5342b 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -83,6 +83,7 @@ void loongarch_csr_translate_init(void)
     SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr_tcfg);
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
     SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
+    SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
 }
 #undef SET_CSR_FUNC
 
-- 
2.34.1


