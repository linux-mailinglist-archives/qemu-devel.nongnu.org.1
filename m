Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE15816C80
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsf-0007dd-LT; Mon, 18 Dec 2023 06:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsP-00078k-2Y
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsB-0003Oi-Hb
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c236624edso31645855e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899202; x=1703504002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TmxW7KVfKlZkNiHA6/fprQpfKnNWnbFdOQHNckFDGhI=;
 b=kOTCyVZcxE1lU9+Jb19z6u6/F2RtJvV9XxdxRovheilvZpDZzFdBPA0ZT+d6WhpKK+
 oFJuZ8QzdNr7NJmeG4noAKJ0yEB5S7+PYXmjST1K74S14uAvi1oM4me6tmoJtXriYyVO
 IuK/kGn9v1FZ+mjvatSoPATN5TrFSCfBJxfYADlSBv/5E/lV3Tx7R6zFJk3Om/UaePrS
 O7L3SZtMqgYoHm6XEwwviE+6YtbWgzzJVjWHLkELJKsJ7tFGdbdGX6XmjLGLbsi9uG9A
 2bj/HVg6XVAU4Gl1mXT0T2HZ/5sRPxfRTexL8x9x91ojQMMRfuOrOP8oCsd0ZPg1UBTk
 zjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899202; x=1703504002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmxW7KVfKlZkNiHA6/fprQpfKnNWnbFdOQHNckFDGhI=;
 b=SF/gAMz+qkl6ieHQQ7Giq97BWYlBzxz1fl1QUyoJnzioBALAwS5pkyCiuUicDRUD0b
 BXSiUBNfZHNxHppYfE8qmXDBtCIZXGCD0hS4ZDfvVNZzgEBFPZ0hQlpsPnvld2RltpqJ
 u2n4KgZzFp8Wy/zJ178ArknxlMdJZWlj9iNxAihdoW0/W8zvnAH2ZGXLvRgOWvhTx8TD
 SuCA4UZbQdScW8WO1JRjRVFomZzFRAahuuQE7aMACXE/buwomSCbp21mLS6FuYkR/AO7
 e+2eQeFC4dzmy2OiCc3MxFpsSKmxDm5ajjkEmmlNgx5ytaM91T1HTXjrays+TJoDWWSg
 TrOA==
X-Gm-Message-State: AOJu0YwqHIIRhAlJu4jLuuVQiQ0Cy6c2TP3ojo7C2bHnGM+lXtuBt1Ya
 UXkeBTxg9YLDfh+VdMhpZOBUBAxV3TBLTOMGeyk=
X-Google-Smtp-Source: AGHT+IFYaaWMPgwkMDAJTWGOELuDc811QFV7zxBoB+yr6iSjUJp9j1iZ1JW2/p4MlE4F+rILxeVfmw==
X-Received: by 2002:a05:600c:4f11:b0:40c:295f:1195 with SMTP id
 l17-20020a05600c4f1100b0040c295f1195mr8213144wmq.55.1702899202129; 
 Mon, 18 Dec 2023 03:33:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 32/35] hw/intc/arm_gicv3_cpuif: Mark up VNCR offsets for GIC
 CPU registers
Date: Mon, 18 Dec 2023 11:33:02 +0000
Message-Id: <20231218113305.2511480-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Mark up the cpreginfo structs for the GIC CPU registers to indicate
the offsets from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ
in the Arm ARM.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 258dee1b808..96539cdbe9a 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2684,6 +2684,7 @@ static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
     { .name = "ICH_AP0R0_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 0,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x480,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2691,6 +2692,7 @@ static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
     { .name = "ICH_AP1R0_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 0,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4a0,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2698,6 +2700,7 @@ static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
     { .name = "ICH_HCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 0,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4c0,
       .access = PL2_RW,
       .readfn = ich_hcr_read,
       .writefn = ich_hcr_write,
@@ -2729,6 +2732,7 @@ static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
     { .name = "ICH_VMCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 7,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4c8,
       .access = PL2_RW,
       .readfn = ich_vmcr_read,
       .writefn = ich_vmcr_write,
@@ -2739,6 +2743,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr1_reginfo[] = {
     { .name = "ICH_AP0R1_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x488,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2746,6 +2751,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr1_reginfo[] = {
     { .name = "ICH_AP1R1_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4a8,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2756,6 +2762,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     { .name = "ICH_AP0R2_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 2,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x490,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2763,6 +2770,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     { .name = "ICH_AP0R3_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 3,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x498,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2770,6 +2778,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     { .name = "ICH_AP1R2_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 2,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4b0,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2777,6 +2786,7 @@ static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
     { .name = "ICH_AP1R3_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 3,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .nv2_redirect_offset = 0x4b8,
       .access = PL2_RW,
       .readfn = ich_ap_read,
       .writefn = ich_ap_write,
@@ -2898,6 +2908,7 @@ void gicv3_init_cpuif(GICv3State *s)
                       .opc0 = 3, .opc1 = 4, .crn = 12,
                       .crm = 12 + (j >> 3), .opc2 = j & 7,
                       .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                      .nv2_redirect_offset = 0x400 + 8 * j,
                       .access = PL2_RW,
                       .readfn = ich_lr_read,
                       .writefn = ich_lr_write,
-- 
2.34.1


