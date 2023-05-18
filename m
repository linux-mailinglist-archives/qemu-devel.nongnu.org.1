Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4AF7081D4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6U-0004Cy-3r; Thu, 18 May 2023 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6L-0004Ah-CB
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6D-00080Q-5T
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f42c86543bso13198875e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414274; x=1687006274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MitncF/4GqTSNnwixClM4RdAFm5G7KDGOzVgQYsIGKo=;
 b=rx+PmxiW9qIU5xNMBKaIdRg64ufGexmhvR1n5qKoTEvaGBeEw4u97Twf7j2veOOk6A
 BGvbBWtqxUNqkweSrKRl9swyj218YoZ6vuHDJXQiQS2ap67Xsi7WTuNGUINR0BO2nM9S
 FacJ3bN+1XfcfmjNF29/s5vhcnVSuhc3B5MX1ZcQnBOTQ+/mMJ56coifKIvYdrMVTjY4
 KS4IK6PJNWw+9L2lq9w+3HXkkVFxb6G4DWmxjiHfJFrjWxc67JUZloHtupl8pZYNb1GJ
 4NKQ9vXb0L0UrrmVMBj6OgaNOwLwx5fS0pw6KQxibEWLmnvn4bv6JK++Sizj474nAnX3
 Ts6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414274; x=1687006274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MitncF/4GqTSNnwixClM4RdAFm5G7KDGOzVgQYsIGKo=;
 b=X5tLKFjNQBo6YcMuUBOghJRKirTyBojcYcJgaem2vLDGzsGmgdPlhNBj02frbIr2RB
 mQ4XXTyjnVCzBFDGfe+tWbDjGoNmlzHXC20bWTnXv1s/aDQjnGLTTGuridj8D2SPyIDt
 yitT3RW64rWvQMMKBQbynL6Fmbz63LWJsuRJeE6jegoBeleWbqdARIn/12SCTx/mDwnk
 YEpxI0q67Z9zYY7kuR8mMCgVbKE2d2RstdbNIqK5Mr2uuIS9/FRr+Sh5ysaCd2WwbVEl
 PjR1ZEUt5l2DCmkXZh4clcGv4hQZjidZW2+q48ckYom9C2KcraXNCg4cPVJD/MW98aL6
 RxvQ==
X-Gm-Message-State: AC+VfDx/5c/KnnsjEA723S9k3nd1c2zkiPMD8UStFbJrAYNLxLRKOzXi
 2HXdUOU2pGud0NAVkz7KH8glPT034ARu/adamio=
X-Google-Smtp-Source: ACHHUZ7tw37++rz2SMU5g/0wUcr3v+jPeik2PWy7CtdAbviBbhH3ajx2x7wwh5opkPeDSxG9vpXAqg==
X-Received: by 2002:a05:600c:ad9:b0:3f4:21cf:b4a4 with SMTP id
 c25-20020a05600c0ad900b003f421cfb4a4mr1534086wmr.20.1684414273768; 
 Thu, 18 May 2023 05:51:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/29] target/arm: Split gen_add_CC and gen_sub_CC
Date: Thu, 18 May 2023 13:50:49 +0100
Message-Id: <20230518125107.146421-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Split out specific 32-bit and 64-bit functions.
These carry the same signature as tcg_gen_add_i64,
and so will be easier to pass as callbacks.

Retain gen_add_CC and gen_sub_CC during conversion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230512144106.3608981-6-peter.maydell@linaro.org
[PMM: rebased]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 149 +++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 65 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ffcd05eb38a..7a633abf830 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -682,83 +682,102 @@ static inline void gen_logic_CC(int sf, TCGv_i64 result)
 }
 
 /* dest = T0 + T1; compute C, N, V and Z flags */
+static void gen_add64_CC(TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
+{
+    TCGv_i64 result, flag, tmp;
+    result = tcg_temp_new_i64();
+    flag = tcg_temp_new_i64();
+    tmp = tcg_temp_new_i64();
+
+    tcg_gen_movi_i64(tmp, 0);
+    tcg_gen_add2_i64(result, flag, t0, tmp, t1, tmp);
+
+    tcg_gen_extrl_i64_i32(cpu_CF, flag);
+
+    gen_set_NZ64(result);
+
+    tcg_gen_xor_i64(flag, result, t0);
+    tcg_gen_xor_i64(tmp, t0, t1);
+    tcg_gen_andc_i64(flag, flag, tmp);
+    tcg_gen_extrh_i64_i32(cpu_VF, flag);
+
+    tcg_gen_mov_i64(dest, result);
+}
+
+static void gen_add32_CC(TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
+{
+    TCGv_i32 t0_32 = tcg_temp_new_i32();
+    TCGv_i32 t1_32 = tcg_temp_new_i32();
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_movi_i32(tmp, 0);
+    tcg_gen_extrl_i64_i32(t0_32, t0);
+    tcg_gen_extrl_i64_i32(t1_32, t1);
+    tcg_gen_add2_i32(cpu_NF, cpu_CF, t0_32, tmp, t1_32, tmp);
+    tcg_gen_mov_i32(cpu_ZF, cpu_NF);
+    tcg_gen_xor_i32(cpu_VF, cpu_NF, t0_32);
+    tcg_gen_xor_i32(tmp, t0_32, t1_32);
+    tcg_gen_andc_i32(cpu_VF, cpu_VF, tmp);
+    tcg_gen_extu_i32_i64(dest, cpu_NF);
+}
+
 static void gen_add_CC(int sf, TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
 {
     if (sf) {
-        TCGv_i64 result, flag, tmp;
-        result = tcg_temp_new_i64();
-        flag = tcg_temp_new_i64();
-        tmp = tcg_temp_new_i64();
-
-        tcg_gen_movi_i64(tmp, 0);
-        tcg_gen_add2_i64(result, flag, t0, tmp, t1, tmp);
-
-        tcg_gen_extrl_i64_i32(cpu_CF, flag);
-
-        gen_set_NZ64(result);
-
-        tcg_gen_xor_i64(flag, result, t0);
-        tcg_gen_xor_i64(tmp, t0, t1);
-        tcg_gen_andc_i64(flag, flag, tmp);
-        tcg_gen_extrh_i64_i32(cpu_VF, flag);
-
-        tcg_gen_mov_i64(dest, result);
+        gen_add64_CC(dest, t0, t1);
     } else {
-        /* 32 bit arithmetic */
-        TCGv_i32 t0_32 = tcg_temp_new_i32();
-        TCGv_i32 t1_32 = tcg_temp_new_i32();
-        TCGv_i32 tmp = tcg_temp_new_i32();
-
-        tcg_gen_movi_i32(tmp, 0);
-        tcg_gen_extrl_i64_i32(t0_32, t0);
-        tcg_gen_extrl_i64_i32(t1_32, t1);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, t0_32, tmp, t1_32, tmp);
-        tcg_gen_mov_i32(cpu_ZF, cpu_NF);
-        tcg_gen_xor_i32(cpu_VF, cpu_NF, t0_32);
-        tcg_gen_xor_i32(tmp, t0_32, t1_32);
-        tcg_gen_andc_i32(cpu_VF, cpu_VF, tmp);
-        tcg_gen_extu_i32_i64(dest, cpu_NF);
+        gen_add32_CC(dest, t0, t1);
     }
 }
 
 /* dest = T0 - T1; compute C, N, V and Z flags */
+static void gen_sub64_CC(TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
+{
+    /* 64 bit arithmetic */
+    TCGv_i64 result, flag, tmp;
+
+    result = tcg_temp_new_i64();
+    flag = tcg_temp_new_i64();
+    tcg_gen_sub_i64(result, t0, t1);
+
+    gen_set_NZ64(result);
+
+    tcg_gen_setcond_i64(TCG_COND_GEU, flag, t0, t1);
+    tcg_gen_extrl_i64_i32(cpu_CF, flag);
+
+    tcg_gen_xor_i64(flag, result, t0);
+    tmp = tcg_temp_new_i64();
+    tcg_gen_xor_i64(tmp, t0, t1);
+    tcg_gen_and_i64(flag, flag, tmp);
+    tcg_gen_extrh_i64_i32(cpu_VF, flag);
+    tcg_gen_mov_i64(dest, result);
+}
+
+static void gen_sub32_CC(TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
+{
+    /* 32 bit arithmetic */
+    TCGv_i32 t0_32 = tcg_temp_new_i32();
+    TCGv_i32 t1_32 = tcg_temp_new_i32();
+    TCGv_i32 tmp;
+
+    tcg_gen_extrl_i64_i32(t0_32, t0);
+    tcg_gen_extrl_i64_i32(t1_32, t1);
+    tcg_gen_sub_i32(cpu_NF, t0_32, t1_32);
+    tcg_gen_mov_i32(cpu_ZF, cpu_NF);
+    tcg_gen_setcond_i32(TCG_COND_GEU, cpu_CF, t0_32, t1_32);
+    tcg_gen_xor_i32(cpu_VF, cpu_NF, t0_32);
+    tmp = tcg_temp_new_i32();
+    tcg_gen_xor_i32(tmp, t0_32, t1_32);
+    tcg_gen_and_i32(cpu_VF, cpu_VF, tmp);
+    tcg_gen_extu_i32_i64(dest, cpu_NF);
+}
+
 static void gen_sub_CC(int sf, TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
 {
     if (sf) {
-        /* 64 bit arithmetic */
-        TCGv_i64 result, flag, tmp;
-
-        result = tcg_temp_new_i64();
-        flag = tcg_temp_new_i64();
-        tcg_gen_sub_i64(result, t0, t1);
-
-        gen_set_NZ64(result);
-
-        tcg_gen_setcond_i64(TCG_COND_GEU, flag, t0, t1);
-        tcg_gen_extrl_i64_i32(cpu_CF, flag);
-
-        tcg_gen_xor_i64(flag, result, t0);
-        tmp = tcg_temp_new_i64();
-        tcg_gen_xor_i64(tmp, t0, t1);
-        tcg_gen_and_i64(flag, flag, tmp);
-        tcg_gen_extrh_i64_i32(cpu_VF, flag);
-        tcg_gen_mov_i64(dest, result);
+        gen_sub64_CC(dest, t0, t1);
     } else {
-        /* 32 bit arithmetic */
-        TCGv_i32 t0_32 = tcg_temp_new_i32();
-        TCGv_i32 t1_32 = tcg_temp_new_i32();
-        TCGv_i32 tmp;
-
-        tcg_gen_extrl_i64_i32(t0_32, t0);
-        tcg_gen_extrl_i64_i32(t1_32, t1);
-        tcg_gen_sub_i32(cpu_NF, t0_32, t1_32);
-        tcg_gen_mov_i32(cpu_ZF, cpu_NF);
-        tcg_gen_setcond_i32(TCG_COND_GEU, cpu_CF, t0_32, t1_32);
-        tcg_gen_xor_i32(cpu_VF, cpu_NF, t0_32);
-        tmp = tcg_temp_new_i32();
-        tcg_gen_xor_i32(tmp, t0_32, t1_32);
-        tcg_gen_and_i32(cpu_VF, cpu_VF, tmp);
-        tcg_gen_extu_i32_i64(dest, cpu_NF);
+        gen_sub32_CC(dest, t0, t1);
     }
 }
 
-- 
2.34.1


