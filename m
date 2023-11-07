Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D17E41C3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Mzw-0004DH-HE; Tue, 07 Nov 2023 09:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzr-0004Bw-Ht
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:03 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzl-0007Xq-LN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40859c466efso41702375e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367036; x=1699971836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJ73BpswQluAmFSEM4Kf5oYPeB5xmrt2szkO33mu3lQ=;
 b=vL+05MG3TG1xK0L5/XtUWmm5ti21hJt8b1mfYXh3QxqChZ5vcuIKuQ1QvdfypdX6lJ
 dteZQNiDrJIJtuqACkfNXosA34bKlrphVE6sLwxnc3tcsXTFVzBerPtxNzdjtfpg9lsN
 cjGeNXeHLhEwyT2FMtWMeJ2EVGqWDCZXuWfvAq+9MXoSkGsjW1JsQZWq4+T1ZUjeW/Qp
 1ut8xyqwiEtsu4WlljEfQkr0iEp+aYX+EzKHMLejPc1xl/TU7Bq6KnLpU4q/qNEg7hhu
 YC0SQkf6PN+1pt5OiTd4iHslKuEgDniTTjojeD8sfjm5KZmJ2h09ffN53SVybREYFIIV
 AT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367036; x=1699971836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJ73BpswQluAmFSEM4Kf5oYPeB5xmrt2szkO33mu3lQ=;
 b=dKqL/Z3DSB4shQ+8QjWhc5cbjKqhvLl3MpnpLnKMaU250G33AtCq1YKl4Yc+d2DLp6
 yu5xhTOWrQwVxWLJLdam7Mx29j+PgcnP2bjMPJkNWW38cvinfIGJU+Ca8I4bUGLG5WDF
 tl8ymMaHv+/bad7KtQ7JcI00IMNqL74t9w4aLvYvBdTB3K/4dU8t81XSYegYpbInVkFQ
 qZjWANN0TZCz+nOtsD06y5jTlHgdFUbjxM6ghL3Zb5lZHZwNOw/KXI2Zw5EQ9BjpnPYG
 9XPcOw/0GTmSuFmc+hYJYMMBpvO3GxxlU9AnPY2a2U32VcQt0EjGSyvb3bm9Qd2whJ03
 1jbg==
X-Gm-Message-State: AOJu0Yyt4b+JskoOxz4/er9wP2iiKzhihb/sNX9jvDSDLjJsriTWPDtV
 SGBDqmrXIGByk0/uu6qqlm1M9g==
X-Google-Smtp-Source: AGHT+IHE4KNYPhuOvdaTyJCWC6VhIPnSENhQ4pPNx8XnkxKjso9qigbi/Ex1YyVqMRILQLOZL4Nx2Q==
X-Received: by 2002:a05:600c:1c9d:b0:407:5ad0:ab5b with SMTP id
 k29-20020a05600c1c9d00b004075ad0ab5bmr2117838wms.8.1699367036027; 
 Tue, 07 Nov 2023 06:23:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4cc7000000b0032fa66bda58sm2495423wrt.101.2023.11.07.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DEF596573F;
 Tue,  7 Nov 2023 14:23:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 03/23] target/arm: mark the 32bit alias of PAR when LPAE enabled
Date: Tue,  7 Nov 2023 14:23:34 +0000
Message-Id: <20231107142354.3151266-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

We also mark it ARM_CP_NO_GDB so we avoid duplicate PAR's in the
system register XML we send to gdb.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20231107105145.2916124-1-alex.bennee@linaro.org>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5dc0d20a84..6acd87f5b9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3722,20 +3722,6 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 #endif
 
-static const ARMCPRegInfo vapa_cp_reginfo[] = {
-    { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .resetvalue = 0,
-      .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
-                             offsetoflow32(CPUARMState, cp15.par_ns) },
-      .writefn = par_write },
-#ifndef CONFIG_USER_ONLY
-    /* This underdecoding is safe because the reginfo is NO_RAW. */
-    { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
-      .access = PL1_W, .accessfn = ats_access,
-      .writefn = ats_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
-#endif
-};
-
 /* Return basic MPU access permission bits.  */
 static uint32_t simple_mpu_ap_bits(uint32_t val)
 {
@@ -8904,6 +8890,27 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, generic_timer_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_VAPA)) {
+        ARMCPRegInfo vapa_cp_reginfo[] = {
+            { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
+              .access = PL1_RW, .resetvalue = 0,
+              .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
+                                     offsetoflow32(CPUARMState, cp15.par_ns) },
+              .writefn = par_write},
+#ifndef CONFIG_USER_ONLY
+            /* This underdecoding is safe because the reginfo is NO_RAW. */
+            { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
+              .access = PL1_W, .accessfn = ats_access,
+              .writefn = ats_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
+#endif
+        };
+
+        /*
+         * When LPAE exists this 32-bit PAR register is an alias of the
+         * 64-bit AArch32 PAR register defined in lpae_cp_reginfo[]
+         */
+        if (arm_feature(env, ARM_FEATURE_LPAE)) {
+            vapa_cp_reginfo[0].type = ARM_CP_ALIAS | ARM_CP_NO_GDB;
+        }
         define_arm_cp_regs(cpu, vapa_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_CACHE_TEST_CLEAN)) {
-- 
2.39.2


