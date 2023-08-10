Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B63777DDD
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:14:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8I5-0008Ve-AZ; Thu, 10 Aug 2023 12:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU8I3-0008UB-V4
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:13:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU8I2-0002i4-5C
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:13:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31765aee31bso942189f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691684012; x=1692288812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bJM8N4R9J6Gyk9m0A9ejLgBXb/ApU3lquNvKlYn7WWg=;
 b=bjx+D9h2xauAgseHaauo6pWEv3J3g7M4+qQmCXkEF6ySK944HO31dtoFj/6k/2a3ab
 zkdxCAQQ8E/Q+E3AkYiaVyP8WZQfP/tsIOjvcQU0/QNsy1qvgzQAoIwSmwcih6695cM4
 Zbm/tkKGvZ0zlbmw/acbxXBQx/OCT8X0NM50sm+DbvsU/gkLWfHqLb9hq+Z3bCzY3yyw
 URctd4QRfPsNY6QzfeBzaE3QCvlm1ZngxQCJqn0h8iF8ll06jcmsbwRgPszlr0PLjLp2
 ZcfN5SaVzEndbJOxmYBWtNndI0M3x3eTtp1uNKJhjx1BC+qSoNr+1oZ3tdzWc0gv+bBg
 Nz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691684012; x=1692288812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bJM8N4R9J6Gyk9m0A9ejLgBXb/ApU3lquNvKlYn7WWg=;
 b=bMfYRWx/T9Ie7MPVTk4q0Nwp/K/BkrwyUgdTzHdFR2u0Xjx1CI4Osuvu94OT6/U+Ju
 zpZVT/41LomZgtsGMlw8Mx/v6Em0ukLyq8EzBHDMHSawOYBn1I1Pr8W29Tt60G5m/5q8
 6Pjtg8tji47Lfzm46DhomHeZmsj/sgqAtxrJmREOQD9050bjUBwKEZ6i4samUU32z3Tk
 PB+4U72j53Z+taRJ7lsmZzxDSAFYBx6LNKmyr15wQDUFT9e0haMnv/WUxDcpdhLiWufb
 QXUxgyC4J6JhSWLRqggfws0a+Pk80RuWti/+GKTGN11P22Mv+M+fcAtWo+2fCl6DJgGV
 tQXw==
X-Gm-Message-State: AOJu0YzuZeEhAuF91ONds3qH2ES5UdVpjQai/4smS8kGrMa4vLJ5JMTD
 kDRDr67KXM5vI844cxHiZdOqncdMLjQl74vSN64=
X-Google-Smtp-Source: AGHT+IHwnZLCHX3T/K+iKxZKSrthQEiNZ0IrFoZIqfTQ4WwTOKvgNwERXyGNEBVWDzW3ljCAyv2GVQ==
X-Received: by 2002:a5d:46ca:0:b0:314:e929:bcb9 with SMTP id
 g10-20020a5d46ca000000b00314e929bcb9mr2563128wrs.57.1691684012416; 
 Thu, 10 Aug 2023 09:13:32 -0700 (PDT)
Received: from localhost.localdomain
 (tre93-h02-176-184-7-255.dsl.sta.abo.bbox.fr. [176.184.7.255])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a5d4281000000b00317a29af4b2sm2589650wrq.68.2023.08.10.09.13.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Aug 2023 09:13:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2] target/arm/cpu: Allow logging disabled CPU features
 at UNIMP level
Date: Thu, 10 Aug 2023 18:13:29 +0200
Message-Id: <20230810161329.7453-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Some CPU features aren't strictly required to run guest code (such
debugging features), so we don't model them. To prevent the guest
to access non-existent system registers, we disable the feature bit
in the ID registers (see commit 7d8c283e10 "target/arm: Suppress more
TCG unimplemented features in ID registers").

Since it might be useful to know when a CPU supposed to implement a
feature has it disabled in QEMU, provide the ability to log disabled
features at the UNIMP level:

  $ qemu-system-aarch64 -M virt -d unimp -S -cpu neoverse-v1
  QEMU 8.0.92 monitor - type 'help' for more information
  CPU#0: Disabling unimplemented feature 'FEAT_SPE (Statistical Profiling Extension)' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'FEAT_TRF (Self-hosted Trace Extension)' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'FEAT_TRF (Self-hosted Trace Extension)' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'Trace Macrocell system register access' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'Trace Macrocell system register access' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'Memory-mapped Trace' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'FEAT_AMU (Activity Monitors Extension)' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'FEAT_AMU (Activity Monitors Extension)' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'FEAT_MPAM (Memory Partitioning and Monitoring Extension)' for neoverse-v1
  CPU#0: Disabling unimplemented feature 'FEAT_NV (Nested Virtualization)' for neoverse-v1
  (qemu) q

  $ qemu-system-aarch64 -M xlnx-zcu102 -trace arm_disable\* -S -d unimp -monitor stdio -cpu cortex-a76
  QEMU 8.0.92 monitor - type 'help' for more information
  CPU#0: Disabling unimplemented feature 'Memory-mapped Trace' for cortex-a53
  CPU#1: Disabling unimplemented feature 'Memory-mapped Trace' for cortex-a53
  CPU#2: Disabling unimplemented feature 'Memory-mapped Trace' for cortex-a53
  CPU#3: Disabling unimplemented feature 'Memory-mapped Trace' for cortex-a53
  (qemu) q

Refactor the FIELD_DPxx() calls into the DISABLE_UNIMP_CPU_FEATURE()
macro where we call qemu_log(UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
There is another series reworking cpu_typename() helpers, so
meanwhile I simply added a static arm_cpu_typename() here.
---
 target/arm/cpu.c | 60 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93c28d50e5..becd2d2690 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1580,6 +1580,24 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
     }
 }
 
+/* callers must free the returned string with g_free() */
+static char *arm_cpu_typename(ARMCPU *cpu)
+{
+    const char *cpu_type = object_get_typename(OBJECT(cpu));
+
+    return g_strndup(cpu_type, strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX));
+}
+
+#define DISABLE_UNIMP_CPU_FEATURE(size, cpu, storage, reg, field, desc) \
+    if (FIELD_EX##size(cpu->isar.storage, reg, field)) { \
+        g_autofree char *cpu_type = arm_cpu_typename(cpu); \
+        \
+        qemu_log_mask(LOG_UNIMP, \
+                      "CPU#%d: Disabling unimplemented feature '%s' for %s\n", \
+                      CPU(cpu)->cpu_index, desc, cpu_type); \
+        cpu->isar.storage = FIELD_DP##size(cpu->isar.storage, reg, field, 0); \
+    }
+
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -2075,32 +2093,34 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * try to access the non-existent system registers for them.
          */
         /* FEAT_SPE (Statistical Profiling Extension) */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMSVER, 0);
+        DISABLE_UNIMP_CPU_FEATURE(64, cpu, id_aa64dfr0, ID_AA64DFR0, PMSVER,
+                                  "FEAT_SPE (Statistical Profiling Extension)");
+
         /* FEAT_TRF (Self-hosted Trace Extension) */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEFILT, 0);
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, TRACEFILT, 0);
+        DISABLE_UNIMP_CPU_FEATURE(64, cpu, id_aa64dfr0, ID_AA64DFR0, TRACEFILT,
+                                  "FEAT_TRF (Self-hosted Trace Extension)");
+        DISABLE_UNIMP_CPU_FEATURE(32, cpu, id_dfr0, ID_DFR0, TRACEFILT,
+                                  "FEAT_TRF (Self-hosted Trace Extension)");
         /* Trace Macrocell system register access */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEVER, 0);
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPTRC, 0);
+        DISABLE_UNIMP_CPU_FEATURE(64, cpu, id_aa64dfr0, ID_AA64DFR0, TRACEVER,
+                                  "Trace Macrocell system register access");
+        DISABLE_UNIMP_CPU_FEATURE(32, cpu, id_dfr0, ID_DFR0, COPTRC,
+                                  "Trace Macrocell system register access");
         /* Memory mapped trace */
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, MMAPTRC, 0);
+        DISABLE_UNIMP_CPU_FEATURE(32, cpu, id_dfr0, ID_DFR0, MMAPTRC,
+                                  "Memory-mapped Trace");
         /* FEAT_AMU (Activity Monitors Extension) */
-        cpu->isar.id_aa64pfr0 =
-            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, AMU, 0);
-        cpu->isar.id_pfr0 =
-            FIELD_DP32(cpu->isar.id_pfr0, ID_PFR0, AMU, 0);
+        DISABLE_UNIMP_CPU_FEATURE(64, cpu, id_aa64pfr0, ID_AA64PFR0, AMU,
+                                  "FEAT_AMU (Activity Monitors Extension)");
+        DISABLE_UNIMP_CPU_FEATURE(32, cpu, id_pfr0, ID_PFR0, AMU,
+                                  "FEAT_AMU (Activity Monitors Extension)");
         /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
-        cpu->isar.id_aa64pfr0 =
-            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 0);
+        DISABLE_UNIMP_CPU_FEATURE(64, cpu, id_aa64pfr0, ID_AA64PFR0, MPAM,
+                                  "FEAT_MPAM (Memory Partitioning"
+                                  " and Monitoring Extension)");
         /* FEAT_NV (Nested Virtualization) */
-        cpu->isar.id_aa64mmfr2 =
-            FIELD_DP64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV, 0);
+        DISABLE_UNIMP_CPU_FEATURE(64, cpu, id_aa64mmfr2, ID_AA64MMFR2, NV,
+                                  "FEAT_NV (Nested Virtualization)");
     }
 
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
-- 
2.38.1


