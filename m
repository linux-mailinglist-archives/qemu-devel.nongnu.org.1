Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C43747243
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:08:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfkA-0001S2-1f; Tue, 04 Jul 2023 09:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfk6-0001Qw-M5
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:06:54 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfk4-0003UR-PJ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:06:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso6341106f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688476011; x=1691068011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o63W7D3dZ+IsTd+CBM4Ktiq6kGzSxYbY5hWwGmlhVKI=;
 b=o/7LlAin+0uYGz9C3AJ7WPZGIXtjSpAzH/8HH/LAwM1WX1i5PviJvpWlvnP3DTGR97
 Smlm5NYu6jGCyEW4mVMcyq+B1W9v93SidGGnJrq5SX9SxR+R71u40KlCcnzFjyMC7Kni
 PPW2A5DWNPx5dWaxXJFcpldgxa5kuM8nvDxisIDQvnzIZBiYjYbrzezW7zhTZUl7XbJa
 WD0qq8yFHXI1oxtEGl7I17mKy3ZriRgGR+azn3ClGPxFTbYv4QbwstWDjFRNRNivC/MO
 il3w3JyT5qfLtwbDeMuqKpl3so+xLVqmfZacU2mSEyFoMwLMzadggjIm69+NAtUmRA24
 Oktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476011; x=1691068011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o63W7D3dZ+IsTd+CBM4Ktiq6kGzSxYbY5hWwGmlhVKI=;
 b=OcdZvtGHnsbGXvf23tTOPoQEP7JxioCXewELl4R4qQQuHEtaR0w+DM4MpfhSUFFPOq
 hT3Bw/KhWL+FvnssrIELDElmEj2fztjqlbxJN2ASZkbNcvdAeFEeDpMrnvrK1FVOxqpj
 knjfzQrwNLXbXBXYkqsYCQCX4tULi1ggkYuZcTcAveDMxDSNtCLKW4iYnid0xiM02q6F
 h+OQ8sJAZzfZqIfjQRclcMfqCfIhuKlUZg9ZWpy4G8bc5CvqekBqcggPXvaVC8inrFjZ
 2RLwBHU9cnuPjIxArmpvGqiZ1k0cs5o7Tzo9m43AQYNoM4nZAHNxlVehLBYYoRx6xOed
 AQpQ==
X-Gm-Message-State: ABy/qLbWMgwPDqFJOve46G824D/IcydEeJWEKdG6A/42u+NBdFQn4k3W
 EggWIf5bnFyyh7PT9aLBPfg8nA==
X-Google-Smtp-Source: APBJJlF7BaP6b9dgU8KsCIJ+jKCy0SSdY8flCqiCU8Exh01HZVVuFM41AHdRiJBxIUXlKW9+AKzOwg==
X-Received: by 2002:a5d:4445:0:b0:314:3a3d:5d1f with SMTP id
 x5-20020a5d4445000000b003143a3d5d1fmr4353699wrr.19.1688476010311; 
 Tue, 04 Jul 2023 06:06:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a10-20020adfeeca000000b00314103d6daesm15834737wrp.47.2023.07.04.06.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 06:06:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/arm: Suppress more TCG unimplemented features in
 ID registers
Date: Tue,  4 Jul 2023 14:06:46 +0100
Message-Id: <20230704130647.2842917-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704130647.2842917-1-peter.maydell@linaro.org>
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
---
 target/arm/cpu.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a1e77698ba2..7eb7e909097 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2048,13 +2048,38 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
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


