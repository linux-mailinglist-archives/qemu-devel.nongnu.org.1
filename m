Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE7E723E40
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TJ2-0007t5-Dy; Tue, 06 Jun 2023 05:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIu-0007nd-Ld
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIr-0004ru-Gn
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30b023b0068so4235509f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044916; x=1688636916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xvF2QmUDjhFBRGwj3rIB4i3e5VdTHFDUcn/0aso6Dbs=;
 b=yuUSB/WSC71d2O6dOJJK+ke6smC8sPoY73I2HAUyiw6fJifPkjDWBc6rw+lJF4Liim
 RvkeKpe7HPIwT5OxTqfob4uZZNYVDHaaXJp1Uj0W18k0v0cc3Fi8Q91BoN0dS10a5Fws
 rsLrWYuri3E140a2SmhUzT3gBA+uREA+ap1dV6nVt3+JSaaiId3v9yJdTatgSmWxIfTK
 DkJTl3MFUUgcjNwxnHOY6Z8E0VGU9unTQortQraV84X3WpuB2XvU+JSRGvaaNWzIjTH3
 Sdw7FnI2dya0hym+yg3aEMPSPdwwoPSGT+eGgZ8c13lhdnCA3u9micCHiMrqMmZ8nQhn
 pMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044916; x=1688636916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvF2QmUDjhFBRGwj3rIB4i3e5VdTHFDUcn/0aso6Dbs=;
 b=kVc4Gwkp6MfanuW2UNgqwvEb3SfdXwN8g6I0VvHCfVOyvRkY9z4IbGqVWFMsFGZW3k
 c6nLVw7qpgrozVOVvyNdwxXfy2Z67Da6W28p77aRrhwAZt8AhSMg0miTtE81j7vJZVKb
 hBWGUJQI0SZ1iMHllBKuEWyouupwR7+uxM18zLJRxYnhiBC6rZ2B8QUmA620REqbU5T7
 KB/zlSqkHfR0o3dMCMi05CxcrZp9Dd0l5S/IYgYU3+U764o2JxCx5ivLsrppytmz1gtO
 17GMKCYbQfJIf3w8Of2Lxd5wLX8bDNpJWXK+Qxvg82CY8XGDtfELPrTjegPPySlPMA1Z
 DEEw==
X-Gm-Message-State: AC+VfDwivilxQ810vmbNVCfoMUEs1Gbm6UyesNiNc4LH1O9ZYrXjoWaS
 YZN9crP/TUIioBv0qr750Y3jy+9H9bYC7ockOmc=
X-Google-Smtp-Source: ACHHUZ4jH/2ALedIs25bPN7N5SQFdh8AyC5wVmlB4GI6xf7PBW+XE9j+RuecsufYn7DTs+RPnu9H6w==
X-Received: by 2002:a5d:4943:0:b0:30a:e589:68a5 with SMTP id
 r3-20020a5d4943000000b0030ae58968a5mr1445293wrs.29.1686044916248; 
 Tue, 06 Jun 2023 02:48:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/42] target/arm: trap DCC access in user mode emulation
Date: Tue,  6 Jun 2023 10:48:14 +0100
Message-Id: <20230606094814.3581397-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Zhuojia Shen <chaosdefinition@hotmail.com>

Accessing EL0-accessible Debug Communication Channel (DCC) registers in
user mode emulation is currently enabled.  However, it does not match
Linux behavior as Linux sets MDSCR_EL1.TDCC on startup to disable EL0
access to DCC (see __cpu_setup() in arch/arm64/mm/proc.S).

This patch fixes access_tdcc() to check MDSCR_EL1.TDCC for EL0 and sets
MDSCR_EL1.TDCC for user mode emulation to match Linux.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: DS7PR12MB630905198DD8E69F6817544CAC4EA@DS7PR12MB6309.namprd12.prod.outlook.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c          | 2 ++
 target/arm/debug_helper.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5182ed0c911..4d5bb57f079 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -289,6 +289,8 @@ static void arm_cpu_reset_hold(Object *obj)
          * This is not yet exposed from the Linux kernel in any way.
          */
         env->cp15.sctlr_el[1] |= SCTLR_TSCXT;
+        /* Disable access to Debug Communication Channel (DCC). */
+        env->cp15.mdscr_el1 |= 1 << 12;
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index d41cc643b1b..8362462a07e 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -842,12 +842,14 @@ static CPAccessResult access_tda(CPUARMState *env, const ARMCPRegInfo *ri,
  * is implemented then these are controlled by MDCR_EL2.TDCC for
  * EL2 and MDCR_EL3.TDCC for EL3. They are also controlled by
  * the general debug access trap bits MDCR_EL2.TDA and MDCR_EL3.TDA.
+ * For EL0, they are also controlled by MDSCR_EL1.TDCC.
  */
 static CPAccessResult access_tdcc(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
     int el = arm_current_el(env);
     uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
+    bool mdscr_el1_tdcc = extract32(env->cp15.mdscr_el1, 12, 1);
     bool mdcr_el2_tda = (mdcr_el2 & MDCR_TDA) || (mdcr_el2 & MDCR_TDE) ||
         (arm_hcr_el2_eff(env) & HCR_TGE);
     bool mdcr_el2_tdcc = cpu_isar_feature(aa64_fgt, env_archcpu(env)) &&
@@ -855,6 +857,9 @@ static CPAccessResult access_tdcc(CPUARMState *env, const ARMCPRegInfo *ri,
     bool mdcr_el3_tdcc = cpu_isar_feature(aa64_fgt, env_archcpu(env)) &&
                                           (env->cp15.mdcr_el3 & MDCR_TDCC);
 
+    if (el < 1 && mdscr_el1_tdcc) {
+        return CP_ACCESS_TRAP;
+    }
     if (el < 2 && (mdcr_el2_tda || mdcr_el2_tdcc)) {
         return CP_ACCESS_TRAP_EL2;
     }
-- 
2.34.1


