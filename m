Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DCB74027D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 19:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEClZ-0001J7-64; Tue, 27 Jun 2023 13:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qEClW-0001Ho-RI
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:46:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qEClU-0004q2-Vp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:46:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-666e5f0d60bso2551163b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687887967; x=1690479967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwUJQhiAl4EVmU4h1QeBvtoql9shb+1W6JLFKowVkAg=;
 b=j/vmBMwg1fgzbYPnuTyDc+gA8tVsdMvd+aj55eI3/m9RY6rOs65Dtou3ynCPlMmvJY
 7mQSrwa4i0MIa/5fG7fer8UBWxH1bHLAT3KS6Z2FH7BKNIVOpcvH6LXOR+2y3UG71aWW
 lV6srUYEakn8GbPEISPI/WYojDTKavJYhYkCE0u9dhR1cq61inNfPDZV+Yrh627dsSP6
 LzI+yNSGJCvL3S7HqgxVeImWgPHEXNeRB2xubRD06cNQG/+f49WiF/5Wr+mygo+nXWG1
 y18HtaNikCt1WxWufA0ogac13vARdCZGupXup/oMhWnCpoCQDoiiQ0yAmTK72CC6BukL
 MUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687887967; x=1690479967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwUJQhiAl4EVmU4h1QeBvtoql9shb+1W6JLFKowVkAg=;
 b=gzk8r3Wiori57PZFCvps4w8hbfbe2QUQllMz9JjJbadVxu4omblXZncKZTsO3ralsV
 GzIczAPfcNfBLiuH5SaM9ljOanWWBI+ncDsM6R2IfyuFT8J/xhrLVRGUeSgzs/G0v5TK
 ZVEK4wFUrORMOVhLiSMP7VhfowHKAa4yvxDNvhWwzt4txiK3E5/UYs1H9E7UCtErsYJo
 es9Ti9x7iJ2GVOysNCkWcj9ffqTSmY9DqQktLapj9URdJoVMUOEg+loe2rWfUU64T3Ks
 Ri1EOss4wCTTWd2a//vlLVlixHf3uBM9JuRhM7lJB3GprmQcJoWJ796xiGuepMkmaVtt
 XKuA==
X-Gm-Message-State: AC+VfDzyAraycEVMR8mqdd5DYLSJ21jovPSK8u9mB29pcO5zIMvBoh9E
 Xh7/gyoduyy/6U1X93xdq96LIMlYogNSM4YCkAwirivVDy8Li1DlkThFjklfgHCGbL7yuq2FGBl
 9sDbUf/Ei96rUzXhDZAMXTj/JSuho0yxxcG1LyG3tQoiAuSYkaBq7JQgd4ZIim+xxGnbWjDOMMN
 pouNo=
X-Google-Smtp-Source: ACHHUZ7bZHKeDMEt9FpOrRhux0oVg9s2oQQ+eux5KdayJxK7p7iXtfmK1M9DUXYPGWV8t3w2eCjjfw==
X-Received: by 2002:a05:6a20:7d89:b0:122:b651:f8c0 with SMTP id
 v9-20020a056a207d8900b00122b651f8c0mr18651870pzj.28.1687887967124; 
 Tue, 27 Jun 2023 10:46:07 -0700 (PDT)
Received: from MaxdeMBP.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 i9-20020aa78b49000000b00666e883757fsm5705144pfd.123.2023.06.27.10.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 10:46:06 -0700 (PDT)
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
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
Subject: [PATCH v6 02/15] target/riscv: Refactor vector-vector translation
 macro
Date: Wed, 28 Jun 2023 01:45:36 +0800
Message-Id: <20230627174551.65498-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230627174551.65498-1-max.chou@sifive.com>
References: <20230627174551.65498-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x429.google.com
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


