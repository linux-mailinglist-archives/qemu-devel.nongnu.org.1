Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE7798B3F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeevv-000529-G0; Fri, 08 Sep 2023 13:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevs-0004ya-91
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-00016C-Jj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31c93d2a24fso2038573f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192761; x=1694797561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JHuAaKN4auyLOA3KiaF+WjKQrD1dXsJtQQWLi/jKPHs=;
 b=mmb2Bs06NLVhimsY/ay82DF1UG0FfONb4DuU/HO5pEczd9PwiOxsNCJYvC6AQRHdWZ
 wDaZyvkHOs4ZhGykWcMYxyyDUm02r+FHYoeNTO8QGW1LuwB8IG9HZJ5EeEFkJpmFt+jW
 YWOYlYO4KI7AFPWwcPcm4sZfHZFnOK5NhtEElQ4NIFqsnNRP4G8HY1bxyB7NbDYpCUcy
 3wmtCOowodcBn4u7l8eTH9hRLes1tDlA8EJMIiOg/9diBR7qvL4zc/tOZ+IMj/B0+YWx
 WRTzv09BhaArGAN25MN9Y3tFOlDWjgDtAYlvzpBAMGGcEqeCzDlQRfQ3LLNBO5VoKJE9
 vs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192761; x=1694797561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHuAaKN4auyLOA3KiaF+WjKQrD1dXsJtQQWLi/jKPHs=;
 b=nDTnlefXKlvFspPkSdL/hSvgnM7/kMjnBMHyxYwhB0v+U1yDr/iuy8VLvG/KcM4ZrI
 Fv0AChP2KH0mRpoU6TkfYyZJwsPsIsgdb4Q0/J0bNm6jYZruH0d8MeyGSyVEXeBEckVi
 hxroEan2iC61uJ9tRvnQemmhregKCp9Akw9yhuKBMdkyA6L/3dfzp+HOr2bgb9thDTnu
 Vh47fkDeH+Y5xMAdGYLV7SCGLT1STl+HkvfQQFqeH/qiwUsm2Ca8AyyaP6gfid5jtvJk
 o1HXfj+FmO2yw8+ovDPO3yQM4hjbK2ZnY6GTJsDPaf6bi/EF9hmRBYLknC1XrDqcHelU
 /Iqg==
X-Gm-Message-State: AOJu0YypM+AkoDpW/QRy934yxus9lEmLXXn762mxHv2wSHoezpsbF5q7
 FJv+DTK7oq/l6hRAzjtZPq88mblcF3dQMO89w9g=
X-Google-Smtp-Source: AGHT+IHoIBUOkVyT8fwo/OVPbCseQeFSmzB5p2dxTwvfErzpUCJxDR7MWbVIGdR3tGOvT3xz6GXiQw==
X-Received: by 2002:adf:ef88:0:b0:317:df3a:d030 with SMTP id
 d8-20020adfef88000000b00317df3ad030mr2655061wro.14.1694192761644; 
 Fri, 08 Sep 2023 10:06:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/26] target/arm: Add ID_AA64ISAR2_EL1
Date: Fri,  8 Sep 2023 18:05:33 +0100
Message-Id: <20230908170557.773048-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230829232335.965414-3-richard.henderson@linaro.org
[PMM: drop the HVF part of the patch and just comment that
 we need to do something when the register appears in that API]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


