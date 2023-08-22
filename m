Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BF57838C8
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYIxY-0006H6-OS; Tue, 22 Aug 2023 00:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxX-0006Ey-1x
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxT-0007WE-OK
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:38 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a6cd7c6a6so287324b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678334; x=1693283134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhkbaseSYctv0PKDmJHETTELtOUQpyXPx69wgq43tTw=;
 b=sNkof9U0i1la53JWZ0rew/LsdcEath104n5xTgdMWxgQ1gtaw0Xm8Ntg73duZbtTUF
 SMooTCsacl7qZW4vvndr2P3PlyuzZtEb0coYO4KVv8OmgnJtRBXihyfKN7kXWJuyOpS4
 +KLxTJalFK25Gy+/lAS2y6s3lj2/21SCPc9+dpC4sk5cGdkPt4I4Pbs7GBmlbvygXqX/
 nxTUkTwuWF+b5N8CpmugsEABw7Cj55COV0gKlNJLzvMnAZNeETbaJpYSJEnTGskoxgI5
 +rI+EKM1Gckr4rLDzDUdgZHPAkR00sLaNWysyTK9aEToJmcCInEuQaVy5+8e5KtLI++y
 Rn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678334; x=1693283134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhkbaseSYctv0PKDmJHETTELtOUQpyXPx69wgq43tTw=;
 b=Y1k8ijS5zqBbXUzJXDyJd4bTcJCO4ZOnPzl4H0kEcTbN/Ig9tqz4Kre3hdUbqjP1gv
 QhsEOwKvh+2ffqa0/zd7hUJ2rBAcv0x7726hEr0SogCYB7HYMr4HLxblI1IGXR/Hjp7O
 /hER6vcyOq2umDoF1HeRqYG9ialgahkv+so6EuLd8fvjfp+jmc6siJeuHWccJxjlHhO/
 YgsXXhmvrYZWaeD8WGVs83I2rfkKOjJ5eLYwt0oqm0ujtFAa2oh3B7hv1M/dAvOHsrln
 pKt6mb1dKzOjoK5zNg2qQrfCHlZOkrrbHc+BsM9kYRUVdKJwA/12GevGCld23Mh907Z+
 HsoA==
X-Gm-Message-State: AOJu0Yz9LwGKjfpffk/qOos8ssWnN18OKhtjtthJ1lRcKVFFmsIxrQak
 C3C6CaSVTdRjYq9z4WigmZ/C20Cnji52fpEBTvY=
X-Google-Smtp-Source: AGHT+IHX8vtPBYAZ4AzzRSII9wwiIIF3rCPLQM/zXxCdC8rNVkFSs+gxlwJCqlFf4vTb1BgHGpM53Q==
X-Received: by 2002:a05:6a00:16c5:b0:66e:4df5:6c10 with SMTP id
 l5-20020a056a0016c500b0066e4df56c10mr7028734pfc.34.1692678333930; 
 Mon, 21 Aug 2023 21:25:33 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa7900e000000b0068a3f861b24sm3364908pfo.195.2023.08.21.21.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 21:25:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Aaron Lindsay <aaron@os.amperecomputing.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 2/9] target/arm: Add ID_AA64ISAR2_EL1
Date: Mon, 21 Aug 2023 21:25:23 -0700
Message-Id: <20230822042530.1026751-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822042530.1026751-1-richard.henderson@linaro.org>
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
index 88e5accda6..fbdbf2df7f 100644
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
index 50f61e42ca..3bae262b2f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8334,11 +8334,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
index 8fce64bbf6..c366f7f517 100644
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
index 94bbd9661f..e2d05d7fc0 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -306,6 +306,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
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


