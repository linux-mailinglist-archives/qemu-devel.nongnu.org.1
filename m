Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A87327A9859
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcQ-00023I-P8; Thu, 21 Sep 2023 13:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcL-00020x-Dc
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcG-0007f9-Kp
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401187f8071so8439885e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317846; x=1695922646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P2MjKlOVigf+xWAScg3HKbXgKT5sjpXRoKt4/wbnDZI=;
 b=FaKgVP2qT3U0DphZ+coVFDGFUCSxRfgOZrJaCgP7UAFtBeSYsHele6DJCB42rBAOHY
 dsC3mkqbSkybtBzy7ctcPFojenpJxb+81HWW0UyXTpOvf7IjlDt9Nv2gguXC+FdURwhI
 BbpcnsdnEYe8x3CCqyLzKbaRNkI8zFz386ol5Cktl3eb+533BdGaeX7w/D25ZXIcTz2N
 faTQQCVhfHFaft4ccuTYfxANTVpa93/MaqOwiaxnZMjFR7xSnGfXAfjQtAWPcPp4JPhP
 p+YDFIT+ZjaXyyMopbfyBweFTLHEf2vVkI07E4+S3v01HR5yxvbmYW2x3aLpR+yO+Ilk
 MpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317846; x=1695922646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2MjKlOVigf+xWAScg3HKbXgKT5sjpXRoKt4/wbnDZI=;
 b=E7ZKZoDaljO6fygHZcyAqJ/+FxFy6RCLxzGYaX1elDrG3qRIoXR5D7gjJzc1FmRz2S
 xMmR/Nch1dXOxzInCO2U7lWBbIFdm9S+epTN2RmWHwYU5m7fEb8UFhaBX7SqYMLKWaX6
 /jwsOIniD1M/JZOaeAhKQ8s0Lnha2m1a/DTzFpSNSOgWi0NW0twTjm1qX18Mop+XW9aB
 JEDPSLco4bZigqMAhgnYRaYrmaIJMopxvZDq3hqW2BJRMtTlfQA2VvLgxFF60SjSEcmy
 Jgt7M+xRZUpWwqDUKjZabiwisHgGtiFX3lQk+O7loK91iYj3/pO5zGIdJISndGx3X9HC
 zlaA==
X-Gm-Message-State: AOJu0YzJ6khf7cqym3Jeyk4PxdEnYyT9+PT2RpAgKVhq+plSQii/Ob0t
 RlVXvg04ILryVmOgoztJYv/3eBmLcrSv7Ug00ec=
X-Google-Smtp-Source: AGHT+IFdZI3GE6KqN7Moq0Mhq42Orq46VZx4L5iYKMDggAU7ZMfsW2vFfStXZ1ZWKWgwfGZTzI7uig==
X-Received: by 2002:a05:600c:25a:b0:3fe:4341:a5aa with SMTP id
 26-20020a05600c025a00b003fe4341a5aamr235068wmj.8.1695317846023; 
 Thu, 21 Sep 2023 10:37:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/30] target/arm: Update user-mode ID reg mask values
Date: Thu, 21 Sep 2023 18:36:58 +0100
Message-Id: <20230921173720.3250581-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

For user-only mode we reveal a subset of the AArch64 ID registers
to the guest, to emulate the kernel's trap-and-emulate-ID-regs
handling. Update the feature bit masks to match upstream kernel
commit a48fa7efaf1161c1c.

None of these features are yet implemented by QEMU, so this
doesn't yet have a behavioural change, but implementation of
FEAT_MOPS and FEAT_HBC is imminent.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c         | 11 ++++++++++-
 tests/tcg/aarch64/sysregs.c |  4 ++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3b22596eabf..594985d7c8c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8621,11 +8621,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64ZFR0_F64MM_MASK },
             { .name = "ID_AA64SMFR0_EL1",
               .exported_bits = R_ID_AA64SMFR0_F32F32_MASK |
+                               R_ID_AA64SMFR0_BI32I32_MASK |
                                R_ID_AA64SMFR0_B16F32_MASK |
                                R_ID_AA64SMFR0_F16F32_MASK |
                                R_ID_AA64SMFR0_I8I32_MASK |
+                               R_ID_AA64SMFR0_F16F16_MASK |
+                               R_ID_AA64SMFR0_B16B16_MASK |
+                               R_ID_AA64SMFR0_I16I32_MASK |
                                R_ID_AA64SMFR0_F64F64_MASK |
                                R_ID_AA64SMFR0_I16I64_MASK |
+                               R_ID_AA64SMFR0_SMEVER_MASK |
                                R_ID_AA64SMFR0_FA64_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
@@ -8676,7 +8681,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .exported_bits = R_ID_AA64ISAR2_WFXT_MASK |
                                R_ID_AA64ISAR2_RPRES_MASK |
                                R_ID_AA64ISAR2_GPA3_MASK |
-                               R_ID_AA64ISAR2_APA3_MASK },
+                               R_ID_AA64ISAR2_APA3_MASK |
+                               R_ID_AA64ISAR2_MOPS_MASK |
+                               R_ID_AA64ISAR2_BC_MASK |
+                               R_ID_AA64ISAR2_RPRFM_MASK |
+                               R_ID_AA64ISAR2_CSSC_MASK },
             { .name = "ID_AA64ISAR*_EL1_RESERVED",
               .is_glob = true },
         };
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index d8eb06abcf2..f7a055f1d5f 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -126,7 +126,7 @@ int main(void)
      */
     get_cpu_reg_check_mask(id_aa64isar0_el1, _m(f0ff,ffff,f0ff,fff0));
     get_cpu_reg_check_mask(id_aa64isar1_el1, _m(00ff,f0ff,ffff,ffff));
-    get_cpu_reg_check_mask(SYS_ID_AA64ISAR2_EL1, _m(0000,0000,0000,ffff));
+    get_cpu_reg_check_mask(SYS_ID_AA64ISAR2_EL1, _m(00ff,0000,00ff,ffff));
     /* TGran4 & TGran64 as pegged to -1 */
     get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(f000,0000,ff00,0000));
     get_cpu_reg_check_mask(id_aa64mmfr1_el1, _m(0000,f000,0000,0000));
@@ -138,7 +138,7 @@ int main(void)
     get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
     get_cpu_reg_check_zero(id_aa64dfr1_el1);
     get_cpu_reg_check_mask(SYS_ID_AA64ZFR0_EL1,  _m(0ff0,ff0f,00ff,00ff));
-    get_cpu_reg_check_mask(SYS_ID_AA64SMFR0_EL1, _m(80f1,00fd,0000,0000));
+    get_cpu_reg_check_mask(SYS_ID_AA64SMFR0_EL1, _m(8ff1,fcff,0000,0000));
 
     get_cpu_reg_check_zero(id_aa64afr0_el1);
     get_cpu_reg_check_zero(id_aa64afr1_el1);
-- 
2.34.1


