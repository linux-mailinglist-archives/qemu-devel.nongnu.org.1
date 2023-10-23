Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD627D3ADB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:32:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwtk-00011j-Hw; Mon, 23 Oct 2023 11:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwtd-00010E-8l
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:14 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwtb-0002LD-0E
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:13 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 8853044501;
 Mon, 23 Oct 2023 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698075069; bh=KEVLyqXFsTJd9zK7S6cSpQTaoyE0gNxT7i8Lr/a8r5A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vDxgk74fdTJ8hLmfma7B0RgSZ5NzlK75gAy3UN1GBd6BI6FMkPL4AW0/fLk8HAOv6
 qpM75NQ2QTB1vvZm6iHymYbOks2Z1imSuF8BM9uANML+OMm9s7NHoXTPYTxYjVJ9Ez
 3EqKIgBSTm7zzU4kkdDoLqjb8uZGX+siXwRc/NHQ=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH 3/5] target/loongarch: Add amcas[_db].{b/h/w/d}
Date: Mon, 23 Oct 2023 23:29:20 +0800
Message-ID: <20231023153029.269211-5-c@jia.je>
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

- amcas.b
- amcas.h
- amcas.w
- amcas.d
- amcas_db.b
- amcas_db.h
- amcas_db.w
- amcas_db.d

The new instructions are gated by CPUCFG2.LAMCAS.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h                        |  1 +
 target/loongarch/disas.c                      |  8 +++++++
 .../loongarch/insn_trans/trans_atomic.c.inc   | 24 +++++++++++++++++++
 target/loongarch/insns.decode                 |  8 +++++++
 target/loongarch/translate.h                  |  1 +
 5 files changed, 42 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 7166c07756..80a476c3f8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -156,6 +156,7 @@ FIELD(CPUCFG2, LBT_MIPS, 20, 1)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
 FIELD(CPUCFG2, LAM_BH, 27, 1)
+FIELD(CPUCFG2, LAMCAS, 28, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d33aa8173a..4aa67749cf 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -575,6 +575,14 @@ INSN(fldx_s,       frr)
 INSN(fldx_d,       frr)
 INSN(fstx_s,       frr)
 INSN(fstx_d,       frr)
+INSN(amcas_b,      rrr)
+INSN(amcas_h,      rrr)
+INSN(amcas_w,      rrr)
+INSN(amcas_d,      rrr)
+INSN(amcas_db_b,   rrr)
+INSN(amcas_db_h,   rrr)
+INSN(amcas_db_w,   rrr)
+INSN(amcas_db_d,   rrr)
 INSN(amswap_b,     rrr)
 INSN(amswap_h,     rrr)
 INSN(amadd_b,      rrr)
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index cd28e217ad..bea567fdaf 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -45,6 +45,22 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     return true;
 }
 
+static bool gen_cas(DisasContext *ctx, arg_rrr *a,
+                    void (*func)(TCGv, TCGv, TCGv, TCGv, TCGArg, MemOp),
+                    MemOp mop)
+{
+    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
+    TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv val = gpr_src(ctx, a->rk, EXT_NONE);
+
+    addr = make_address_i(ctx, addr, 0);
+
+    func(dest, addr, dest, val, ctx->mem_idx, mop);
+    gen_set_gpr(a->rd, dest, EXT_NONE);
+
+    return true;
+}
+
 static bool gen_am(DisasContext *ctx, arg_rrr *a,
                    void (*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
                    MemOp mop)
@@ -73,6 +89,14 @@ TRANS(ll_w, ALL, gen_ll, MO_TESL)
 TRANS(sc_w, ALL, gen_sc, MO_TESL)
 TRANS(ll_d, 64, gen_ll, MO_TEUQ)
 TRANS(sc_d, 64, gen_sc, MO_TEUQ)
+TRANS(amcas_b, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESB)
+TRANS(amcas_h, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESW)
+TRANS(amcas_w, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESL)
+TRANS(amcas_d, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TEUQ)
+TRANS(amcas_db_b, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESB)
+TRANS(amcas_db_h, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESW)
+TRANS(amcas_db_w, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TESL)
+TRANS(amcas_db_d, LAMCAS, gen_cas, tcg_gen_atomic_cmpxchg_tl, MO_TEUQ)
 TRANS(amswap_b, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_TESB)
 TRANS(amswap_h, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_TESW)
 TRANS(amadd_b, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESB)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 678ce42038..cf4123cd46 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -261,6 +261,14 @@ ll_w            0010 0000 .............. ..... .....     @rr_i14s2
 sc_w            0010 0001 .............. ..... .....     @rr_i14s2
 ll_d            0010 0010 .............. ..... .....     @rr_i14s2
 sc_d            0010 0011 .............. ..... .....     @rr_i14s2
+amcas_b         0011 10000101 10000 ..... ..... .....    @rrr
+amcas_h         0011 10000101 10001 ..... ..... .....    @rrr
+amcas_w         0011 10000101 10010 ..... ..... .....    @rrr
+amcas_d         0011 10000101 10011 ..... ..... .....    @rrr
+amcas_db_b      0011 10000101 10100 ..... ..... .....    @rrr
+amcas_db_h      0011 10000101 10101 ..... ..... .....    @rrr
+amcas_db_w      0011 10000101 10110 ..... ..... .....    @rrr
+amcas_db_d      0011 10000101 10111 ..... ..... .....    @rrr
 amswap_b        0011 10000101 11000 ..... ..... .....    @rrr
 amswap_h        0011 10000101 11001 ..... ..... .....    @rrr
 amadd_b         0011 10000101 11010 ..... ..... .....    @rrr
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 0b230530e7..3affefdafc 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -23,6 +23,7 @@
 #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
 #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
+#define avail_LAMCAS(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAMCAS))
 #define avail_LSX(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
 #define avail_LASX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
 #define avail_IOCSR(C)  (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
-- 
2.42.0


