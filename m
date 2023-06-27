Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B910E740208
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 19:20:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qECLY-0006bb-Po; Tue, 27 Jun 2023 13:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qECLK-0006Qf-0S
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:19:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qECLE-0006ge-Ei
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:19:01 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b6824141b4so460225ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687886338; x=1690478338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwUJQhiAl4EVmU4h1QeBvtoql9shb+1W6JLFKowVkAg=;
 b=ByLkIqczapgo0HOZ8EUCnZ3vSA72cc+6E8yGay885PHoj338H3RK20kubewaVouiZm
 SjQe8P+2Pw2P6E0TQIS3ygk4qpL3i6VsZ7OM4eyIMvFwssQZqJe+KELGCj/ghnRC6+Yd
 GFqiBcYg/jIByseIXRnQw5I0UCVH3Rv3CglgB3ifcXO/tSlcaPPpcEyHrAz6mAlqP1ki
 ceXO7EYdTZNpHTl69uAF4r3Bqa4nW1d0nq0gzEZ4H4MNoQeH6ifFgFdMrUfRaY8fD7Cr
 crFF36JrMlFi1BbJhvGl2RHW4XKmN6wQM7Z2mVhVWkb1GcFG01YwmnaTJTeGPVG2/k6S
 oK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687886338; x=1690478338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwUJQhiAl4EVmU4h1QeBvtoql9shb+1W6JLFKowVkAg=;
 b=Xu7sUp9UqLywc135g0AYrV26s6bR9o9e/G2qzWVa/bn+pgNpGHivXFT2RFvrCawUrf
 5zJ6Yk3UOLTT6QMMKjoSG5zZvZBzZ3EXu9m3w6v9jPHsawrsqIOp21A97APEL/xRKVkA
 UNBi2pj6/v0iLlJ9Yqpz18bg4vznlJjl/7UoqjawNA9INX1TFyH0RiRAWvDaEGEnIRP3
 /04tGHgZzmvQ1EvfN3fwZ4PNQ/nu1NWedFrd7+bWSQpm9m792UyXgKmpL7pxeqByp9Ly
 jaAeUTwv55zVMO50so+274yog7xzVi33QMIysC1ex0l3tfaqA6hzpHjzY/EKw9Ovf7H8
 xNwg==
X-Gm-Message-State: AC+VfDyTrMSVAwuBq5C9inE1V02Mdsd74vsq0yHj8IsR3l92ReMw4J+r
 /73Dkd7ynL36wUFF8T1KechDd2U1DbmMsmrYwgtzUvDguRz8268BCOpIrqZkgeNqT230710hejb
 h/16p88iFWya9me5+bOO2OUZZygCUABVucb2OhJ8iWAuKllsBlrciixkxXGkJhW9gBgn0gfFLCe
 uEY2w=
X-Google-Smtp-Source: ACHHUZ64DaH9wIzT7/J2pKHopo+N070Re557jcr13hlaQ9tEm7Acm7aKkkIUGl0JTjH8giZsIiq6bw==
X-Received: by 2002:a17:903:22c8:b0:1b6:99a1:177d with SMTP id
 y8-20020a17090322c800b001b699a1177dmr12979064plg.31.1687886338176; 
 Tue, 27 Jun 2023 10:18:58 -0700 (PDT)
Received: from MaxdeMBP.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 jb13-20020a170903258d00b001b8052d58a0sm3796145plb.305.2023.06.27.10.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 10:18:57 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com,
 Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v5 02/15] target/riscv: Refactor vector-vector translation
 macro
Date: Wed, 28 Jun 2023 01:17:33 +0800
Message-Id: <20230627171759.64653-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230627171759.64653-1-max.chou@sifive.com>
References: <20230627171759.64653-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>

Refactor the non SEW-specific stuff out of `GEN_OPIVV_TRANS` into
function `opivv_trans` (similar to `opivi_trans`). `opivv_trans` will be
used in proceeding vector-crypto commits.

Signed-off-by: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 62 +++++++++++++------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index c2f7527f53..4a8e62a8be 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1643,38 +1643,40 @@ GEN_OPIWX_WIDEN_TRANS(vwadd_wx)
 GEN_OPIWX_WIDEN_TRANS(vwsubu_wx)
 GEN_OPIWX_WIDEN_TRANS(vwsub_wx)
 
+static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
+                        gen_helper_gvec_4_ptr *fn, DisasContext *s)
+{
+    uint32_t data = 0;
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+
+    data = FIELD_DP32(data, VDATA, VM, vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
+    tcg_gen_gvec_4_ptr(vreg_ofs(s, vd), vreg_ofs(s, 0), vreg_ofs(s, vs1),
+                       vreg_ofs(s, vs2), cpu_env, s->cfg_ptr->vlen / 8,
+                       s->cfg_ptr->vlen / 8, data, fn);
+    mark_vs_dirty(s);
+    gen_set_label(over);
+    return true;
+}
+
 /* Vector Integer Add-with-Carry / Subtract-with-Borrow Instructions */
 /* OPIVV without GVEC IR */
-#define GEN_OPIVV_TRANS(NAME, CHECK)                               \
-static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
-{                                                                  \
-    if (CHECK(s, a)) {                                             \
-        uint32_t data = 0;                                         \
-        static gen_helper_gvec_4_ptr * const fns[4] = {            \
-            gen_helper_##NAME##_b, gen_helper_##NAME##_h,          \
-            gen_helper_##NAME##_w, gen_helper_##NAME##_d,          \
-        };                                                         \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
-                                                                   \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
-        data =                                                     \
-            FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);\
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
-        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
-                           vreg_ofs(s, a->rs1),                    \
-                           vreg_ofs(s, a->rs2), cpu_env,           \
-                           s->cfg_ptr->vlen / 8,                   \
-                           s->cfg_ptr->vlen / 8, data,             \
-                           fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
-        return true;                                               \
-    }                                                              \
-    return false;                                                  \
+#define GEN_OPIVV_TRANS(NAME, CHECK)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (CHECK(s, a)) {                                                   \
+        static gen_helper_gvec_4_ptr * const fns[4] = {                  \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                \
+        };                                                               \
+        return opivv_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s);\
+    }                                                                    \
+    return false;                                                        \
 }
 
 /*
-- 
2.31.1


