Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0178E4FB
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 05:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbY3c-0005LS-Ld; Wed, 30 Aug 2023 23:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY3S-0005Ky-El
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:09:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY3P-0001Fl-RW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:09:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc63ef9959so2497575ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 20:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693451346; x=1694056146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QM/ygpbDhjXok8n1tNVzNzKRPAlYOM02I0f2FURZ52s=;
 b=Hk6HS+bL6b+oaGgQPt11NH7k496BVxLh5ZXmH0fFBhoRs0U4SOaB83jVd6x23RrnpK
 vbM+Bs5JG34l024RruaqPSitbwCjevLRonp4PMntN37qwYZWaWv71alcqZohefvdKgFe
 oYUmp6M4yVjEM1F3ZqHieHoVFsZX6TfV69n/GiH1lVG4yIGo5RhR2hBcAC7APFvTiTYW
 SN/3M9V6aanLaveP8QjsqppsyInBxmcsgqP/jroXeV3R16Xqn58LO69U1/AhhR1MyBDd
 Fyglj2ji9OTPMF6LfsU0D0yScidm26YppWhTwENK5xaT/CGQqyps8F/GKTXU/lgas9XB
 3YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451346; x=1694056146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QM/ygpbDhjXok8n1tNVzNzKRPAlYOM02I0f2FURZ52s=;
 b=IsEwwyzXZRw3iTXe9kWvuNti1o3y/FIn2Sdwru91n9mjsH6kXxk8GRMRDmDb25Nckm
 67DFnS0GzO457qtFQ7GrM6GO/6bW1sTFPIoa10PsdQr/lECJF2NMay2qz0O8K1VVZS3c
 1J1wOjB8M7U5s7yeCWr16QKdRj+uyhO1bG6lxrTYYRulbpvzzqGc1oU3+DChgbiytAg3
 8ydiUY1bgRACltvAVBCwVRYAybB7Vu/bSkIg5/KCYx21GPN9wvJ12YjTeOj0J8Bq7oVl
 TlB6MMKQSwjVarZD2BFP/5Gxi07imMUZi0xo8b9NCKcH6bOLntNziCPysRP6wYXLUpVJ
 Ynsg==
X-Gm-Message-State: AOJu0YwFYADFd0U48sn6g1mMzGsvsuU2h7mzmKfyV88i0GvOXSm6OyCU
 nzY0GsmRrnaU/xbW4I3lPygzI/ldGWy28HLOVQw=
X-Google-Smtp-Source: AGHT+IH9u/1wt2CjwyZ3ATyiWIQ6eZyanNpn6+xfhlR9tKIvjEvlVIGZzYelfzX8mk0LtCNy43hVNw==
X-Received: by 2002:a17:903:1c4:b0:1bd:d911:2a85 with SMTP id
 e4-20020a17090301c400b001bdd9112a85mr4516604plh.12.1693451346640; 
 Wed, 30 Aug 2023 20:09:06 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 ix21-20020a170902f81500b001bba7aab826sm225123plb.163.2023.08.30.20.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:09:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
Subject: [PATCH 1/2] tcg: Add gvec compare with immediate and scalar operand
Date: Wed, 30 Aug 2023 20:09:03 -0700
Message-Id: <20230831030904.1194667-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831030904.1194667-1-richard.henderson@linaro.org>
References: <20230831030904.1194667-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h          |  25 ++++++
 include/tcg/tcg-op-gvec-common.h |   6 ++
 accel/tcg/tcg-runtime-gvec.c     |  26 ++++++
 tcg/tcg-op-gvec.c                | 150 +++++++++++++++++++++++++++++++
 4 files changed, 207 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 186899a2c7..c23b5e66c4 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -297,4 +297,29 @@ DEF_HELPER_FLAGS_4(gvec_leu16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_leu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_leu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_eqs8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_eqs16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_eqs32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_eqs64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(gvec_lts8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_lts16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_lts32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_lts64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(gvec_les8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_les16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_les32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_les64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(gvec_ltus8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_ltus16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_ltus32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_ltus64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(gvec_leus8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_leus16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_leus32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_leus64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_5(gvec_bitsel, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index e2683d487f..4db8a58c14 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -374,6 +374,12 @@ void tcg_gen_gvec_rotrv(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                       uint32_t aofs, uint32_t bofs,
                       uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_cmpi(TCGCond cond, unsigned vece, uint32_t dofs,
+                       uint32_t aofs, int64_t c,
+                       uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
+                       uint32_t aofs, TCGv_i64 c,
+                       uint32_t oprsz, uint32_t maxsz);
 
 /*
  * Perform vector bit select: d = (b & a) | (c & ~a).
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 6c99f952ca..afca89baa1 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -1042,6 +1042,32 @@ DO_CMP2(64)
 #undef DO_CMP1
 #undef DO_CMP2
 
+#define DO_CMP1(NAME, TYPE, OP)                                            \
+void HELPER(NAME)(void *d, void *a, uint64_t b64, uint32_t desc)           \
+{                                                                          \
+    intptr_t oprsz = simd_oprsz(desc);                                     \
+    TYPE inv = simd_data(desc), b = b64;                                   \
+    for (intptr_t i = 0; i < oprsz; i += sizeof(TYPE)) {                   \
+        *(TYPE *)(d + i) = -((*(TYPE *)(a + i) OP b) ^ inv);               \
+    }                                                                      \
+    clear_high(d, oprsz, desc);                                            \
+}
+
+#define DO_CMP2(SZ) \
+    DO_CMP1(gvec_eqs##SZ, uint##SZ##_t, ==)    \
+    DO_CMP1(gvec_lts##SZ, int##SZ##_t, <)      \
+    DO_CMP1(gvec_les##SZ, int##SZ##_t, <=)     \
+    DO_CMP1(gvec_ltus##SZ, uint##SZ##_t, <)    \
+    DO_CMP1(gvec_leus##SZ, uint##SZ##_t, <=)
+
+DO_CMP2(8)
+DO_CMP2(16)
+DO_CMP2(32)
+DO_CMP2(64)
+
+#undef DO_CMP1
+#undef DO_CMP2
+
 void HELPER(gvec_ssadd8)(void *d, void *a, void *b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index f5cfd9bf99..f7ca9e1051 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -3819,6 +3819,156 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 }
 
+void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
+                       uint32_t aofs, TCGv_i64 c,
+                       uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode cmp_list[] = { INDEX_op_cmp_vec, 0 };
+    static gen_helper_gvec_2i * const eq_fn[4] = {
+        gen_helper_gvec_eqs8, gen_helper_gvec_eqs16,
+        gen_helper_gvec_eqs32, gen_helper_gvec_eqs64
+    };
+    static gen_helper_gvec_2i * const lt_fn[4] = {
+        gen_helper_gvec_lts8, gen_helper_gvec_lts16,
+        gen_helper_gvec_lts32, gen_helper_gvec_lts64
+    };
+    static gen_helper_gvec_2i * const le_fn[4] = {
+        gen_helper_gvec_les8, gen_helper_gvec_les16,
+        gen_helper_gvec_les32, gen_helper_gvec_les64
+    };
+    static gen_helper_gvec_2i * const ltu_fn[4] = {
+        gen_helper_gvec_ltus8, gen_helper_gvec_ltus16,
+        gen_helper_gvec_ltus32, gen_helper_gvec_ltus64
+    };
+    static gen_helper_gvec_2i * const leu_fn[4] = {
+        gen_helper_gvec_leus8, gen_helper_gvec_leus16,
+        gen_helper_gvec_leus32, gen_helper_gvec_leus64
+    };
+    static gen_helper_gvec_2i * const * const fns[16] = {
+        [TCG_COND_EQ] = eq_fn,
+        [TCG_COND_LT] = lt_fn,
+        [TCG_COND_LE] = le_fn,
+        [TCG_COND_LTU] = ltu_fn,
+        [TCG_COND_LEU] = leu_fn,
+    };
+
+    TCGType type;
+
+    check_size_align(oprsz, maxsz, dofs | aofs);
+    check_overlap_2(dofs, aofs, maxsz);
+
+    if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
+        do_dup(MO_8, dofs, oprsz, maxsz,
+               NULL, NULL, -(cond == TCG_COND_ALWAYS));
+        return;
+    }
+
+    /*
+     * Implement inline with a vector type, if possible.
+     * Prefer integer when 64-bit host and 64-bit comparison.
+     */
+    type = choose_vector_type(cmp_list, vece, oprsz,
+                              TCG_TARGET_REG_BITS == 64 && vece == MO_64);
+    if (type != 0) {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(cmp_list);
+        TCGv_vec t_vec = tcg_temp_new_vec(type);
+        uint32_t some, i;
+
+        tcg_gen_dup_i64_vec(vece, t_vec, c);
+
+        switch (type) {
+        case TCG_TYPE_V256:
+            some = QEMU_ALIGN_DOWN(oprsz, 32);
+            for (i = 0; i < some; i += 32) {
+                TCGv_vec t0 = tcg_temp_new_vec(TCG_TYPE_V256);
+                TCGv_vec t1 = tcg_temp_new_vec(TCG_TYPE_V256);
+                tcg_gen_ld_vec(t0, cpu_env, aofs);
+                tcg_gen_cmp_vec(cond, vece, t0, t1, t_vec);
+                tcg_gen_st_vec(t0, cpu_env, dofs);
+                aofs += 32;
+                dofs += 32;
+            }
+            oprsz -= some;
+            maxsz -= some;
+            /* fallthru */
+
+        case TCG_TYPE_V128:
+            some = QEMU_ALIGN_DOWN(oprsz, 16);
+            for (i = 0; i < some; i += 16) {
+                TCGv_vec t0 = tcg_temp_new_vec(TCG_TYPE_V128);
+                TCGv_vec t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+                tcg_gen_cmp_vec(cond, vece, t0, t1, t_vec);
+                tcg_gen_st_vec(t0, cpu_env, dofs + i);
+            }
+            break;
+
+        case TCG_TYPE_V64:
+            some = QEMU_ALIGN_DOWN(oprsz, 8);
+            for (i = 0; i < some; i += 8) {
+                TCGv_vec t0 = tcg_temp_new_vec(TCG_TYPE_V64);
+                TCGv_vec t1 = tcg_temp_new_vec(TCG_TYPE_V64);
+                tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+                tcg_gen_cmp_vec(cond, vece, t0, t1, t_vec);
+                tcg_gen_st_vec(t0, cpu_env, dofs + i);
+            }
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+        tcg_temp_free_vec(t_vec);
+        tcg_swap_vecop_list(hold_list);
+    } else if (vece == MO_64 && check_size_impl(oprsz, 8)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        uint32_t i;
+
+        for (i = 0; i < oprsz; i += 8) {
+            tcg_gen_ld_i64(t0, cpu_env, aofs + i);
+            tcg_gen_negsetcond_i64(cond, t0, t0, c);
+            tcg_gen_st_i64(t0, cpu_env, dofs + i);
+        }
+        tcg_temp_free_i64(t0);
+    } else if (vece == MO_32 && check_size_impl(oprsz, 4)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        uint32_t i;
+
+        tcg_gen_extrl_i64_i32(t1, c);
+        for (i = 0; i < oprsz; i += 8) {
+            tcg_gen_ld_i32(t0, cpu_env, aofs + i);
+            tcg_gen_negsetcond_i32(cond, t0, t0, t1);
+            tcg_gen_st_i32(t0, cpu_env, dofs + i);
+        }
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
+    } else {
+        gen_helper_gvec_2i * const *fn = fns[cond];
+        bool inv = false;
+
+        if (fn == NULL) {
+            cond = tcg_invert_cond(cond);
+            fn = fns[cond];
+            assert(fn != NULL);
+            inv = true;
+        }
+        tcg_gen_gvec_2i_ool(dofs, aofs, c, oprsz, maxsz, inv, fn[vece]);
+        return;
+    }
+
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
+void tcg_gen_gvec_cmpi(TCGCond cond, unsigned vece, uint32_t dofs,
+                       uint32_t aofs, int64_t c,
+                       uint32_t oprsz, uint32_t maxsz)
+{
+    TCGv_i64 tmp = tcg_constant_i64(c);
+    tcg_gen_gvec_cmps(cond, vece, dofs, aofs, tmp, oprsz, maxsz);
+}
+
 static void tcg_gen_bitsel_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.34.1


