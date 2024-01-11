Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF0882ACFA
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssW-0001Rl-2m; Thu, 11 Jan 2024 06:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssN-0001PW-9b
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssI-0004Z7-2m
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:30 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33677fb38a3so4874139f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971124; x=1705575924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AoPQ2VhrOauUZxXZpUbSBMmD7E3ILO63LwCrzpMDSt8=;
 b=ITIOxvywMw7zpBoPRuxxeCHqdygMdY+MSvbAHG9SG0MAE33B9oAFlFApIHmfrctb0j
 Sf19gl7y7SMms0PgTfENZ4YKiQF6L86RJQoYtNYtsfN3hU0SD/VFDTsqVRSrBhQIt0VW
 poRb11IJULhjV35r/prHfvhhsN1N6oL9k/t81NLcm8D9WJxTpP/iT9vUh/PdCC6FthMA
 Vx5jAG5ZvgVhFOBsdvJ7E4KyUyiHO7o+DWoxV9oAX3FN1qbVj/JFNlMlXeTBIi89jdrM
 /wzB/riSYfEIHNxJdajYmFT0IIIRQHpN8WVBawBrB4EgHT/HXeD84B6O8w7gnPgBDN6h
 EY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971124; x=1705575924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AoPQ2VhrOauUZxXZpUbSBMmD7E3ILO63LwCrzpMDSt8=;
 b=r/AhRMNVUBjIKvW74YUWU+atOeIXrLCzexN5iWRyZWic9sedi4YO1sPVxqNQ5nD2DO
 uMdCPyz8tvRM7nrVDYI0fBd00L/WwjP2uSIaOh4ENKy1HfHgyZDQ0afCOROMI8s7+JSm
 cOR9i4Ajepn4WnWHFaARV3SxdHGOLNdV7Gt8fh4z3f5YOAsWWJNlzggodaONhai8f5ae
 DeUgCNhZUbqCOztTr8kYIkVERJv6oBwqC199CslQh3EqREOAqdPIelJLY+UGEy8pSfNa
 1M4hBhptYkfO2ah0tj8hLu3ljXjnUdAE2mq8qD7NI7p1MRNMixQL3TwrPxqtYzaZjgXb
 up3w==
X-Gm-Message-State: AOJu0YwD75YaYdPIgDHQxvNkIB+8rD2LTkDI2y1KtYbvOQkoy9a6ByFH
 bY01wMJS9KOU8NfzKb0PJadXv7VbZhY7Wyxayg6dGx8edm8=
X-Google-Smtp-Source: AGHT+IH7dGrEWBAsrZm8WfGyLEGWPtxAbGI1iVvka8+Hk/oEoryHVsroecxPDirFfD1ZxyvGx53Ckg==
X-Received: by 2002:adf:ef43:0:b0:336:6797:485c with SMTP id
 c3-20020adfef43000000b003366797485cmr511605wrp.27.1704971124763; 
 Thu, 11 Jan 2024 03:05:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/41] target/arm: Add FEAT_NV2 to max, neoverse-n2,
 neoverse-v1 CPUs
Date: Thu, 11 Jan 2024 11:05:05 +0000
Message-Id: <20240111110505.1563291-42-peter.maydell@linaro.org>
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

Enable FEAT_NV2 on the 'max' CPU, and stop filtering it out for
the Neoverse N2 and Neoverse V1 CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
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
index 7d763786d88..826ce842c09 100644
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


