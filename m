Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4BB82ACD7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:07:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssk-0001hJ-QC; Thu, 11 Jan 2024 06:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssH-0001OG-Nx
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssD-0004U9-54
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3367601a301so4553504f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971119; x=1705575919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SaqZ9xe22tumjx3dL0fsEpY2dA8696LTi7vPLEZxD+Q=;
 b=IC/jNGUnDhwXTsFZFTw/3Pxbr/4H1zw2a7xiLQMJX3o2w94PvZqO2ELH5uuknLRUtR
 b341ay4jND3Qu+43f6GpMPdTVqMIbv8XSz3UWZujUlBFZH3YwZXqvSi1g1y41OmyKhn0
 IjPJ6FhfLeD0/x675oa0XqSyadO4zwwhm1fldnpEp2fLI0jRl5S6j+d926VwX29hBmW3
 P4SiLu9OwH4R55t5XRLdfEiI9nW6fv7B0fcU1K1be/PCK2KLcT+F43JqVDSC1A8yQNlQ
 MLQ695fwyZKDLyKVRA+0DKxzzotICv5SMKXztR3cB66wb/ne2ZHbOSbsk9CPG1BVTsUl
 g9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971119; x=1705575919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SaqZ9xe22tumjx3dL0fsEpY2dA8696LTi7vPLEZxD+Q=;
 b=KlQ3PfAR6vUKJigR+VY8J/0Z97wsnUytJ6iSaBVr5nwNYPZachGVDeIsNmyvU3QQOP
 IV9UKd/CrgiCVPArgW612g+9ggaATw+4tlIrCFjP6ZD1QYo0CO7KCJNZnMO97zZDMCli
 mW0MOYczxealpB1opbzSq7PNzeWeCB0mVVrGaaFcVd7FchrLxgUSi4USx9wH4/mm0xm2
 ymi7lxv3iuvdQnDTSy7JQnK+b0SrG/yOMf3bhpTfwPZQiyMfxzLC7PNKMCs36zN64w4j
 CLZfWI01gdbB5rFevR1jlZkmo1XBXKWWZCSdDbKnY9fsPvWSdiKq85w+/zYNQwRCw5H+
 CCSg==
X-Gm-Message-State: AOJu0YwOIM9scwEfTsehTh/C60pAeYl/Q0YYkKVYl9jP6MFHrGgsipoM
 Fr2aFeVlZMYGII8ZkqlasPIvcNKX/FjmWy8zctYZpVttuj4=
X-Google-Smtp-Source: AGHT+IHOUft2it1rm1avw7SaLDMsfMYUH6+2i24LWP4tIGjzyE+VJoM8CF+6TTF0mZrNuQGohLe3+A==
X-Received: by 2002:a05:600c:158a:b0:40e:4e06:26b4 with SMTP id
 r10-20020a05600c158a00b0040e4e0626b4mr211858wmf.109.1704971119737; 
 Thu, 11 Jan 2024 03:05:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/41] target/arm: Implement VNCR_EL2 register
Date: Thu, 11 Jan 2024 11:04:53 +0000
Message-Id: <20240111110505.1563291-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

For FEAT_NV2, a new system register VNCR_EL2 holds the base
address of the memory which nested-guest system register
accesses are redirected to. Implement this register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/cpu.h    |  3 +++
 target/arm/helper.c | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d7a10fb4b61..0e48a1366bd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -547,6 +547,9 @@ typedef struct CPUArchState {
         uint64_t gpccr_el3;
         uint64_t gptbr_el3;
         uint64_t mfar_el3;
+
+        /* NV2 register */
+        uint64_t vncr_el2;
     } cp15;
 
     struct {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e3e56539594..53bd6c85990 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8131,6 +8131,28 @@ static const ARMCPRegInfo fgt_reginfo[] = {
       .access = PL2_RW, .accessfn = access_fgt,
       .fieldoffset = offsetof(CPUARMState, cp15.fgt_exec[FGTREG_HFGITR]) },
 };
+
+static void vncr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                       uint64_t value)
+{
+    /*
+     * Clear the RES0 bottom 12 bits; this means at runtime we can guarantee
+     * that VNCR_EL2 + offset is 64-bit aligned. We don't need to do anything
+     * about the RESS bits at the top -- we choose the "generate an EL2
+     * translation abort on use" CONSTRAINED UNPREDICTABLE option (i.e. let
+     * the ptw.c code detect the resulting invalid address).
+     */
+    env->cp15.vncr_el2 = value & ~0xfffULL;
+}
+
+static const ARMCPRegInfo nv2_reginfo[] = {
+    { .name = "VNCR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 2, .opc2 = 0,
+      .access = PL2_RW,
+      .writefn = vncr_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vncr_el2) },
+};
+
 #endif /* TARGET_AARCH64 */
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -9614,6 +9636,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_arm_cp_regs(cpu, rme_mte_reginfo);
         }
     }
+
+    if (cpu_isar_feature(aa64_nv2, cpu)) {
+        define_arm_cp_regs(cpu, nv2_reginfo);
+    }
 #endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
-- 
2.34.1


