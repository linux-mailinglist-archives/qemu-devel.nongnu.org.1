Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9152D82F93B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:03:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqWO-0004et-Kl; Tue, 16 Jan 2024 15:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqWF-0004dM-FK
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:48 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqWD-0007cB-ME
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:46 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso7308082a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 12:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705438723; x=1706043523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmcjSOd+ND7T4M2CJjG1m3nBwtyCINj3/RaPEFtwNPs=;
 b=jpeDGxHRx3kVdUDPNdKF7AU7GOxrTw196xMm2PMuk5PipQ3R+sn5jWCZzAFTCQQi/V
 bArbeyOUh8lbJ1xsiVYPYIrLqf02OBbL3Cu39EXwRQrDRQprmJpjJfbp7YBNm9NEAp6Q
 QAKN12Welb0kvf7YczCwi/qDmZ242TnJkRv9OyOg6huIwWBjqrJbwrd2o4WHI4Pkr3qb
 sOFDVGq1jUZRLgXeNTNEiypy9Vcn+DJLa5pcLANYfqt/pPnlGuD70xyM397AXVL2eLkM
 KVrXNXC0N6HWaAE13MAfZDbAK81A6fbT5239kFa/ObwIN8Osb0OftjlYuXJmVOKnhyKW
 G8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705438723; x=1706043523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmcjSOd+ND7T4M2CJjG1m3nBwtyCINj3/RaPEFtwNPs=;
 b=azmhLEkCFz3rH4FFcZLURbskX74UUMZWSV3sxk4Eh9zRwrUGwhhdGFSLT0BSmBW5jV
 aJU8bz66PuC7kEWPtkOW6CnFL2QwDLyudM573oMvQ5FmlVVWGgd7ZIBiB+9tg+/zFUzb
 WUyecb4LOZ6tpeJBePKQVO8AWa5F/pFm/z2PwIshiX+MJzebTn2EMbEcjHirxyypnncm
 GHCu+0QxhSvOL6ipaKZFbYSyGhh/Vnug4y4pGEmkds0sYAtR8RnJWqeUlth7kLBdxgxb
 dFmQOZbENvt42YpKuvbpKTs0Wjk1eHqTe1VyIfww8lpUIEpX7qZOJinwLgdxaBXnrAK4
 ozXA==
X-Gm-Message-State: AOJu0YyIo/JhLWJ0om1LlX82W188975BbtJ3y/GDTMacaOUnDcyGjMQO
 +g40yWcjiRkQhTne6Ao10tt9Y/8uCvZoF84Z3jje0Vejk8SfYg==
X-Google-Smtp-Source: AGHT+IEUqzjP2BwjH6rSxEkkLjUGcDFp+1uIFeQ9tUGsbmWFPCcOgqg6Obs1kduqjOgavxwfXi8/tQ==
X-Received: by 2002:a17:90a:9a2:b0:28c:fdcd:ba47 with SMTP id
 31-20020a17090a09a200b0028cfdcdba47mr5297801pjo.25.1705438723584; 
 Tue, 16 Jan 2024 12:58:43 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 sh2-20020a17090b524200b0028df5c748e4sm11326949pjb.44.2024.01.16.12.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 12:58:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 06/13] target/riscv/insn_trans/trans_rvvk.c.inc: use 'vlenb'
Date: Tue, 16 Jan 2024 17:58:10 -0300
Message-ID: <20240116205817.344178-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116205817.344178-1-dbarboza@ventanamicro.com>
References: <20240116205817.344178-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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


