Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBED8369DD
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:13:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwth-0006X3-C0; Mon, 22 Jan 2024 11:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwte-0006W0-NK
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:38 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtd-0005KP-3f
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:38 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29026523507so2524700a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705939895; x=1706544695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vtd2ck9WDgqr4jkxn0CvBI9nnqbyC741kYLzWfKv6Fs=;
 b=CRKWh5HEFbiFh4Seo8KgAjXg1GgpXDxXz9GDAbBPXNtgumVRUd0RoJNjFNYuch0TGo
 Kl4Wy5ktjbkNHvVsPmmwsvWb74wdkcTgBaJZjjGFH62Py257yve55EXZVcBb7Ky3bL1W
 JKV4QAH3ESnolCKPpTRjyogTQIi9Ebxm4aGq7nnMPncfgaW7vvjsFaeIJh/WuJwqlO2h
 /pEiwMLfpNPbW3trqRnyg+JsP7c2bTzn/oF1vu9OmE/ZT7lyD425vreXTfV25z7hJT/Q
 nv7DPoo3akuxtSB7TWk0EeJOXV0EP0621ogJXVzxymVEKfLBnrb/fW8e91QEIGfg4bDK
 Z1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939895; x=1706544695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vtd2ck9WDgqr4jkxn0CvBI9nnqbyC741kYLzWfKv6Fs=;
 b=Q38BBpcSmTgg0G0Y8JJ078F8EmvAPF/OIitYZZ8XaE2rqkdC8wfAOyLU9EiDm/iTH+
 ehE8iSj6r7Nhl/xCWDP2p9pTZUjZDzZr8AY515osRZFe3ehVt9IwEjvDwJ16E3ajAJAz
 tCGvFoA8842MEy7GJnpfsN86ZE+5B+YnSStHGfkiygi47+QcdfbBLBkUYjaOFLZPlN2f
 A3lRs975HhTWokplqvoWLrxKBN/jKAeOtWTT+b90OsQjqnFc1ZX2550QgWpSxZAVV03p
 3naOCAoym2e5UZqnpOoX1fPNAkePQdFK4OY4g4OipPdtKJzuWS9al9GRI5frwELZo16D
 TSzA==
X-Gm-Message-State: AOJu0YxScba6OvhQTwxif1GjvLrsI7iDV7Yz9nK36SF1FtWMS2kZpNny
 +WczOZRVLBwtE3g0ODdIopfjpzgCQ+iCSKa28ieadtGlFjXZNn25hh9n5yMHByFPqG7dyRgganC
 B
X-Google-Smtp-Source: AGHT+IGAbBwDvT6LsYmOHi+obeTEERk77HsDmwffj4v2JEPPVX7YDbX4j5hXL4EA531JTfXcISwXrw==
X-Received: by 2002:a17:90a:4dcf:b0:28b:db20:3803 with SMTP id
 r15-20020a17090a4dcf00b0028bdb203803mr1948111pjl.46.1705939895043; 
 Mon, 22 Jan 2024 08:11:35 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 db3-20020a17090ad64300b0028e245501e7sm9866446pjb.4.2024.01.22.08.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:11:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 06/13] target/riscv/insn_trans/trans_rvvk.c.inc: use 'vlenb'
Date: Mon, 22 Jan 2024 13:11:00 -0300
Message-ID: <20240122161107.26737-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122161107.26737-1-dbarboza@ventanamicro.com>
References: <20240122161107.26737-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102d.google.com
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

Use s->cfg_ptr->vlenb instead of s->cfg_ptr->vlen / 8.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvvk.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 3801c16829..a5cdd1b67f 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -174,7 +174,7 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
             data = FIELD_DP32(data, VDATA, VMA, s->vma);                   \
             tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),         \
                                vreg_ofs(s, a->rs2), tcg_env,               \
-                               s->cfg_ptr->vlen / 8, s->cfg_ptr->vlen / 8, \
+                               s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,       \
                                data, fns[s->sew]);                         \
             mark_vs_dirty(s);                                              \
             gen_set_label(over);                                           \
@@ -267,7 +267,7 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             rd_v = tcg_temp_new_ptr();                                        \
             rs2_v = tcg_temp_new_ptr();                                       \
             desc = tcg_constant_i32(                                          \
-                simd_desc(s->cfg_ptr->vlen / 8, s->cfg_ptr->vlen / 8, data)); \
+                simd_desc(s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, data));       \
             tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));              \
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
@@ -345,7 +345,7 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             rs2_v = tcg_temp_new_ptr();                                       \
             uimm_v = tcg_constant_i32(a->rs1);                                \
             desc = tcg_constant_i32(                                          \
-                simd_desc(s->cfg_ptr->vlen / 8, s->cfg_ptr->vlen / 8, data)); \
+                simd_desc(s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, data));       \
             tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));              \
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
@@ -413,7 +413,7 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                                                                               \
             tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),       \
                                vreg_ofs(s, a->rs2), tcg_env,                  \
-                               s->cfg_ptr->vlen / 8, s->cfg_ptr->vlen / 8,    \
+                               s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,          \
                                data, gen_helper_##NAME);                      \
                                                                               \
             mark_vs_dirty(s);                                                 \
@@ -466,8 +466,8 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
         data = FIELD_DP32(data, VDATA, VMA, s->vma);
 
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
-            vreg_ofs(s, a->rs2), tcg_env, s->cfg_ptr->vlen / 8,
-            s->cfg_ptr->vlen / 8, data,
+            vreg_ofs(s, a->rs2), tcg_env, s->cfg_ptr->vlenb,
+            s->cfg_ptr->vlenb, data,
             s->sew == MO_32 ?
                 gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
 
@@ -500,8 +500,8 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
         data = FIELD_DP32(data, VDATA, VMA, s->vma);
 
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
-            vreg_ofs(s, a->rs2), tcg_env, s->cfg_ptr->vlen / 8,
-            s->cfg_ptr->vlen / 8, data,
+            vreg_ofs(s, a->rs2), tcg_env, s->cfg_ptr->vlenb,
+            s->cfg_ptr->vlenb, data,
             s->sew == MO_32 ?
                 gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
 
-- 
2.43.0


