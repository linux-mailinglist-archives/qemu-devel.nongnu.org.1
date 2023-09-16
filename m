Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6E7A2DAD
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:32:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM11-00061l-90; Fri, 15 Sep 2023 23:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0y-000612-Ok
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:36 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0w-00083P-N3
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:36 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-76dc77fd024so179731085a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835034; x=1695439834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfgiV30YY9BmFELNtJwJy2RvFgo1WS6aWRn3sjQZrEw=;
 b=DZpWbRQcZyAVc6XNz/FmDMBH3iMlbP2kOSDj/y9W8Fp8c1fAMXQX4QMBruX/RfDV/G
 qeccGrNy3ReVm6R28j34luJ4bdeqCq7I/zO1T56WCVmxuIxczMzQLsBZWjD6Mhc2guyJ
 4BPVDl+Je5u3IRZpaSjT4Ejdn0Rh0T+G4Vcr05obq6k1LIJzPqqZnZelkFO1F+LTyKCJ
 tz+Yn0d3Ugxtq8PcR/AIbmUlf7nYuK+fAHQWjB8G3iRZLhUgl3Qlbz0ZegH1zYQaa0tb
 t36VuITliUTvj5S1jU29sEBn8nHcRt2wtJ9WOmRwnju8PI6n0nu9nMkjxeTUVIlHTTew
 CfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835034; x=1695439834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfgiV30YY9BmFELNtJwJy2RvFgo1WS6aWRn3sjQZrEw=;
 b=G2Ea77OT7zmzAB+aYwKGgGX9u+kt+GB6M8GalEQJ8ubwPWV6YK6Sqw0PwJbvt6Gn4j
 a7k1edsirTv5DCQrUKDghHu+LMM1otxm8+kle3pkM1TJ594wi18r0IXkhQSomDfQ8o0l
 qk0lPcEZBy1ZEgGpZLpTqy/Oi85t8W0RnhhnM7JSCUmpADpyctBdGPT+KlriKDT5UH1R
 Te28CQ6B2SXp5muUza9WTchWLuVAzWejzEHCz4/aryB00ZMvw1klSJxb8zMNa9S7iE1Q
 rlb1ln9f08TjN6dQyFqmtwOZmKVWhpUFFV1VhKRl9TZ1T8VXyigi2rRdmKdAg5JVuDeY
 2TtQ==
X-Gm-Message-State: AOJu0YzxmxtqBxXkM9W+w6xOtSY/YUTxE004C6eGRGHDkvF0oOYOTsps
 9fLzghoBBhD/wiL+2NRLiNBT+FUObYbF1tM0NcM=
X-Google-Smtp-Source: AGHT+IE1WLpHSy4PYak+khahGL/j0LEchcSRPDVuY+i5BsGK8T38hZI1BgD+cAYEzwv73PiFwuH5Tw==
X-Received: by 2002:a05:620a:2584:b0:76f:1ba:9c44 with SMTP id
 x4-20020a05620a258400b0076f01ba9c44mr3800833qko.1.1694835033776; 
 Fri, 15 Sep 2023 20:30:33 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 22/39] tcg: Add gvec compare with immediate and scalar operand
Date: Fri, 15 Sep 2023 20:29:54 -0700
Message-Id: <20230916033011.479144-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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
Tested-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230831030904.1194667-2-richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h          |  25 ++++++
 include/tcg/tcg-op-gvec-common.h |   6 ++
 accel/tcg/tcg-runtime-gvec.c     |  26 ++++++
 tcg/tcg-op-gvec.c                | 149 +++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+)

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
index e260a07c61..41b1ae18e4 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -3846,6 +3846,155 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 }
 
+static void expand_cmps_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                            uint32_t oprsz, uint32_t tysz, TCGType type,
+                            TCGCond cond, TCGv_vec c)
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += tysz) {
+        tcg_gen_ld_vec(t1, cpu_env, aofs + i);
+        tcg_gen_cmp_vec(cond, vece, t0, t1, c);
+        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+    }
+}
+
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
+        uint32_t some;
+
+        tcg_gen_dup_i64_vec(vece, t_vec, c);
+        switch (type) {
+        case TCG_TYPE_V256:
+            some = QEMU_ALIGN_DOWN(oprsz, 32);
+            expand_cmps_vec(vece, dofs, aofs, some, 32,
+                            TCG_TYPE_V256, cond, t_vec);
+            aofs += some;
+            dofs += some;
+            oprsz -= some;
+            maxsz -= some;
+            /* fallthru */
+
+        case TCG_TYPE_V128:
+            some = QEMU_ALIGN_DOWN(oprsz, 16);
+            expand_cmps_vec(vece, dofs, aofs, some, 16,
+                            TCG_TYPE_V128, cond, t_vec);
+            break;
+
+        case TCG_TYPE_V64:
+            some = QEMU_ALIGN_DOWN(oprsz, 8);
+            expand_cmps_vec(vece, dofs, aofs, some, 8,
+                            TCG_TYPE_V64, cond, t_vec);
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


