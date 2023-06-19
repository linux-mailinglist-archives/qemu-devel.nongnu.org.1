Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF9735B66
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH3f-0005lh-M3; Mon, 19 Jun 2023 11:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH3c-0005Nr-8h
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:44:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH3Y-0001Fd-EO
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:44:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30e3caa6aa7so3605590f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189471; x=1689781471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQ57k58/TJU7GczCU1n00BAj0iap+eCTdOYHiHp6abQ=;
 b=HXDMIWixtD+Vy1ScFBpvBJiIENlQa9X1WAdA8AwSRsHy0W7JlgDHUTQqRPqprDkDcA
 9Ihpot+aOEjP94PYXmoVz2S9eoC2xWTtlWrl4E4pAiKWbIUT7HZUnQ42ueZiyzJpulD+
 ObngMWXaO7AEDqDxO89T5JLlSAly7nycgbmauw+Y6OiL6gWY5nHED08e+ehMVyMydGJL
 NKjBoJEU5NiLFn3SvE/7hi/4DxH29w3MWm7p8VF3vWlPXOQogJtPP0hhNyM3wcDDHiSN
 rGC6Ol/emrliyj0nNDssxBXy5gy5mIwqDcuTtyxsmPd3rDi6XdWaV0pGINkFG54f1k8O
 NrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189471; x=1689781471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQ57k58/TJU7GczCU1n00BAj0iap+eCTdOYHiHp6abQ=;
 b=gfDnM6+sR4oN/J0HTdIJrHFk78qAL9U5abkhWbJ6brcP6kl627kbddWbDITTPJBsYk
 XvsTgY5cvdu33Q4p+8+RPyrlm5x90W8qhjPfxf3YfRHjpRZrJoJwJpsfOMcgt3rEJXgJ
 Y2P5aLxoZmnABwe+MnmrhMrryHewMj6snnV9wwT2zZstVE53AuEolqyMmnIq/NOwuQqo
 rovvoElV9k4NoM1QqcPsIEzwZ1/0rQlrUlGSj1Xq0KGVhed1tqoUrMs6v5vFORI8HuSP
 Ml1ldwd4KFGi4cUoXQ0atUVMiP7VovpBQVp8cSU6PjdOQhjb0Yh3hpJIl+75O0qWERrN
 m/CQ==
X-Gm-Message-State: AC+VfDzU5CmdkRr84ab5BV16WrDF6fVAoLM7finZoV/OjFD0M1CuxbSY
 8ErHRfuInwCsVI6CJ4wQoWmv1SeTo47f9cl2mgzPHA==
X-Google-Smtp-Source: ACHHUZ7A0QqBZrQsbdJcb52s9iZEI3l8v9dJ7WwfM+qUscN6/8U5O8KWvNGlbmVRtvRAuWzdd6j5rQ==
X-Received: by 2002:a5d:6505:0:b0:30f:d2af:d62b with SMTP id
 x5-20020a5d6505000000b0030fd2afd62bmr7809591wru.19.1687189471266; 
 Mon, 19 Jun 2023 08:44:31 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 a17-20020a5d5711000000b003113b3bc9d7sm4281946wrv.32.2023.06.19.08.44.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:44:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/34] target/arm/tcg: Move VFP helpers from helper-a64.c
 to vfp_helper.c
Date: Mon, 19 Jun 2023 17:42:37 +0200
Message-Id: <20230619154302.80350-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619154302.80350-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Keep the VFP helpers in the same file, guarding them with #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/helper-a64.c | 87 ----------------------------------
 target/arm/vfp_helper.c     | 93 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 88 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 1c9370f07b..c43f22e7d4 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -93,93 +93,6 @@ void HELPER(msr_i_daifclear)(CPUARMState *env, uint32_t imm)
     arm_rebuild_hflags(env);
 }
 
-/* Convert a softfloat float_relation_ (as returned by
- * the float*_compare functions) to the correct ARM
- * NZCV flag state.
- */
-static inline uint32_t float_rel_to_flags(int res)
-{
-    uint64_t flags;
-    switch (res) {
-    case float_relation_equal:
-        flags = PSTATE_Z | PSTATE_C;
-        break;
-    case float_relation_less:
-        flags = PSTATE_N;
-        break;
-    case float_relation_greater:
-        flags = PSTATE_C;
-        break;
-    case float_relation_unordered:
-    default:
-        flags = PSTATE_C | PSTATE_V;
-        break;
-    }
-    return flags;
-}
-
-uint64_t HELPER(vfp_cmph_a64)(uint32_t x, uint32_t y, void *fp_status)
-{
-    return float_rel_to_flags(float16_compare_quiet(x, y, fp_status));
-}
-
-uint64_t HELPER(vfp_cmpeh_a64)(uint32_t x, uint32_t y, void *fp_status)
-{
-    return float_rel_to_flags(float16_compare(x, y, fp_status));
-}
-
-uint64_t HELPER(vfp_cmps_a64)(float32 x, float32 y, void *fp_status)
-{
-    return float_rel_to_flags(float32_compare_quiet(x, y, fp_status));
-}
-
-uint64_t HELPER(vfp_cmpes_a64)(float32 x, float32 y, void *fp_status)
-{
-    return float_rel_to_flags(float32_compare(x, y, fp_status));
-}
-
-uint64_t HELPER(vfp_cmpd_a64)(float64 x, float64 y, void *fp_status)
-{
-    return float_rel_to_flags(float64_compare_quiet(x, y, fp_status));
-}
-
-uint64_t HELPER(vfp_cmped_a64)(float64 x, float64 y, void *fp_status)
-{
-    return float_rel_to_flags(float64_compare(x, y, fp_status));
-}
-
-float32 HELPER(vfp_mulxs)(float32 a, float32 b, void *fpstp)
-{
-    float_status *fpst = fpstp;
-
-    a = float32_squash_input_denormal(a, fpst);
-    b = float32_squash_input_denormal(b, fpst);
-
-    if ((float32_is_zero(a) && float32_is_infinity(b)) ||
-        (float32_is_infinity(a) && float32_is_zero(b))) {
-        /* 2.0 with the sign bit set to sign(A) XOR sign(B) */
-        return make_float32((1U << 30) |
-                            ((float32_val(a) ^ float32_val(b)) & (1U << 31)));
-    }
-    return float32_mul(a, b, fpst);
-}
-
-float64 HELPER(vfp_mulxd)(float64 a, float64 b, void *fpstp)
-{
-    float_status *fpst = fpstp;
-
-    a = float64_squash_input_denormal(a, fpst);
-    b = float64_squash_input_denormal(b, fpst);
-
-    if ((float64_is_zero(a) && float64_is_infinity(b)) ||
-        (float64_is_infinity(a) && float64_is_zero(b))) {
-        /* 2.0 with the sign bit set to sign(A) XOR sign(B) */
-        return make_float64((1ULL << 62) |
-                            ((float64_val(a) ^ float64_val(b)) & (1ULL << 63)));
-    }
-    return float64_mul(a, b, fpst);
-}
-
 /* 64bit/double versions of the neon float compare functions */
 uint64_t HELPER(neon_ceq_f64)(float64 a, float64 b, void *fpstp)
 {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 36906db8e0..0a5b2993a4 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1326,4 +1326,95 @@ void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
     raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
 }
 
-#endif
+#ifdef TARGET_AARCH64
+
+/* Convert a softfloat float_relation_ (as returned by
+ * the float*_compare functions) to the correct ARM
+ * NZCV flag state.
+ */
+static inline uint32_t float_rel_to_flags(int res)
+{
+    uint64_t flags;
+    switch (res) {
+    case float_relation_equal:
+        flags = PSTATE_Z | PSTATE_C;
+        break;
+    case float_relation_less:
+        flags = PSTATE_N;
+        break;
+    case float_relation_greater:
+        flags = PSTATE_C;
+        break;
+    case float_relation_unordered:
+    default:
+        flags = PSTATE_C | PSTATE_V;
+        break;
+    }
+    return flags;
+}
+
+uint64_t HELPER(vfp_cmph_a64)(uint32_t x, uint32_t y, void *fp_status)
+{
+    return float_rel_to_flags(float16_compare_quiet(x, y, fp_status));
+}
+
+uint64_t HELPER(vfp_cmpeh_a64)(uint32_t x, uint32_t y, void *fp_status)
+{
+    return float_rel_to_flags(float16_compare(x, y, fp_status));
+}
+
+uint64_t HELPER(vfp_cmps_a64)(float32 x, float32 y, void *fp_status)
+{
+    return float_rel_to_flags(float32_compare_quiet(x, y, fp_status));
+}
+
+uint64_t HELPER(vfp_cmpes_a64)(float32 x, float32 y, void *fp_status)
+{
+    return float_rel_to_flags(float32_compare(x, y, fp_status));
+}
+
+uint64_t HELPER(vfp_cmpd_a64)(float64 x, float64 y, void *fp_status)
+{
+    return float_rel_to_flags(float64_compare_quiet(x, y, fp_status));
+}
+
+uint64_t HELPER(vfp_cmped_a64)(float64 x, float64 y, void *fp_status)
+{
+    return float_rel_to_flags(float64_compare(x, y, fp_status));
+}
+
+float32 HELPER(vfp_mulxs)(float32 a, float32 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+
+    a = float32_squash_input_denormal(a, fpst);
+    b = float32_squash_input_denormal(b, fpst);
+
+    if ((float32_is_zero(a) && float32_is_infinity(b)) ||
+        (float32_is_infinity(a) && float32_is_zero(b))) {
+        /* 2.0 with the sign bit set to sign(A) XOR sign(B) */
+        return make_float32((1U << 30) |
+                            ((float32_val(a) ^ float32_val(b)) & (1U << 31)));
+    }
+    return float32_mul(a, b, fpst);
+}
+
+float64 HELPER(vfp_mulxd)(float64 a, float64 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+
+    a = float64_squash_input_denormal(a, fpst);
+    b = float64_squash_input_denormal(b, fpst);
+
+    if ((float64_is_zero(a) && float64_is_infinity(b)) ||
+        (float64_is_infinity(a) && float64_is_zero(b))) {
+        /* 2.0 with the sign bit set to sign(A) XOR sign(B) */
+        return make_float64((1ULL << 62) |
+                            ((float64_val(a) ^ float64_val(b)) & (1ULL << 63)));
+    }
+    return float64_mul(a, b, fpst);
+}
+
+#endif /* TARGET_AARCH64 */
+
+#endif /* CONFIG_TCG */
-- 
2.38.1


