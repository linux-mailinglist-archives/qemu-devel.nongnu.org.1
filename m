Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC382C6D6
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:40:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPEw-0004AO-BJ; Fri, 12 Jan 2024 16:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPEk-00040S-3R
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:47 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPEg-0001gM-15
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:45 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d9b5c4f332so4319297b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705095518; x=1705700318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udL8itZxAYolT0n7RG5zjbv51JaVnR8dYZboAfLTPv0=;
 b=Y+3+5k2LGiScdo+4AXVkOGw2NqkcbPjr1F1QoUBswg1ZT7pMQ/of+EaPhP8VZ0kk/5
 HWxs9tKNlvOBVi7QiwI3vq+d587maada7d2/H762jJYPQMwOCROZA8uSBq50OHHvAYP9
 yT191ojod/vAYk/Jz8aYgTg9lyB8GS5UOpouACA8KhC7rVpB3CjXlAI9eHUVWjSrk8EY
 3cbddIe1ZqbXbr9d7l3ffq03WDiZ62HAbBx0dC6f3CjHRDt7V+qoiHve+Ldv3TIGXOjI
 1QRXpx8nJyuRNZnY6Xa+M5fazzLZKR4yHryqfTrw2AwNBQcA0Zo+sn4ctCIx7KfSfM/P
 nTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095518; x=1705700318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udL8itZxAYolT0n7RG5zjbv51JaVnR8dYZboAfLTPv0=;
 b=a2ThBAMRG8am2WQ03wmCYixOWGqTbcjB20PaWwyaMVtlgdv40+ZeUNeGNo+Hv68ckh
 p9RZi7yQewdtSQy6VavdtY8cRQnYeYJe+8M3wgUQcNJP5FFEqNGBH5ZChHI3da8cta/v
 NRnXS/kb+y1Vj56SFnAWJL7stoHgh1IZ9ltPiihfNWL7CKeW10tFosJUH/fCaXEoref7
 ZawoAZDyoMATeHCS0rOMsEg8qi1oZ3Nevoadi1XduEkXdwgyeekwZs3odZ79shETqgou
 5o/WWTdkdx/5Us7t+dlBWjSVTpS/S64DNQIQUVMVUzdJq0Ub0itWto9nNm6kv7/m3zwt
 sKYg==
X-Gm-Message-State: AOJu0YzKjFXdPFyjNJ2WaC4lQiK6/pz7BddUQGuz/brEVHi8WU62nxC0
 bOroFtQcjQgw/NswiuVripDwXr02ORwGuPkr+2AP+1ewpkgvrg==
X-Google-Smtp-Source: AGHT+IHnokSBjbJbQGhIi25x/K71lMKzigpFQwiFjIjPUXCMmbTp9sneiZQEF64Vv4tZhRMGc6nU7A==
X-Received: by 2002:a05:6a20:12c5:b0:199:b889:31f6 with SMTP id
 v5-20020a056a2012c500b00199b88931f6mr1599731pzg.57.1705095518096; 
 Fri, 12 Jan 2024 13:38:38 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 lf8-20020a170902fb4800b001d5b2967d00sm364727plb.290.2024.01.12.13.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:38:37 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 06/13] target/riscv/insn_trans/trans_rvvk.c.inc: use 'vlenb'
Date: Fri, 12 Jan 2024 18:38:05 -0300
Message-ID: <20240112213812.173521-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112213812.173521-1-dbarboza@ventanamicro.com>
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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


