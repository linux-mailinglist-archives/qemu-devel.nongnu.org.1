Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32339744E7E
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzPP-0001ws-TT; Sun, 02 Jul 2023 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qFzPJ-0001mc-KH
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:54:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qFzPH-0008KU-Om
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:54:37 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-668730696a4so1831011b3a.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1688313273; x=1690905273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JS/seDe4VjLU1pf2ZqVM02yLlfQw6sh7/U5/yP+fcQc=;
 b=gESGFeGeBgjY4XFLMCYB4g+bBnuVgHQxf5kSytusX1P5IxNyH4I1HW/aoqTvLu1Hxa
 ZbDzLxhqZfTcQdXMk1WXENv+3Ko2AUURBpcLhQ+O7YzuT7D9ZajigCMBdREeSMHo6KHt
 npxibHGAcGebPPwYeziN2cQX/DvUSqbiMpG1rSwyV+k4WmaH72/UXwMG4OKXxxndER1Z
 I+7utS5j5wa4XJwlD/9hfRJPLR4dgxqqo0uX1lr+0bNyRHbsrqH5pJBd0JDk3qScGVDJ
 3mw1+RSlzf2hQPKvwhdEIz8R4aGG7+9+sJYdbpN45QnAonKfZXQ7KFg7qbvSLNQkVQvw
 FX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688313273; x=1690905273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JS/seDe4VjLU1pf2ZqVM02yLlfQw6sh7/U5/yP+fcQc=;
 b=VcwRAF0JLZ0HaYNbkbYNaeFXZjhA4GIlvjjd9Iaao7scv2O2dkOKBHfQM7KlGDmKE5
 nAlMVxn3xQbkt20E1mA190Zw8tH1bfVVrDOCN3WFweVRRc/1EeN3g7v58mapXV41Y6gi
 ichZKNjqxKQveG4WDHKCbFlqtRIbWbcDDMnz2bwan8hoNInJDBSBUlqwxJ8t3CbH+nHg
 bhlbxoDjqknehc9cVfg0a7r40NPaGR4Ko9fTlt8UeYL9M7DTLUdVl1VOjQ32CYYLLk1J
 3a9mNleiL/aLoPgW+ftbLumNSTMSphmecdWifl3Tka60kb3hT5ztTmnKE/gNcodQnnmL
 iLAQ==
X-Gm-Message-State: ABy/qLZ+fW8C5gCjzhp0oCh2Zjg24ohPEFKOUkDrfX1NMmkNzdI3tfDx
 mYpEGdyOlO3PCEr0CLyv4wMW04PKGpLa93JZsoYLgxarcSVmuzEYIFoEyiaIF4wCL/6as6e3cbk
 nuDwPY38ByZQ+8UzTeouRicyjG4QFlNFwNTQp6mWsoXcRsD4CRzarqcDWjrQerCmS1xvTVN5krJ
 V14LY=
X-Google-Smtp-Source: APBJJlGss/F6tM31yCItW2+SB4BTCToZ7wOUPwwMV3pvW9gY0ZGzzP7bgo0EdwDxbwnRsY6He1L6Zg==
X-Received: by 2002:a05:6a00:2da0:b0:668:8596:752f with SMTP id
 fb32-20020a056a002da000b006688596752fmr9059991pfb.4.1688313273511; 
 Sun, 02 Jul 2023 08:54:33 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 y19-20020aa78553000000b0066f37665a63sm8231969pfn.73.2023.07.02.08.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 08:54:33 -0700 (PDT)
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
Subject: [PATCH v7 02/15] target/riscv: Refactor vector-vector translation
 macro
Date: Sun,  2 Jul 2023 23:53:36 +0800
Message-Id: <20230702155354.2478495-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702155354.2478495-1-max.chou@sifive.com>
References: <20230702155354.2478495-1-max.chou@sifive.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.34.1


