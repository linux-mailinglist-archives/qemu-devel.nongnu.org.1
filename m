Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A166BADD69F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Jun 2025 18:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZH8-0000vK-2N; Tue, 17 Jun 2025 12:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG3-0000l2-1V
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZFz-0000cV-EN
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:33:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so6093591f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178033; x=1750782833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBtlyJQHnn2XrK52w3tY8zONlrGnxASWOwYgRCPrevI=;
 b=Oo1QJ3GL9zq7I9EGEBYKdU5RUUYuHuhKu0tWTGrtKi58tlTadpovRTl2vS3d/fl/q1
 oZx6X5CVLoEbgpUxpKn/yQpxOOifaR7OCgU4S4mBZ9Accxb1DVpP+8/lQ1NxU37PwmeR
 AIbCnSxNG8QKZEKOSdvbRXgXuUNFyQdXkZbpalKaQHEAPpl6Kp8c/m5IsNM/egVdDtoj
 /KIh1qFF4zIeyfzEGcPOzR5Ijr1AuTLreOsG2pbDEhcPTwh31ddxPggm2zbkRsUCeVFR
 kVAaA6KhRq7qTY06ps4PEI+2sL2PH0nA1wfKrg19tMblNsJsjrryJqCfP0GD6KiOGPS1
 Cl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178033; x=1750782833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBtlyJQHnn2XrK52w3tY8zONlrGnxASWOwYgRCPrevI=;
 b=ZzKxrqwyPGHFe1MEEuuDps931surkj6V4qoNLfQfZndyZsPyp7zXSKQcUbXWscLPEi
 5YFTcaH8UqiSvjwEUURbIpAh9GjWw8NxQdSAMT83u1cL0z+XkAe3rOenRe0QjHe8KkVr
 xXwcXoqX0Kf6L4tJN8KSqq8dGDOWBi1d2kxWmysEb+2fTEQuxa+NTsugfF19Y7pdJGjl
 GhPsJ0nFUSU7j7WKK0aYSesdFd5e2/yHeJzENanvpsnIpgj4FiC8Vwlxtngw9NCxDbba
 6e6n4vqabE8FHQIkGPEc4/SLWLVSiOUae01rHk/stBcJifo7HfLQa710PznMi1NuMNBW
 BR0g==
X-Gm-Message-State: AOJu0Yw0zYVz1tEMV03J9f6nee8WHRVyAUKBObukSrPf92RnplqFp3uD
 Eh58xWVeJ+Q4CmRKiuJhRP62l2bNocYOlS1gmdzEH3nCX/IdJyKO4mblNAh6rOlKp7A=
X-Gm-Gg: ASbGncvNR1i6lv0+aKEY7JpPrHB8vVxzeGq30BlKDyLFbrW2EQH2y2YzL7+MeOGOlR3
 XG1jr0tZm8tbw7PDgQ7TEkNrACcQxBHMc3NC8VgAG7+diMBD7SQkZOyNlZ4WYb8PfdtygVGQISU
 GVkyLoUgRxYpyVAb41gI8dI6J4QQgoM9kp102dS3/ZNLRuQJ1FHFAb3S+q2lrhGgAePZxSX3ywO
 fYNew46vkl/M9Uy4edNkZ3ts2t+USbdOZi6241+mppla8UPIg1G5NWdO7Pk/UGtvbSPACTF9aZf
 S4PqclH45kpn2kpXVe6hiHF2bTPR4pzqNIbznN43znCZDCvdYW/24H1X1bT4uOo=
X-Google-Smtp-Source: AGHT+IH+3wu/JYRt2Cb67tCwy6ldv4JyxCS38r3+XwSF93HDvkOHA/dvMd3/djG9W8UPOVQhwyydqQ==
X-Received: by 2002:a05:6000:2582:b0:3a5:27ba:479c with SMTP id
 ffacd0b85a97d-3a5723af8b9mr11474110f8f.43.1750178033368; 
 Tue, 17 Jun 2025 09:33:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b798d3sm14364723f8f.100.2025.06.17.09.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F3F655F845;
 Tue, 17 Jun 2025 17:33:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 01/11] target/arm: allow gdb to read ARM_CP_NORAW regs
 (!upstream)
Date: Tue, 17 Jun 2025 17:33:41 +0100
Message-ID: <20250617163351.2640572-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Before this we suppress all ARM_CP_NORAW registers being listed under
GDB. This includes useful registers like CurrentEL which gets tagged
as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
registers. These are registers TCG can directly compute because we
have the information at compile time but until now with no readfn.

Add a .readfn to return the CurrentEL and then loosen the restrictions
in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers to
be read if there is a readfn available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250507165840.401623-1-alex.bennee@linaro.org>

---
vRFC
  - this is a useful debugging aid but a bit haphazard for
    up-streaming. See thread comments for details.
---
 target/arm/gdbstub.c |  6 +++++-
 target/arm/helper.c  | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ce4497ad7c..029678ac9a 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -282,7 +282,11 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
     CPUARMState *env = &cpu->env;
     DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
 
-    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
+    if (!(ri->type & ARM_CP_NO_GDB)) {
+        /* skip ARM_CP_NO_RAW if there are no helper functions */
+        if ((ri->type & ARM_CP_NO_RAW) && !ri->readfn) {
+            return;
+        }
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
                 arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7631210287..8501c06b93 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4996,6 +4996,17 @@ static void ic_ivau_write(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 #endif
 
+/*
+ * Normally the current_el is known at translation time and we can
+ * emit the result directly in TCG code. However this helper exists
+ * only so we can also expose CURRENTEL to gdb.
+ */
+static uint64_t aa64_currentel_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    int el = arm_current_el(env);
+    return el;
+}
+
 static const ARMCPRegInfo v8_cp_reginfo[] = {
     /*
      * Minimal set of EL0-visible registers. This will need to be expanded
@@ -5034,7 +5045,9 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     },
     { .name = "CURRENTEL", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 4, .crm = 2,
-      .access = PL1_R, .type = ARM_CP_CURRENTEL },
+      .access = PL1_R, .type = ARM_CP_CURRENTEL,
+      .readfn = aa64_currentel_read
+    },
     /*
      * Instruction cache ops. All of these except `IC IVAU` NOP because we
      * don't emulate caches.
-- 
2.47.2


