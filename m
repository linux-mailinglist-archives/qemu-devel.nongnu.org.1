Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5D7D3AD9
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwtl-000129-2l; Mon, 23 Oct 2023 11:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwtg-00010b-G2
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:17 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwte-0002L7-MR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:16 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 510DD444F9;
 Mon, 23 Oct 2023 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698075067; bh=bnn7zqD5xGtABDWrLrmY4nLF1W2Fnk+JBLj3Bsc+7SA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ivblpb43SuK4JBUntO1H8x7PZVXtGw941SlzSFGh1xcVghSGnXXkQGhCrzoxnXMv7
 SDbAp9SFGNhQ/deWxXRij6sN3fgLWaGvrikanqEUCc9a8xW7Voaf1Kovys4Ee4nTqb
 JG3SySx5/mXlB3/bTGVLaOKsW7SEJhd0MKDmveO4=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH 2/5] target/loongarch: Add am{swap/add}[_db].{b/h}
Date: Mon, 23 Oct 2023 23:29:19 +0800
Message-ID: <20231023153029.269211-4-c@jia.je>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023153029.269211-2-c@jia.je>
References: <20231023153029.269211-2-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The new instructions are introduced in LoongArch v1.1:

- amswap.b
- amswap.h
- amadd.b
- amadd.h
- amswap_db.b
- amswap_db.h
- amadd_db.b
- amadd_db.h

The instructions are gated by CPUCFG2.LAM_BH.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h                         |  1 +
 target/loongarch/disas.c                       |  8 ++++++++
 target/loongarch/insn_trans/trans_atomic.c.inc |  8 ++++++++
 target/loongarch/insns.decode                  |  8 ++++++++
 target/loongarch/translate.h                   | 17 +++++++++--------
 5 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8b54cf109c..7166c07756 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -155,6 +155,7 @@ FIELD(CPUCFG2, LBT_ARM, 19, 1)
 FIELD(CPUCFG2, LBT_MIPS, 20, 1)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
+FIELD(CPUCFG2, LAM_BH, 27, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 2040f3e44d..d33aa8173a 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -575,6 +575,14 @@ INSN(fldx_s,       frr)
 INSN(fldx_d,       frr)
 INSN(fstx_s,       frr)
 INSN(fstx_d,       frr)
+INSN(amswap_b,     rrr)
+INSN(amswap_h,     rrr)
+INSN(amadd_b,      rrr)
+INSN(amadd_h,      rrr)
+INSN(amswap_db_b,  rrr)
+INSN(amswap_db_h,  rrr)
+INSN(amadd_db_b,   rrr)
+INSN(amadd_db_h,   rrr)
 INSN(amswap_w,     rrr)
 INSN(amswap_d,     rrr)
 INSN(amadd_w,      rrr)
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index 80c2e286fd..cd28e217ad 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -73,6 +73,14 @@ TRANS(ll_w, ALL, gen_ll, MO_TESL)
 TRANS(sc_w, ALL, gen_sc, MO_TESL)
 TRANS(ll_d, 64, gen_ll, MO_TEUQ)
 TRANS(sc_d, 64, gen_sc, MO_TEUQ)
+TRANS(amswap_b, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_TESB)
+TRANS(amswap_h, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_TESW)
+TRANS(amadd_b, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESB)
+TRANS(amadd_h, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESW)
+TRANS(amswap_db_b, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_TESB)
+TRANS(amswap_db_h, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_TESW)
+TRANS(amadd_db_b, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESB)
+TRANS(amadd_db_h, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESW)
 TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
 TRANS(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
 TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 62f58cc541..678ce42038 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -261,6 +261,14 @@ ll_w            0010 0000 .............. ..... .....     @rr_i14s2
 sc_w            0010 0001 .............. ..... .....     @rr_i14s2
 ll_d            0010 0010 .............. ..... .....     @rr_i14s2
 sc_d            0010 0011 .............. ..... .....     @rr_i14s2
+amswap_b        0011 10000101 11000 ..... ..... .....    @rrr
+amswap_h        0011 10000101 11001 ..... ..... .....    @rrr
+amadd_b         0011 10000101 11010 ..... ..... .....    @rrr
+amadd_h         0011 10000101 11011 ..... ..... .....    @rrr
+amswap_db_b     0011 10000101 11100 ..... ..... .....    @rrr
+amswap_db_h     0011 10000101 11101 ..... ..... .....    @rrr
+amadd_db_b      0011 10000101 11110 ..... ..... .....    @rrr
+amadd_db_h      0011 10000101 11111 ..... ..... .....    @rrr
 amswap_w        0011 10000110 00000 ..... ..... .....    @rrr
 amswap_d        0011 10000110 00001 ..... ..... .....    @rrr
 amadd_w         0011 10000110 00010 ..... ..... .....    @rrr
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 195f53573a..0b230530e7 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -17,14 +17,15 @@
 #define avail_ALL(C)   true
 #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == \
                         CPUCFG1_ARCH_LA64)
-#define avail_FP(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
-#define avail_FP_SP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
-#define avail_FP_DP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
-#define avail_LSPW(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
-#define avail_LAM(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
-#define avail_LSX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
-#define avail_LASX(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
-#define avail_IOCSR(C) (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
+#define avail_FP(C)     (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
+#define avail_FP_SP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
+#define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
+#define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
+#define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
+#define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
+#define avail_LSX(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
+#define avail_LASX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
+#define avail_IOCSR(C)  (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
-- 
2.42.0


