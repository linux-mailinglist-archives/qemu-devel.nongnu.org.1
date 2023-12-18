Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FE816C7A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsf-0007bI-AK; Mon, 18 Dec 2023 06:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsQ-00079O-Qs
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:38 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsD-0003Py-24
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:37 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3365f09de18so1649552f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899203; x=1703504003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J+EE0+mnHPHGCOMaG+C9/pWFxkc9Xq3u5HldCrY3Xbg=;
 b=DGHhG9lEckTZhGquDpAFOCJ595TFNdttLrhaL6ZCEZy+DhrDeP46khkaOib0DPVDAO
 uLfrbyRhhg3NA5mAUQaDvVsggsScLROvEbhioEXXPv8vvUBEqK/69JVh4UNQt8hi2TvS
 P7xMW2SYgjt2ZJQLYgX/q7fY2VgMU4ptbT+d6NsRimgzOn/mApG2OQC7aMr8wRKNCJ2N
 a8Sg187wENN+YonMUjWwQ84+425KGwbhhYtn80TOGBYA8+boH0XAMWVvG+DovAWBdZso
 pGLknKc8j8hehJLrMaMUwJUbGLJkNVueZ/InVoAVPPcXG3uwYi9YUiXSVBkuVI1EfqHZ
 qvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899203; x=1703504003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+EE0+mnHPHGCOMaG+C9/pWFxkc9Xq3u5HldCrY3Xbg=;
 b=tHUPdmIfSKxqYpJhWNK0IuHsewNipl/awtWHzFVKfSx+G+0VWLp0k0cm1trPgBKTQr
 vSnCAtW0gB6L/NCTFsRZ7G0SSVXT1cM1KKIlrdt6hr9RMyORGAl9I36nabrnU8nzur7v
 IRsIi+rjbz/aGKhEL0o0mQEimwrGMyko0AjTFwhOsjOoLxak15UqTuL+ifo5AVw/LhR8
 5YZ1rOuYWlQfGGg40RK10lKcG1moiW75Q4bnC6sxf29f7BEH+r3KMuCpCRHbUfIWMWE5
 xL6gBTGdidjJmbc5HUjVjJ8kkAt1EhJsDshvjXZJQT2wx+z+NprFX8qFRU1cYzR2/PZa
 mCMw==
X-Gm-Message-State: AOJu0YyQvE0uyWTiqq+QVnPAF0blr7PJaiIMi1/Oll5K67bDP1OFqBMR
 hxo/tkVhJAsX+IBJWre8C5Z3PdfoouAvmsPfDmg=
X-Google-Smtp-Source: AGHT+IHGPhJy1+VgbdKPL6yWcZbGJLHFluCNWz79naQmHBW9AA0gXThJbiN3rS8BOS1kCDVELOSgbA==
X-Received: by 2002:a05:6000:1961:b0:336:6ba1:556e with SMTP id
 da1-20020a056000196100b003366ba1556emr422026wrb.4.1702899203633; 
 Mon, 18 Dec 2023 03:33:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 35/35] target/arm: Add FEAT_NV2 to max, neoverse-n2,
 neoverse-v1 CPUs
Date: Mon, 18 Dec 2023 11:33:05 +0000
Message-Id: <20231218113305.2511480-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Enable FEAT_NV2 on the 'max' CPU, and stop filtering it out for
the Neoverse N2 and Neoverse V1 CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu.c              | 5 -----
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index d827b42de79..f67aea2d836 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -64,6 +64,7 @@ the following architecture extensions:
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_NV (Nested Virtualization)
+- FEAT_NV2 (Enhanced nested virtualization support)
 - FEAT_PACIMP (Pointer authentication - IMPLEMENTATION DEFINED algorithm)
 - FEAT_PACQARMA3 (Pointer authentication - QARMA3 algorithm)
 - FEAT_PACQARMA5 (Pointer authentication - QARMA5 algorithm)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d1d592609eb..65dc88ba864 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2243,11 +2243,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
         cpu->isar.id_aa64pfr0 =
             FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 0);
-        /* FEAT_NV2 (Enhanced Nested Virtualization support) */
-        if (FIELD_EX64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV) > 1) {
-            cpu->isar.id_aa64mmfr2 =
-                FIELD_DP64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV, 1);
-        }
     }
 
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 93f040e6e96..5fba2c0f040 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1204,7 +1204,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* FEAT_UAO */
     t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
     t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* FEAT_LVA */
-    t = FIELD_DP64(t, ID_AA64MMFR2, NV, 1);       /* FEAT_NV */
+    t = FIELD_DP64(t, ID_AA64MMFR2, NV, 2);       /* FEAT_NV2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* FEAT_TTST */
     t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* FEAT_LSE2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* FEAT_IDST */
-- 
2.34.1


