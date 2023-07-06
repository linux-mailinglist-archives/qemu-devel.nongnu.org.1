Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2D749D9B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzc-0005HS-He; Thu, 06 Jul 2023 09:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzM-0004re-1E
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzE-0000sp-Ud
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so7637225e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649919; x=1691241919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U9CeGIttj7agKc+IG3L3VXz8hzpfa363h3PPFaSP8BM=;
 b=hGr+Oivwm0S4HtGd3ZiUwg5XZK2WTrzCsqT5IqO3tPDxtj6kDwL5iPz+DmnRUh40fC
 5UaY7iqBHdnTzjUioh1PqgY8hRZN/uXPAKdQ0pP9nQDNSU8jdB4xZ55LkeqK+1ep5rPC
 LgcllW4V/OjtoJ3I9b6fdfw89kMfGYZw1fgK7Zs+AHoc8EI6cBYxzrNrqFSE7CjSFkjk
 JwtmIHqQLCLosbVOTsU1pMK1HLedbI2o25DQ4RyxyuDh9J5o45Es1YoU26J53G+cNVWl
 Xp/57OpguJwT85h3my/eyi6UEm3dGeWvz8NiGVioIEpydWRpVOhPCAS0GUdVmmJlN4Ss
 HadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649919; x=1691241919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9CeGIttj7agKc+IG3L3VXz8hzpfa363h3PPFaSP8BM=;
 b=e+8y02PSJuZ3s7S3ZqiyVpZClvUjNnJrAQJeluRf3AeaktaAss7RLyD5f2pf7g84DG
 Lo1biglsXW40oKO9IifVRN4qlETfZP7Wm75C+kiXl2UFiffHgkHIVFQYvt3QPwK9FE+M
 A6cdL1dBfVrnQAR4kb1abC41Pa9Ehat4u6z/aLeNSm/xQV/7mT58smNxs4i7h5dBhrVE
 4qmVDaCFKxb+fgP1XHTMf+Yq/SviJGGX6MuURw8nK5nseDJinT6eCJSMlcfU4kt1d/X+
 gifUdeSd7JwG4zDquAZu23hWxUdPi3wR51cVIFl28XC5IimZCuSCB2NzZIfM3zxfCVKU
 DTsA==
X-Gm-Message-State: ABy/qLbAHFZ+bgYLTdad7NK3sipdv3jwladVDHdt7NNCnkOzzK0X/W5Y
 6nnSXfO8Bq+aoS0PqzeuyEPXGs0n1/EFNbrW628=
X-Google-Smtp-Source: APBJJlFVTFzUaPxVukiXaEiDHIn2wMeRWeMwrlCwh7EDz6hnD2M4EthM4H3nfowFB+PCJLjgXCeBdw==
X-Received: by 2002:a7b:c043:0:b0:3f9:c04:e76c with SMTP id
 u3-20020a7bc043000000b003f90c04e76cmr1449802wmc.28.1688649919505; 
 Thu, 06 Jul 2023 06:25:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/14] target/arm: Suppress more TCG unimplemented features in
 ID registers
Date: Thu,  6 Jul 2023 14:25:10 +0100
Message-Id: <20230706132512.3534397-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

We already squash the ID register field for FEAT_SPE (the Statistical
Profiling Extension) because TCG does not implement it and if we
advertise it to the guest the guest will crash trying to look at
non-existent system registers.  Do the same for some other features
which a real hardware Neoverse-V1 implements but which TCG doesn't:
 * FEAT_TRF (Self-hosted Trace Extension)
 * Trace Macrocell system register access
 * Memory mapped trace
 * FEAT_AMU (Activity Monitors Extension)
 * FEAT_MPAM (Memory Partitioning and Monitoring Extension)
 * FEAT_NV (Nested Virtualization)

Most of these, like FEAT_SPE, are "introspection/trace" type features
which QEMU is unlikely to ever implement.  The odd-one-out here is
FEAT_NV -- we could implement that and at some point we probably
will.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230704130647.2842917-2-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 822efa5b2c1..69e2bde3c2d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2069,13 +2069,38 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     if (tcg_enabled()) {
         /*
-         * Don't report the Statistical Profiling Extension in the ID
-         * registers, because TCG doesn't implement it yet (not even a
-         * minimal stub version) and guests will fall over when they
-         * try to access the non-existent system registers for it.
+         * Don't report some architectural features in the ID registers
+         * where TCG does not yet implement it (not even a minimal
+         * stub version). This avoids guests falling over when they
+         * try to access the non-existent system registers for them.
          */
+        /* FEAT_SPE (Statistical Profiling Extension) */
         cpu->isar.id_aa64dfr0 =
             FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMSVER, 0);
+        /* FEAT_TRF (Self-hosted Trace Extension) */
+        cpu->isar.id_aa64dfr0 =
+            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEFILT, 0);
+        cpu->isar.id_dfr0 =
+            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, TRACEFILT, 0);
+        /* Trace Macrocell system register access */
+        cpu->isar.id_aa64dfr0 =
+            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEVER, 0);
+        cpu->isar.id_dfr0 =
+            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPTRC, 0);
+        /* Memory mapped trace */
+        cpu->isar.id_dfr0 =
+            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, MMAPTRC, 0);
+        /* FEAT_AMU (Activity Monitors Extension) */
+        cpu->isar.id_aa64pfr0 =
+            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, AMU, 0);
+        cpu->isar.id_pfr0 =
+            FIELD_DP32(cpu->isar.id_pfr0, ID_PFR0, AMU, 0);
+        /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
+        cpu->isar.id_aa64pfr0 =
+            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 0);
+        /* FEAT_NV (Nested Virtualization) */
+        cpu->isar.id_aa64mmfr2 =
+            FIELD_DP64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV, 0);
     }
 
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
-- 
2.34.1


