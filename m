Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 097A17D3ADA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:32:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwtk-000127-Vs; Mon, 23 Oct 2023 11:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwtg-00010c-Lv
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:17 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwte-0002MP-Me
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:16 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id EF95744509;
 Mon, 23 Oct 2023 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698075073; bh=vlp6SJnA0DL0ZXy1SulphydR9VEoX2PpOhUtE+dlL/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GeLAMk25wl27RrRNzSaKJT1ycBKQCu0zxwxS04qVpXOcFV9cAWs3oLJHSCjCBr5Qm
 RM5CbwUYQWdZ07tab7IDo/qzVrNGEFyLqLR+mVyJQ6D1yg9w4NOiOn8yL4Y+b+QeAZ
 7IBMM6EerPMDT8mLm5DbaXM0A1YQl9mWRXa0zt4o=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH 5/5] target/loongarch: Add llacq/screl instructions
Date: Mon, 23 Oct 2023 23:29:22 +0800
Message-ID: <20231023153029.269211-7-c@jia.je>
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

Add the following instructions in LoongArch v1.1:

- llacq.w
- screl.w
- llacq.d
- screl.d

They are guarded by CPUCFG2.LLACQ_SCREL.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h                        |  1 +
 target/loongarch/disas.c                      |  4 ++++
 .../loongarch/insn_trans/trans_atomic.c.inc   | 20 +++++++++++++++++++
 target/loongarch/insns.decode                 |  4 ++++
 target/loongarch/translate.h                  |  3 +++
 5 files changed, 32 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8f938effa8..f0a63d5484 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -158,6 +158,7 @@ FIELD(CPUCFG2, LAM, 22, 1)
 FIELD(CPUCFG2, FRECIPE, 25, 1)
 FIELD(CPUCFG2, LAM_BH, 27, 1)
 FIELD(CPUCFG2, LAMCAS, 28, 1)
+FIELD(CPUCFG2, LLACQ_SCREL, 29, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 9eb49fb5e3..8e02f51ddc 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -579,6 +579,10 @@ INSN(fldx_s,       frr)
 INSN(fldx_d,       frr)
 INSN(fstx_s,       frr)
 INSN(fstx_d,       frr)
+INSN(llacq_w,      rr)
+INSN(screl_w,      rr)
+INSN(llacq_d,      rr)
+INSN(screl_d,      rr)
 INSN(amcas_b,      rrr)
 INSN(amcas_h,      rrr)
 INSN(amcas_w,      rrr)
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index bea567fdaf..0c81fbd745 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -17,6 +17,14 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     return true;
 }
 
+static bool gen_llacq(DisasContext *ctx, arg_rr *a, MemOp mop)
+{
+    arg_rr_i tmp_a = {
+        .rd = a->rd, .rj = a->rj, .imm = 0
+    };
+    return gen_ll(ctx, &tmp_a, mop);
+}
+
 static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
@@ -45,6 +53,14 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     return true;
 }
 
+static bool gen_screl(DisasContext *ctx, arg_rr *a, MemOp mop)
+{
+    arg_rr_i tmp_a = {
+        .rd = a->rd, .rj = a->rj, .imm = 0
+    };
+    return gen_sc(ctx, &tmp_a, mop);
+}
+
 static bool gen_cas(DisasContext *ctx, arg_rrr *a,
                     void (*func)(TCGv, TCGv, TCGv, TCGv, TCGArg, MemOp),
                     MemOp mop)
@@ -89,6 +105,10 @@ TRANS(ll_w, ALL, gen_ll, MO_TESL)
 TRANS(sc_w, ALL, gen_sc, MO_TESL)
 TRANS(ll_d, 64, gen_ll, MO_TEUQ)
 TRANS(sc_d, 64, gen_sc, MO_TEUQ)
+TRANS(llacq_w, LLACQ_SCREL, gen_llacq, MO_TESL)
+TRANS(screl_w, LLACQ_SCREL, gen_screl, MO_TESL)
+TRANS(llacq_d, LLACQ_SCREL_64, gen_llacq, MO_TEUQ)
+TRANS(screl_d, LLACQ_SCREL_64, gen_screl, MO_TEUQ)
 TRANS(amcas_b, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESB)
 TRANS(amcas_h, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESW)
 TRANS(amcas_w, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESL)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 92078f0f9f..e056d492d3 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -261,6 +261,10 @@ ll_w            0010 0000 .............. ..... .....     @rr_i14s2
 sc_w            0010 0001 .............. ..... .....     @rr_i14s2
 ll_d            0010 0010 .............. ..... .....     @rr_i14s2
 sc_d            0010 0011 .............. ..... .....     @rr_i14s2
+llacq_w         0011 10000101 01111 00000 ..... .....    @rr
+screl_w         0011 10000101 01111 00001 ..... .....    @rr
+llacq_d         0011 10000101 01111 00010 ..... .....    @rr
+screl_d         0011 10000101 01111 00011 ..... .....    @rr
 amcas_b         0011 10000101 10000 ..... ..... .....    @rrr
 amcas_h         0011 10000101 10001 ..... ..... .....    @rrr
 amcas_w         0011 10000101 10010 ..... ..... .....    @rrr
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 651c5796ca..3d13d40ca6 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -34,6 +34,9 @@
 #define avail_FRECIPE_LSX(C)   (avail_FRECIPE(C) && avail_LSX(C))
 #define avail_FRECIPE_LASX(C)   (avail_FRECIPE(C) && avail_LASX(C))
 
+#define avail_LLACQ_SCREL(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LLACQ_SCREL))
+#define avail_LLACQ_SCREL_64(C) (avail_64(C) && avail_LLACQ_SCREL(C))
+
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
-- 
2.42.0


