Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90113AF5A2E
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 15:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwhp-0002TK-2w; Wed, 02 Jul 2025 08:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgK-0008In-Br
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:20 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg0-00018T-Jr
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:19 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73afbe149afso2485667a34.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459697; x=1752064497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJyUOtrlrDv0B+MKpNaKSMoSPPgcpvHASEXA36jwgJk=;
 b=OfOFrzavEM7/kdI+la0pv9C5Xg9EQB1sRsqKqFqhMfMAX4J+2XRSNb+HnIpMKzYEWg
 2m0wOK9By1Hby422Wg58ehNvYVYT2MzgM+sawJhb/XfKkblNEi8vpYA5YReN+Tzspe9R
 70HHrRxievIahZ39xd3CazBo2H3zkYfcshYtiL/dXJUB3I+GmOmTrwsUA2MaBq9UMyD2
 5gMmQRzjU63kL+9EYAQMFAyIFhlpPLS6wjDzH4e1z7j9j7aL/rWvxtTAqDVfZXLKHkud
 n6GlVY8S58100z8uJHwPXeqzxWcsT/Xhzb9uUGy4kolrFoSQ4y002kVW1BWZOhW5iyRh
 9mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459697; x=1752064497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJyUOtrlrDv0B+MKpNaKSMoSPPgcpvHASEXA36jwgJk=;
 b=rRS2HjI2fnlouY4k9muua7rb1Cxx7sgJEVYcowa2zhLxbj/hoE0//9x08Lue06GGaX
 0UYNlwufpHOOtPuU35TE9dthsYiIMtiGjho3GIh6FS6q+ZlV4Wk0fUy+Q3Hw2cnvk654
 pZpU3lrF3/xPkJ3JwjvWwAyW41/EpTWxjA66BAdev6qy0xdn66tsyuWSCIpPLOfrcFuZ
 0/0QQLsR0UNXQ+rVVVOnRFfE9UzgXT3z8vWpcmH54LFybqhHz6ifTUAZSjeECZjE6Iya
 KxTW5L89zZh/SUHIhP5Vq4RXolIs70KIrQIRb0fMoJQseMXzSGgwxKk/1oK4mLlYWjp+
 XnTA==
X-Gm-Message-State: AOJu0YzasyeOMJdWMKDK5J5wZmzx/6uPvylMeOv+Nu7mhlUy6tNEbYcM
 mBxgRdfTz6BEro9SCkcdI9U75zlj5/xhH+YL5Tzge1RCkVnOeMbkV10y5bMij2q/N6vroq3qBtH
 iNBq+JtI=
X-Gm-Gg: ASbGncu4lKHelk4E6eomOqJvfwKZ0gU9roOtUno5VAeHqbNZ4Mv0uo73qbH5rkfl8ff
 R0Qyt9hB5tbk12RyREoytV61z7m+iEZyMeRI23/SmMbzOdTL/9aaxOkaoHFzkNfD8vsvPKYZDAD
 jdG7l5P9c/+rzNpqu/ZqTeuYAg8mBpbQ1bwlrDuR+tFETiQnf7hXWMBM54CXYLPH56Vpnj5g01I
 ceZZzjmgQBKcqB8DJqdfn5XG8ZbUaLwcsd2mUgl5jLnjsW3dmFf7ingEQ/76OBz/Q/aCc+UQqFN
 x3G2Iirpx/MstTm+Xod/kDWkFoTtuJIff0vvL3gSErhZY8ZySxOMn0ZqpTuWRsf7Q99V9Q==
X-Google-Smtp-Source: AGHT+IF1FyMHxuT7yJqac16XyOsFGJeMAfA3pU6PtpkllM+m/Wbm+nYQ1Pbh/xXz8b5027cwOAntrQ==
X-Received: by 2002:a05:6830:7303:b0:73a:9d92:fa51 with SMTP id
 46e09a7af769-73b4cc8f0eamr2065248a34.25.1751459697124; 
 Wed, 02 Jul 2025 05:34:57 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 36/97] target/arm: Implement SME2 SMLAL, SMLSL, UMLAL, UMLSL
Date: Wed,  2 Jul 2025 06:33:09 -0600
Message-ID: <20250702123410.761208-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
 target/arm/tcg/helper-sme.h    |  21 +++++
 target/arm/tcg/sme_helper.c    |  59 ++++++++++++
 target/arm/tcg/translate-sme.c |  84 +++++++++++++++++
 target/arm/tcg/sme.decode      | 168 +++++++++++++++++++++++++++++++++
 4 files changed, 332 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 464877516b..0bb8af194b 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -191,3 +191,24 @@ DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sme2_svdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme2_uvdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sme2_smlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlall_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_usmlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sme2_smlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index f5242d99be..0f79d7cb6e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1458,3 +1458,62 @@ DO_VDOT_IDX(sme2_svdot_idx_2h, int32_t, int16_t, int16_t, H4, H2)
 DO_VDOT_IDX(sme2_uvdot_idx_2h, uint32_t, uint16_t, uint16_t, H4, H2)
 
 #undef DO_VDOT_IDX
+
+#define DO_MLALL(NAME, TYPEW, TYPEN, TYPEM, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                               \
+    intptr_t elements = simd_oprsz(desc) / sizeof(TYPEW);       \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 2);         \
+    TYPEW *d = vd, *a = va; TYPEN *n = vn; TYPEM *m = vm;       \
+    for (intptr_t i = 0; i < elements; ++i) {                   \
+        TYPEW nn = n[HN(i * 4 + sel)];                          \
+        TYPEM mm = m[HN(i * 4 + sel)];                          \
+        d[HW(i)] = a[HW(i)] OP (nn * mm);                       \
+    }                                                           \
+}
+
+DO_MLALL(sme2_smlall_s, int32_t, int8_t, int8_t, H4, H1, +)
+DO_MLALL(sme2_smlall_d, int64_t, int16_t, int16_t, H8, H2, +)
+DO_MLALL(sme2_smlsll_s, int32_t, int8_t, int8_t, H4, H1, -)
+DO_MLALL(sme2_smlsll_d, int64_t, int16_t, int16_t, H8, H2, -)
+
+DO_MLALL(sme2_umlall_s, uint32_t, uint8_t, uint8_t, H4, H1, +)
+DO_MLALL(sme2_umlall_d, uint64_t, uint16_t, uint16_t, H8, H2, +)
+DO_MLALL(sme2_umlsll_s, uint32_t, uint8_t, uint8_t, H4, H1, -)
+DO_MLALL(sme2_umlsll_d, uint64_t, uint16_t, uint16_t, H8, H2, -)
+
+DO_MLALL(sme2_usmlall_s, uint32_t, uint8_t, int8_t, H4, H1, +)
+
+#undef DO_MLALL
+
+#define DO_MLALL_IDX(NAME, TYPEW, TYPEN, TYPEM, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                               \
+    intptr_t elements = simd_oprsz(desc) / sizeof(TYPEW);       \
+    intptr_t eltspersegment = 16 / sizeof(TYPEW);               \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 2);         \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 4);     \
+    TYPEW *d = vd, *a = va; TYPEN *n = vn; TYPEM *m = vm;       \
+    for (intptr_t i = 0; i < elements; i += eltspersegment) {   \
+        TYPEW mm = m[HN(i * 4 + idx)];                          \
+        for (intptr_t j = 0; j < eltspersegment; ++j) {         \
+            TYPEN nn = n[HN((i + j) * 4 + sel)];                \
+            d[HW(i + j)] = a[HW(i + j)] OP (nn * mm);           \
+        }                                                       \
+    }                                                           \
+}
+
+DO_MLALL_IDX(sme2_smlall_idx_s, int32_t, int8_t, int8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_smlall_idx_d, int64_t, int16_t, int16_t, H8, H2, +)
+DO_MLALL_IDX(sme2_smlsll_idx_s, int32_t, int8_t, int8_t, H4, H1, -)
+DO_MLALL_IDX(sme2_smlsll_idx_d, int64_t, int16_t, int16_t, H8, H2, -)
+
+DO_MLALL_IDX(sme2_umlall_idx_s, uint32_t, uint8_t, uint8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_umlall_idx_d, uint64_t, uint16_t, uint16_t, H8, H2, +)
+DO_MLALL_IDX(sme2_umlsll_idx_s, uint32_t, uint8_t, uint8_t, H4, H1, -)
+DO_MLALL_IDX(sme2_umlsll_idx_d, uint64_t, uint16_t, uint16_t, H8, H2, -)
+
+DO_MLALL_IDX(sme2_usmlall_idx_s, uint32_t, uint8_t, int8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
+
+#undef DO_MLALL_IDX
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b88f439ef9..070cebc573 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1070,3 +1070,87 @@ TRANS_FEAT(UVDOT_nx_4h, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4h)
 
 TRANS_FEAT(SUVDOT_nx_4b, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_suvdot_idx_4b)
 TRANS_FEAT(USVDOT_nx_4b, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_usvdot_idx_4b)
+
+static bool do_smlal(DisasContext *s, arg_azz_n *a, bool multi,
+                     gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                      0, 0, multi, fn);
+}
+
+TRANS_FEAT(SMLAL_n1, aa64_sme2, do_smlal, a, false, gen_helper_sve2_smlal_zzzw_s)
+TRANS_FEAT(SMLSL_n1, aa64_sme2, do_smlal, a, false, gen_helper_sve2_smlsl_zzzw_s)
+TRANS_FEAT(UMLAL_n1, aa64_sme2, do_smlal, a, false, gen_helper_sve2_umlal_zzzw_s)
+TRANS_FEAT(UMLSL_n1, aa64_sme2, do_smlal, a, false, gen_helper_sve2_umlsl_zzzw_s)
+
+TRANS_FEAT(SMLAL_nn, aa64_sme2, do_smlal, a, true, gen_helper_sve2_smlal_zzzw_s)
+TRANS_FEAT(SMLSL_nn, aa64_sme2, do_smlal, a, true, gen_helper_sve2_smlsl_zzzw_s)
+TRANS_FEAT(UMLAL_nn, aa64_sme2, do_smlal, a, true, gen_helper_sve2_umlal_zzzw_s)
+TRANS_FEAT(UMLSL_nn, aa64_sme2, do_smlal, a, true, gen_helper_sve2_umlsl_zzzw_s)
+
+static bool do_smlal_nx(DisasContext *s, arg_azx_n *a,
+                         gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                      a->idx << 1, 0, false, fn);
+}
+
+TRANS_FEAT(SMLAL_nx, aa64_sme2, do_smlal_nx, a, gen_helper_sve2_smlal_idx_s)
+TRANS_FEAT(SMLSL_nx, aa64_sme2, do_smlal_nx, a, gen_helper_sve2_smlsl_idx_s)
+TRANS_FEAT(UMLAL_nx, aa64_sme2, do_smlal_nx, a, gen_helper_sve2_umlal_idx_s)
+TRANS_FEAT(UMLSL_nx, aa64_sme2, do_smlal_nx, a, gen_helper_sve2_umlsl_idx_s)
+
+static bool do_smlall(DisasContext *s, arg_azz_n *a, bool multi,
+                     gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 4, a->rv, a->off, a->zn, a->zm,
+                      0, 0, multi, fn);
+}
+
+static void gen_helper_sme2_sumlall_s(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                      TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_sme2_usmlall_s(d, m, n, a, desc);
+}
+
+TRANS_FEAT(SMLALL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_smlall_s)
+TRANS_FEAT(SMLSLL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_smlsll_s)
+TRANS_FEAT(UMLALL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_umlall_s)
+TRANS_FEAT(UMLSLL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_umlsll_s)
+TRANS_FEAT(USMLALL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_usmlall_s)
+TRANS_FEAT(SUMLALL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_sumlall_s)
+
+TRANS_FEAT(SMLALL_n1_d, aa64_sme2_i16i64, do_smlall, a, false, gen_helper_sme2_smlall_d)
+TRANS_FEAT(SMLSLL_n1_d, aa64_sme2_i16i64, do_smlall, a, false, gen_helper_sme2_smlsll_d)
+TRANS_FEAT(UMLALL_n1_d, aa64_sme2_i16i64, do_smlall, a, false, gen_helper_sme2_umlall_d)
+TRANS_FEAT(UMLSLL_n1_d, aa64_sme2_i16i64, do_smlall, a, false, gen_helper_sme2_umlsll_d)
+
+TRANS_FEAT(SMLALL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_smlall_s)
+TRANS_FEAT(SMLSLL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_smlsll_s)
+TRANS_FEAT(UMLALL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_umlall_s)
+TRANS_FEAT(UMLSLL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_umlsll_s)
+TRANS_FEAT(USMLALL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_usmlall_s)
+
+TRANS_FEAT(SMLALL_nn_d, aa64_sme2_i16i64, do_smlall, a, true, gen_helper_sme2_smlall_d)
+TRANS_FEAT(SMLSLL_nn_d, aa64_sme2_i16i64, do_smlall, a, true, gen_helper_sme2_smlsll_d)
+TRANS_FEAT(UMLALL_nn_d, aa64_sme2_i16i64, do_smlall, a, true, gen_helper_sme2_umlall_d)
+TRANS_FEAT(UMLSLL_nn_d, aa64_sme2_i16i64, do_smlall, a, true, gen_helper_sme2_umlsll_d)
+
+static bool do_smlall_nx(DisasContext *s, arg_azx_n *a,
+                        gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 4, a->rv, a->off, a->zn, a->zm,
+                      a->idx << 2, 0, false, fn);
+}
+
+TRANS_FEAT(SMLALL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_smlall_idx_s)
+TRANS_FEAT(SMLSLL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_s)
+TRANS_FEAT(UMLALL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_umlall_idx_s)
+TRANS_FEAT(UMLSLL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_umlsll_idx_s)
+TRANS_FEAT(USMLALL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_usmlall_idx_s)
+TRANS_FEAT(SUMLALL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_sumlall_idx_s)
+
+TRANS_FEAT(SMLALL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_smlall_idx_d)
+TRANS_FEAT(SMLSLL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_d)
+TRANS_FEAT(UMLALL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_umlall_idx_d)
+TRANS_FEAT(UMLSLL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_umlsll_idx_d)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4146744a46..934e4a802e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -311,6 +311,65 @@ UDOT_n1_4h      11000001 011 1 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=4
 UDOT_n1_2h      11000001 011 0 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=2
 UDOT_n1_2h      11000001 011 1 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=4
 
+SMLAL_n1        11000001 011 0 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
+SMLAL_n1        11000001 011 0 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=2
+SMLAL_n1        11000001 011 1 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=4
+
+SMLSL_n1        11000001 011 0 .... 0 .. 011 ..... 01 ...   @azz_nx1_o3x2 n=1
+SMLSL_n1        11000001 011 0 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=2
+SMLSL_n1        11000001 011 1 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=4
+
+UMLAL_n1        11000001 011 0 .... 0 .. 011 ..... 10 ...   @azz_nx1_o3x2 n=1
+UMLAL_n1        11000001 011 0 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=2
+UMLAL_n1        11000001 011 1 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=4
+
+UMLSL_n1        11000001 011 0 .... 0 .. 011 ..... 11 ...   @azz_nx1_o3x2 n=1
+UMLSL_n1        11000001 011 0 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=2
+UMLSL_n1        11000001 011 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
+
+%off2_x4        0:2 !function=times_4
+%off1_x4        0:1 !function=times_4
+
+@azz_nx1_o2x4   ........ ... . zm:4 . .. ... zn:5 ... ..    \
+                &azz_n off=%off2_x4 rv=%mova_rv
+@azz_nx1_o1x4   ........ ... . zm:4 . .. ... zn:5 .... .    \
+                &azz_n off=%off1_x4 rv=%mova_rv
+
+SMLALL_n1_s     11000001 001 0 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
+SMLALL_n1_d     11000001 011 0 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
+SMLALL_n1_s     11000001 001 0 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=2
+SMLALL_n1_d     11000001 011 0 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=2
+SMLALL_n1_s     11000001 001 1 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=4
+SMLALL_n1_d     11000001 011 1 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=4
+
+SMLSLL_n1_s     11000001 001 0 .... 0 .. 001 ..... 010 ..   @azz_nx1_o2x4 n=1
+SMLSLL_n1_d     11000001 011 0 .... 0 .. 001 ..... 010 ..   @azz_nx1_o2x4 n=1
+SMLSLL_n1_s     11000001 001 0 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=2
+SMLSLL_n1_d     11000001 011 0 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=2
+SMLSLL_n1_s     11000001 001 1 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=4
+SMLSLL_n1_d     11000001 011 1 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=4
+
+UMLALL_n1_s     11000001 001 0 .... 0 .. 001 ..... 100 ..   @azz_nx1_o2x4 n=1
+UMLALL_n1_d     11000001 011 0 .... 0 .. 001 ..... 100 ..   @azz_nx1_o2x4 n=1
+UMLALL_n1_s     11000001 001 0 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=2
+UMLALL_n1_d     11000001 011 0 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=2
+UMLALL_n1_s     11000001 001 1 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=4
+UMLALL_n1_d     11000001 011 1 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=4
+
+UMLSLL_n1_s     11000001 001 0 .... 0 .. 001 ..... 110 ..   @azz_nx1_o2x4 n=1
+UMLSLL_n1_d     11000001 011 0 .... 0 .. 001 ..... 110 ..   @azz_nx1_o2x4 n=1
+UMLSLL_n1_s     11000001 001 0 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=2
+UMLSLL_n1_d     11000001 011 0 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=2
+UMLSLL_n1_s     11000001 001 1 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=4
+UMLSLL_n1_d     11000001 011 1 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=4
+
+USMLALL_n1_s    11000001 001 0 .... 0 .. 001 ..... 001 ..   @azz_nx1_o2x4 n=1
+USMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=2
+USMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=4
+
+SUMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
+SUMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -371,6 +430,46 @@ UDOT_nn_4h      11000001 111 ...01 0 .. 101 ...00 10 ...    @azz_4x4_o3
 UDOT_nn_2h      11000001 111 ....0 0 .. 101 ....0 11 ...    @azz_2x2_o3
 UDOT_nn_2h      11000001 111 ...01 0 .. 101 ...00 11 ...    @azz_4x4_o3
 
+SMLAL_nn        11000001 111 ....0 0 .. 010 ....0 000 ..    @azz_2x2_o2x2
+SMLAL_nn        11000001 111 ...01 0 .. 010 ...00 000 ..    @azz_4x4_o2x2
+
+SMLSL_nn        11000001 111 ....0 0 .. 010 ....0 010 ..    @azz_2x2_o2x2
+SMLSL_nn        11000001 111 ...01 0 .. 010 ...00 010 ..    @azz_4x4_o2x2
+
+UMLAL_nn        11000001 111 ....0 0 .. 010 ....0 100 ..    @azz_2x2_o2x2
+UMLAL_nn        11000001 111 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
+
+UMLSL_nn        11000001 111 ....0 0 .. 010 ....0 110 ..    @azz_2x2_o2x2
+UMLSL_nn        11000001 111 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
+
+@azz_2x2_o1x4   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2 off=%off1_x4
+@azz_4x4_o1x4   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4 off=%off1_x4
+
+SMLALL_nn_s     11000001 101 ....0 0 .. 000 ....0 0000 .    @azz_2x2_o1x4
+SMLALL_nn_d     11000001 111 ....0 0 .. 000 ....0 0000 .    @azz_2x2_o1x4
+SMLALL_nn_s     11000001 101 ...01 0 .. 000 ...00 0000 .    @azz_4x4_o1x4
+SMLALL_nn_d     11000001 111 ...01 0 .. 000 ...00 0000 .    @azz_4x4_o1x4
+
+SMLSLL_nn_s     11000001 101 ....0 0 .. 000 ....0 0100 .    @azz_2x2_o1x4
+SMLSLL_nn_d     11000001 111 ....0 0 .. 000 ....0 0100 .    @azz_2x2_o1x4
+SMLSLL_nn_s     11000001 101 ...01 0 .. 000 ...00 0100 .    @azz_4x4_o1x4
+SMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 0100 .    @azz_4x4_o1x4
+
+UMLALL_nn_s     11000001 101 ....0 0 .. 000 ....0 1000 .    @azz_2x2_o1x4
+UMLALL_nn_d     11000001 111 ....0 0 .. 000 ....0 1000 .    @azz_2x2_o1x4
+UMLALL_nn_s     11000001 101 ...01 0 .. 000 ...00 1000 .    @azz_4x4_o1x4
+UMLALL_nn_d     11000001 111 ...01 0 .. 000 ...00 1000 .    @azz_4x4_o1x4
+
+UMLSLL_nn_s     11000001 101 ....0 0 .. 000 ....0 1100 .    @azz_2x2_o1x4
+UMLSLL_nn_d     11000001 111 ....0 0 .. 000 ....0 1100 .    @azz_2x2_o1x4
+UMLSLL_nn_s     11000001 101 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
+UMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
+
+USMLALL_nn_s    11000001 101 ....0 0 .. 000 ....0 0010 .    @azz_2x2_o1x4
+USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 0010 .    @azz_4x4_o1x4
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -449,3 +548,72 @@ UVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 11 ...   @azx_4x1_i1_o3
 
 SUVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 11 ...   @azx_4x1_i2_o3
 USVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 01 ...   @azx_4x1_i2_o3
+
+SMLAL_nx        11000001 1100 .... . .. 1 .. ..... 00 ...   @azx_1x1_o3x2
+SMLAL_nx        11000001 1101 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_o2x2
+SMLAL_nx        11000001 1101 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_o2x2
+
+SMLSL_nx        11000001 1100 .... . .. 1 .. ..... 01 ...   @azx_1x1_o3x2
+SMLSL_nx        11000001 1101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_o2x2
+SMLSL_nx        11000001 1101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_o2x2
+
+UMLAL_nx        11000001 1100 .... . .. 1 .. ..... 10 ...   @azx_1x1_o3x2
+UMLAL_nx        11000001 1101 .... 0 .. 1 .. ....0 10 ...   @azx_2x1_o2x2
+UMLAL_nx        11000001 1101 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_o2x2
+
+UMLSL_nx        11000001 1100 .... . .. 1 .. ..... 11 ...   @azx_1x1_o3x2
+UMLSL_nx        11000001 1101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_o2x2
+UMLSL_nx        11000001 1101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
+
+%idx4_15_10     15:1 10:3
+%idx4_10_1      10:2 1:2
+%idx3_10_1      10:1 1:2
+
+@azx_1x1_i4_o2  ........ .... zm:4 . .. ... zn:5 ... ..     \
+                &azx_n n=1 rv=%mova_rv off=%off2_x4 idx=%idx4_15_10
+@azx_1x1_i3_o2  ........ .... zm:4 . .. ... zn:5 ... ..     \
+                &azx_n n=1 rv=%mova_rv off=%off2_x4 idx=%idx3_15_10
+@azx_2x1_i4_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=2 rv=%mova_rv off=%off1_x4 zn=%zn_ax2 idx=%idx4_10_1
+@azx_2x1_i3_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=2 rv=%mova_rv off=%off1_x4 zn=%zn_ax2 idx=%idx3_10_1
+@azx_4x1_i4_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=4 rv=%mova_rv off=%off1_x4 zn=%zn_ax4 idx=%idx4_10_1
+@azx_4x1_i3_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=4 rv=%mova_rv off=%off1_x4 zn=%zn_ax4 idx=%idx3_10_1
+
+SMLALL_nx_s     11000001 0000 .... . .. ... ..... 000 ..    @azx_1x1_i4_o2
+SMLALL_nx_d     11000001 1000 .... . .. 0.. ..... 000 ..    @azx_1x1_i3_o2
+SMLALL_nx_s     11000001 0001 .... 0 .. 0.. ....0 00 ...    @azx_2x1_i4_o1
+SMLALL_nx_d     11000001 1001 .... 0 .. 00. ....0 00 ...    @azx_2x1_i3_o1
+SMLALL_nx_s     11000001 0001 .... 1 .. 0.. ...00 00 ...    @azx_4x1_i4_o1
+SMLALL_nx_d     11000001 1001 .... 1 .. 00. ...00 00 ...    @azx_4x1_i3_o1
+
+SMLSLL_nx_s     11000001 0000 .... . .. ... ..... 010 ..    @azx_1x1_i4_o2
+SMLSLL_nx_d     11000001 1000 .... . .. 0.. ..... 010 ..    @azx_1x1_i3_o2
+SMLSLL_nx_s     11000001 0001 .... 0 .. 0.. ....0 01 ...    @azx_2x1_i4_o1
+SMLSLL_nx_d     11000001 1001 .... 0 .. 00. ....0 01 ...    @azx_2x1_i3_o1
+SMLSLL_nx_s     11000001 0001 .... 1 .. 0.. ...00 01 ...    @azx_4x1_i4_o1
+SMLSLL_nx_d     11000001 1001 .... 1 .. 00. ...00 01 ...    @azx_4x1_i3_o1
+
+UMLALL_nx_s     11000001 0000 .... . .. ... ..... 100 ..    @azx_1x1_i4_o2
+UMLALL_nx_d     11000001 1000 .... . .. 0.. ..... 100 ..    @azx_1x1_i3_o2
+UMLALL_nx_s     11000001 0001 .... 0 .. 0.. ....0 10 ...    @azx_2x1_i4_o1
+UMLALL_nx_d     11000001 1001 .... 0 .. 00. ....0 10 ...    @azx_2x1_i3_o1
+UMLALL_nx_s     11000001 0001 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i4_o1
+UMLALL_nx_d     11000001 1001 .... 1 .. 00. ...00 10 ...    @azx_4x1_i3_o1
+
+UMLSLL_nx_s     11000001 0000 .... . .. ... ..... 110 ..    @azx_1x1_i4_o2
+UMLSLL_nx_d     11000001 1000 .... . .. 0.. ..... 110 ..    @azx_1x1_i3_o2
+UMLSLL_nx_s     11000001 0001 .... 0 .. 0.. ....0 11 ...    @azx_2x1_i4_o1
+UMLSLL_nx_d     11000001 1001 .... 0 .. 00. ....0 11 ...    @azx_2x1_i3_o1
+UMLSLL_nx_s     11000001 0001 .... 1 .. 0.. ...00 11 ...    @azx_4x1_i4_o1
+UMLSLL_nx_d     11000001 1001 .... 1 .. 00. ...00 11 ...    @azx_4x1_i3_o1
+
+USMLALL_nx_s    11000001 0000 .... . .. ... ..... 001 ..    @azx_1x1_i4_o2
+USMLALL_nx_s    11000001 0001 .... 0 .. 0.. ....1 00 ...    @azx_2x1_i4_o1
+USMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 00 ...    @azx_4x1_i4_o1
+
+SUMLALL_nx_s    11000001 0000 .... . .. ... ..... 101 ..    @azx_1x1_i4_o2
+SUMLALL_nx_s    11000001 0001 .... 0 .. 0.. ....1 10 ...    @azx_2x1_i4_o1
+SUMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 10 ...    @azx_4x1_i4_o1
-- 
2.43.0


