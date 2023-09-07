Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1C797650
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHU4-0000u1-0N; Thu, 07 Sep 2023 12:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTz-0000ps-FH
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTu-0001zd-BA
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso1556007f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102624; x=1694707424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XiMac+EyjFmDHh8KtlpnhJCEzMAlxr5N/iXDwj0li1s=;
 b=TqWvO+oplSAHBWYAFHQC2YjCG7Q6vTNnd5rG8/bhnZEXiT36ATUbLy/eE0SEzLxivT
 C4Rd0jFwl+vRcKL0dKJI+fADK8W6Ar+evFRSoJcjAWbu2oKDi+dKTfAxYyuak/iXkSOe
 KnS0l2Y7a8OjpJchWhSEvXF9gqC8lXdaSVEz+jVmFEL0jjGGJCsmSUiiVS9wBB6J8+1W
 T73L58tvO4/WVzkSPKgGFZ74As0xu5xXU/3iWo7suyY9HZ0CJj45T6djQ21JS7eEGf2U
 7CZ6M9OLCIn2WvsiMylKO6zhbAZk/+/WNct17a7KQLefh4jcEmGQHWAOBYOKhsI49Pq5
 ArQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694102624; x=1694707424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XiMac+EyjFmDHh8KtlpnhJCEzMAlxr5N/iXDwj0li1s=;
 b=ku+2zIHh7DYDOszeekI82UOLPRwAUQnfaE2s1UfVOaIwVqxmqRKHvyYBrC1iUxPivH
 yTUpAo2FuQ0qkgF9QHat5Z7qLQCQyi6EPy2GoxMC2DPCzpFgUv+m2OGEdRRpGZqsoK5C
 guP7bZpGCeYKleHnFIMQTLC64Wq6KgNUb0PUzTp9vfTUK+8Mmi8ppHS16J2ohkwwKVFc
 B5H9jED1c8iiTYEr9RHnaB1Hdm1zDk5mEdpOL6a3/UPVtHuOOy3NOAhG478e/tGftOG9
 bnRjOEUJ6HyqbTnVcPXt/tu+5JaCNhjJL1MKmOq11njAWgpFIDatYxb0Xt0nExfBfHXH
 mdWw==
X-Gm-Message-State: AOJu0YxraBtryztha+BANJ1fJ/RnELxWn/plHNRNZOQjgBQqIKxJohNc
 YIK1wEvYSlDLgcCwsw1aY2AuCXue4YFV9qpTJ3A=
X-Google-Smtp-Source: AGHT+IFm5xfDBN14+61oTxLFaMxiZTDVObrw5m6+t/O7bp+UUHIMDhQ7aiOsMlazL2m3mX77jcaZCQ==
X-Received: by 2002:adf:f8cf:0:b0:317:6734:c2ae with SMTP id
 f15-20020adff8cf000000b003176734c2aemr2372884wrq.11.1694102624048; 
 Thu, 07 Sep 2023 09:03:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/14] target/arm: Add ID_AA64ISAR2_EL1
Date: Thu,  7 Sep 2023 17:03:29 +0100
Message-Id: <20230907160340.260094-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
[PMM: drop the HVF part of the patch and just comment that
 we need to do something when the register appears in that API]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     | 1 +
 target/arm/helper.c  | 4 ++--
 target/arm/hvf/hvf.c | 1 +
 target/arm/kvm64.c   | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 278cc135c23..9b76cc68c6d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1033,6 +1033,7 @@ struct ArchCPU {
         uint32_t dbgdevid1;
         uint64_t id_aa64isar0;
         uint64_t id_aa64isar1;
+        uint64_t id_aa64isar2;
         uint64_t id_aa64pfr0;
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e3f5a7d2bdc..f9f7c3c39e9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8435,11 +8435,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64isar1 },
-            { .name = "ID_AA64ISAR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64ISAR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64isar2 },
             { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 486f90be1d2..546c0e817f4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -847,6 +847,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
         { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
+        /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
         { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.id_aa64mmfr0 },
         { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.id_aa64mmfr1 },
         { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.id_aa64mmfr2 },
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 4d904a1d11b..ac440c33f9a 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -304,6 +304,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 6, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
                               ARM64_SYS_REG(3, 0, 0, 6, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar2,
+                              ARM64_SYS_REG(3, 0, 0, 6, 2));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
-- 
2.34.1


