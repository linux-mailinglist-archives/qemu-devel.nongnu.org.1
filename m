Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F23BAB2CA
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Sep 2025 05:55:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RQy-0000uR-Vu; Mon, 29 Sep 2025 23:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RQu-0000u5-SV
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RQq-0001pY-Vd
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:44 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxztI+VNtovGsQAA--.34338S3;
 Tue, 30 Sep 2025 11:53:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8E8VNtoak+_AA--.40492S4;
 Tue, 30 Sep 2025 11:53:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 02/13] target/loongarch: Add CSR_PWCH write helper function
Date: Tue, 30 Sep 2025 11:53:21 +0800
Message-Id: <20250930035332.2609520-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250930035332.2609520-1-maobibo@loongson.cn>
References: <20250930035332.2609520-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8E8VNtoak+_AA--.40492S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Bit HPTW_EN in register CSR_PWCH controls enabling hardware page
table walker feature when PTW feature is enabled. Otherwise it is
reserved bit.

Here add register CSR_PWCH write helper function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-csr.h                        |  2 ++
 target/loongarch/tcg/csr_helper.c                 | 15 +++++++++++++++
 target/loongarch/tcg/helper.h                     |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc         |  1 +
 4 files changed, 19 insertions(+)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 9097fddee1..0bcb51d3a3 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -105,6 +105,8 @@ FIELD(CSR_PWCH, DIR3_BASE, 0, 6)
 FIELD(CSR_PWCH, DIR3_WIDTH, 6, 6)
 FIELD(CSR_PWCH, DIR4_BASE, 12, 6)
 FIELD(CSR_PWCH, DIR4_WIDTH, 18, 6)
+FIELD(CSR_PWCH, HPTW_EN, 24, 1)
+FIELD(CSR_PWCH, RESERVE, 25, 7)
 
 #define LOONGARCH_CSR_STLBPS         0x1e /* Stlb page size */
 FIELD(CSR_STLBPS, PS, 0, 5)
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 5ebe15f993..c1a8ba3089 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -163,3 +163,18 @@ target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
     env->CSR_PWCL = val;
     return old_v;
 }
+
+target_ulong helper_csrwr_pwch(CPULoongArchState *env, target_ulong val)
+{
+    uint8_t has_ptw;
+    int64_t old_v = env->CSR_PWCH;
+
+    val = FIELD_DP64(val, CSR_PWCH, RESERVE, 0);
+    has_ptw = FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW);
+    if (!has_ptw) {
+        val = FIELD_DP64(val, CSR_PWCH, HPTW_EN, 0);
+    }
+
+    env->CSR_PWCH = val;
+    return old_v;
+ }
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index db57dbfc16..f1f690b880 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -107,6 +107,7 @@ DEF_HELPER_2(csrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
 DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
 DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
+DEF_HELPER_2(csrwr_pwch, i64, env, tl)
 DEF_HELPER_2(iocsrrd_b, i64, env, tl)
 DEF_HELPER_2(iocsrrd_h, i64, env, tl)
 DEF_HELPER_2(iocsrrd_w, i64, env, tl)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index a407ab51b7..c96390267c 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -79,6 +79,7 @@ void loongarch_csr_translate_init(void)
     SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr_asid);
     SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
     SET_CSR_FUNC(PWCL,  NULL, gen_helper_csrwr_pwcl);
+    SET_CSR_FUNC(PWCH,  NULL, gen_helper_csrwr_pwch);
     SET_CSR_FUNC(CPUID, gen_helper_csrrd_cpuid, NULL);
     SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr_tcfg);
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
-- 
2.39.3


