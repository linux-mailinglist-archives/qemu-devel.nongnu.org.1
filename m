Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5591382AD00
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssV-0001Rk-UF; Thu, 11 Jan 2024 06:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssE-0001OB-EX
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:25 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssC-0004Tf-2J
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:21 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33748c4f33dso5005904f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971118; x=1705575918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aNZhB04G9aaU3Fn26zvvYto3KEIbf3D7ndy2bXnEsD0=;
 b=qEIODOWJ5IZ1QXSeyYogtsKTsAJwVaTBlwyCabH5jzRSb873qVMJ5cMlh64HPVBOil
 9Ik/Vv3VACXkMgu5WbnHgq5z82EmWQ+//Hf0EDfJ6h73Wog7Lh0uMG8gE71wrUFrSsfA
 ME9UjoOVL/T1QxplreSPdaUQ7HbKlPEqjlm2KLcNQA3+XyvOmx0UoppdLUFd3Jd847uD
 T8o16UqwoHw5jvmFiJpdB/p1J9roWveLoYztsAgb8C6AwYL6K6U+DIhW01e8tvbdUJ1s
 TeKxcCFPG8ZK/sTj+GqOGODv5E0dhKr9qes/LoYBOQeIuglPdlUFFEAL1G+X0u1jND8R
 3sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971118; x=1705575918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNZhB04G9aaU3Fn26zvvYto3KEIbf3D7ndy2bXnEsD0=;
 b=XUL+rOO8WezrAe4ESHpwKCyxVBvhOboGbq/QOIMENq6LVbqA0hyoGD//sfniuDbStQ
 6r8OMhAJdpWrTt9C2JIKAIH8gJ7EBXzmwovFMHGuG1cvvTZ9PmWZeCgNx4Xl7bULEtax
 AYA8CsCBtvyEL45vj2iRH+B8j11hiuSOD8PcMUBlWjQUH71kNOfnRv6gfEKoqUN8UVbP
 vPdXEfS7LvC7wX0jOzUi4ArXMqUtrPafuthOIE9+rXC9a2+mW2gQ5DJ3ppLPTYKU/YyB
 EnY6vo25GLxMqd8jVy56Iyvt1oIhHk/2M1J89G2TMCp8rZiNsSnN2KhMqhEZa7c/uceo
 5iuQ==
X-Gm-Message-State: AOJu0YwpMqqGIWS15gPZ1kY55U0KRjXmCRSXvWkG06ITQ1QsvwSbZXLB
 y2RR5bC1bIVA2n6wj61u/tK1F0M+iMZYKuhMLUe6ISprmrA=
X-Google-Smtp-Source: AGHT+IEtLfACFX0de7KYuVTVL3HO2hHHI1LloB7c2nPQaKsGdO7+moFbur33ZjxcXpF87zPzBXSMOA==
X-Received: by 2002:adf:ca0f:0:b0:336:76de:c171 with SMTP id
 o15-20020adfca0f000000b0033676dec171mr420446wrh.62.1704971118719; 
 Thu, 11 Jan 2024 03:05:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/41] target/arm: Add FEAT_NV to max, neoverse-n2,
 neoverse-v1 CPUs
Date: Thu, 11 Jan 2024 11:04:51 +0000
Message-Id: <20240111110505.1563291-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
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

Enable FEAT_NV on the 'max' CPU, and stop filtering it out for the
Neoverse N2 and Neoverse V1 CPUs.  We continue to downgrade FEAT_NV2
support to FEAT_NV for the latter two CPU types.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu.c              | 8 +++++---
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0b604f90059..d827b42de79 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -63,6 +63,7 @@ the following architecture extensions:
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
+- FEAT_NV (Nested Virtualization)
 - FEAT_PACIMP (Pointer authentication - IMPLEMENTATION DEFINED algorithm)
 - FEAT_PACQARMA3 (Pointer authentication - QARMA3 algorithm)
 - FEAT_PACQARMA5 (Pointer authentication - QARMA5 algorithm)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1c8b7874823..c15ad52ab3d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2238,9 +2238,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
         cpu->isar.id_aa64pfr0 =
             FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 0);
-        /* FEAT_NV (Nested Virtualization) */
-        cpu->isar.id_aa64mmfr2 =
-            FIELD_DP64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV, 0);
+        /* FEAT_NV2 (Enhanced Nested Virtualization support) */
+        if (FIELD_EX64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV) > 1) {
+            cpu->isar.id_aa64mmfr2 =
+                FIELD_DP64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV, 1);
+        }
     }
 
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 40e7a45166f..93f040e6e96 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1204,6 +1204,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* FEAT_UAO */
     t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
     t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* FEAT_LVA */
+    t = FIELD_DP64(t, ID_AA64MMFR2, NV, 1);       /* FEAT_NV */
     t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* FEAT_TTST */
     t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* FEAT_LSE2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* FEAT_IDST */
-- 
2.34.1


